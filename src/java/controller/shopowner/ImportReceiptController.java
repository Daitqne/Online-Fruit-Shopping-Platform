package controller.shopowner;

import dal.ImportReceiptDAO;
import dal.NotificationDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Authen;
import model.ImportReceipt;
import model.ImportReceiptItem;
import model.Notification;
import model.Product;

/**
 * Controller cho trang Nhập Kho của Shop Owner.
 * URL: /import-receipt
 * Actions GET: (none) → form tạo phiếu
 * Actions POST: submit → tạo phiếu nhập kho
 */
@WebServlet(name = "ImportReceiptController", urlPatterns = {"/import-receipt"})
public class ImportReceiptController extends HttpServlet {

    // ===================================================================
    // GET — Hiển thị form tạo phiếu nhập kho
    // ===================================================================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Authen user = (Authen) session.getAttribute("user");
        if (!"Shop Owner".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang này!");
            return;
        }

        int shopOwnerId = user.getId();
        ProductDAO productDAO = new ProductDAO();

        // Lấy sản phẩm đã được duyệt của shop owner (status Approved/Available/Featured)
        List<Product> products = productDAO.getFilteredProducts("", "All", null, null, "All", shopOwnerId);

        // Lấy lịch sử phiếu nhập
        ImportReceiptDAO receiptDAO = new ImportReceiptDAO();
        List<ImportReceipt> receipts = receiptDAO.getReceiptsByShopOwner(shopOwnerId);

        // Lấy thông báo
        NotificationDAO notifDAO = new NotificationDAO();
        List<Notification> notifications = notifDAO.getNotificationsByUserId(shopOwnerId);
        long unreadCount = notifications.stream().filter(n -> !n.isRead()).count();

        // Flash messages từ session
        String successMsg = (String) session.getAttribute("importSuccess");
        String errorMsg   = (String) session.getAttribute("importError");
        session.removeAttribute("importSuccess");
        session.removeAttribute("importError");

        request.setAttribute("products", products);
        request.setAttribute("receipts", receipts);
        request.setAttribute("notifications", notifications);
        request.setAttribute("unreadCount", unreadCount);
        request.setAttribute("successMsg", successMsg);
        request.setAttribute("errorMsg", errorMsg);

        request.getRequestDispatcher("/shopowner/import_receipt.jsp").forward(request, response);
    }

    // ===================================================================
    // POST — Xử lý submit phiếu nhập kho
    // ===================================================================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Authen user = (Authen) session.getAttribute("user");
        if (!"Shop Owner".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String note = request.getParameter("note");

        // Đọc mảng sản phẩm từ form (productId[], quantity[], expiryDate[], manufactureDate[])
        String[] productIds      = request.getParameterValues("productId[]");
        String[] quantities      = request.getParameterValues("quantity[]");
        String[] expiryDates     = request.getParameterValues("expiryDate[]");
        String[] manufactureDates = request.getParameterValues("manufactureDate[]");

        // Validate: phải có ít nhất 1 dòng
        if (productIds == null || productIds.length == 0) {
            session.setAttribute("importError", "Vui lòng thêm ít nhất một sản phẩm vào phiếu nhập kho.");
            response.sendRedirect(request.getContextPath() + "/import-receipt");
            return;
        }

        // Validate quyền sở hữu sản phẩm
        ProductDAO productDAO = new ProductDAO();
        List<ImportReceiptItem> items = new ArrayList<>();

        for (int i = 0; i < productIds.length; i++) {
            try {
                int productId = Integer.parseInt(productIds[i].trim());
                int quantity  = Integer.parseInt(quantities[i].trim());

                if (quantity <= 0) continue; // Bỏ qua dòng số lượng = 0

                // Kiểm tra sản phẩm thuộc shop owner
                Product p = productDAO.getProductById(productId);
                if (p == null || p.getShopOwnerId() != user.getId()) {
                    session.setAttribute("importError", "Sản phẩm ID=" + productId + " không thuộc quyền quản lý của bạn.");
                    response.sendRedirect(request.getContextPath() + "/import-receipt");
                    return;
                }

                // Parse ngày hết hạn (bắt buộc)
                Date expiryDate;
                try {
                    expiryDate = Date.valueOf(expiryDates[i].trim());
                } catch (Exception e) {
                    session.setAttribute("importError", "Ngày hết hạn của sản phẩm \"" + p.getName() + "\" không hợp lệ.");
                    response.sendRedirect(request.getContextPath() + "/import-receipt");
                    return;
                }

                // Ngày hết hạn phải sau hôm nay
                if (expiryDate.before(new Date(System.currentTimeMillis()))) {
                    session.setAttribute("importError", "Ngày hết hạn của sản phẩm \"" + p.getName() + "\" phải là ngày trong tương lai.");
                    response.sendRedirect(request.getContextPath() + "/import-receipt");
                    return;
                }

                // Parse ngày sản xuất (tùy chọn)
                Date manufDate = null;
                if (manufactureDates != null && i < manufactureDates.length
                        && !manufactureDates[i].trim().isEmpty()) {
                    try {
                        manufDate = Date.valueOf(manufactureDates[i].trim());
                    } catch (Exception e) {
                        // Bỏ qua nếu format sai
                    }
                }

                ImportReceiptItem item = new ImportReceiptItem();
                item.setProductId(productId);
                item.setQuantity(quantity);
                item.setExpiryDate(expiryDate);
                item.setManufactureDate(manufDate);
                items.add(item);

            } catch (NumberFormatException e) {
                // Bỏ qua dòng lỗi format
            }
        }

        if (items.isEmpty()) {
            session.setAttribute("importError", "Không có dòng sản phẩm hợp lệ nào. Vui lòng kiểm tra lại số lượng.");
            response.sendRedirect(request.getContextPath() + "/import-receipt");
            return;
        }

        // Tạo phiếu nhập
        ImportReceipt receipt = new ImportReceipt();
        receipt.setCreatedBy(user.getId());
        receipt.setImportDate(new Timestamp(System.currentTimeMillis()));
        receipt.setNote(note != null ? note.trim() : "");
        receipt.setItems(items);

        ImportReceiptDAO receiptDAO = new ImportReceiptDAO();
        boolean success = receiptDAO.createReceipt(receipt);

        if (success) {
            // Gửi thông báo cho shop owner
            NotificationDAO notifDAO = new NotificationDAO();
            int totalQty = items.stream().mapToInt(ImportReceiptItem::getQuantity).sum();
            notifDAO.addNotification(user.getId(),
                "Nhập kho thành công",
                "Phiếu nhập kho #" + receipt.getReceiptId() + " đã được tạo với "
                + items.size() + " sản phẩm, tổng " + totalQty + " đơn vị.");

            session.setAttribute("importSuccess", "Phiếu nhập kho #" + receipt.getReceiptId()
                + " đã được tạo thành công! Tổng " + totalQty + " đơn vị được cộng vào kho.");
        } else {
            session.setAttribute("importError", "Đã xảy ra lỗi khi tạo phiếu nhập kho. Vui lòng thử lại.");
        }

        response.sendRedirect(request.getContextPath() + "/import-receipt");
    }
}

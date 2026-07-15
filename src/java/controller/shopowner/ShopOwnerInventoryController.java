package controller.shopowner;

import dal.ProductDAO;
import dal.NotificationDAO;
import dal.ImportReceiptDAO;
import model.Product;
import model.Authen;
import model.Notification;
import model.InventoryBatch;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ShopOwnerInventoryController", urlPatterns = {"/inventory-shop-owner"})
public class ShopOwnerInventoryController extends HttpServlet {

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
        ImportReceiptDAO batchDAO = new ImportReceiptDAO();
        
        // Fetch all products of this shop owner
        List<Product> products = productDAO.getFilteredProducts("", "All", null, null, "All", shopOwnerId);
        
        // Get all batches for this shop owner
        List<InventoryBatch> allBatches = batchDAO.getBatchesByShopOwner(shopOwnerId);
        
        // Build map: productId -> nearest expiry date
        Map<Integer, Date> nearestExpiryMap = new HashMap<>();
        Map<Integer, Boolean> hasExpiredMap = new HashMap<>();
        Map<Integer, Boolean> hasExpiringSoonMap = new HashMap<>();
        
        for (InventoryBatch batch : allBatches) {
            int pid = batch.getProductId();
            Date expiryDate = batch.getExpiryDate();
            
            // Track nearest expiry
            if (!nearestExpiryMap.containsKey(pid) || expiryDate.before(nearestExpiryMap.get(pid))) {
                nearestExpiryMap.put(pid, expiryDate);
            }
            
            // Track expired/expiring status
            if (batch.isExpired()) {
                hasExpiredMap.put(pid, true);
            }
            if (batch.isExpiringSoon()) {
                hasExpiringSoonMap.put(pid, true);
            }
        }
        
        // Calculate statistics
        long totalProducts = products.size();
        long lowStockProducts = products.stream()
                .filter(p -> p.getStockQuantity() <= p.getLowStockThreshold())
                .count();
        long expiredProducts = hasExpiredMap.size();
        long expiringSoonProducts = hasExpiringSoonMap.size();

        // Get notifications for Shop Owner
        NotificationDAO notificationDAO = new NotificationDAO();
        List<Notification> notifications = notificationDAO.getNotificationsByUserId(shopOwnerId);
        long unreadCount = notifications.stream().filter(n -> !n.isRead()).count();

        // Flash messages
        String inventorySuccess = (String) session.getAttribute("inventorySuccess");
        String inventoryError = (String) session.getAttribute("inventoryError");
        session.removeAttribute("inventorySuccess");
        session.removeAttribute("inventoryError");

        request.setAttribute("products", products);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("lowStockProducts", lowStockProducts);
        request.setAttribute("expiredProducts", expiredProducts);
        request.setAttribute("expiringSoonProducts", expiringSoonProducts);
        request.setAttribute("nearestExpiryMap", nearestExpiryMap);
        request.setAttribute("hasExpiredMap", hasExpiredMap);
        request.setAttribute("hasExpiringSoonMap", hasExpiringSoonMap);
        request.setAttribute("notifications", notifications);
        request.setAttribute("unreadCount", unreadCount);
        request.setAttribute("inventorySuccess", inventorySuccess);
        request.setAttribute("inventoryError", inventoryError);

        request.getRequestDispatcher("/shopowner/inventory_shop_owner.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        Authen user = (Authen) session.getAttribute("user");
        if (!"Shop Owner".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập!");
            return;
        }

        String action = request.getParameter("action");
        String productIdStr = request.getParameter("productId");
        
        if (action == null) {
            response.sendRedirect("inventory-shop-owner");
            return;
        }

        ProductDAO productDAO = new ProductDAO();
        ImportReceiptDAO batchDAO = new ImportReceiptDAO();

        if ("update-threshold".equals(action)) {
            if (productIdStr == null) {
                response.sendRedirect("inventory-shop-owner");
                return;
            }
            
            int productId = Integer.parseInt(productIdStr);
            Product p = productDAO.getProductById(productId);

            if (p == null || p.getShopOwnerId() != user.getId()) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Sản phẩm không thuộc quyền quản lý của bạn!");
                return;
            }

            String thresholdStr = request.getParameter("threshold");
            if (thresholdStr != null && !thresholdStr.trim().isEmpty()) {
                int threshold = Integer.parseInt(thresholdStr);
                if (threshold < 0) threshold = 0;
                productDAO.updateLowStockThreshold(productId, threshold);
            }
            
            response.sendRedirect("inventory-shop-owner?success=true");
            
        } else if ("remove-batch".equals(action)) {
            String batchIdStr = request.getParameter("batchId");
            if (batchIdStr == null) {
                response.sendRedirect("inventory-shop-owner");
                return;
            }
            
            int batchId = Integer.parseInt(batchIdStr);
            boolean success = batchDAO.removeExpiredBatch(batchId, user.getId());
            
            if (success) {
                session.setAttribute("inventorySuccess", "Đã loại bỏ lô hết hạn thành công!");
            } else {
                session.setAttribute("inventoryError", "Không thể loại bỏ lô. Vui lòng kiểm tra lại!");
            }
            
            response.sendRedirect("inventory-shop-owner");
        } else {
            response.sendRedirect("inventory-shop-owner");
        }
    }
}

package controller.shopowner;

import dal.ProductDAO;
import dal.NotificationDAO;
import model.Product;
import model.Authen;
import model.Notification;
import java.io.IOException;
import java.util.List;
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
        
        // Fetch all products of this shop owner
        List<Product> products = productDAO.getFilteredProducts("", "All", null, null, "All", shopOwnerId);
        
        // Calculate statistics
        long totalProducts = products.size();
        long lowStockProducts = products.stream()
                .filter(p -> p.getStockQuantity() <= p.getLowStockThreshold())
                .count();

        // Get notifications for Shop Owner
        NotificationDAO notificationDAO = new NotificationDAO();
        List<Notification> notifications = notificationDAO.getNotificationsByUserId(shopOwnerId);
        long unreadCount = notifications.stream().filter(n -> !n.isRead()).count();

        request.setAttribute("products", products);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("lowStockProducts", lowStockProducts);
        request.setAttribute("notifications", notifications);
        request.setAttribute("unreadCount", unreadCount);

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
        
        if (productIdStr == null || action == null) {
            response.sendRedirect("inventory-shop-owner");
            return;
        }

        int productId = Integer.parseInt(productIdStr);
        ProductDAO productDAO = new ProductDAO();
        Product p = productDAO.getProductById(productId);

        if (p == null || p.getShopOwnerId() != user.getId()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Sản phẩm không thuộc quyền quản lý của bạn!");
            return;
        }

        if ("restock".equals(action)) {
            String qtyStr = request.getParameter("quantity");
            if (qtyStr != null && !qtyStr.trim().isEmpty()) {
                int addQty = Integer.parseInt(qtyStr);
                int newQty = p.getStockQuantity() + addQty;
                if (newQty < 0) newQty = 0;
                productDAO.updateStock(productId, newQty);
            }
        } else if ("update-threshold".equals(action)) {
            String thresholdStr = request.getParameter("threshold");
            if (thresholdStr != null && !thresholdStr.trim().isEmpty()) {
                int threshold = Integer.parseInt(thresholdStr);
                if (threshold < 0) threshold = 0;
                productDAO.updateLowStockThreshold(productId, threshold);
            }
        }

        response.sendRedirect("inventory-shop-owner?success=true");
    }
}

package controller;

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

@WebServlet(name = "ShopOwnerProductsController", urlPatterns = {"/products-shop-owner"})
public class ShopOwnerProductsController extends HttpServlet {

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

  
        String search = request.getParameter("search");
        String category = request.getParameter("category");
        
        if (category == null || category.trim().isEmpty()) {
            category = "All";
        }
        
     
        int shopOwnerId = user.getId();
        ProductDAO productDAO = new ProductDAO();
        List<Product> products = productDAO.getFilteredProducts(search, category, null, null, "All", shopOwnerId);
        List<String> categories = productDAO.getAllCategories();
        
        // Thống kê dữ liệu theo shop owner
        List<Product> allProducts = productDAO.getFilteredProducts("", "All", null, null, "All", shopOwnerId);
        long totalProducts = allProducts.size();
        long pendingProducts = allProducts.stream()
                .filter(p -> "Pending".equalsIgnoreCase(p.getStatus()) || "Rejected".equalsIgnoreCase(p.getStatus()))
                .count();
        long approvedProducts = allProducts.stream()
                .filter(p -> "Approved".equalsIgnoreCase(p.getStatus()) || "Available".equalsIgnoreCase(p.getStatus()) || "Featured".equalsIgnoreCase(p.getStatus()))
                .count();
        long totalCategories = categories.size();
        long lowStockProducts = allProducts.stream()
                .filter(p -> p.getStockQuantity() <= p.getLowStockThreshold())
                .count();
        
        // Lấy thông báo của Shop Owner
        NotificationDAO notificationDAO = new NotificationDAO();
        List<Notification> notifications = notificationDAO.getNotificationsByUserId(shopOwnerId);
        long unreadCount = notifications.stream().filter(n -> !n.isRead()).count();
    
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("searchQuery", search != null ? search : "");
        request.setAttribute("selectedCategory", category);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("pendingProducts", pendingProducts);
        request.setAttribute("approvedProducts", approvedProducts);
        request.setAttribute("totalCategories", totalCategories);
        request.setAttribute("lowStockProducts", lowStockProducts);
        request.setAttribute("notifications", notifications);
        request.setAttribute("unreadCount", unreadCount);
        
        request.getRequestDispatcher("products_shop_owner.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

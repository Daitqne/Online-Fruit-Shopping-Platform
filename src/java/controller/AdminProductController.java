package controller;

import dal.AdminDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Authen;
import model.Product;

@WebServlet(name = "AdminProductController", urlPatterns = {"/admin-products"})
public class AdminProductController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Authen user = (Authen) session.getAttribute("user");
        
        // Debug logging
        System.out.println("[AdminProductController] User: " + (user != null ? user.getUsername() : "null"));
        System.out.println("[AdminProductController] Role: " + (user != null ? user.getRole() : "null"));
        
        // Kiểm tra quyền Admin
        if (user == null || user.getRole() == null || !user.getRole().equalsIgnoreCase("Admin")) {
            System.out.println("[AdminProductController] Access denied - redirecting to login");
            response.sendRedirect("login");
            return;
        }
        
        AdminDAO adminDAO = new AdminDAO();
        String action = request.getParameter("action");
        
        // Xử lý toggle product status
        if (action != null && action.equals("toggleStatus")) {
            int productId = Integer.parseInt(request.getParameter("id"));
            String currentStatus = request.getParameter("status");
            
            String newStatus = currentStatus.equalsIgnoreCase("Available") ? "Unavailable" : "Available";
            System.out.println("[AdminProductController] Toggle status for product " + productId + " from " + currentStatus + " to " + newStatus);
            adminDAO.changeProductStatus(productId, newStatus);
            
            response.sendRedirect("admin-products");
            return;
        }

        // Lấy danh sách tất cả sản phẩm
        System.out.println("[AdminProductController] Loading all products");
        List<Product> productList = adminDAO.getAllProducts();
        System.out.println("[AdminProductController] Found " + (productList != null ? productList.size() : 0) + " products");
        
        request.setAttribute("productList", productList);
        request.setAttribute("pageTitle", "Quản lý Sản phẩm");
        
        request.getRequestDispatcher("admin_products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

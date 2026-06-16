package controller;

import dal.ProductDAO;
import model.Product;
import model.Authen;
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
        
        // 1. Phân quyền
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

        // 2. Tiếp nhận tham số lọc/tìm kiếm
        String search = request.getParameter("search");
        String category = request.getParameter("category");
        
        if (category == null || category.trim().isEmpty()) {
            category = "All";
        }
        
        // 3. Truy vấn dữ liệu
        ProductDAO productDAO = new ProductDAO();
        List<Product> products = productDAO.getFilteredProducts(search, category, null, null, "All");
        List<String> categories = productDAO.getAllCategories();
        
        // Thống kê dữ liệu
        List<Product> allProducts = productDAO.getFilteredProducts("", "All", null, null, "All");
        long totalProducts = allProducts.size();
        long featuredProducts = allProducts.stream()
                .filter(p -> "Featured".equalsIgnoreCase(p.getStatus()))
                .count();
        long totalCategories = categories.size();
        
        // 4. Thiết lập thuộc tính
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("searchQuery", search != null ? search : "");
        request.setAttribute("selectedCategory", category);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("featuredProducts", featuredProducts);
        request.setAttribute("totalCategories", totalCategories);
        
        request.getRequestDispatcher("products_shop_owner.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

package controller.shopowner;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Authen;

@WebServlet(name = "ShopOwnerProfileServlet", urlPatterns = {"/shop-owner-profile"})
public class ShopOwnerProfileServlet extends HttpServlet {

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
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }

      
        dal.ProductDAO productDAO = new dal.ProductDAO();
        java.util.List<model.Product> allProducts = productDAO.getFilteredProducts("", "All", null, null, "All");
        java.util.List<String> categories = productDAO.getAllCategories();
        
        long totalProducts = allProducts.size();
        long featuredProducts = allProducts.stream()
                .filter(p -> "Featured".equalsIgnoreCase(p.getStatus()))
                .count();
        long totalCategories = categories.size();
        
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("featuredProducts", featuredProducts);
        request.setAttribute("totalCategories", totalCategories);

        request.getRequestDispatcher("/shopowner/profile_shop_owner.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

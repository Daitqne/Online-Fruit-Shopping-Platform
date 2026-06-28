package controller.shopowner;

import dal.ProductDAO;
import model.Authen;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Controller servlet for Deleting a Product.
 * GET /delete-product?id=X → deletes the product and redirects to /products-shop-owner
 */
@WebServlet(name = "DeleteProductController", urlPatterns = {"/delete-product"})
public class DeleteProductController extends HttpServlet {

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

        String idStr = request.getParameter("id");

        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect("products-shop-owner");
            return;
        }

        try {
            int id = Integer.parseInt(idStr.trim());
            ProductDAO dao = new ProductDAO();
            dao.deleteProduct(id);
            response.sendRedirect("products-shop-owner?success=true");

        } catch (NumberFormatException e) {
            response.sendRedirect("products-shop-owner");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

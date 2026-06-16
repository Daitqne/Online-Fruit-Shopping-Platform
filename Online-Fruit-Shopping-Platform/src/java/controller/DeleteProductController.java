package controller;

import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Controller servlet for Deleting a Product.
 * GET /delete-product?id=X → deletes the product and redirects to /products
 */
@WebServlet(name = "DeleteProductController", urlPatterns = {"/delete-product"})
public class DeleteProductController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");

        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect("products");
            return;
        }

        try {
            int id = Integer.parseInt(idStr.trim());
            ProductDAO dao = new ProductDAO();
            dao.deleteProduct(id);
            response.sendRedirect("products");

        } catch (NumberFormatException e) {
            response.sendRedirect("products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

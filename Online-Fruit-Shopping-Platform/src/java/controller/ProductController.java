package controller;

import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Product;

/**
 * Controller servlet for the Products Listing Page.
 */
@WebServlet(name = "ProductController", urlPatterns = {"/products"})
public class ProductController extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String search = request.getParameter("search");
        String category = request.getParameter("category");
        
        if (category == null || category.trim().isEmpty()) {
            category = "All";
        }
        
        ProductDAO productDAO = new ProductDAO();
        
        List<Product> products = productDAO.getFilteredProducts(search, category);
        List<String> categories = productDAO.getAllCategories();
        
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        
        request.setAttribute("searchQuery", search);
        request.setAttribute("selectedCategory", category);
        
        request.getRequestDispatcher("products.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

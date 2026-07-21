package controller.customer;

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
        String minPriceStr  = request.getParameter("minPrice");
        String maxPriceStr  = request.getParameter("maxPrice");
        String availability = request.getParameter("availability");

        if (category == null || category.trim().isEmpty()) {
            category = "All";
        }
        if (availability == null || availability.trim().isEmpty()) {
            availability = "All";
        }

        Double minPrice = null, maxPrice = null;
        try { if (minPriceStr != null && !minPriceStr.isEmpty()) minPrice = Double.parseDouble(minPriceStr); } catch (NumberFormatException e) {}
        try { if (maxPriceStr != null && !maxPriceStr.isEmpty()) maxPrice = Double.parseDouble(maxPriceStr); } catch (NumberFormatException e) {}

        String pageStr = request.getParameter("page");
        int currentPage = 1;
        int pageSize = 12; // 12 products per page
        if (pageStr != null && !pageStr.trim().isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageStr);
                if (currentPage < 1) currentPage = 1;
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        ProductDAO productDAO = new ProductDAO();

        int totalProducts = productDAO.getFilteredProductsCount(search, category, minPrice, maxPrice, availability);
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        if (totalPages == 0) totalPages = 1;
        if (currentPage > totalPages) currentPage = totalPages;

        List<Product> products = productDAO.getFilteredProducts(search, category, minPrice, maxPrice, availability, currentPage, pageSize);
        List<String> categories = productDAO.getAllCategories();

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalProducts", totalProducts);

        request.setAttribute("searchQuery", search);
        request.setAttribute("selectedCategory", category);
        request.setAttribute("selectedAvailability", availability);
        request.setAttribute("minPrice", minPriceStr != null ? minPriceStr : "");
        request.setAttribute("maxPrice", maxPriceStr != null ? maxPriceStr : "");
        
        request.getRequestDispatcher("/customer/products.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

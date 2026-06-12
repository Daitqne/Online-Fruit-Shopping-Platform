package controller;

import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Product;

/**
 * Controller servlet for Adding a New Product.
 */
@WebServlet(name = "AddProductController", urlPatterns = {"/add-product"})
public class AddProductController extends HttpServlet {

 
    private static final String DEFAULT_FRUIT_IMAGE =
            "https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?auto=format&fit=crop&q=80&w=600";

    /**
     * Handles the HTTP <code>GET</code> method.
     * Renders the add_product form.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("add_product.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * Processes product parameters and performs database saving with fallbacks.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String name        = request.getParameter("name");
        String priceStr    = request.getParameter("price");
        String discountStr = request.getParameter("discountPrice");
        String image       = request.getParameter("image");
        String description = request.getParameter("description");
        String category    = request.getParameter("category");
        String unit        = request.getParameter("unit");
        String origin      = request.getParameter("origin");
        String status      = request.getParameter("status");

        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("error", "Tên sản phẩm bắt buộc phải nhập!");
            request.getRequestDispatcher("add_product.jsp").forward(request, response);
            return;
        }

        double price = 0.0;
        if (priceStr != null && !priceStr.trim().isEmpty()) {
            try { price = Double.parseDouble(priceStr); if (price < 0) price = 0.0; }
            catch (NumberFormatException e) { price = 0.0; }
        }

        double discountPrice = 0.0;
        if (discountStr != null && !discountStr.trim().isEmpty()) {
            try { discountPrice = Double.parseDouble(discountStr); if (discountPrice < 0) discountPrice = 0.0; }
            catch (NumberFormatException e) { discountPrice = 0.0; }
        }

        if (image    == null || image.trim().isEmpty())    image    = DEFAULT_FRUIT_IMAGE;
        if (category == null || category.trim().isEmpty()) category = "Fruit";
        if (unit     == null || unit.trim().isEmpty())     unit     = "kg";
        if (origin   == null || origin.trim().isEmpty())   origin   = "Vietnam";
        if (status   == null || status.trim().isEmpty())   status   = "Available";

        Product p = new Product();
        p.setName(name.trim());
        p.setPrice(price);
        p.setDiscountPrice(discountPrice);
        p.setImage(image.trim());
        p.setDescription(description != null ? description.trim() : "");
        p.setCategory(category.trim());
        p.setUnit(unit.trim());
        p.setOrigin(origin.trim());
        p.setStatus(status.trim());

        ProductDAO dao = new ProductDAO();
        boolean success = dao.addProduct(p);

        if (success) {
            response.sendRedirect("products");
        } else {
            request.setAttribute("error", "Lưu sản phẩm vào cơ sở dữ liệu thất bại!");
            request.getRequestDispatcher("add_product.jsp").forward(request, response);
        }
    }
}

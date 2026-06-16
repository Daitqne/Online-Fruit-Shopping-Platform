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
 * Controller servlet for Editing an Existing Product.
 * GET  /edit-product?id=X  → render pre-filled form
 * POST /edit-product        → save updated data to DB
 */
@WebServlet(name = "EditProductController", urlPatterns = {"/edit-product"})
public class EditProductController extends HttpServlet {

    private static final String DEFAULT_FRUIT_IMAGE =
            "https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?auto=format&fit=crop&q=80&w=600";

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
            Product p = dao.getProductById(id);

            if (p == null) {
                request.setAttribute("error", "Không tìm thấy sản phẩm với ID = " + id);
                request.getRequestDispatcher("products.jsp").forward(request, response);
                return;
            }

            request.setAttribute("product", p);
            request.getRequestDispatcher("edit_product.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String idStr    = request.getParameter("id");
        String name     = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String image    = request.getParameter("image");
        String desc     = request.getParameter("description");
        String category = request.getParameter("category");
        String featStr  = request.getParameter("isFeatured");

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("products");
            return;
        }

        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("error", "Tên sản phẩm bắt buộc phải nhập!");
            ProductDAO dao = new ProductDAO();
            request.setAttribute("product", dao.getProductById(id));
            request.getRequestDispatcher("edit_product.jsp").forward(request, response);
            return;
        }

        double price = 0.0;
        if (priceStr != null && !priceStr.trim().isEmpty()) {
            try {
                price = Double.parseDouble(priceStr);
                if (price < 0) price = 0.0;
            } catch (NumberFormatException e) {
                price = 0.0;
            }
        }

        if (image == null || image.trim().isEmpty()) {
            image = DEFAULT_FRUIT_IMAGE;
        }

        if (category == null || category.trim().isEmpty()) {
            category = "Trái cây khác";
        }

        boolean isFeatured = "on".equals(featStr) || "true".equals(featStr);

        Product p = new Product();
        p.setId(id);
        p.setName(name.trim());
        p.setPrice(price);
        p.setImage(image.trim());
        p.setDescription(desc != null ? desc.trim() : "");
        p.setCategory(category.trim());
        p.setFeatured(isFeatured);

        ProductDAO dao = new ProductDAO();
        boolean success = dao.updateProduct(p);

        if (success) {
            response.sendRedirect("products");
        } else {
            request.setAttribute("error", "Cập nhật sản phẩm thất bại! Vui lòng thử lại.");
            request.setAttribute("product", p);
            request.getRequestDispatcher("edit_product.jsp").forward(request, response);
        }
    }
}

package controller;

import dal.ProductDAO;
import model.Product;
import model.Authen;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

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
            Product p = dao.getProductById(id);

            if (p == null) {
                request.setAttribute("error", "Không tìm thấy sản phẩm với ID = " + id);
                request.getRequestDispatcher("products_shop_owner.jsp").forward(request, response);
                return;
            }

            request.setAttribute("product", p);
            request.setAttribute("categories", dao.getAllCategories());
            request.getRequestDispatcher("edit_product.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("products-shop-owner");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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

        request.setCharacterEncoding("UTF-8");

        String idStr    = request.getParameter("id");
        String name     = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String discountPriceStr = request.getParameter("discountPrice");
        String unit     = request.getParameter("unit");
        String origin   = request.getParameter("origin");
        String status   = request.getParameter("status");
        String image    = request.getParameter("image");
        String desc     = request.getParameter("description");
        String category = request.getParameter("category");

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("products-shop-owner");
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

        double discountPrice = 0.0;
        if (discountPriceStr != null && !discountPriceStr.trim().isEmpty()) {
            try {
                discountPrice = Double.parseDouble(discountPriceStr);
                if (discountPrice < 0) discountPrice = 0.0;
            } catch (NumberFormatException e) {
                discountPrice = 0.0;
            }
        }

        if (image == null || image.trim().isEmpty()) {
            image = DEFAULT_FRUIT_IMAGE;
        }

        if (category == null || category.trim().isEmpty()) {
            category = "Trái cây khác";
        }

        if (status == null || status.trim().isEmpty()) {
            status = "Available";
        }

        Product p = new Product();
        p.setId(id);
        p.setName(name != null ? name.trim() : "");
        p.setPrice(price);
        p.setDiscountPrice(discountPrice);
        p.setUnit(unit != null ? unit.trim() : "");
        p.setOrigin(origin != null ? origin.trim() : "");
        p.setStatus(status.trim());
        p.setImage(image.trim());
        p.setDescription(desc != null ? desc.trim() : "");
        p.setCategory(category.trim());

        ProductDAO dao = new ProductDAO();

        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("error", "Tên sản phẩm bắt buộc phải nhập!");
            request.setAttribute("product", p);
            request.setAttribute("categories", dao.getAllCategories());
            request.getRequestDispatcher("edit_product.jsp").forward(request, response);
            return;
        }

        boolean success = dao.updateProduct(p);

        if (success) {
            response.sendRedirect("products-shop-owner?success=true");
        } else {
            request.setAttribute("error", "Cập nhật sản phẩm thất bại! Vui lòng thử lại.");
            request.setAttribute("product", p);
            request.setAttribute("categories", dao.getAllCategories());
            request.getRequestDispatcher("edit_product.jsp").forward(request, response);
        }
    }
}

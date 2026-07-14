package controller.shopowner;

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
 * Controller servlet for Adding a New Product.
 */
@WebServlet(name = "AddProductController", urlPatterns = {"/add-product"})
public class AddProductController extends HttpServlet {

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
        
        request.setAttribute("categories", new ProductDAO().getAllCategories());
        request.getRequestDispatcher("/shopowner/add_product.jsp").forward(request, response);
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
        
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String discountPriceStr = request.getParameter("discountPrice");
        String unit = request.getParameter("unit");
        String origin = request.getParameter("origin");
        String status = request.getParameter("status");
        String image = request.getParameter("image");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String lowStockThresholdStr = request.getParameter("lowStockThreshold");
        String initialStockStr = request.getParameter("initialStock");

        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("error", "Tên sản phẩm bắt buộc phải nhập!");
            request.setAttribute("categories", new ProductDAO().getAllCategories());
            request.getRequestDispatcher("/shopowner/add_product.jsp").forward(request, response);
            return;
        }

        double price = 0.0;
        if (priceStr != null && !priceStr.trim().isEmpty()) {
            try {
                price = Double.parseDouble(priceStr);
                if (price < 0) {
                    price = 0.0;
                }
            } catch (NumberFormatException e) {
                price = 0.0;
            }
        }

        double discountPrice = 0.0;
        if (discountPriceStr != null && !discountPriceStr.trim().isEmpty()) {
            try {
                discountPrice = Double.parseDouble(discountPriceStr);
                if (discountPrice < 0) {
                    discountPrice = 0.0;
                }
            } catch (NumberFormatException e) {
                discountPrice = 0.0;
            }
        }

        double importPrice = 0.0;
        String importPriceStr = request.getParameter("importPrice");
        if (importPriceStr != null && !importPriceStr.trim().isEmpty()) {
            try {
                importPrice = Double.parseDouble(importPriceStr);
                if (importPrice < 0) {
                    importPrice = 0.0;
                }
            } catch (NumberFormatException e) {
                importPrice = 0.0;
            }
        }

        java.sql.Date importDate = null;
        String importDateStr = request.getParameter("importDate");
        if (importDateStr != null && !importDateStr.trim().isEmpty()) {
            try {
                importDate = java.sql.Date.valueOf(importDateStr.trim());
            } catch (IllegalArgumentException e) {
                // Invalid date
            }
        }

        java.sql.Date expiredDate = null;
        String expiredDateStr = request.getParameter("expiredDate");
        if (expiredDateStr != null && !expiredDateStr.trim().isEmpty()) {
            try {
                expiredDate = java.sql.Date.valueOf(expiredDateStr.trim());
            } catch (IllegalArgumentException e) {
                // Invalid date
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

        int lowStockThreshold = 10;
        if (lowStockThresholdStr != null && !lowStockThresholdStr.trim().isEmpty()) {
            try {
                lowStockThreshold = Integer.parseInt(lowStockThresholdStr);
                if (lowStockThreshold < 0) lowStockThreshold = 10;
            } catch (NumberFormatException e) {
                lowStockThreshold = 10;
            }
        }

        int initialStock = 100;
        if (initialStockStr != null && !initialStockStr.trim().isEmpty()) {
            try {
                initialStock = Integer.parseInt(initialStockStr);
                if (initialStock < 0) initialStock = 100;
            } catch (NumberFormatException e) {
                initialStock = 100;
            }
        }

        Product p = new Product();
        p.setName(name.trim());
        p.setPrice(price);
        p.setDiscountPrice(discountPrice);
        p.setImportPrice(importPrice);
        p.setImportDate(importDate);
        p.setExpiredDate(expiredDate);
        p.setUnit(unit != null ? unit.trim() : "");
        p.setOrigin(origin != null ? origin.trim() : "");
        p.setStatus("Pending");
        p.setImage(image.trim());
        p.setDescription(description != null ? description.trim() : "");
        p.setCategory(category.trim());
        p.setShopOwnerId(user.getId());
        p.setLowStockThreshold(lowStockThreshold);
        p.setStockQuantity(initialStock);

        ProductDAO dao = new ProductDAO();
        boolean success = dao.addProduct(p);

        if (success) {
            response.sendRedirect("products-shop-owner?success=true");
        } else {
            request.setAttribute("error", "Lưu sản phẩm vào cơ sở dữ liệu thất bại!");
            request.setAttribute("categories", dao.getAllCategories());
            request.getRequestDispatcher("/shopowner/add_product.jsp").forward(request, response);
        }
    }
}

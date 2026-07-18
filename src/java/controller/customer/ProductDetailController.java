package controller.customer;

import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Authen;
import model.Product;

@WebServlet(name = "ProductDetailController", urlPatterns = {"/product-detail"})
public class ProductDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(idParam.trim());
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productId);

        if (product == null) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        // Kiểm tra quyền xem sản phẩm chưa duyệt
        String status = product.getStatus();
        boolean isPublic = "Approved".equalsIgnoreCase(status)
                        || "Available".equalsIgnoreCase(status)
                        || "Featured".equalsIgnoreCase(status);

        if (!isPublic) {
            HttpSession session = request.getSession(false);
            Authen user = (session != null) ? (Authen) session.getAttribute("user") : null;
            boolean isAdmin = user != null && "Admin".equalsIgnoreCase(user.getRole());
            boolean isOwner = user != null && user.getId() == product.getShopOwnerId();

            if (!isAdmin && !isOwner) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN,
                    "Sản phẩm này chưa được duyệt và không thể xem.");
                return;
            }
        }

        // Lấy sản phẩm liên quan (cùng danh mục, loại trừ sản phẩm hiện tại)
        List<Product> relatedProducts = productDAO.getFilteredProducts(
                null, product.getCategory(), null, null, "All"
        );
        relatedProducts.removeIf(p -> p.getId() == productId);
        if (relatedProducts.size() > 4) {
            relatedProducts = relatedProducts.subList(0, 4);
        }

        // Lấy số lượng tồn kho
        int stockQuantity = productDAO.getProductStock(productId);

        dal.WeightVariantDAO variantDAO = new dal.WeightVariantDAO();
        dal.PackagingDAO packagingDAO = new dal.PackagingDAO();
        List<model.WeightVariant> weightVariants = variantDAO.getVariantsByProductId(productId);
        List<model.PackagingOption> packagingOptions = packagingDAO.getPackagingByProductId(productId);

        // Load reviews for this product
        dal.ReviewDAO reviewDAO = new dal.ReviewDAO();
        List<model.Review> reviews = reviewDAO.getReviewsByProductId(productId);
        double avgRating = 0.0;
        int reviewCount = reviews.size();
        int fullStars = 0;
        boolean hasHalfStar = false;
        boolean roundUp = false;
        if (reviewCount > 0) {
            int totalStars = 0;
            for (model.Review r : reviews) {
                totalStars += r.getRating();
            }
            avgRating = (double) totalStars / reviewCount;
            fullStars = (int) avgRating;
            hasHalfStar = (avgRating - fullStars >= 0.25 && avgRating - fullStars <= 0.75);
            roundUp = (avgRating - fullStars > 0.75);
        }

        // Load shop owner info
        dal.AuthenDAO authenDAO = new dal.AuthenDAO();
        model.Authen shopOwner = authenDAO.findById(product.getShopOwnerId());

        request.setAttribute("product", product);
        request.setAttribute("stockQuantity", stockQuantity);
        request.setAttribute("relatedProducts", relatedProducts);
        request.setAttribute("weightVariants", weightVariants);
        request.setAttribute("packagingOptions", packagingOptions);
        request.setAttribute("reviews", reviews);
        request.setAttribute("avgRating", avgRating);
        request.setAttribute("reviewCount", reviewCount);
        request.setAttribute("fullStars", fullStars);
        request.setAttribute("hasHalfStar", hasHalfStar);
        request.setAttribute("roundUp", roundUp);
        request.setAttribute("shopOwner", shopOwner);
        request.getRequestDispatcher("/customer/product_detail.jsp").forward(request, response);
    }
}

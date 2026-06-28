package controller.shopowner;

import dal.ProductDAO;
import dal.WeightVariantDAO;
import model.Product;
import model.WeightVariant;
import model.Authen;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ProductVariantsController", urlPatterns = {"/product-variants"})
public class ProductVariantsController extends HttpServlet {

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
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập!");
            return;
        }

        String productIdStr = request.getParameter("productId");
        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            response.sendRedirect("products-shop-owner");
            return;
        }

        int productId = Integer.parseInt(productIdStr);
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productId);

        if (product == null || product.getShopOwnerId() != user.getId()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Sản phẩm không tồn tại hoặc không thuộc quyền quản lý của bạn!");
            return;
        }

        WeightVariantDAO variantDAO = new WeightVariantDAO();
        List<WeightVariant> variants = variantDAO.getVariantsByProductId(productId);

        request.setAttribute("product", product);
        request.setAttribute("variants", variants);
        request.getRequestDispatcher("/shopowner/product_variants.jsp").forward(request, response);
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
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền thực hiện hành động này!");
            return;
        }

        String productIdStr = request.getParameter("productId");
        String action = request.getParameter("action");
        if (productIdStr == null || action == null) {
            response.sendRedirect("products-shop-owner");
            return;
        }

        int productId = Integer.parseInt(productIdStr);
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productId);

        if (product == null || product.getShopOwnerId() != user.getId()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Sản phẩm không hợp lệ!");
            return;
        }

        WeightVariantDAO variantDAO = new WeightVariantDAO();

        if ("add".equals(action)) {
            String label = request.getParameter("weightLabel");
            String adjStr = request.getParameter("priceAdjustment");
            if (label != null && !label.trim().isEmpty() && adjStr != null) {
                double adj = Double.parseDouble(adjStr);
                WeightVariant variant = new WeightVariant();
                variant.setProductId(productId);
                variant.setWeightLabel(label.trim());
                variant.setPriceAdjustment(adj);
                variantDAO.addVariant(variant);
            }
        } else if ("delete".equals(action)) {
            String variantIdStr = request.getParameter("variantId");
            if (variantIdStr != null) {
                int variantId = Integer.parseInt(variantIdStr);
                variantDAO.deleteVariant(variantId);
            }
        }

        response.sendRedirect("product-variants?productId=" + productId);
    }
}

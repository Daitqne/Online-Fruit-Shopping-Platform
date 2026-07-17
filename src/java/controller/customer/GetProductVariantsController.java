package controller.customer;

import dal.ProductDAO;
import dal.WeightVariantDAO;
import dal.PackagingDAO;
import model.Product;
import model.WeightVariant;
import model.PackagingOption;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "GetProductVariantsController", urlPatterns = {"/get-product-variants"})
public class GetProductVariantsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(productId);

            if (product == null) {
                response.getWriter().write("{\"success\":false,\"message\":\"Sản phẩm không tồn tại\"}");
                return;
            }

            WeightVariantDAO variantDAO = new WeightVariantDAO();
            PackagingDAO packagingDAO = new PackagingDAO();
            List<WeightVariant> weightVariants = variantDAO.getVariantsByProductId(productId);
            List<PackagingOption> packagingOptions = packagingDAO.getPackagingByProductId(productId);

            boolean hasVariants = !weightVariants.isEmpty() || !packagingOptions.isEmpty();

            StringBuilder json = new StringBuilder();
            json.append("{");
            json.append("\"success\":true,");
            json.append("\"hasVariants\":").append(hasVariants).append(",");
            json.append("\"productId\":").append(productId).append(",");
            json.append("\"productName\":\"").append(escapeJson(product.getName())).append("\",");
            json.append("\"basePrice\":").append(product.getPrice()).append(",");
            json.append("\"discountPrice\":").append(product.getDiscountPrice()).append(",");
            json.append("\"unit\":\"").append(escapeJson(product.getUnit())).append("\",");
            json.append("\"image\":\"").append(escapeJson(product.getImage())).append("\",");

            // weightVariants array
            json.append("\"weightVariants\":[");
            for (int i = 0; i < weightVariants.size(); i++) {
                WeightVariant v = weightVariants.get(i);
                json.append("{");
                json.append("\"variantId\":").append(v.getVariantId()).append(",");
                json.append("\"weightLabel\":\"").append(escapeJson(v.getWeightLabel())).append("\",");
                json.append("\"priceAdjustment\":").append(v.getPriceAdjustment());
                json.append("}");
                if (i < weightVariants.size() - 1) {
                    json.append(",");
                }
            }
            json.append("],");

            // packagingOptions array
            json.append("\"packagingOptions\":[");
            for (int i = 0; i < packagingOptions.size(); i++) {
                PackagingOption k = packagingOptions.get(i);
                json.append("{");
                json.append("\"packagingId\":").append(k.getPackagingId()).append(",");
                json.append("\"packagingName\":\"").append(escapeJson(k.getPackagingName())).append("\",");
                json.append("\"priceAdjustment\":").append(k.getPriceAdjustment());
                json.append("}");
                if (i < packagingOptions.size() - 1) {
                    json.append(",");
                }
            }
            json.append("]");
            json.append("}");

            response.getWriter().write(json.toString());

        } catch (Exception e) {
            response.getWriter().write("{\"success\":false,\"message\":\"Lỗi hệ thống: " + escapeJson(e.getMessage()) + "\"}");
        }
    }

    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\b", "\\b")
                  .replace("\f", "\\f")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}

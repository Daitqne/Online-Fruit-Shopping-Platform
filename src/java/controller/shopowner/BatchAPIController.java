package controller.shopowner;

import dal.ImportReceiptDAO;
import model.Authen;
import model.InventoryBatch;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * API để lấy thông tin các lô hàng của sản phẩm.
 */
@WebServlet(name = "BatchAPIController", urlPatterns = {"/api/batches"})
public class BatchAPIController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\": \"Unauthorized\"}");
            return;
        }
        
        Authen user = (Authen) session.getAttribute("user");
        if (!"Shop Owner".equals(user.getRole())) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.getWriter().write("{\"error\": \"Forbidden\"}");
            return;
        }

        String productIdStr = request.getParameter("productId");
        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Missing productId\"}");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdStr);
            ImportReceiptDAO dao = new ImportReceiptDAO();
            List<InventoryBatch> batches = dao.getBatchesByProduct(productId);
            
            // Build JSON manually
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            StringBuilder json = new StringBuilder("[");
            
            for (int i = 0; i < batches.size(); i++) {
                InventoryBatch batch = batches.get(i);
                if (i > 0) json.append(",");
                
                json.append("{");
                json.append("\"batchId\":").append(batch.getBatchId()).append(",");
                json.append("\"productId\":").append(batch.getProductId()).append(",");
                json.append("\"batchNumber\":\"").append(escapeJson(batch.getBatchNumber())).append("\",");
                json.append("\"quantityIn\":").append(batch.getQuantityIn()).append(",");
                json.append("\"quantityRemain\":").append(batch.getQuantityRemain()).append(",");
                
                if (batch.getManufactureDate() != null) {
                    json.append("\"manufactureDate\":\"").append(sdf.format(batch.getManufactureDate())).append("\",");
                } else {
                    json.append("\"manufactureDate\":null,");
                }
                
                json.append("\"expiryDate\":\"").append(sdf.format(batch.getExpiryDate())).append("\"");
                json.append("}");
            }
            
            json.append("]");
            response.getWriter().write(json.toString());
            
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Invalid productId\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Internal server error\"}");
            e.printStackTrace();
        }
    }
    
    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}

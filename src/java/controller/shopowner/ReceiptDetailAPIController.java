package controller.shopowner;

import dal.ImportReceiptDAO;
import model.Authen;
import model.ImportReceipt;
import model.ImportReceiptItem;
import java.io.IOException;
import java.text.SimpleDateFormat;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * API để lấy chi tiết phiếu nhập kho.
 */
@WebServlet(name = "ReceiptDetailAPIController", urlPatterns = {"/api/receipt-detail"})
public class ReceiptDetailAPIController extends HttpServlet {

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

        String receiptIdStr = request.getParameter("receiptId");
        if (receiptIdStr == null || receiptIdStr.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Missing receiptId\"}");
            return;
        }

        try {
            int receiptId = Integer.parseInt(receiptIdStr);
            ImportReceiptDAO dao = new ImportReceiptDAO();
            ImportReceipt receipt = dao.getReceiptDetail(receiptId);
            
            if (receipt == null || receipt.getCreatedBy() != user.getId()) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\": \"Receipt not found or access denied\"}");
                return;
            }
            
            // Build JSON
            SimpleDateFormat sdfDateTime = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
            SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
            
            StringBuilder json = new StringBuilder("{");
            json.append("\"receiptId\":").append(receipt.getReceiptId()).append(",");
            json.append("\"importDate\":\"").append(sdfDateTime.format(receipt.getImportDate())).append("\",");
            json.append("\"note\":").append(receipt.getNote() != null ? "\"" + escapeJson(receipt.getNote()) + "\"" : "null").append(",");
            json.append("\"items\":[");
            
            for (int i = 0; i < receipt.getItems().size(); i++) {
                ImportReceiptItem item = receipt.getItems().get(i);
                if (i > 0) json.append(",");
                
                json.append("{");
                json.append("\"productId\":").append(item.getProductId()).append(",");
                json.append("\"productName\":\"").append(escapeJson(item.getProduct().getName())).append("\",");
                json.append("\"quantity\":").append(item.getQuantity()).append(",");
                json.append("\"batchNumber\":\"").append(escapeJson(item.getBatchNumber())).append("\",");
                json.append("\"expiryDate\":\"").append(sdfDate.format(item.getExpiryDate())).append("\"");
                json.append("}");
            }
            
            json.append("]}");
            response.getWriter().write(json.toString());
            
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Invalid receiptId\"}");
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

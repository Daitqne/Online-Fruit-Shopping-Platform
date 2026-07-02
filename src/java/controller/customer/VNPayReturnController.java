package controller.customer;

import dal.OrderDAO;
import dal.NotificationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.*;
import model.Authen;
import utils.VNPayConfig;

@WebServlet(name = "VNPayReturnController", urlPatterns = {"/vnpay-return"})
public class VNPayReturnController extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();
    private final NotificationDAO notificationDAO = new NotificationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Authen user = (Authen) session.getAttribute("user");
        
        // Read VNPAY parameters
        Map<String, String> fields = new HashMap<>();
        for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements();) {
            String fieldName = params.nextElement();
            String fieldValue = request.getParameter(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                fields.put(fieldName, fieldValue);
            }
        }

        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
        if (fields.containsKey("vnp_SecureHashType")) {
            fields.remove("vnp_SecureHashType");
        }
        if (fields.containsKey("vnp_SecureHash")) {
            fields.remove("vnp_SecureHash");
        }
        
        // Sort parameters alphabetically
        List<String> fieldNames = new ArrayList<>(fields.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        boolean isFirst = true;
        for (String fieldName : fieldNames) {
            String fieldValue = fields.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                if (!isFirst) {
                    hashData.append('&');
                }
                isFirst = false;
                
                // Build hash data (re-encoding values because request.getParameter() decoded them)
                hashData.append(fieldName);
                hashData.append('=');
                hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.UTF_8.toString()).replaceAll("\\+", "%20"));
            }
        }

        String signValue = VNPayConfig.hmacSHA512(VNPayConfig.vnp_HashSecret, hashData.toString());
        boolean isSignValid = signValue.equalsIgnoreCase(vnp_SecureHash);

        if (isSignValid) {
            String orderIdStr = request.getParameter("vnp_TxnRef");
            String responseCode = request.getParameter("vnp_ResponseCode");
            String transactionNo = request.getParameter("vnp_TransactionNo");
            
            int orderId = 0;
            try {
                orderId = Integer.parseInt(orderIdStr);
            } catch (NumberFormatException e) {
                // Invalid order ID
            }

            if ("00".equals(responseCode)) {
                // Success! Update payment status to 'Paid' and order status to 'Processing'
                if (orderId > 0) {
                    orderDAO.updateOrderStatusAndPaymentStatus(orderId, "Processing", "Paid");
                    
                    // Add notification to customer
                    if (user != null) {
                        notificationDAO.addNotification(user.getId(),
                            "Thanh toán thành công",
                            "Đơn hàng #" + orderId + " đã được thanh toán thành công trực tuyến qua VNPAY. Mã giao dịch: " + transactionNo);
                    }
                    
                    session.setAttribute("promoSuccess", "Thanh toán thành công qua VNPAY!");
                    response.sendRedirect(request.getContextPath() + "/checkout?action=success&orderId=" + orderId);
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Mã đơn hàng không hợp lệ.");
                }
            } else {
                // Failed or cancelled! Update payment status to 'Failed'
                if (orderId > 0) {
                    orderDAO.updatePaymentStatus(orderId, "Failed");
                    
                    if (user != null) {
                        notificationDAO.addNotification(user.getId(),
                            "Thanh toán thất bại",
                            "Giao dịch thanh toán VNPAY cho đơn hàng #" + orderId + " đã thất bại hoặc bị hủy.");
                    }
                    
                    session.setAttribute("checkoutError", "Thanh toán qua VNPAY không thành công hoặc bị hủy. (Mã lỗi: " + responseCode + ")");
                    response.sendRedirect(request.getContextPath() + "/checkout");
                } else {
                    response.sendRedirect(request.getContextPath() + "/checkout");
                }
            }
        } else {
            // Invalid Signature
            session.setAttribute("checkoutError", "Chữ ký bảo mật VNPAY không hợp lệ hoặc dữ liệu bị giả mạo. Giao dịch thất bại.");
            response.sendRedirect(request.getContextPath() + "/checkout");
        }
    }
}

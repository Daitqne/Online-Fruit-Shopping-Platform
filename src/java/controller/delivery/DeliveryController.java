package controller.delivery;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import dal.DeliveryDAO;
import dal.NotificationDAO;
import model.Authen;
import model.Delivery;
import model.Notification;
import model.SaleOrderItem;

@WebServlet(name = "DeliveryController", urlPatterns = {"/delivery"})
public class DeliveryController extends HttpServlet {

    private String jsonEscape(String str) {
        if (str == null) return "\"\"";
        return "\"" + str.replace("\\", "\\\\")
                        .replace("\"", "\\\"")
                        .replace("\n", "\\n")
                        .replace("\r", "\\r") + "\"";
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Authen user = (Authen) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        if (!"Delivery".equalsIgnoreCase(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập.");
            return;
        }

        DeliveryDAO dld = new DeliveryDAO();
        NotificationDAO ntd = new NotificationDAO();

        String action = request.getParameter("action");

        // Handle AJAX request for Quick View Modal items
        if ("get_items".equals(action)) {
            response.setContentType("application/json;charset=UTF-8");
            String orderIdStr = request.getParameter("orderId");
            if (orderIdStr != null) {
                try {
                    int orderId = Integer.parseInt(orderIdStr.trim());
                    List<SaleOrderItem> items = dld.getSaleOrderItems(orderId);
                    StringBuilder sb = new StringBuilder("[");
                    for (int i = 0; i < items.size(); i++) {
                        SaleOrderItem item = items.get(i);
                        if (i > 0) sb.append(",");
                        sb.append("{");
                        sb.append("\"productName\":").append(jsonEscape(item.getProduct() != null ? item.getProduct().getName() : "Sản phẩm")).append(",");
                        sb.append("\"image\":").append(jsonEscape(item.getProduct() != null && item.getProduct().getImage() != null ? item.getProduct().getImage() : "")).append(",");
                        sb.append("\"quantity\":").append(item.getQuantity()).append(",");
                        sb.append("\"unitPrice\":").append(item.getUnitPrice()).append(",");
                        sb.append("\"weightLabel\":").append(jsonEscape(item.getWeightLabel() != null ? item.getWeightLabel() : "")).append(",");
                        sb.append("\"packagingName\":").append(jsonEscape(item.getPackagingName() != null ? item.getPackagingName() : ""));
                        sb.append("}");
                    }
                    sb.append("]");
                    response.getWriter().write(sb.toString());
                    return;
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            response.getWriter().write("[]");
            return;
        }

        // Search & Filter parameters
        String keyword = request.getParameter("keyword");
        String paymentMethod = request.getParameter("paymentMethod");
        String statusFilter = request.getParameter("statusFilter");

        List<Delivery> unassigned = dld.getUnassignedDeliveriesFiltered(keyword, paymentMethod);
        List<Delivery> staffDeliveries = dld.getDeliveriesByStaffFiltered(user.getId(), keyword, paymentMethod, statusFilter);
        List<Delivery> allStaffDeliveries = dld.getDeliveriesByStaff(user.getId()); // Unfiltered for stats calculation

        List<Notification> notifs = ntd.getNotificationsByUserId(user.getId());
        long unread = notifs.stream().filter(n -> !n.isRead()).count();

        // Calculate KPI Statistics
        int totalUnassignedCount = dld.getUnassignedDeliveries().size();
        long myShippingCount = allStaffDeliveries.stream().filter(d -> "Shipping".equalsIgnoreCase(d.getStatus())).count();
        long completedTodayCount = allStaffDeliveries.stream().filter(d -> "Delivered".equalsIgnoreCase(d.getStatus())).count();
        double totalCodAmount = allStaffDeliveries.stream()
                .filter(d -> "Shipping".equalsIgnoreCase(d.getStatus()))
                .filter(d -> d.getPaymentMethod() != null && (d.getPaymentMethod().toLowerCase().contains("cod") 
                        || d.getPaymentMethod().toLowerCase().contains("tiền mặt") 
                        || d.getPaymentMethod().toLowerCase().contains("cash")
                        || "Pending".equalsIgnoreCase(d.getPaymentStatus())))
                .mapToDouble(Delivery::getTotalAmount)
                .sum();

        request.setAttribute("unassigned", unassigned);
        request.setAttribute("myDeliveries", staffDeliveries);
        request.setAttribute("notifications", notifs);
        request.setAttribute("unreadCount", unread);

        request.setAttribute("totalUnassignedCount", totalUnassignedCount);
        request.setAttribute("myShippingCount", myShippingCount);
        request.setAttribute("completedTodayCount", completedTodayCount);
        request.setAttribute("totalCodAmount", totalCodAmount);

        request.setAttribute("paramKeyword", keyword != null ? keyword : "");
        request.setAttribute("paramPaymentMethod", paymentMethod != null ? paymentMethod : "");
        request.setAttribute("paramStatusFilter", statusFilter != null ? statusFilter : "");

        request.getRequestDispatcher("/delivery/delivery.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Authen user = (Authen) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        if (!"Delivery".equalsIgnoreCase(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập.");
            return;
        }

        String action = request.getParameter("action");
        String idStr = request.getParameter("deliveryId");
        String reason = request.getParameter("reason");
        String customReason = request.getParameter("customReason");
        DeliveryDAO dld = new DeliveryDAO();

        if (action != null && idStr != null && !idStr.trim().isEmpty()) {
            try {
                int deliveryId = Integer.parseInt(idStr.trim());
                switch (action) {
                    case "claim":
                        dld.claimDelivery(deliveryId, user.getId());
                        break;
                    case "confirm":
                        dld.confirmDelivery(deliveryId, user.getId());
                        break;
                    case "report_fail":
                        String finalReason = (reason != null && !reason.trim().isEmpty())
                                ? reason.trim() : "Khách không nhận hàng";
                        if (customReason != null && !customReason.trim().isEmpty()) {
                            finalReason += " - " + customReason.trim();
                        }
                        dld.reportDeliveryFailure(deliveryId, user.getId(), finalReason);
                        break;
                }
            } catch (NumberFormatException e) {
                // ignore
            }
        }

        response.sendRedirect(request.getContextPath() + "/delivery");
    }

    @Override
    public String getServletInfo() {
        return "Delivery Controller for Shipper Management";
    }
}

package controller;

import dal.DeliveryDAO;
import dal.OrderDAO;
import dal.NotificationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Authen;
import model.Notification;
import model.SaleOrder;

@WebServlet(name = "ShopOwnerOrderController", urlPatterns = {"/shop-owner-orders"})
public class ShopOwnerOrderController extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();
    private final DeliveryDAO deliveryDAO = new DeliveryDAO();
    private final NotificationDAO notifDAO = new NotificationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Authen user = (Authen) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        if (!"Shop Owner".equalsIgnoreCase(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Ban khong co quyen truy cap.");
            return;
        }

        // Flash messages from session
        String successMsg = (String) session.getAttribute("orderSuccess");
        String errorMsg   = (String) session.getAttribute("orderError");
        session.removeAttribute("orderSuccess");
        session.removeAttribute("orderError");
        request.setAttribute("successMsg", successMsg);
        request.setAttribute("errorMsg", errorMsg);

        // Load orders for this shop owner
        List<SaleOrder> orders = orderDAO.getOrdersByShopOwner(user.getId());

        // Filter by status if requested
        String filterStatus = request.getParameter("status");
        if (filterStatus != null && !filterStatus.trim().isEmpty() && !"all".equalsIgnoreCase(filterStatus)) {
            orders = orders.stream()
                .filter(o -> filterStatus.equalsIgnoreCase(o.getOrderStatus()))
                .collect(java.util.stream.Collectors.toList());
        }

        // Counts for badges
        long countPending    = countByStatus(orderDAO.getOrdersByShopOwner(user.getId()), "Pending");
        long countProcessing = countByStatus(orderDAO.getOrdersByShopOwner(user.getId()), "Processing");
        long countShipping   = countByStatus(orderDAO.getOrdersByShopOwner(user.getId()), "Shipping");
        long countDelivered  = countByStatus(orderDAO.getOrdersByShopOwner(user.getId()), "Delivered");

        request.setAttribute("orders", orders);
        request.setAttribute("filterStatus", filterStatus);
        request.setAttribute("countPending", countPending);
        request.setAttribute("countProcessing", countProcessing);
        request.setAttribute("countShipping", countShipping);
        request.setAttribute("countDelivered", countDelivered);

        // Notifications (reuse same pattern as other shop owner pages)
        try {
            java.util.List<model.Notification> notifs = notifDAO.getNotificationsByUserId(user.getId());
            long unread = notifs.stream().filter(n -> !n.isRead()).count();
            request.setAttribute("notifications", notifs);
            request.setAttribute("unreadCount", unread);
        } catch (Exception e) {
            // non-fatal
        }

        request.getRequestDispatcher("/orders_shop_owner.jsp").forward(request, response);
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
        if (!"Shop Owner".equalsIgnoreCase(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Ban khong co quyen truy cap.");
            return;
        }

        String action  = request.getParameter("action");
        String idStr   = request.getParameter("orderId");

        if (action != null && idStr != null && !idStr.trim().isEmpty()) {
            try {
                int orderId = Integer.parseInt(idStr.trim());
                String newStatus = null;

                switch (action) {
                    case "confirm":     newStatus = "Processing"; break;
                    case "ship":        newStatus = "Shipping";   break;
                    case "delivered":   newStatus = "Delivered";  break;
                    case "cancel":      newStatus = "Cancelled";  break;
                }

                if (newStatus != null) {
                    boolean ok = orderDAO.updateOrderStatus(orderId, newStatus);
                    if (ok) {
                        if (newStatus.equals("Shipping")) {
                            SaleOrder order = orderDAO.getOrderById(orderId);
                            if (order != null) {
                                deliveryDAO.createDelivery(orderId, order.getShippingAddress());
                                notifDAO.notifyDeliveryStaff(orderId);
                            }
                        }
                        session.setAttribute("orderSuccess",
                            "Cap nhat trang thai don hang #" + orderId + " thanh '" + newStatus + "' thanh cong!");
                    } else {
                        session.setAttribute("orderError",
                            "Khong the cap nhat trang thai don hang #" + orderId + ".");
                    }
                }
            } catch (NumberFormatException e) {
                session.setAttribute("orderError", "Ma don hang khong hop le.");
            }
        }

        // Redirect back (preserve filter)
        String backStatus = request.getParameter("filterStatus");
        String redirect = request.getContextPath() + "/shop-owner-orders";
        if (backStatus != null && !backStatus.trim().isEmpty()) {
            redirect += "?status=" + backStatus;
        }
        response.sendRedirect(redirect);
    }

    private long countByStatus(List<SaleOrder> orders, String status) {
        return orders.stream().filter(o -> status.equalsIgnoreCase(o.getOrderStatus())).count();
    }
}

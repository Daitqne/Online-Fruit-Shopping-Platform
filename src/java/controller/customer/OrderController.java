package controller.customer;

import dal.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Authen;
import model.SaleOrder;

@WebServlet(name = "OrderController", urlPatterns = {"/orders"})
public class OrderController extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Authen user = (Authen) session.getAttribute("user");
        
        if (user == null) {
            session.setAttribute("redirectUrl", request.getRequestURI() + (request.getQueryString() != null ? "?" + request.getQueryString() : ""));
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null || action.trim().isEmpty()) {
            action = "list";
        }

        // Role check
        if (!"invoice".equalsIgnoreCase(action)) {
            if (!"Customer".equalsIgnoreCase(user.getRole())) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập chức năng này.");
                return;
            }
        } else {
            if (!"Customer".equalsIgnoreCase(user.getRole()) && !"Shop Owner".equalsIgnoreCase(user.getRole())) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập chức năng này.");
                return;
            }
        }

        switch (action) {
            case "detail":
                handleViewDetail(request, response, session, user);
                break;
            case "cancel":
                handleCancelOrder(request, response, session, user);
                break;
            case "changeToCOD":
                handleChangeToCOD(request, response, session, user);
                break;
            case "invoice":
                handleViewInvoice(request, response, session, user);
                break;
            case "list":
            default:
                handleListOrders(request, response, user);
                break;
        }
    }

    private void handleListOrders(HttpServletRequest request, HttpServletResponse response, Authen user)
            throws ServletException, IOException {
        
        List<SaleOrder> orders = orderDAO.getOrdersByUserId(user.getId());
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/customer/orders.jsp").forward(request, response);
    }

    private void handleViewDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session, Authen user)
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/orders");
            return;
        }

        try {
            int orderId = Integer.parseInt(idStr);
            SaleOrder order = orderDAO.getOrderById(orderId);
            
            if (order == null || order.getCreatedBy() != user.getId()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy đơn hàng hoặc đơn hàng không thuộc về bạn.");
                return;
            }

            // Flush flash attributes from session to request
            String orderSuccess = (String) session.getAttribute("orderSuccess");
            String orderError = (String) session.getAttribute("orderError");
            session.removeAttribute("orderSuccess");
            session.removeAttribute("orderError");

            request.setAttribute("order", order);
            request.setAttribute("orderSuccess", orderSuccess);
            request.setAttribute("orderError", orderError);
            request.getRequestDispatcher("/customer/order-details.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/orders");
        }
    }

    private void handleCancelOrder(HttpServletRequest request, HttpServletResponse response, HttpSession session, Authen user)
            throws IOException {
        
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/orders");
            return;
        }

        try {
            int orderId = Integer.parseInt(idStr);
            boolean success = orderDAO.cancelOrder(orderId, user.getId());
            
            if (success) {
                session.setAttribute("orderSuccess", "Đã hủy đơn hàng thành công và hoàn trả số lượng vào kho hàng.");
            } else {
                session.setAttribute("orderError", "Không thể hủy đơn hàng. Đơn hàng chỉ có thể hủy khi ở trạng thái 'Pending' (Chờ xử lý).");
            }
            response.sendRedirect(request.getContextPath() + "/orders?action=detail&id=" + orderId);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/orders");
        }
    }

    private void handleViewInvoice(HttpServletRequest request, HttpServletResponse response, HttpSession session, Authen user)
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/orders");
            return;
        }

        try {
            int orderId = Integer.parseInt(idStr);
            SaleOrder order = orderDAO.getOrderById(orderId);
            
            if (order == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy đơn hàng.");
                return;
            }

            // Security check: if customer, must be their own order. If shop owner, allowed.
            if ("Customer".equalsIgnoreCase(user.getRole()) && order.getCreatedBy() != user.getId()) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền xem hóa đơn của đơn hàng này.");
                return;
            }

            String download = request.getParameter("download");
            request.setAttribute("order", order);
            request.setAttribute("download", "true".equalsIgnoreCase(download));
            
            request.getRequestDispatcher("/delivery/invoice.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/orders");
        }
    }

    private void handleChangeToCOD(HttpServletRequest request, HttpServletResponse response, HttpSession session, Authen user)
            throws IOException {
        
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/orders");
            return;
        }

        try {
            int orderId = Integer.parseInt(idStr);
            SaleOrder order = orderDAO.getOrderById(orderId);
            
            if (order == null || order.getCreatedBy() != user.getId()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy đơn hàng hoặc đơn hàng không thuộc về bạn.");
                return;
            }

            if (!"Pending".equalsIgnoreCase(order.getOrderStatus())) {
                session.setAttribute("orderError", "Đơn hàng này đã được xử lý hoặc đã hủy, không thể đổi phương thức thanh toán.");
                response.sendRedirect(request.getContextPath() + "/orders?action=detail&id=" + orderId);
                return;
            }

            if ("Paid".equalsIgnoreCase(order.getPaymentStatus())) {
                session.setAttribute("orderError", "Đơn hàng này đã được thanh toán thành công, không thể đổi sang COD.");
                response.sendRedirect(request.getContextPath() + "/orders?action=detail&id=" + orderId);
                return;
            }

            boolean success = orderDAO.updatePaymentMethodAndStatus(orderId, "COD", "Pending");
            if (success) {
                dal.NotificationDAO notifDAO = new dal.NotificationDAO();
                notifDAO.addNotification(user.getId(),
                    "Thay đổi phương thức thanh toán",
                    "Đơn hàng #" + orderId + " đã được thay đổi phương thức thanh toán sang COD thành công.");
                
                session.setAttribute("orderSuccess", "Đổi phương thức thanh toán sang COD thành công!");
            } else {
                session.setAttribute("orderError", "Không thể cập nhật phương thức thanh toán trong cơ sở dữ liệu.");
            }
            response.sendRedirect(request.getContextPath() + "/orders?action=detail&id=" + orderId);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/orders");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

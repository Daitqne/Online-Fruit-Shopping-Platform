package controller.customer;

import dal.NotificationDAO;
import model.Authen;
import model.Notification;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet(name = "CustomerNotificationController", urlPatterns = {"/customer/notifications"})
public class CustomerNotificationController extends HttpServlet {

    private final NotificationDAO notificationDAO = new NotificationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Authen user = (Authen) session.getAttribute("user");

        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With")) 
                || "true".equals(request.getParameter("ajax"));

        if (user == null) {
            if (isAjax) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\":false,\"message\":\"Chưa đăng nhập\"}");
            } else {
                session.setAttribute("redirectUrl", request.getRequestURI() + (request.getQueryString() != null ? "?" + request.getQueryString() : ""));
                response.sendRedirect(request.getContextPath() + "/login");
            }
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        if (isAjax) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            List<Notification> list = notificationDAO.getNotificationsByUserId(user.getId());
            long unreadCount = list.stream().filter(n -> !n.isRead()).count();

            // Limit to 5 notifications if requested for dropdown
            if ("dropdown".equals(request.getParameter("view"))) {
                if (list.size() > 5) {
                    list = list.subList(0, 5);
                }
            }

            StringBuilder json = new StringBuilder();
            json.append("{");
            json.append("\"success\":true,");
            json.append("\"unreadCount\":").append(unreadCount).append(",");
            json.append("\"notifications\":[");
            
            SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            for (int i = 0; i < list.size(); i++) {
                Notification n = list.get(i);
                json.append("{");
                json.append("\"id\":").append(n.getNotificationId()).append(",");
                json.append("\"title\":\"").append(escapeJson(n.getTitle())).append("\",");
                json.append("\"content\":\"").append(escapeJson(n.getContent())).append("\",");
                json.append("\"isRead\":").append(n.isRead()).append(",");
                
                String timeStr = n.getCreatedAt() != null ? df.format(n.getCreatedAt()) : "";
                String friendlyTime = getFriendlyTime(n.getCreatedAt());
                json.append("\"createdAt\":\"").append(timeStr).append("\",");
                json.append("\"friendlyTime\":\"").append(friendlyTime).append("\"");
                json.append("}");
                if (i < list.size() - 1) {
                    json.append(",");
                }
            }
            json.append("]");
            json.append("}");

            response.getWriter().write(json.toString());
        } else {
            // Standard Page Forward
            List<Notification> list = notificationDAO.getNotificationsByUserId(user.getId());
            long unreadCount = list.stream().filter(n -> !n.isRead()).count();
            
            request.setAttribute("notifications", list);
            request.setAttribute("unreadCount", unreadCount);
            request.getRequestDispatcher("/customer/notifications.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Authen user = (Authen) session.getAttribute("user");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"success\":false,\"message\":\"Chưa đăng nhập\"}");
            return;
        }

        String action = request.getParameter("action");
        if ("read-all".equals(action)) {
            boolean success = notificationDAO.markAllAsRead(user.getId());
            response.getWriter().write("{\"success\":" + success + "}");
        } else if ("read".equals(action)) {
            try {
                int notificationId = Integer.parseInt(request.getParameter("id"));
                boolean success = notificationDAO.markAsRead(notificationId);
                response.getWriter().write("{\"success\":" + success + "}");
            } catch (NumberFormatException e) {
                response.getWriter().write("{\"success\":false,\"message\":\"ID không hợp lệ\"}");
            }
        } else {
            response.getWriter().write("{\"success\":false,\"message\":\"Hành động không được hỗ trợ\"}");
        }
    }

    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\\", "\\\\")
                    .replace("\"", "\\\"")
                    .replace("\b", "\\b")
                    .replace("\f", "\\f")
                    .replace("\n", "\\n")
                    .replace("\r", "\\r")
                    .replace("\t", "\\t");
    }

    private String getFriendlyTime(java.sql.Timestamp ts) {
        if (ts == null) {
            return "Vừa xong";
        }
        long diff = System.currentTimeMillis() - ts.getTime();
        long diffSeconds = diff / 1000;

        if (diffSeconds < 60) {
            return "Vừa xong";
        } else if (diffSeconds < 3600) {
            long min = diff / (60 * 1000);
            return min + " phút trước";
        } else if (diffSeconds < 86400) {
            long hr = diff / (3600 * 1000);
            return hr + " giờ trước";
        } else {
            long diffDays = diff / (24 * 60 * 60 * 1000);
            if (diffDays == 1) {
                return "Hôm qua";
            } else if (diffDays < 7) {
                return diffDays + " ngày trước";
            } else {
                return new SimpleDateFormat("dd/MM/yyyy").format(ts);
            }
        }
    }
}

package controller.shopowner;

import dal.RevenueDAO;
import dal.NotificationDAO;
import model.Authen;
import model.Notification;
import model.RevenueReport;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ShopOwnerRevenueController", urlPatterns = {"/shop-owner-revenue"})
public class ShopOwnerRevenueController extends HttpServlet {

    //final là không thể thay đổi sau khi khởi tọa như là đã gán r thì không gán đc lần 2
    private final  RevenueDAO revenueDAO = new RevenueDAO();
    private final NotificationDAO notificationDAO = new NotificationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        Authen user = (Authen) session.getAttribute("user");
        //ss ngược để đỡ null pointerException
        if (!"Shop Owner".equals(user.getRole())) {
            //SC_FORBIDDEN: Status code 403 (Forbidden - Không có quyền)
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang này!");
            return;
        }

        int shopOwnerId = user.getId();
        
        // lấy filter parameters(dữ liệu) from request
        String reportType = request.getParameter("type");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        
        // mặc định type là day
        if (reportType == null || reportType.trim().isEmpty()) {
            reportType = "day";
        }
        
        // lấy ngày hôm nay của máy chủ đang chạy chương trình set end date 
        LocalDate endDate = LocalDate.now();
        LocalDate startDate;
        

        if (startDateStr == null || startDateStr.trim().isEmpty() || endDateStr == null || endDateStr.trim().isEmpty()) {
            if ("week".equals(reportType)) {
                // Tuần này: từ thứ 2 đến hôm nay
                int dayOfWeek = endDate.getDayOfWeek().getValue(); // 1 = Monday, 7 = Sunday
                startDate = endDate.minusDays(dayOfWeek - 1);
            } else if ("month".equals(reportType)) {
                // Tháng này: từ ngày 1 đến hôm nay
                startDate = endDate.withDayOfMonth(1);
            } else {
                // Ngày: chỉ hôm nay
                startDate = endDate;
            }
        } else {
            // Use provided date parameters
            try {
                startDate = LocalDate.parse(startDateStr);
            } catch (Exception e) {
                startDate = endDate;
            }
            
            try {
                endDate = LocalDate.parse(endDateStr);
            } catch (Exception e) {
                endDate = LocalDate.now();
            }
        }
        //Convert LocalDate → java.sql.Date "LocalDate: Java 8+ (không dùng được cho JDBC)"
        Date sqlStartDate = Date.valueOf(startDate);
        Date sqlEndDate = Date.valueOf(endDate);
        
        // Get revenue data based on report type
        List<RevenueReport> revenueData = null;
        
        switch (reportType) {
            case "week":
                revenueData = revenueDAO.getWeeklyRevenue(shopOwnerId, sqlStartDate, sqlEndDate);
                break;
            case "month":
                revenueData = revenueDAO.getMonthlyRevenue(shopOwnerId, sqlStartDate, sqlEndDate);
                break;
            default:
                revenueData = revenueDAO.getDailyRevenue(shopOwnerId, sqlStartDate, sqlEndDate);
                break;
        }
        
        // Get summary statistics
        Map<String, Object> summary = revenueDAO.getRevenueSummary(shopOwnerId, sqlStartDate, sqlEndDate);
        
        // Calculate total revenue
        double totalRevenue = revenueData.stream()
                .mapToDouble(RevenueReport::getNetRevenue)
                .sum();
        
        int totalOrders = revenueData.stream()
                .mapToInt(RevenueReport::getTotalOrders)
                .sum();
        
        int totalProductsSold = revenueData.stream()
                .mapToInt(RevenueReport::getTotalProductsSold)
                .sum();
        
        double avgOrderValue = totalOrders > 0 ? totalRevenue / totalOrders : 0;
        
        // Get notifications
        List<Notification> notifications = notificationDAO.getNotificationsByUserId(shopOwnerId);
        long unreadCount = notifications.stream().filter(n -> !n.isRead()).count();
        
        // Set attributes
        request.setAttribute("revenueData", revenueData);
        request.setAttribute("summary", summary);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalProductsSold", totalProductsSold);
        request.setAttribute("avgOrderValue", avgOrderValue);
        request.setAttribute("reportType", reportType);
        request.setAttribute("startDate", startDate.toString());
        request.setAttribute("endDate", endDate.toString());
        request.setAttribute("notifications", notifications);
        request.setAttribute("unreadCount", unreadCount);
        
        request.getRequestDispatcher("/shopowner/revenue_shop_owner.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.RevenueReport;

/**
 * Revenue Data Access Object for Shop Owner revenue reports
 */
public class RevenueDAO extends DBContext {

    /**
     * Get daily revenue report for a shop owner
     * @param shopOwnerId Shop owner's user ID
     * @param startDate Start date of report period
     * @param endDate End date of report period
     * @return List of daily revenue reports
     */
    public List<RevenueReport> getDailyRevenue(int shopOwnerId, Date startDate, Date endDate) {
        List<RevenueReport> reports = new ArrayList<>();
        String sql = """
            SELECT 
                CAST(COALESCE(so.delivered_date, so.order_date) AS DATE) as report_date,
                COUNT(DISTINCT so.sale_order_id) as total_orders,
                SUM(soi.quantity) as total_products_sold,
                SUM(soi.quantity * soi.unit_price) as subtotal,
                SUM(soi.quantity * soi.unit_price) as total_payment
            FROM Sale_Order so
            JOIN Sale_Order_Item soi ON so.sale_order_id = soi.sale_order_id
            JOIN Product p ON soi.product_id = p.product_id
            WHERE p.shop_owner_id = ?
                AND so.order_status = 'Delivered'
                AND CAST(COALESCE(so.delivered_date, so.order_date) AS DATE) BETWEEN ? AND ?
            GROUP BY CAST(COALESCE(so.delivered_date, so.order_date) AS DATE)
            ORDER BY report_date DESC
        """;

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, shopOwnerId);
            ps.setDate(2, startDate);
            ps.setDate(3, endDate);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    RevenueReport report = new RevenueReport();
                    report.setReportDate(rs.getDate("report_date"));
                    report.setPeriodLabel(rs.getDate("report_date").toString());
                    report.setTotalOrders(rs.getInt("total_orders"));
                    report.setTotalProductsSold(rs.getInt("total_products_sold"));
                    report.setSubtotal(rs.getDouble("subtotal"));
                    report.setTotalDiscount(0.0); // Simplified for now
                    report.setTotalShippingFee(0.0); // Simplified for now
                    report.setTotalPayment(rs.getDouble("total_payment"));
                    report.setNetRevenue(rs.getDouble("subtotal"));
                    reports.add(report);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(RevenueDAO.class.getName()).log(Level.SEVERE, "Failed to get daily revenue", ex);
        }
        return reports;
    }

    /**
     * Get weekly revenue report for a shop owner
     * @param shopOwnerId Shop owner's user ID
     * @param startDate Start date of report period
     * @param endDate End date of report period
     * @return List of weekly revenue reports
     */
    public List<RevenueReport> getWeeklyRevenue(int shopOwnerId, Date startDate, Date endDate) {
        List<RevenueReport> reports = new ArrayList<>();
        String sql = """
            SELECT 
                DATEPART(ISO_WEEK, COALESCE(so.delivered_date, so.order_date)) as week_number,
                DATEPART(YEAR, COALESCE(so.delivered_date, so.order_date)) as year_number,
                MIN(CAST(COALESCE(so.delivered_date, so.order_date) AS DATE)) as week_start,
                MAX(CAST(COALESCE(so.delivered_date, so.order_date) AS DATE)) as week_end,
                COUNT(DISTINCT so.sale_order_id) as total_orders,
                SUM(soi.quantity) as total_products_sold,
                SUM(soi.quantity * soi.unit_price) as subtotal,
                SUM(soi.quantity * soi.unit_price) as total_payment
            FROM Sale_Order so
            JOIN Sale_Order_Item soi ON so.sale_order_id = soi.sale_order_id
            JOIN Product p ON soi.product_id = p.product_id
            WHERE p.shop_owner_id = ?
                AND so.order_status = 'Delivered'
                AND CAST(COALESCE(so.delivered_date, so.order_date) AS DATE) BETWEEN ? AND ?
            GROUP BY DATEPART(ISO_WEEK, COALESCE(so.delivered_date, so.order_date)), 
                     DATEPART(YEAR, COALESCE(so.delivered_date, so.order_date))
            ORDER BY year_number DESC, week_number DESC
        """;

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, shopOwnerId);
            ps.setDate(2, startDate);
            ps.setDate(3, endDate);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    RevenueReport report = new RevenueReport();
                    report.setReportDate(rs.getDate("week_start"));
                    
                    // Format: "Tuần 26 (21/06 - 28/06)"
                    String weekLabel = String.format("Tuần %d (%s - %s)", 
                        rs.getInt("week_number"),
                        formatDate(rs.getDate("week_start")),
                        formatDate(rs.getDate("week_end"))
                    );
                    report.setPeriodLabel(weekLabel);
                    
                    report.setTotalOrders(rs.getInt("total_orders"));
                    report.setTotalProductsSold(rs.getInt("total_products_sold"));
                    report.setSubtotal(rs.getDouble("subtotal"));
                    report.setTotalPayment(rs.getDouble("total_payment"));
                    report.setNetRevenue(rs.getDouble("subtotal"));
                    reports.add(report);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(RevenueDAO.class.getName()).log(Level.SEVERE, "Failed to get weekly revenue", ex);
        }
        return reports;
    }
    
    /**
     * Format date to dd/MM format
     */
    private String formatDate(Date date) {
        if (date == null) return "";
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM");
        return sdf.format(date);
    }

    /**
     * Get monthly revenue report for a shop owner
     * @param shopOwnerId Shop owner's user ID
     * @param startDate Start date of report period
     * @param endDate End date of report period
     * @return List of monthly revenue reports
     */
    public List<RevenueReport> getMonthlyRevenue(int shopOwnerId, Date startDate, Date endDate) {
        List<RevenueReport> reports = new ArrayList<>();
        String sql = """
            SELECT 
                DATEPART(MONTH, COALESCE(so.delivered_date, so.order_date)) as month_number,
                DATEPART(YEAR, COALESCE(so.delivered_date, so.order_date)) as year_number,
                MIN(CAST(COALESCE(so.delivered_date, so.order_date) AS DATE)) as month_start,
                COUNT(DISTINCT so.sale_order_id) as total_orders,
                SUM(soi.quantity) as total_products_sold,
                SUM(soi.quantity * soi.unit_price) as subtotal,
                SUM(soi.quantity * soi.unit_price) as total_payment
            FROM Sale_Order so
            JOIN Sale_Order_Item soi ON so.sale_order_id = soi.sale_order_id
            JOIN Product p ON soi.product_id = p.product_id
            WHERE p.shop_owner_id = ?
                AND so.order_status = 'Delivered'
                AND CAST(COALESCE(so.delivered_date, so.order_date) AS DATE) BETWEEN ? AND ?
            GROUP BY DATEPART(MONTH, COALESCE(so.delivered_date, so.order_date)), 
                     DATEPART(YEAR, COALESCE(so.delivered_date, so.order_date))
            ORDER BY year_number DESC, month_number DESC
        """;

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, shopOwnerId);
            ps.setDate(2, startDate);
            ps.setDate(3, endDate);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    RevenueReport report = new RevenueReport();
                    report.setReportDate(rs.getDate("month_start"));
                    
                    // Format: "Tháng 06/2026"
                    String monthLabel = String.format("Tháng %02d/%d", 
                        rs.getInt("month_number"),
                        rs.getInt("year_number")
                    );
                    report.setPeriodLabel(monthLabel);
                    
                    report.setTotalOrders(rs.getInt("total_orders"));
                    report.setTotalProductsSold(rs.getInt("total_products_sold"));
                    report.setSubtotal(rs.getDouble("subtotal"));
                    report.setTotalPayment(rs.getDouble("total_payment"));
                    report.setNetRevenue(rs.getDouble("subtotal"));
                    reports.add(report);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(RevenueDAO.class.getName()).log(Level.SEVERE, "Failed to get monthly revenue", ex);
        }
        return reports;
    }

    /**
     * Get revenue summary statistics
     * @param shopOwnerId Shop owner's user ID
     * @param startDate Start date of report period
     * @param endDate End date of report period
     * @return Map containing summary statistics
     */
    public Map<String, Object> getRevenueSummary(int shopOwnerId, Date startDate, Date endDate) {
        Map<String, Object> summary = new HashMap<>();
        String sql = """
            SELECT 
                COUNT(DISTINCT so.sale_order_id) as total_orders,
                SUM(soi.quantity) as total_products_sold,
                SUM(soi.quantity * soi.unit_price) as total_revenue,
                AVG(soi.quantity * soi.unit_price) as avg_order_value
            FROM Sale_Order so
            JOIN Sale_Order_Item soi ON so.sale_order_id = soi.sale_order_id
            JOIN Product p ON soi.product_id = p.product_id
            WHERE p.shop_owner_id = ?
                AND so.order_status = 'Delivered'
                AND CAST(COALESCE(so.delivered_date, so.order_date) AS DATE) BETWEEN ? AND ?
        """;

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, shopOwnerId);
            ps.setDate(2, startDate);
            ps.setDate(3, endDate);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    summary.put("totalOrders", rs.getInt("total_orders"));
                    summary.put("totalProductsSold", rs.getInt("total_products_sold"));
                    summary.put("totalRevenue", rs.getDouble("total_revenue"));
                    summary.put("avgOrderValue", rs.getDouble("avg_order_value"));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(RevenueDAO.class.getName()).log(Level.SEVERE, "Failed to get revenue summary", ex);
        }
        return summary;
    }
}

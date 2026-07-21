package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Membership;

public class MembershipDAO extends DBContext {

    // Lấy toàn bộ danh sách membership kèm họ tên khách hàng
    public List<Membership> getAllMembership() {
        List<Membership> list = new ArrayList<>();

        // Thực hiện JOIN để lấy trường fullName từ bảng Users 
        String sql = """
    SELECT m.*, ui.full_name
    FROM Membership m
    LEFT JOIN UserInfo ui
        ON m.user_id = ui.user_id
    """;

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Membership m = new Membership();

                m.setMembershipId(rs.getInt("membership_id"));
                m.setUserId(rs.getInt("user_id"));
                m.setCurrentPoints(rs.getInt("current_points"));
                m.setCurrentTier(rs.getString("current_tier"));

                m.setPointConversionRate(rs.getInt("point_conversion_rate"));

                m.setSilverMinPoint(rs.getInt("silver_min_point"));
                m.setSilverDiscountPercent(rs.getInt("silver_discount_percent"));

                m.setGoldMinPoint(rs.getInt("gold_min_point"));
                m.setGoldDiscountPercent(rs.getInt("gold_discount_percent"));

                m.setDiamondMinPoint(rs.getInt("diamond_min_point"));
                m.setDiamondDiscountPercent(rs.getInt("diamond_discount_percent"));

                m.setManualOverride(rs.getBoolean("manual_override"));
                m.setTierUpdatedAt(rs.getTimestamp("tier_updated_at"));

                // Nhận thông tin họ tên người dùng từ DB
                m.setFullName(rs.getString("full_name"));
                list.add(m);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Lấy thông tin một membership theo userId
    public Membership getMembershipByUserId(int userId) {
        String sql = """
    SELECT m.*, ui.full_name
    FROM Membership m
    LEFT JOIN UserInfo ui
        ON m.user_id = ui.user_id
    WHERE m.user_id = ?
    """;

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                Membership m = new Membership();

                m.setMembershipId(rs.getInt("membership_id"));
                m.setUserId(rs.getInt("user_id"));
                m.setCurrentPoints(rs.getInt("current_points"));
                m.setCurrentTier(rs.getString("current_tier"));

                m.setPointConversionRate(rs.getInt("point_conversion_rate"));

                m.setSilverMinPoint(rs.getInt("silver_min_point"));
                m.setSilverDiscountPercent(rs.getInt("silver_discount_percent"));

                m.setGoldMinPoint(rs.getInt("gold_min_point"));
                m.setGoldDiscountPercent(rs.getInt("gold_discount_percent"));

                m.setDiamondMinPoint(rs.getInt("diamond_min_point"));
                m.setDiamondDiscountPercent(rs.getInt("diamond_discount_percent"));

                m.setManualOverride(rs.getBoolean("manual_override"));
                m.setTierUpdatedAt(rs.getTimestamp("tier_updated_at"));

                m.setFullName(rs.getString("full_name"));
                return m;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // Cập nhật thông tin Membership
    public boolean updateMembership(Membership m) {
        String sql = """
                     UPDATE Membership
                     SET current_points = ?,
                         current_tier = ?,
                         manual_override = ?,
                         tier_updated_at = GETDATE()
                     WHERE user_id = ?
                     """;

        try {
            PreparedStatement st = connection.prepareStatement(sql);

            st.setInt(1, m.getCurrentPoints());
            st.setString(2, m.getCurrentTier());
            st.setBoolean(3, m.isManualOverride());
            st.setInt(4, m.getUserId());

            int rows = st.executeUpdate();
            return rows > 0;

        } catch (Exception e) {
            System.out.println("Membership DAO Error:");
            e.printStackTrace();
            return false;
        }
    }
    // Thêm phương thức này vào file dal/MembershipDAO.java
public List<Membership> searchAndFilterMembership(String searchName, String tierFilter) {
    List<Membership> list = new ArrayList<>();
    
    // Khởi tạo SQL cơ bản
    StringBuilder sql = new StringBuilder("""
        SELECT m.*, ui.full_name
        FROM Membership m
        LEFT JOIN UserInfo ui ON m.user_id = ui.user_id
        WHERE 1=1
    """);
    
    // Thêm điều kiện tìm kiếm theo tên nếu có
    if (searchName != null && !searchName.trim().isEmpty()) {
        sql.append(" AND ui.full_name LIKE ? ");
    }
    
    // Thêm điều kiện lọc theo hạng nếu có và khác "Tất cả hạng"
    if (tierFilter != null && !tierFilter.trim().isEmpty() && !tierFilter.equalsIgnoreCase("all")) {
        sql.append(" AND m.current_tier = ? ");
    }

    try {
        PreparedStatement st = connection.prepareStatement(sql.toString());
        int paramIndex = 1;
        
        if (searchName != null && !searchName.trim().isEmpty()) {
            st.setString(paramIndex++, "%" + searchName.trim() + "%");
        }
        
        if (tierFilter != null && !tierFilter.trim().isEmpty() && !tierFilter.equalsIgnoreCase("all")) {
            st.setString(paramIndex++, tierFilter.trim());
        }
        
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Membership m = new Membership();
            m.setMembershipId(rs.getInt("membership_id"));
            m.setUserId(rs.getInt("user_id"));
            m.setCurrentPoints(rs.getInt("current_points"));
            m.setCurrentTier(rs.getString("current_tier"));
            m.setPointConversionRate(rs.getInt("point_conversion_rate"));
            m.setSilverMinPoint(rs.getInt("silver_min_point"));
            m.setSilverDiscountPercent(rs.getInt("silver_discount_percent"));
            m.setGoldMinPoint(rs.getInt("gold_min_point"));
            m.setGoldDiscountPercent(rs.getInt("gold_discount_percent"));
            m.setDiamondMinPoint(rs.getInt("diamond_min_point"));
            m.setDiamondDiscountPercent(rs.getInt("diamond_discount_percent"));
            m.setManualOverride(rs.getBoolean("manual_override"));
            m.setTierUpdatedAt(rs.getTimestamp("tier_updated_at"));
            m.setFullName(rs.getString("full_name"));
            list.add(m);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
public boolean updateMembershipRule(
        int pointConversionRate,
        int silverMinPoint,
        int silverDiscount,
        int goldMinPoint,
        int goldDiscount,
        int diamondMinPoint,
        int diamondDiscount) {

    // SQL cập nhật luật quy định trên toàn bộ bảng Membership
    String sqlUpdateRule = """
        UPDATE Membership
        SET point_conversion_rate = ?,
            silver_min_point = ?,
            silver_discount_percent = ?,
            gold_min_point = ?,
            gold_discount_percent = ?,
            diamond_min_point = ?,
            diamond_discount_percent = ?
        """;

    // SQL tự động tính toán và cập nhật lại hạng thành viên (current_tier) của các user
    // dựa trên các mốc điểm mới cập nhật. Chỉ áp dụng cho các user không bị khóa chỉnh sửa thủ công.
    String sqlUpdateTiers = """
        UPDATE Membership
        SET current_tier = CASE
            WHEN current_points >= diamond_min_point THEN 'Diamond'
            WHEN current_points >= gold_min_point THEN 'Gold'
            WHEN current_points >= silver_min_point THEN 'Silver'
            ELSE 'Normal'
        END,
        tier_updated_at = GETDATE()
        WHERE manual_override = 0 OR manual_override IS NULL
        """;

    try {
        // Tắt auto commit để thực hiện transaction đảm bảo tính toàn vẹn dữ liệu
        connection.setAutoCommit(false);

        // 1. Cập nhật các cột quy định
        PreparedStatement st = connection.prepareStatement(sqlUpdateRule);
        st.setInt(1, pointConversionRate);
        st.setInt(2, silverMinPoint);
        st.setInt(3, silverDiscount);
        st.setInt(4, goldMinPoint);
        st.setInt(5, goldDiscount);
        st.setInt(6, diamondMinPoint);
        st.setInt(7, diamondDiscount);

        int rowsUpdated = st.executeUpdate();

        // 2. Nếu cập nhật quy định thành công, tiến hành tính toán lại hạng cho toàn bộ thành viên
        if (rowsUpdated > 0) {
            PreparedStatement stTiers = connection.prepareStatement(sqlUpdateTiers);
            stTiers.executeUpdate();
        }

        // Commit transaction
        connection.commit();
        connection.setAutoCommit(true);
        return rowsUpdated > 0;

    } catch (Exception e) {
        // Rollback nếu xảy ra lỗi
        try {
            if (connection != null) {
                connection.rollback();
                connection.setAutoCommit(true);
            }
        } catch (Exception rollbackEx) {
            rollbackEx.printStackTrace();
        }
        e.printStackTrace();
    }

    return false;
}

/**
 * Tự động cộng điểm và cập nhật hạng thành viên của người dùng khi đơn hàng hoàn thành (Delivered).
 * Lấy tỷ lệ quy đổi điểm động (point_conversion_rate) từ DB của chính người dùng đó.
 */
public boolean addPointsForOrder(int orderId) {
    String getOrderSql = "SELECT created_by, total_payment FROM Sale_Order WHERE sale_order_id = ?";
    String getRateSql = "SELECT point_conversion_rate FROM Membership WHERE user_id = ?";
    String updatePointsSql = "UPDATE Membership SET current_points = current_points + ? WHERE user_id = ?";
    String recalculateTierSql = """
        UPDATE m
        SET m.current_tier = CASE 
            WHEN m.current_points >= r.diamond_min_point THEN 'Diamond'
            WHEN m.current_points >= r.gold_min_point THEN 'Gold'
            WHEN m.current_points >= r.silver_min_point THEN 'Silver'
            ELSE 'Normal'
        END,
        m.tier_updated_at = GETDATE()
        FROM Membership m
        CROSS JOIN Membership r
        WHERE m.user_id = ? AND (m.manual_override = 0 OR m.manual_override IS NULL)
    """;
    
    try {
        // Sử dụng connection của DBContext
        connection.setAutoCommit(false);
        
        int userId = -1;
        double totalPayment = 0;
        
        // 1. Lấy thông tin khách hàng và số tiền thanh toán thực tế của đơn hàng
        try (PreparedStatement ps = connection.prepareStatement(getOrderSql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    userId = rs.getInt("created_by");
                    totalPayment = rs.getDouble("total_payment");
                }
            }
        }
        
        if (userId == -1 || totalPayment <= 0) {
            connection.rollback();
            connection.setAutoCommit(true);
            return false;
        }
        
        // 2. Lấy tỷ lệ quy đổi điểm (point_conversion_rate) của khách hàng này
        int pointConversionRate = 10000; // Giá trị dự phòng (mặc định) nếu lỗi hoặc bằng 0
        try (PreparedStatement ps = connection.prepareStatement(getRateSql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int rate = rs.getInt("point_conversion_rate");
                    if (rate > 0) {
                        pointConversionRate = rate;
                    }
                }
            }
        }
        
        // 3. Tính số điểm được cộng = Tổng thanh toán / Tỷ lệ quy đổi
        int pointsToAdd = (int) (totalPayment / pointConversionRate);
        if (pointsToAdd <= 0) {
            connection.commit();
            connection.setAutoCommit(true);
            return true; // Số tiền quá nhỏ không đủ đổi thành 1 điểm
        }
        
        // 4. Thực hiện cộng điểm tích lũy
        try (PreparedStatement ps = connection.prepareStatement(updatePointsSql)) {
            ps.setInt(1, pointsToAdd);
            ps.setInt(2, userId);
            ps.executeUpdate();
        }
        
        // 5. Cập nhật lại hạng thăng/hạ theo quy định
        try (PreparedStatement ps = connection.prepareStatement(recalculateTierSql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        }
        
        connection.commit();
        connection.setAutoCommit(true);
        return true;
    } catch (SQLException ex) {
        try {
            if (connection != null) {
                connection.rollback();
                connection.setAutoCommit(true);
            }
        } catch (SQLException rollbackEx) {
            rollbackEx.printStackTrace();
        }
        ex.printStackTrace();
        return false;
    }
}
}

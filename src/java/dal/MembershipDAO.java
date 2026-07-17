package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Membership;

public class MembershipDAO extends DBContext {

    // Lấy toàn bộ danh sách membership kèm họ tên khách hàng
    public List<Membership> getAllMembership() {
        List<Membership> list = new ArrayList<>();

        // Thực hiện JOIN để lấy trường fullName từ bảng Users (Thay đổi tên bảng Users/cột fullName nếu DB của bạn đặt tên khác)
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
}

package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Membership;
import model.MembershipTier;

public class MembershipDAO extends DBContext {

    /**
     * Đồng bộ bảng MembershipTier và Membership nếu chưa tồn tại
     */
    public void syncMissingMemberships() {
        String createTierTableSql = """
            IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='MembershipTier')
            BEGIN
                CREATE TABLE MembershipTier (
                    tier_id INT IDENTITY(1,1) PRIMARY KEY,
                    tier_name NVARCHAR(50) NOT NULL UNIQUE,
                    min_points INT NOT NULL DEFAULT 0,
                    discount_percent INT NOT NULL DEFAULT 0,
                    point_conversion_rate INT NOT NULL DEFAULT 10000
                );
                INSERT INTO MembershipTier (tier_name, min_points, discount_percent, point_conversion_rate) VALUES
                ('Normal', 0, 0, 10000),
                ('Silver', 100, 5, 10000),
                ('Gold', 500, 10, 10000),
                ('Diamond', 1000, 15, 10000);
            END
        """;

        String createMembershipTableSql = """
            IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='Membership')
            BEGIN
                CREATE TABLE Membership (
                    membership_id INT IDENTITY(1,1) PRIMARY KEY,
                    user_id INT NOT NULL UNIQUE FOREIGN KEY REFERENCES Users(user_id) ON DELETE CASCADE,
                    current_points INT NOT NULL DEFAULT 0,
                    tier_id INT NOT NULL DEFAULT 1 FOREIGN KEY REFERENCES MembershipTier(tier_id),
                    manual_override BIT NOT NULL DEFAULT 0,
                    tier_updated_at DATETIME NOT NULL DEFAULT GETDATE()
                );
            END
        """;

        String insertMissingSql = """
            INSERT INTO Membership (user_id, current_points, tier_id, manual_override)
            SELECT u.user_id, 0, 1, 0
            FROM Users u
            JOIN User_Role ur ON u.user_id = ur.user_id
            JOIN Roles r ON ur.role_id = r.role_id
            WHERE (r.role_name = 'Customer' OR ur.role_id = 1)
              AND NOT EXISTS (SELECT 1 FROM Membership m WHERE m.user_id = u.user_id)
        """;

        try {
            Connection conn = getConnection();
            if (conn != null && !conn.isClosed()) {
                try (PreparedStatement ps1 = conn.prepareStatement(createTierTableSql)) {
                    ps1.executeUpdate();
                }
                try (PreparedStatement ps2 = conn.prepareStatement(createMembershipTableSql)) {
                    ps2.executeUpdate();
                }
                try (PreparedStatement ps3 = conn.prepareStatement(insertMissingSql)) {
                    ps3.executeUpdate();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // =========================================================================
    // QUẢN LÝ HẠNG THÀNH VIÊN (MembershipTier)
    // =========================================================================

    /**
     * Lấy toàn bộ danh sách Hạng thành viên (MembershipTier) sắp xếp theo min_points
     */
    public List<MembershipTier> getAllTiers() {
        syncMissingMemberships();
        List<MembershipTier> list = new ArrayList<>();
        String sql = "SELECT * FROM MembershipTier ORDER BY min_points ASC";

        try (PreparedStatement st = getConnection().prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                MembershipTier t = new MembershipTier(
                        rs.getInt("tier_id"),
                        rs.getString("tier_name"),
                        rs.getInt("min_points"),
                        rs.getInt("discount_percent"),
                        rs.getInt("point_conversion_rate")
                );
                list.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy thông tin 1 hạng theo tier_id
     */
    public MembershipTier getTierById(int tierId) {
        String sql = "SELECT * FROM MembershipTier WHERE tier_id = ?";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, tierId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new MembershipTier(
                            rs.getInt("tier_id"),
                            rs.getString("tier_name"),
                            rs.getInt("min_points"),
                            rs.getInt("discount_percent"),
                            rs.getInt("point_conversion_rate")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Lấy thông tin 1 hạng theo tier_name
     */
    public MembershipTier getTierByName(String tierName) {
        String sql = "SELECT * FROM MembershipTier WHERE LOWER(tier_name) = LOWER(?)";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setString(1, tierName.trim());
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new MembershipTier(
                            rs.getInt("tier_id"),
                            rs.getString("tier_name"),
                            rs.getInt("min_points"),
                            rs.getInt("discount_percent"),
                            rs.getInt("point_conversion_rate")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // =========================================================================
    // QUẢN LÝ MEMBERSHIP CỦA KHÁCH HÀNG (UserMembership)
    // =========================================================================

    /**
     * Lấy toàn bộ danh sách membership kèm thông tin Hạng & Họ tên khách hàng
     */
    public List<Membership> getAllMembership() {
        syncMissingMemberships();
        List<Membership> list = new ArrayList<>();

        String sql = """
            SELECT m.*, t.tier_name, t.min_points, t.discount_percent, t.point_conversion_rate, ui.full_name
            FROM Membership m
            JOIN MembershipTier t ON m.tier_id = t.tier_id
            LEFT JOIN UserInfo ui ON m.user_id = ui.user_id
            JOIN User_Role ur ON m.user_id = ur.user_id
            JOIN Roles r ON ur.role_id = r.role_id
            WHERE (r.role_name = 'Customer' OR ur.role_id = 1)
            ORDER BY m.membership_id DESC
        """;

        try (PreparedStatement st = getConnection().prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                Membership m = mapResultSetToMembership(rs);
                list.add(m);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * Lấy thông tin membership của 1 user theo userId
     */
    public Membership getMembershipByUserId(int userId) {
        syncMissingMemberships();
        String sql = """
            SELECT m.*, t.tier_name, t.min_points, t.discount_percent, t.point_conversion_rate, ui.full_name
            FROM Membership m
            JOIN MembershipTier t ON m.tier_id = t.tier_id
            LEFT JOIN UserInfo ui ON m.user_id = ui.user_id
            WHERE m.user_id = ?
        """;

        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, userId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToMembership(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Tìm kiếm và lọc danh sách Membership theo Tên và Hạng
     */
    public List<Membership> searchAndFilterMembership(String searchName, String tierFilter) {
        syncMissingMemberships();
        List<Membership> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder("""
            SELECT m.*, t.tier_name, t.min_points, t.discount_percent, t.point_conversion_rate, ui.full_name
            FROM Membership m
            JOIN MembershipTier t ON m.tier_id = t.tier_id
            LEFT JOIN UserInfo ui ON m.user_id = ui.user_id
            JOIN User_Role ur ON m.user_id = ur.user_id
            JOIN Roles r ON ur.role_id = r.role_id
            WHERE (r.role_name = 'Customer' OR ur.role_id = 1)
        """);

        if (searchName != null && !searchName.trim().isEmpty()) {
            sql.append(" AND ui.full_name LIKE ? ");
        }

        if (tierFilter != null && !tierFilter.trim().isEmpty() && !tierFilter.equalsIgnoreCase("all")) {
            sql.append(" AND (LOWER(t.tier_name) = LOWER(?) OR CAST(t.tier_id AS NVARCHAR) = ?) ");
        }

        sql.append(" ORDER BY m.membership_id DESC ");

        try (PreparedStatement st = getConnection().prepareStatement(sql.toString())) {
            int paramIndex = 1;

            if (searchName != null && !searchName.trim().isEmpty()) {
                st.setString(paramIndex++, "%" + searchName.trim() + "%");
            }

            if (tierFilter != null && !tierFilter.trim().isEmpty() && !tierFilter.equalsIgnoreCase("all")) {
                st.setString(paramIndex++, tierFilter.trim());
                st.setString(paramIndex++, tierFilter.trim());
            }

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Membership m = mapResultSetToMembership(rs);
                    list.add(m);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Cập nhật điểm, hạng (tier_id) và cờ thủ công của người dùng
     */
    public boolean updateMembership(Membership m) {
        String sql = """
            UPDATE Membership
            SET current_points = ?,
                tier_id = ?,
                manual_override = ?,
                tier_updated_at = GETDATE()
            WHERE user_id = ?
        """;

        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, m.getCurrentPoints());
            st.setInt(2, m.getTierId());
            st.setBoolean(3, m.isManualOverride());
            st.setInt(4, m.getUserId());

            int rows = st.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Cập nhật quy định chung các hạng thành viên (MembershipTier)
     * và tự động tính toán lại Hạng cho tất cả các user chưa bị khóa thủ công.
     */
    public boolean updateMembershipRule(
            int pointConversionRate,
            int silverMinPoint,
            int silverDiscount,
            int goldMinPoint,
            int goldDiscount,
            int diamondMinPoint,
            int diamondDiscount) {

        String updateNormal = "UPDATE MembershipTier SET point_conversion_rate = ? WHERE tier_name = 'Normal'";
        String updateSilver = "UPDATE MembershipTier SET min_points = ?, discount_percent = ?, point_conversion_rate = ? WHERE tier_name = 'Silver'";
        String updateGold   = "UPDATE MembershipTier SET min_points = ?, discount_percent = ?, point_conversion_rate = ? WHERE tier_name = 'Gold'";
        String updateDiamond= "UPDATE MembershipTier SET min_points = ?, discount_percent = ?, point_conversion_rate = ? WHERE tier_name = 'Diamond'";

        // SQL tự động gán tier_id mới cho user theo mốc min_points cao nhất mà điểm user đạt được
        String sqlUpdateTiers = """
            UPDATE m
            SET m.tier_id = (
                SELECT TOP 1 t.tier_id
                FROM MembershipTier t
                WHERE m.current_points >= t.min_points
                ORDER BY t.min_points DESC
            ),
            m.tier_updated_at = GETDATE()
            FROM Membership m
            WHERE m.manual_override = 0 OR m.manual_override IS NULL
        """;

        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            try (PreparedStatement ps = conn.prepareStatement(updateNormal)) {
                ps.setInt(1, pointConversionRate);
                ps.executeUpdate();
            }

            try (PreparedStatement ps = conn.prepareStatement(updateSilver)) {
                ps.setInt(1, silverMinPoint);
                ps.setInt(2, silverDiscount);
                ps.setInt(3, pointConversionRate);
                ps.executeUpdate();
            }

            try (PreparedStatement ps = conn.prepareStatement(updateGold)) {
                ps.setInt(1, goldMinPoint);
                ps.setInt(2, goldDiscount);
                ps.setInt(3, pointConversionRate);
                ps.executeUpdate();
            }

            try (PreparedStatement ps = conn.prepareStatement(updateDiamond)) {
                ps.setInt(1, diamondMinPoint);
                ps.setInt(2, diamondDiscount);
                ps.setInt(3, pointConversionRate);
                ps.executeUpdate();
            }

            // Tính toán lại hạng cho toàn bộ thành viên
            try (PreparedStatement psTiers = conn.prepareStatement(sqlUpdateTiers)) {
                psTiers.executeUpdate();
            }

            conn.commit();
            conn.setAutoCommit(true);
            return true;
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                    conn.setAutoCommit(true);
                } catch (Exception rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Tự động cộng điểm và cập nhật hạng thành viên của người dùng khi đơn hàng hoàn thành (Delivered).
     */
    public boolean addPointsForOrder(int orderId) {
        String getOrderSql = "SELECT created_by, total_payment FROM Sale_Order WHERE sale_order_id = ?";
        String updatePointsSql = "UPDATE Membership SET current_points = current_points + ? WHERE user_id = ?";
        String recalculateTierSql = """
            UPDATE m
            SET m.tier_id = (
                SELECT TOP 1 t.tier_id
                FROM MembershipTier t
                WHERE m.current_points >= t.min_points
                ORDER BY t.min_points DESC
            ),
            m.tier_updated_at = GETDATE()
            FROM Membership m
            WHERE m.user_id = ? AND (m.manual_override = 0 OR m.manual_override IS NULL)
        """;

        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            int userId = -1;
            double totalPayment = 0;

            try (PreparedStatement ps = conn.prepareStatement(getOrderSql)) {
                ps.setInt(1, orderId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        userId = rs.getInt("created_by");
                        totalPayment = rs.getDouble("total_payment");
                    }
                }
            }

            if (userId == -1 || totalPayment <= 0) {
                conn.rollback();
                conn.setAutoCommit(true);
                return false;
            }

            // Lấy tỷ lệ quy đổi điểm từ Hạng hiện tại của User
            Membership userMembership = getMembershipByUserId(userId);
            int pointConversionRate = (userMembership != null) ? userMembership.getPointConversionRate() : 10000;

            int pointsToAdd = (int) (totalPayment / pointConversionRate);
            if (pointsToAdd <= 0) {
                conn.commit();
                conn.setAutoCommit(true);
                return true;
            }

            // Cộng điểm tích lũy
            try (PreparedStatement ps = conn.prepareStatement(updatePointsSql)) {
                ps.setInt(1, pointsToAdd);
                ps.setInt(2, userId);
                ps.executeUpdate();
            }

            // Cập nhật lại hạng thăng/hạ
            try (PreparedStatement ps = conn.prepareStatement(recalculateTierSql)) {
                ps.setInt(1, userId);
                ps.executeUpdate();
            }

            conn.commit();
            conn.setAutoCommit(true);
            return true;
        } catch (SQLException ex) {
            if (conn != null) {
                try {
                    conn.rollback();
                    conn.setAutoCommit(true);
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            ex.printStackTrace();
            return false;
        }
    }

    // Mapper trợ giúp map ResultSet thành Membership Object
    private Membership mapResultSetToMembership(ResultSet rs) throws SQLException {
        Membership m = new Membership();
        m.setMembershipId(rs.getInt("membership_id"));
        m.setUserId(rs.getInt("user_id"));
        m.setCurrentPoints(rs.getInt("current_points"));
        m.setTierId(rs.getInt("tier_id"));
        m.setManualOverride(rs.getBoolean("manual_override"));
        m.setTierUpdatedAt(rs.getTimestamp("tier_updated_at"));
        m.setFullName(rs.getString("full_name"));

        MembershipTier t = new MembershipTier(
                rs.getInt("tier_id"),
                rs.getString("tier_name"),
                rs.getInt("min_points"),
                rs.getInt("discount_percent"),
                rs.getInt("point_conversion_rate")
        );
        m.setTierInfo(t);

        return m;
    }
}

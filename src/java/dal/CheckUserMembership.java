package dal;

import java.sql.*;

public class CheckUserMembership extends DBContext {

    public void run() {
        Connection conn = getConnection();
        if (conn == null) {
            System.err.println("Could not establish connection to the database.");
            return;
        }

        try {
            System.out.println("=== USER INFO & MEMBERSHIP DATABASE INSPECTOR ===");
            
            // Check users
            String userSql = "SELECT u.user_id, u.username, r.role_name, ui.full_name, ui.phone " +
                             "FROM Users u " +
                             "LEFT JOIN UserInfo ui ON u.user_id = ui.user_id " +
                             "LEFT JOIN User_Role ur ON u.user_id = ur.user_id " +
                             "LEFT JOIN Roles r ON ur.role_id = r.role_id";
            try (Statement s = conn.createStatement();
                 ResultSet rs = s.executeQuery(userSql)) {
                while (rs.next()) {
                    System.out.println(String.format("User: ID=%d, Username=%s, Role=%s, Name=%s, Phone=%s",
                            rs.getInt("user_id"),
                            rs.getString("username"),
                            rs.getString("role_name"),
                            rs.getNString("full_name"),
                            rs.getString("phone")));
                }
            }

            System.out.println("\n=== MEMBERSHIP RECORDS ===");
            // Check membership
            String memberSql = "SELECT m.*, ui.full_name " +
                               "FROM Membership m " +
                               "LEFT JOIN UserInfo ui ON m.user_id = ui.user_id";
            try (Statement s = conn.createStatement();
                 ResultSet rs = s.executeQuery(memberSql)) {
                while (rs.next()) {
                    System.out.println(String.format("Membership: ID=%d, UserID=%d, Name=%s, Tier=%s, Points=%d, Silver%%=%d, Gold%%=%d, Diamond%%=%d",
                            rs.getInt("membership_id"),
                            rs.getInt("user_id"),
                            rs.getNString("full_name"),
                            rs.getString("current_tier"),
                            rs.getInt("current_points"),
                            rs.getInt("silver_discount_percent"),
                            rs.getInt("gold_discount_percent"),
                            rs.getInt("diamond_discount_percent")));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        new CheckUserMembership().run();
    }
}

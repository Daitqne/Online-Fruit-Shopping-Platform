package dal;

import java.sql.*;

public class CreateMembershipTable extends DBContext {

    public void run() {
        Connection conn = getConnection();
        if (conn == null) {
            System.err.println("Could not establish connection to the database.");
            return;
        }

        try {
            System.out.println("=== CREATING MEMBERSHIP TABLE ===");
            try (Statement s = conn.createStatement()) {
                s.executeUpdate("""
                    IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='Membership')
                    CREATE TABLE Membership (
                        membership_id INT IDENTITY(1,1) PRIMARY KEY,
                        user_id INT NOT NULL FOREIGN KEY REFERENCES Users(user_id) ON DELETE CASCADE,
                        current_points INT NOT NULL DEFAULT 0,
                        current_tier NVARCHAR(50) NOT NULL DEFAULT 'Normal',
                        point_conversion_rate INT NOT NULL DEFAULT 10000,
                        silver_min_point INT NOT NULL DEFAULT 100,
                        silver_discount_percent INT NOT NULL DEFAULT 5,
                        gold_min_point INT NOT NULL DEFAULT 500,
                        gold_discount_percent INT NOT NULL DEFAULT 10,
                        diamond_min_point INT NOT NULL DEFAULT 1000,
                        diamond_discount_percent INT NOT NULL DEFAULT 15,
                        manual_override BIT NOT NULL DEFAULT 0,
                        tier_updated_at DATETIME NOT NULL DEFAULT GETDATE()
                    )
                """);
                System.out.println("Table 'Membership' ensured to exist.");
            }

            // Populate membership for all customers if they don't have one
            // We select user_ids of Customers (role_id = 3 or role_name = 'Customer')
            String sqlCustomers = """
                SELECT u.user_id, u.username
                FROM Users u
                JOIN User_Role ur ON u.user_id = ur.user_id
                JOIN Roles r ON ur.role_id = r.role_id
                WHERE r.role_name = 'Customer'
            """;

            try (Statement s = conn.createStatement();
                 ResultSet rs = s.executeQuery(sqlCustomers)) {
                while (rs.next()) {
                    int userId = rs.getInt("user_id");
                    String username = rs.getString("username");

                    // Check if they already have a membership record
                    boolean hasRecord = false;
                    try (PreparedStatement psCheck = conn.prepareStatement("SELECT user_id FROM Membership WHERE user_id = ?")) {
                        psCheck.setInt(1, userId);
                        try (ResultSet rsCheck = psCheck.executeQuery()) {
                            if (rsCheck.next()) {
                                hasRecord = true;
                            }
                        }
                    }

                    if (!hasRecord) {
                        // Give 'kynd123' (Nguyen Dai Ky) 600 points -> Gold tier to test
                        int points = 0;
                        String tier = "Normal";
                        if ("kynd123".equals(username)) {
                            points = 600;
                            tier = "Gold";
                            System.out.println("Giving user 'kynd123' (Nguyen Dai Ky) Gold tier membership for testing.");
                        } else {
                            points = 150;
                            tier = "Silver";
                            System.out.println("Giving user '" + username + "' Silver tier membership for testing.");
                        }

                        String sqlInsert = """
                            INSERT INTO Membership (user_id, current_points, current_tier, point_conversion_rate, 
                                                    silver_min_point, silver_discount_percent, 
                                                    gold_min_point, gold_discount_percent, 
                                                    diamond_min_point, diamond_discount_percent, manual_override)
                            VALUES (?, ?, ?, 10000, 100, 5, 500, 10, 1000, 15, 0)
                        """;
                        try (PreparedStatement psIns = conn.prepareStatement(sqlInsert)) {
                            psIns.setInt(1, userId);
                            psIns.setInt(2, points);
                            psIns.setString(3, tier);
                            psIns.executeUpdate();
                        }
                    }
                }
            }

            System.out.println("Membership records verified and populated successfully.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        new CreateMembershipTable().run();
    }
}

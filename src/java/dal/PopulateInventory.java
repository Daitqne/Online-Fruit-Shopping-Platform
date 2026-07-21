package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PopulateInventory extends DBContext {

    public void run() {
        Connection conn = getConnection();
        if (conn == null) {
            System.err.println("Could not establish connection to the database.");
            return;
        }

        try {
            // First, make sure table Inventory exists (just in case)
            try (Statement s = conn.createStatement()) {
                s.executeUpdate(
                    "IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='Inventory') " +
                    "CREATE TABLE Inventory (" +
                    "  product_id INT PRIMARY KEY, " +
                    "  quantity INT NOT NULL, " +
                    "  last_updated DATETIME NOT NULL DEFAULT GETDATE()" +
                    ")"
                );
                System.out.println("Ensured table 'Inventory' exists.");
            } catch (SQLException e) {
                System.err.println("Warning ensuring Inventory exists: " + e.getMessage());
            }

            // Make sure table Inventory_Batch exists
            try (Statement s = conn.createStatement()) {
                s.executeUpdate(
                    "IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='Inventory_Batch') " +
                    "CREATE TABLE Inventory_Batch (" +
                    "  batch_id INT IDENTITY(1,1) PRIMARY KEY, " +
                    "  product_id INT NOT NULL, " +
                    "  receipt_item_id INT NOT NULL, " +
                    "  batch_number VARCHAR(50) NOT NULL, " +
                    "  quantity_in INT NOT NULL, " +
                    "  quantity_remain INT NOT NULL, " +
                    "  manufacture_date DATE NULL, " +
                    "  expiry_date DATE NOT NULL, " +
                    "  created_at DATETIME NOT NULL DEFAULT GETDATE()" +
                    ")"
                );
                System.out.println("Ensured table 'Inventory_Batch' exists.");
            } catch (SQLException e) {
                System.err.println("Warning ensuring Inventory_Batch exists: " + e.getMessage());
            }

            // Get all product IDs
            List<Integer> productIds = new ArrayList<>();
            try (Statement s = conn.createStatement();
                 ResultSet rs = s.executeQuery("SELECT product_id FROM Product")) {
                while (rs.next()) {
                    productIds.add(rs.getInt("product_id"));
                }
            }
            System.out.println("Found " + productIds.size() + " products in the database.");

            // For each product, insert/update Inventory and Inventory_Batch
            for (int id : productIds) {
                // Check if Inventory record exists
                boolean invExists = false;
                try (PreparedStatement ps = conn.prepareStatement("SELECT product_id FROM Inventory WHERE product_id = ?")) {
                    ps.setInt(1, id);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            invExists = true;
                        }
                    }
                }

                if (invExists) {
                    try (PreparedStatement ps = conn.prepareStatement("UPDATE Inventory SET quantity = 500, last_updated = GETDATE() WHERE product_id = ?")) {
                        ps.setInt(1, id);
                        ps.executeUpdate();
                    }
                } else {
                    try (PreparedStatement ps = conn.prepareStatement("INSERT INTO Inventory (product_id, quantity, last_updated) VALUES (?, 500, GETDATE())")) {
                        ps.setInt(1, id);
                        ps.executeUpdate();
                    }
                }

                // Check if there is already a valid batch in Inventory_Batch
                boolean batchExists = false;
                try (PreparedStatement ps = conn.prepareStatement("SELECT batch_id FROM Inventory_Batch WHERE product_id = ? AND quantity_remain > 0 AND expiry_date > GETDATE()")) {
                    ps.setInt(1, id);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            batchExists = true;
                        }
                    }
                }

                if (!batchExists) {
                    // Insert a new batch with quantity 500
                    try (PreparedStatement ps = conn.prepareStatement(
                        "INSERT INTO Inventory_Batch (product_id, receipt_item_id, batch_number, quantity_in, quantity_remain, manufacture_date, expiry_date, created_at) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE())")) {
                        ps.setInt(1, id);
                        ps.setInt(2, 0); // dummy receipt_item_id
                        ps.setString(3, "BATCH-AUTO-" + id);
                        ps.setInt(4, 500);
                        ps.setInt(5, 500);
                        ps.setDate(6, new java.sql.Date(System.currentTimeMillis() - 7L * 24 * 60 * 60 * 1000)); // 7 days ago
                        ps.setDate(7, java.sql.Date.valueOf("2029-12-31")); // Far future expiry
                        ps.executeUpdate();
                    }
                } else {
                    // Update quantity_remain to 500 for existing active batches of this product
                    try (PreparedStatement ps = conn.prepareStatement("UPDATE Inventory_Batch SET quantity_remain = 500, expiry_date = '2029-12-31' WHERE product_id = ?")) {
                        ps.setInt(1, id);
                        ps.executeUpdate();
                    }
                }
            }

            System.out.println("Inventory and active batches populated successfully for all products.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        new PopulateInventory().run();
    }
}

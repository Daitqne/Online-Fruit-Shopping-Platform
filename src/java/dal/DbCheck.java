package dal;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;

public class DbCheck {
    public static void main(String[] args) {
        DBContext db = new DBContext();
        Connection conn = db.getConnection();
        if (conn == null) { System.out.println("Ket noi THAT BAI!"); return; }

        String[] tables = {"Product", "Product_Category", "Product_Image"};

        for (String table : tables) {
            System.out.println("\n========== Bang: " + table + " ==========");
            try (Statement stmt = conn.createStatement()) {
                ResultSet rs = stmt.executeQuery("SELECT TOP 3 * FROM " + table);
                ResultSetMetaData rsmd = rs.getMetaData();
                int colCount = rsmd.getColumnCount();

                // In ten cot
                StringBuilder header = new StringBuilder("Cot: ");
                for (int i = 1; i <= colCount; i++) {
                    header.append(rsmd.getColumnName(i)).append(" | ");
                }
                System.out.println(header);

                // In du lieu mau
                System.out.println("Du lieu mau:");
                int rowNum = 0;
                while (rs.next()) {
                    rowNum++;
                    StringBuilder row = new StringBuilder("  Row " + rowNum + ": ");
                    for (int i = 1; i <= colCount; i++) {
                        row.append(rsmd.getColumnName(i)).append("=").append(rs.getString(i)).append(" | ");
                    }
                    System.out.println(row);
                }
                if (rowNum == 0) System.out.println("  (Khong co du lieu)");

            } catch (Exception e) {
                System.out.println("Loi khi doc bang " + table + ": " + e.getMessage());
            }
        }
    }
}

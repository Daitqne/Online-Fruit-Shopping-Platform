package dal;

import java.sql.*;

public class PrintAllTables extends DBContext {

    public void run() {
        Connection conn = getConnection();
        if (conn == null) {
            System.err.println("Could not establish connection to the database.");
            return;
        }

        try {
            System.out.println("=== LIST OF ALL TABLES ===");
            DatabaseMetaData dbmd = conn.getMetaData();
            try (ResultSet rs = dbmd.getTables(null, null, "%", new String[]{"TABLE"})) {
                while (rs.next()) {
                    System.out.println(rs.getString("TABLE_NAME"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        new PrintAllTables().run();
    }
}

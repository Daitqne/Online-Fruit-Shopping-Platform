package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Modern DBContext for MS SQL Server connection.
 * Customized for GreenStockDatabase with robust password fallback.
 */
public class DBContext {
    protected Connection connection;

    static {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            System.err.println("[DBContext Error] SQL Server Driver not found in classpath!");
        }
    }

    public DBContext() {
        connection = establishConnection();
    }

    private Connection establishConnection() {
        String[] passwords = {"123456", "123", "sa", "admin", "1234"};
        String user = "sa";
        
        for (String pass : passwords) {
            try {
                String url = "jdbc:sqlserver://localhost:1433;databaseName=GreenStockDB;encrypt=true;trustServerCertificate=true;";
                Connection conn = DriverManager.getConnection(url, user, pass);
                System.out.println("[DBContext] Database connected successfully to GreenStockDB with password: " + pass);
                return conn;
            } catch (SQLException e) {
                // Ignore and try next password
            }
        }
        
        System.err.println("[DBContext Error] Connection failed! Check database configuration.");
        return null;
    }

    /**
     * Helper method to get the established connection.
     * @return Connection object
     */
    public Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                connection = establishConnection();
            }
        } catch (Exception e) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, e);
        }
        return connection;
    }

    /**
     * Test the connection.
     */
    public static void main(String[] args) {
        DBContext db = new DBContext();
        if (db.getConnection() != null) {
            System.out.println("Connection test: SUCCESS!");
        } else {
            System.out.println("Connection test: FAILED!");
        }
    }
}

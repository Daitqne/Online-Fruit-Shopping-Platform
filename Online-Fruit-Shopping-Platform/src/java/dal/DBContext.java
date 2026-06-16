package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Modern DBContext for MS SQL Server connection.
 * Customized for GreenStockDatabase.
 */
public class DBContext {
    protected Connection connection;

    public DBContext() {
        try {
            String user = "sa";
            String pass = "123";
            String url = "jdbc:sqlserver://localhost:1433;databaseName=GreenStockDB;encrypt=true;trustServerCertificate=true;";
            
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            
            connection = DriverManager.getConnection(url, user, pass);
            System.out.println("[DBContext] Database connected successfully to GreenStockDB!");
        } catch (ClassNotFoundException e) {
            System.err.println("[DBContext Error] SQL Server Driver not found in classpath!");
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, e);
        } catch (SQLException e) {
            System.err.println("[DBContext Error] Connection failed! Check database, URL, username and password.");
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    /**
     * Helper method to get the established connection.
     * @return Connection object
     */
    public Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                String user = "sa";
                String pass = "123";
                String url = "jdbc:sqlserver://localhost:1433;databaseName=GreenStockDB;encrypt=true;trustServerCertificate=true;";
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                connection = DriverManager.getConnection(url, user, pass);
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

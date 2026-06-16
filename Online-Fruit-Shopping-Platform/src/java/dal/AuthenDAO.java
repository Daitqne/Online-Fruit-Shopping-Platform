package dal;

import java.sql.Statement;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.mindrot.jbcrypt.BCrypt;
import model.Authen;

public class AuthenDAO extends DBContext {

    // =====================================================
    // LOGIN
    // =====================================================
    public Authen login(String username, String password) {

        String sql = """
            SELECT u.user_id, u.username, u.password, u.status,
                   ui.full_name, ui.phone, ui.email,
                   r.role_id, r.role_name
            FROM Users u
            JOIN UserInfo ui ON u.user_id = ui.user_id
            JOIN User_Role ur ON u.user_id = ur.user_id
            JOIN Roles r ON ur.role_id = r.role_id
            WHERE u.username = ?
              AND u.status = 'Active'
        """;

        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String hashedPassword = rs.getString("password");

                // kiểm tra mật khẩu
                if (!BCrypt.checkpw(password, hashedPassword)) {
                    return null;
                }

                Authen a = new Authen();
                a.setId(rs.getInt("user_id"));
                a.setUsername(rs.getString("username"));
                a.setStatus(rs.getString("status"));

                a.setFullName(rs.getString("full_name"));
                a.setPhone(rs.getString("phone"));
                a.setEmail(rs.getString("email"));

                a.setRoleId(rs.getInt("role_id"));
                a.setRole(rs.getString("role_name"));

                return a;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // =====================================================
    // CHECK USERNAME
    // =====================================================
    public boolean isUsernameExists(String username) {
        String sql = "SELECT 1 FROM Users WHERE username = ?";
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            return ps.executeQuery().next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // =====================================================
    // CHECK EMAIL
    // =====================================================
    public boolean isEmailExists(String email) {
        String sql = "SELECT 1 FROM UserInfo WHERE email = ?";
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            return ps.executeQuery().next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // =====================================================
    // REGISTER (INSERT USERS + USERINFO + USER_ROLE)
    // =====================================================
   
           // =====================================================
    // REGISTER (INSERT USERS + USERINFO + USER_ROLE) - FIXED
    // =====================================================
    public boolean register(model.Authen a) {
        String sqlUser = "INSERT INTO Users (username, password, status) VALUES (?, ?, ?);";
        String sqlInfo = "INSERT INTO UserInfo (user_id, full_name, phone, email) VALUES (?, ?, ?, ?);";
        String sqlRole = "INSERT INTO User_Role (user_id, role_id) VALUES (?, ?);";

        // Sử dụng luôn biến 'connection' kế thừa từ DBContext thay vì new mới
        Connection conn = this.connection; 
        
        if (conn == null) {
            System.out.println("REGISTER ERROR: Connection is null!");
            return false;
        }

        // Khai báo PreparedStatement ngoài để đóng trong block finally
        PreparedStatement psUser = null;
        PreparedStatement psInfo = null;
        PreparedStatement psRole = null;
        ResultSet generatedKeys = null;

        try {
            conn.setAutoCommit(false); // Bật transaction

            // Bước 1: Chèn vào bảng Users
            psUser = conn.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS);
            psUser.setString(1, a.getUsername());
            psUser.setString(2, BCrypt.hashpw(a.getPassword(), BCrypt.gensalt())); 
            psUser.setString(3, a.getStatus()); 

            int affectedRows = psUser.executeUpdate();
            if (affectedRows == 0) {
                conn.rollback();
                return false;
            }

            // Lấy user_id vừa tự động tăng ra
            int generatedUserId = -1;
            generatedKeys = psUser.getGeneratedKeys();
            if (generatedKeys.next()) {
                generatedUserId = generatedKeys.getInt(1);
            }

            if (generatedUserId == -1) {
                conn.rollback();
                return false;
            }

            // Bước 2: Chèn vào bảng UserInfo
            psInfo = conn.prepareStatement(sqlInfo);
            psInfo.setInt(1, generatedUserId);
            psInfo.setString(2, a.getFullName());
            psInfo.setString(3, a.getPhone());
            psInfo.setString(4, a.getEmail());
            psInfo.executeUpdate();

            // Bước 3: Chèn vào bảng User_Role
            psRole = conn.prepareStatement(sqlRole);
            psRole.setInt(1, generatedUserId);
            psRole.setInt(2, a.getRoleId()); 
            psRole.executeUpdate();

            conn.commit(); // Thành công thì commit
            return true;

        } catch (Exception e) {
            System.out.println("REGISTER ERROR:");
            e.printStackTrace();
            if (conn != null) {
                try { 
                    conn.rollback(); 
                } catch (SQLException ex) { 
                    ex.printStackTrace(); 
                }
            }
            return false;
        } finally {
            // Giải phóng tài nguyên hệ thống (Rất quan trọng)
            try { if (generatedKeys != null) generatedKeys.close(); } catch (Exception e) {}
            try { if (psUser != null) psUser.close(); } catch (Exception e) {}
            try { if (psInfo != null) psInfo.close(); } catch (Exception e) {}
            try { if (psRole != null) psRole.close(); } catch (Exception e) {}
            // Không đóng conn ở đây vì connection này quản lý chung cho toàn bộ class qua DBContext
            try { if (conn != null) conn.setAutoCommit(true); } catch (Exception e) {}
        }
    }

    // tìm user theo email
    public Authen findByEmail(String email) {

        String sql = """
        SELECT u.user_id, u.username
        FROM Users u
        JOIN UserInfo ui ON u.user_id = ui.user_id
        WHERE ui.email = ?
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Authen a = new Authen();
                a.setId(rs.getInt("user_id"));
                a.setUsername(rs.getString("username"));
                return a;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

// update password
    public void updatePassword(int userId, String rawPassword) {

        String sql = "UPDATE Users SET password = ? WHERE user_id = ?";

        String hashedPassword = BCrypt.hashpw(rawPassword, BCrypt.gensalt(12));

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, hashedPassword);
            ps.setInt(2, userId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // =====================================================
    // TEST
    // =====================================================
    public static void main(String[] args) {

        AuthenDAO dao = new AuthenDAO();
        Authen a = dao.login("admin", "admin123");

        if (a != null) {
            System.out.println("LOGIN SUCCESS");
            System.out.println("ID: " + a.getId());
            System.out.println("Username: " + a.getUsername());
            System.out.println("Full Name: " + a.getFullName());
            System.out.println("Email: " + a.getEmail());
            System.out.println("Phone: " + a.getPhone());
            System.out.println("Role: " + a.getRole());
            System.out.println("Status: " + a.getStatus());
        } else {
            System.out.println("LOGIN FAILED");
        }
    }
}

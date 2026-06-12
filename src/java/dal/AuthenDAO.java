package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.mindrot.jbcrypt.BCrypt;
import model.Authen;

public class AuthenDAO extends DBContext{

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
    public boolean register(Authen a) {

        String insertUser = """
            INSERT INTO Users (username, password, status)
            VALUES (?, ?, 'Active')
        """;

        String insertInfo = """
            INSERT INTO UserInfo (user_id, full_name, phone, email)
            VALUES (?, ?, ?, ?)
        """;

        String insertRole = """
            INSERT INTO User_Role (user_id, role_id)
            VALUES (?, ?)
        """;

        try  {
            connection.setAutoCommit(false);

            // 1. INSERT USERS
            PreparedStatement psUser = connection.prepareStatement(
                    insertUser, PreparedStatement.RETURN_GENERATED_KEYS);
            psUser.setString(1, a.getUsername());
            psUser.setString(2, BCrypt.hashpw(a.getPassword(), BCrypt.gensalt()));
            psUser.executeUpdate();

            ResultSet rs = psUser.getGeneratedKeys();
            if (!rs.next()) {
                connection.rollback();
                return false;
            }

            int userId = rs.getInt(1);

            // 2. INSERT USERINFO
            PreparedStatement psInfo = connection.prepareStatement(insertInfo);
            psInfo.setInt(1, userId);
            psInfo.setString(2, a.getFullName());
            psInfo.setString(3, a.getPhone());
            psInfo.setString(4, a.getEmail());
            psInfo.executeUpdate();

            // 3. INSERT ROLE (default: CUSTOMER = 1)
            PreparedStatement psRole = connection.prepareStatement(insertRole);
            psRole.setInt(1, userId);
            psRole.setInt(2, a.getRoleId()); // 1-Customer | 2-Staff | 3-Admin
            psRole.executeUpdate();

            connection.commit();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
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

// check old password
    public boolean checkOldPassword(int userId, String oldPassword) {
        String sql = "SELECT password FROM Users WHERE user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String hashedPassword = rs.getString("password");
                    return BCrypt.checkpw(oldPassword, hashedPassword);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
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
    // UPDATE PROFILE
    // =====================================================
    public boolean updateProfile(Authen a) {
        String sql = """
            UPDATE UserInfo
            SET full_name = ?, phone = ?, email = ?, avatar = ?, gender = ?, dob = ?, address = ?
            WHERE user_id = ?
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, a.getFullName());
            ps.setString(2, a.getPhone());
            ps.setString(3, a.getEmail());
            ps.setString(4, a.getAvatar());
            ps.setString(5, a.getGender());
            
            if (a.getDob() == null || a.getDob().trim().isEmpty()) {
                ps.setNull(6, java.sql.Types.DATE);
            } else {
                try {
                    ps.setDate(6, java.sql.Date.valueOf(a.getDob()));
                } catch (IllegalArgumentException e) {
                    ps.setNull(6, java.sql.Types.DATE);
                }
            }
            
            ps.setString(7, a.getAddress());
            ps.setInt(8, a.getId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
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

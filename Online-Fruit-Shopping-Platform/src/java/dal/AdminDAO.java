package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.User;

/**
 * DAO dành riêng cho các chức năng quản trị của Admin
 */
public class AdminDAO extends DBContext {

    // CHỨC NĂNG 1 & 2: Lấy danh sách người dùng theo tên quyền (Customer / Shop Owner)
    public List<User> getUsersByRole(String roleName) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT u.user_id, u.username, u.status, ui.full_name, ui.email, ui.phone, r.role_name " +
                     "FROM Users u " +
                     "INNER JOIN User_Role ur ON u.user_id = ur.user_id " +
                     "INNER JOIN Roles r ON ur.role_id = r.role_id " +
                     "LEFT JOIN UserInfo ui ON u.user_id = ui.user_id " +
                     "WHERE r.role_name = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, roleName);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("user_id")); 
                u.setUsername(rs.getString("username"));
                u.setStatus(rs.getString("status"));
                u.setFullName(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setRole(rs.getString("role_name"));
                list.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // CHỨC NĂNG 3: Khóa hoặc Mở khóa tài khoản (Active <-> Inactive)
    public boolean changeUserStatus(int userId, String newStatus) {
        String sql = "UPDATE Users SET status = ? WHERE user_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, newStatus);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
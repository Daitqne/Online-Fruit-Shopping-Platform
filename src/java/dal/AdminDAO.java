package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import model.User;

/**
 * DAO dành riêng cho các chức năng quản trị của Admin
 */
public class AdminDAO extends DBContext {

    /**
     * Lấy danh sách người dùng theo tên quyền (Customer / Shop Owner)
     */
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

    /**
     * Khóa hoặc Mở khóa tài khoản (Active <-> Inactive)
     */
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

    /**
     * Lấy tất cả sản phẩm trong hệ thống
     */
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.product_id, p.product_name, p.price, p.discount_price, p.unit, " +
                     "p.origin, p.status, p.description, pc.category_name, pi.image_url, " +
                     "ui.full_name as shop_owner_name " +
                     "FROM Product p " +
                     "LEFT JOIN Product_Category pc ON p.category_id = pc.category_id " +
                     "LEFT JOIN Product_Image pi ON p.product_id = pi.product_id " +
                     "LEFT JOIN Users u ON p.shop_owner_id = u.user_id " +
                     "LEFT JOIN UserInfo ui ON u.user_id = ui.user_id " +
                     "ORDER BY p.product_id DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("product_id"));
                p.setName(rs.getString("product_name"));
                p.setPrice(rs.getDouble("price"));
                p.setDiscountPrice(rs.getDouble("discount_price"));
                p.setUnit(rs.getString("unit"));
                p.setOrigin(rs.getString("origin"));
                p.setCategory(rs.getString("category_name"));
                p.setStatus(rs.getString("status"));
                p.setDescription(rs.getString("description"));
                p.setImage(rs.getString("image_url"));
                p.setShopOwnerName(rs.getString("shop_owner_name"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Khóa hoặc Mở khóa sản phẩm (Available <-> Unavailable)
     */
    public boolean changeProductStatus(int productId, String newStatus) {
        String sql = "UPDATE Product SET status = ? WHERE product_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, newStatus);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}

package dal;

import java.sql.*;
import java.util.*;
import model.UserInfo;
import model.AdminSaleOrder;
import model.SaleOrderItem;
import model.Product;

public class AdminOrderDAO extends DBContext {

    // 1. Lấy danh sách khách hàng hiển thị bên trái panel
    public List<UserInfo> getCustomers() {
        List<UserInfo> list = new ArrayList<>();
        String sql = "SELECT u.user_id, ui.user_info_id, ui.full_name, ui.email, ui.phone "
                + "FROM Users u JOIN UserInfo ui ON u.user_id = ui.user_id "
                + "JOIN User_Role ur ON u.user_id = ur.user_id WHERE ur.role_id = 1 ORDER BY ui.full_name";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                UserInfo ui = new UserInfo();
                ui.setUserId(rs.getInt("user_id"));
                ui.setUserInfoId(rs.getInt("user_info_id"));
                ui.setFullName(rs.getString("full_name"));
                ui.setEmail(rs.getString("email"));
                ui.setPhone(rs.getString("phone"));
                list.add(ui);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<UserInfo> searchCustomers(String keyword) {

        List<UserInfo> list = new ArrayList<>();

        String sql = """
        SELECT u.user_id,
               ui.user_info_id,
               ui.full_name,
               ui.email,
               ui.phone
        FROM Users u
        JOIN UserInfo ui ON u.user_id = ui.user_id
        JOIN User_Role ur ON u.user_id = ur.user_id
        WHERE ur.role_id = 1
          AND ui.full_name LIKE ?
        ORDER BY ui.full_name
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                UserInfo ui = new UserInfo();

                ui.setUserId(rs.getInt("user_id"));
                ui.setUserInfoId(rs.getInt("user_info_id"));
                ui.setFullName(rs.getString("full_name"));
                ui.setEmail(rs.getString("email"));
                ui.setPhone(rs.getString("phone"));

                list.add(ui);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 2. CHUẨN HÓA: Lấy lịch sử mua hàng kèm chi tiết sản phẩm dựa theo lớp SaleOrderItem
    public List<AdminSaleOrder> getOrdersByCustomer(int userId) {
        List<AdminSaleOrder> list = new ArrayList<>();
        String sqlOrder = "SELECT sale_order_id, order_date, order_status, payment_method, payment_status, total_payment "
                + "FROM Sale_Order WHERE created_by = ? ORDER BY order_date DESC";

        String sqlItems = "SELECT soi.sale_item_id, soi.sale_order_id, soi.product_id, soi.quantity, soi.unit_price, "
                + "p.product_name, p.unit, "
                + "(SELECT TOP 1 image_url FROM Product_Image WHERE product_id = p.product_id ORDER BY image_id) as img "
                + "FROM Sale_Order_Item soi JOIN Product p ON soi.product_id = p.product_id WHERE soi.sale_order_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sqlOrder)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    AdminSaleOrder o = new AdminSaleOrder();
                    o.setSaleOrderId(rs.getInt("sale_order_id"));
                    o.setOrderDate(rs.getTimestamp("order_date"));
                    o.setOrderStatus(rs.getString("order_status"));
                    o.setPaymentMethod(rs.getString("payment_method"));
                    o.setPaymentStatus(rs.getString("payment_status"));
                    o.setTotalPayment(rs.getDouble("total_payment"));

                    // Chuẩn hóa: Khởi tạo danh sách bằng cấu trúc lớp SaleOrderItem
                    List<SaleOrderItem> items = new ArrayList<>();
                    try (PreparedStatement ps2 = connection.prepareStatement(sqlItems)) {
                        ps2.setInt(1, o.getSaleOrderId());
                        try (ResultSet rs2 = ps2.executeQuery()) {
                            while (rs2.next()) {
                                // Khởi tạo item chi tiết đơn hàng
                                SaleOrderItem item = new SaleOrderItem();
                                item.setSaleItemId(rs2.getInt("sale_item_id"));
                                item.setSaleOrderId(rs2.getInt("sale_order_id"));
                                item.setProductId(rs2.getInt("product_id"));
                                item.setQuantity(rs2.getInt("quantity"));
                                item.setUnitPrice(rs2.getDouble("unit_price"));

                                // Khởi tạo thực thể Product để mapping mối quan hệ (Join field)
                                // Khởi tạo thực thể Product để mapping mối quan hệ
                                Product p = new Product();
                                p.setId(rs2.getInt("product_id"));        // Dùng setId thay vì setProductId
                                p.setName(rs2.getString("product_name")); // Dùng setName thay vì setProductName
                                p.setUnit(rs2.getString("unit"));         // Dùng setUnit
                                p.setImage(rs2.getString("img"));         // Dùng setImage thay vì setImageurl

                                // Nhúng Product vào thực thể quản lý dòng sản phẩm
                                item.setProduct(p);
                                items.add(item);
                            }
                        }
                    }
                    o.setItems(items); // Gán List<SaleOrderItem> vào thực thể AdminSaleOrder
                    list.add(o);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 3. Tối ưu hóa nghiệp vụ: Khóa đơn + tự động hoàn trả số lượng vào kho Inventory
    public boolean lockOrder(int orderId) {
        String check = "SELECT order_status FROM Sale_Order WHERE sale_order_id = ?";
        String update = "UPDATE Sale_Order SET order_status = 'Cancelled' WHERE sale_order_id = ?";
        String getItems = "SELECT product_id, quantity FROM Sale_Order_Item WHERE sale_order_id = ?";
        String restore = "UPDATE Inventory SET quantity = quantity + ? WHERE product_id = ?";
        try {
            connection.setAutoCommit(false);

            try (PreparedStatement ps = connection.prepareStatement(check)) {
                ps.setInt(1, orderId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        String status = rs.getString("order_status");
                        if ("Delivered".equalsIgnoreCase(status) || "Cancelled".equalsIgnoreCase(status)) {
                            connection.rollback();
                            return false;
                        }
                    }
                }
            }
            try (PreparedStatement ps = connection.prepareStatement(update)) {
                ps.setInt(1, orderId);
                if (ps.executeUpdate() == 0) {
                    connection.rollback();
                    return false;
                }
            }
            try (PreparedStatement ps = connection.prepareStatement(getItems)) {
                ps.setInt(1, orderId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        try (PreparedStatement ps2 = connection.prepareStatement(restore)) {
                            ps2.setInt(1, rs.getInt("quantity"));
                            ps2.setInt(2, rs.getInt("product_id"));
                            ps2.executeUpdate();
                        }
                    }
                }
            }
            connection.commit();
            return true;
        } catch (Exception e) {
            try {
                connection.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }
}

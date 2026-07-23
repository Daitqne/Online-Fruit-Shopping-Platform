package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Delivery;
import model.Product;
import model.SaleOrderItem;

public class DeliveryDAO extends DBContext {

    // Helper method to map ResultSet to Delivery model with full order & customer info
    private Delivery mapDelivery(ResultSet rs) throws SQLException {
        Delivery d = new Delivery();
        d.setDeliveryId(rs.getInt("delivery_id"));
        d.setOrderId(rs.getInt("order_id"));
        int shipperId = rs.getInt("shipper_id");
        d.setShipperId((rs.wasNull() || shipperId == 0) ? null : shipperId);
        d.setStatus(rs.getString("status"));
        d.setShippingAddress(rs.getString("shipping_address"));
        d.setShippedDate(rs.getTimestamp("shipped_date"));
        d.setDeliveredDate(rs.getTimestamp("delivered_date"));

        d.setCustomerName(rs.getString("customer_name"));
        d.setShippingPhone(rs.getString("shipping_phone"));
        d.setPaymentMethod(rs.getString("payment_method"));
        d.setPaymentStatus(rs.getString("payment_status"));
        d.setShipperNote(rs.getString("shipper_note"));
        d.setTotalAmount(rs.getDouble("total_amount"));
        return d;
    }

    // Auto sync missing delivery records for orders in active status
    public void syncMissingDeliveries() {
        String insertSql = "INSERT INTO Delivery (order_id, shipping_address, status) "
                         + "SELECT so.sale_order_id, ISNULL(so.shipping_address, N'Chưa cập nhật'), 'Pending' "
                         + "FROM Sale_Order so "
                         + "WHERE (so.order_status IS NULL OR so.order_status NOT IN ('Cancelled', 'Delivered', 'Delivery Failed')) "
                         + "  AND NOT EXISTS (SELECT 1 FROM Delivery d WHERE d.order_id = so.sale_order_id)";

        String fixStatusSql = "UPDATE Delivery SET status = 'Pending' "
                            + "WHERE (shipper_id IS NULL OR shipper_id = 0) "
                            + "  AND (status IS NULL OR status = '' OR status NOT IN ('Delivered', 'Failed'))";
        try {
            Connection conn = getConnection();
            if (conn != null && !conn.isClosed()) {
                try (PreparedStatement ps1 = conn.prepareStatement(insertSql)) {
                    ps1.executeUpdate();
                }
                try (PreparedStatement ps2 = conn.prepareStatement(fixStatusSql)) {
                    ps2.executeUpdate();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Create a delivery for an order
    public boolean createDelivery(int orderId, String shippingAddress) {
        if (getDeliveryByOrderId(orderId) != null) {
            return false;
        }
        String sql = "INSERT INTO Delivery (order_id, shipping_address, status) VALUES (?, ?, 'Pending')";
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.setString(2, shippingAddress != null ? shippingAddress : "Chưa cập nhật");
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Check if order has a delivery
    public Delivery getDeliveryByOrderId(int orderId) {
        String sql = "SELECT d.*, "
                   + "       so.shipping_phone, so.payment_method, so.payment_status, so.shipper_note, "
                   + "       ui.full_name AS customer_name, "
                   + "       ISNULL((SELECT SUM(quantity * unit_price) FROM Sale_Order_Item WHERE sale_order_id = d.order_id), 0) AS total_amount "
                   + "FROM Delivery d "
                   + "LEFT JOIN Sale_Order so ON d.order_id = so.sale_order_id "
                   + "LEFT JOIN UserInfo ui ON so.created_by = ui.user_id "
                   + "WHERE d.order_id = ?";
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapDelivery(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // View all pending unassigned deliveries
    public List<Delivery> getUnassignedDeliveries() {
        return getUnassignedDeliveriesFiltered(null, null);
    }

    // View unassigned deliveries with filter (keyword / paymentMethod)
    public List<Delivery> getUnassignedDeliveriesFiltered(String keyword, String paymentMethod) {
        syncMissingDeliveries();
        List<Delivery> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT d.*, ")
           .append("       so.shipping_phone, so.payment_method, so.payment_status, so.shipper_note, ")
           .append("       ui.full_name AS customer_name, ")
           .append("       ISNULL((SELECT SUM(quantity * unit_price) FROM Sale_Order_Item WHERE sale_order_id = d.order_id), 0) AS total_amount ")
           .append("FROM Delivery d ")
           .append("LEFT JOIN Sale_Order so ON d.order_id = so.sale_order_id ")
           .append("LEFT JOIN UserInfo ui ON so.created_by = ui.user_id ")
           .append("WHERE (d.shipper_id IS NULL OR d.shipper_id = 0) AND (d.status IS NULL OR d.status = '' OR d.status NOT IN ('Delivered', 'Failed')) ");

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (d.shipping_address LIKE ? OR CAST(d.order_id AS VARCHAR) LIKE ? OR so.shipping_phone LIKE ? OR ui.full_name LIKE ?) ");
            String k = "%" + keyword.trim() + "%";
            params.add(k);
            params.add(k);
            params.add(k);
            params.add(k);
        }

        if (paymentMethod != null && !paymentMethod.trim().isEmpty() && !"ALL".equalsIgnoreCase(paymentMethod)) {
            sql.append("AND so.payment_method = ? ");
            params.add(paymentMethod.trim());
        }

        sql.append("ORDER BY d.delivery_id DESC");

        try {
            PreparedStatement ps = getConnection().prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapDelivery(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // View all deliveries assigned to a specific staff
    public List<Delivery> getDeliveriesByStaff(int staffId) {
        return getDeliveriesByStaffFiltered(staffId, null, null, null);
    }

    // View staff deliveries with filtering (keyword, paymentMethod, statusFilter)
    public List<Delivery> getDeliveriesByStaffFiltered(int staffId, String keyword, String paymentMethod, String statusFilter) {
        List<Delivery> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT d.*, ")
           .append("       so.shipping_phone, so.payment_method, so.payment_status, so.shipper_note, ")
           .append("       ui.full_name AS customer_name, ")
           .append("       ISNULL((SELECT SUM(quantity * unit_price) FROM Sale_Order_Item WHERE sale_order_id = d.order_id), 0) AS total_amount ")
           .append("FROM Delivery d ")
           .append("LEFT JOIN Sale_Order so ON d.order_id = so.sale_order_id ")
           .append("LEFT JOIN UserInfo ui ON so.created_by = ui.user_id ")
           .append("WHERE d.shipper_id = ? ");

        List<Object> params = new ArrayList<>();
        params.add(staffId);

        if (statusFilter != null && !statusFilter.trim().isEmpty() && !"ALL".equalsIgnoreCase(statusFilter)) {
            sql.append("AND d.status = ? ");
            params.add(statusFilter.trim());
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (d.shipping_address LIKE ? OR CAST(d.order_id AS VARCHAR) LIKE ? OR so.shipping_phone LIKE ? OR ui.full_name LIKE ?) ");
            String k = "%" + keyword.trim() + "%";
            params.add(k);
            params.add(k);
            params.add(k);
            params.add(k);
        }

        if (paymentMethod != null && !paymentMethod.trim().isEmpty() && !"ALL".equalsIgnoreCase(paymentMethod)) {
            sql.append("AND so.payment_method = ? ");
            params.add(paymentMethod.trim());
        }

        sql.append("ORDER BY d.shipped_date DESC, d.delivery_id DESC");

        try {
            PreparedStatement ps = getConnection().prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapDelivery(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Delivery shipper assigns deliveries to self
    public boolean claimDelivery(int deliveryId, int staffId) {
        String sql = "UPDATE Delivery SET shipper_id = ?, status = 'Shipping', shipped_date=? "
                   + "WHERE delivery_id=? AND shipper_id IS NULL AND status = 'Pending'";
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, staffId);
            ps.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            ps.setInt(3, deliveryId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private int getOrderIdByDeliveryId(int deliveryId) {
        String sql = "SELECT order_id FROM Delivery WHERE delivery_id = ?";
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, deliveryId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("order_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Update order status
    private boolean syncOrderDelivered(int orderId) {
        String sql = "UPDATE Sale_Order SET order_status = 'Delivered', delivered_date = ? WHERE sale_order_id=?";
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update delivery status to Delivered
    public boolean confirmDelivery(int deliveryId, int staffId) {
        String sql = "UPDATE Delivery SET status = 'Delivered', delivered_date=? "
                   + "WHERE delivery_id=? AND shipper_id=? AND status = 'Shipping'";
        try {
            getConnection().setAutoCommit(false);

            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            ps.setInt(2, deliveryId);
            ps.setInt(3, staffId);
            int updated = ps.executeUpdate();
            if (updated == 0) {
                getConnection().rollback();
                return false;
            }

            int orderId = getOrderIdByDeliveryId(deliveryId);
            if (orderId == -1) {
                getConnection().rollback();
                return false;
            }
            syncOrderDelivered(orderId);

            // Cập nhật payment_status thành Paid nếu là đơn COD
            String updatePaymentSql = "UPDATE Sale_Order SET payment_status = 'Paid' WHERE sale_order_id = ? AND (payment_status IS NULL OR payment_status = 'Pending')";
            PreparedStatement psPay = getConnection().prepareStatement(updatePaymentSql);
            psPay.setInt(1, orderId);
            psPay.executeUpdate();

            getConnection().commit();

            try {
                MembershipDAO membershipDAO = new MembershipDAO();
                membershipDAO.addPointsForOrder(orderId);
            } catch (Exception ex) {
                ex.printStackTrace();
            }

            return true;
        } catch (SQLException e) {
            try {
                getConnection().rollback();
            } catch (SQLException re) {
                re.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                getConnection().setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    // Report delivery failure
    public boolean reportDeliveryFailure(int deliveryId, int staffId, String reason) {
        String sqlDelivery = "UPDATE Delivery SET status = 'Failed', delivered_date = ? "
                           + "WHERE delivery_id = ? AND shipper_id = ? AND status = 'Shipping'";
        String sqlOrder = "UPDATE Sale_Order SET order_status = 'Delivery Failed', "
                        + "shipper_note = ISNULL(shipper_note, '') + ' [Lý do giao thất bại: ' + ? + ']' "
                        + "WHERE sale_order_id = ?";
        try {
            getConnection().setAutoCommit(false);
            PreparedStatement psD = getConnection().prepareStatement(sqlDelivery);
            psD.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            psD.setInt(2, deliveryId);
            psD.setInt(3, staffId);
            int rows = psD.executeUpdate();
            if (rows == 0) {
                getConnection().rollback();
                return false;
            }

            int orderId = getOrderIdByDeliveryId(deliveryId);
            if (orderId != -1) {
                PreparedStatement psO = getConnection().prepareStatement(sqlOrder);
                psO.setString(1, reason);
                psO.setInt(2, orderId);
                psO.executeUpdate();
            }
            getConnection().commit();

            // Gửi thông báo cho khách hàng và chủ shop sau khi commit
            if (orderId != -1) {
                try {
                    NotificationDAO ntd = new NotificationDAO();
                    String title = "\u26A0\uFE0F Giao hàng thất bại - Đơn hàng #" + orderId;
                    String contentCustomer = "Đơn hàng #" + orderId + " của bạn đã bị báo giao hàng thất bại. Lý do: " + reason + ". Vui lòng liên hệ shop để được hỗ trợ.";
                    String contentOwner   = "Đơn hàng #" + orderId + " giao hàng thất bại. Lý do: " + reason + ". Vui lòng kiểm tra và xử lý đơn hàng.";

                    // Thông báo cho khách hàng (created_by)
                    int customerId = getCustomerIdByOrderId(orderId);
                    if (customerId != -1) {
                        ntd.addNotification(customerId, title, contentCustomer);
                    }

                    // Thông báo cho tất cả chủ shop có sản phẩm trong đơn
                    List<Integer> ownerIds = getShopOwnerIdsByOrderId(orderId);
                    for (int ownerId : ownerIds) {
                        ntd.addNotification(ownerId, title, contentOwner);
                    }
                } catch (Exception ex) {
                    ex.printStackTrace(); // Không ảnh hưởng kết quả chính
                }
            }

            return true;
        } catch (SQLException e) {
            try {
                getConnection().rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                getConnection().setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    // Lấy user_id của khách hàng đặt đơn
    private int getCustomerIdByOrderId(int orderId) {
        String sql = "SELECT created_by FROM Sale_Order WHERE sale_order_id = ?";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("created_by");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Lấy danh sách shop_owner_id có sản phẩm trong đơn hàng
    private List<Integer> getShopOwnerIdsByOrderId(int orderId) {
        List<Integer> ids = new ArrayList<>();
        String sql = "SELECT DISTINCT p.shop_owner_id "
                   + "FROM Sale_Order_Item soi "
                   + "JOIN Product p ON soi.product_id = p.product_id "
                   + "WHERE soi.sale_order_id = ? AND p.shop_owner_id IS NOT NULL";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ids.add(rs.getInt("shop_owner_id"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ids;
    }

    // Get order items list for Quick View Modal
    public List<SaleOrderItem> getSaleOrderItems(int orderId) {
        List<SaleOrderItem> list = new ArrayList<>();
        String sql = "SELECT soi.*, p.product_name, "
                   + "       (SELECT TOP 1 image_url FROM Product_Image WHERE product_id = p.product_id ORDER BY image_id ASC) AS image_url "
                   + "FROM Sale_Order_Item soi "
                   + "JOIN Product p ON soi.product_id = p.product_id "
                   + "WHERE soi.sale_order_id = ?";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SaleOrderItem item = new SaleOrderItem();
                item.setSaleItemId(rs.getInt("sale_item_id"));
                item.setSaleOrderId(rs.getInt("sale_order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setUnitPrice(rs.getDouble("unit_price"));
                item.setWeightLabel(rs.getString("weight_label"));
                item.setPackagingName(rs.getString("packaging_name"));

                Product p = new Product();
                p.setId(rs.getInt("product_id"));
                p.setName(rs.getString("product_name"));
                p.setImage(rs.getString("image_url"));
                item.setProduct(p);

                list.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}

package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.SaleOrder;
import model.SaleOrderItem;

public class OrderDAO extends DBContext {

    public OrderDAO() {
        super();
        checkAndAddColumns();
    }

    /**
     * Silently alters the Sale_Order table to ensure it contains pricing/coupon fields.
     * MS SQL Server will throw an error if they exist, which we catch and ignore.
     */
    private void checkAndAddColumns() {
        String[] cols = {
            "ALTER TABLE Sale_Order ADD discount_amount DECIMAL(10, 2) NULL DEFAULT 0",
            "ALTER TABLE Sale_Order ADD promo_code VARCHAR(50) NULL",
            "ALTER TABLE Sale_Order ADD shipping_fee DECIMAL(10, 2) NULL DEFAULT 0",
            "ALTER TABLE Sale_Order ADD total_payment DECIMAL(10, 2) NULL DEFAULT 0"
        };
        for (String sql : cols) {
            try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
                ps.executeUpdate();
            } catch (SQLException e) {
                // Column probably already exists, which is fine
            }
        }
    }

    /**
     * Inserts a SaleOrder along with its SaleOrderItems and updates Inventory stock.
     * Everything is wrapped in a single database transaction.
     */
    public boolean insertOrder(SaleOrder order) {
        String insertOrderSql = """
            INSERT INTO Sale_Order (order_date, created_by, order_status, payment_method, payment_status, 
                                    shipping_address, shipping_phone, shipper_note, 
                                    discount_amount, promo_code, shipping_fee, total_payment)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """;
        
        String insertItemSql = """
            INSERT INTO Sale_Order_Item (sale_order_id, product_id, quantity, unit_price)
            VALUES (?, ?, ?, ?)
        """;

        String updateInventorySql = """
            UPDATE Inventory 
            SET quantity = quantity - ? 
            WHERE product_id = ?
        """;

        try {
            // Get connection and start transaction
            getConnection().setAutoCommit(false);

            // 1. Insert Order
            try (PreparedStatement psOrder = getConnection().prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS)) {
                psOrder.setTimestamp(1, order.getOrderDate() != null ? order.getOrderDate() : new Timestamp(System.currentTimeMillis()));
                psOrder.setInt(2, order.getCreatedBy());
                psOrder.setNString(3, order.getOrderStatus() != null ? order.getOrderStatus() : "Pending");
                psOrder.setNString(4, order.getPaymentMethod());
                psOrder.setNString(5, order.getPaymentStatus() != null ? order.getPaymentStatus() : "Pending");
                psOrder.setNString(6, order.getShippingAddress());
                psOrder.setNString(7, order.getShippingPhone());
                psOrder.setNString(8, order.getShipperNote());
                psOrder.setDouble(9, order.getDiscountAmount());
                psOrder.setString(10, order.getPromoCode());
                psOrder.setDouble(11, order.getShippingFee());
                psOrder.setDouble(12, order.getTotalPayment());

                int affectedRows = psOrder.executeUpdate();
                if (affectedRows == 0) {
                    throw new SQLException("Creating order failed, no rows affected.");
                }

                // Retrieve the generated Order ID
                try (ResultSet generatedKeys = psOrder.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        order.setSaleOrderId(generatedKeys.getInt(1));
                    } else {
                        throw new SQLException("Creating order failed, no ID obtained.");
                    }
                }
            }

            // 2. Insert Order Items and Update Inventory
            try (PreparedStatement psItem = getConnection().prepareStatement(insertItemSql);
                 PreparedStatement psInventory = getConnection().prepareStatement(updateInventorySql)) {
                
                for (SaleOrderItem item : order.getItems()) {
                    // Insert Item
                    psItem.setInt(1, order.getSaleOrderId());
                    psItem.setInt(2, item.getProductId());
                    psItem.setInt(3, item.getQuantity());
                    psItem.setDouble(4, item.getUnitPrice());
                    psItem.executeUpdate();

                    // Update Stock in Inventory
                    psInventory.setInt(1, item.getQuantity());
                    psInventory.setInt(2, item.getProductId());
                    psInventory.executeUpdate();
                }
            }

            // Commit transaction
            getConnection().commit();
            return true;

        } catch (SQLException ex) {
            try {
                getConnection().rollback();
            } catch (SQLException rollbackEx) {
                Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, "Rollback failed", rollbackEx);
            }
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, "Failed to insert order", ex);
        } finally {
            try {
                getConnection().setAutoCommit(true);
            } catch (SQLException e) {
                Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, "Reset auto commit failed", e);
            }
        }
        return false;
    }

    /**
     * Retrieves all orders for a specific user, ordered by date descending.
     */
    public java.util.List<SaleOrder> getOrdersByUserId(int userId) {
        java.util.List<SaleOrder> list = new java.util.ArrayList<>();
        String sql = """
            SELECT sale_order_id, order_date, created_by, order_status, payment_method, payment_status,
                   shipping_address, shipping_phone, shipper_id, shipped_date, delivered_date, shipper_note,
                   discount_amount, promo_code, shipping_fee, total_payment
            FROM Sale_Order
            WHERE created_by = ?
            ORDER BY order_date DESC
        """;
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SaleOrder order = new SaleOrder();
                    order.setSaleOrderId(rs.getInt("sale_order_id"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setCreatedBy(rs.getInt("created_by"));
                    order.setOrderStatus(rs.getString("order_status"));
                    order.setPaymentMethod(rs.getString("payment_method"));
                    order.setPaymentStatus(rs.getString("payment_status"));
                    order.setShippingAddress(rs.getString("shipping_address"));
                    order.setShippingPhone(rs.getString("shipping_phone"));
                    order.setShipperId(rs.getObject("shipper_id") != null ? rs.getInt("shipper_id") : null);
                    order.setShippedDate(rs.getTimestamp("shipped_date"));
                    order.setDeliveredDate(rs.getTimestamp("delivered_date"));
                    order.setShipperNote(rs.getString("shipper_note"));
                    order.setDiscountAmount(rs.getDouble("discount_amount"));
                    order.setPromoCode(rs.getString("promo_code"));
                    order.setShippingFee(rs.getDouble("shipping_fee"));
                    order.setTotalPayment(rs.getDouble("total_payment"));
                    list.add(order);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     * Retrieves detailed information of an order, including its items and product info.
     */
    public SaleOrder getOrderById(int orderId) {
        String orderSql = """
            SELECT sale_order_id, order_date, created_by, order_status, payment_method, payment_status,
                   shipping_address, shipping_phone, shipper_id, shipped_date, delivered_date, shipper_note,
                   discount_amount, promo_code, shipping_fee, total_payment
            FROM Sale_Order
            WHERE sale_order_id = ?
        """;
        
        String itemsSql = """
            SELECT soi.sale_item_id, soi.sale_order_id, soi.product_id, soi.quantity, soi.unit_price,
                   p.product_name,
                   (SELECT TOP 1 image_url FROM Product_Image WHERE product_id = p.product_id ORDER BY image_id ASC) AS image_url
            FROM Sale_Order_Item soi
            JOIN Product p ON soi.product_id = p.product_id
            WHERE soi.sale_order_id = ?
        """;

        try (PreparedStatement psOrder = getConnection().prepareStatement(orderSql)) {
            psOrder.setInt(1, orderId);
            try (ResultSet rs = psOrder.executeQuery()) {
                if (rs.next()) {
                    SaleOrder order = new SaleOrder();
                    order.setSaleOrderId(rs.getInt("sale_order_id"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setCreatedBy(rs.getInt("created_by"));
                    order.setOrderStatus(rs.getString("order_status"));
                    order.setPaymentMethod(rs.getString("payment_method"));
                    order.setPaymentStatus(rs.getString("payment_status"));
                    order.setShippingAddress(rs.getString("shipping_address"));
                    order.setShippingPhone(rs.getString("shipping_phone"));
                    order.setShipperId(rs.getObject("shipper_id") != null ? rs.getInt("shipper_id") : null);
                    order.setShippedDate(rs.getTimestamp("shipped_date"));
                    order.setDeliveredDate(rs.getTimestamp("delivered_date"));
                    order.setShipperNote(rs.getString("shipper_note"));
                    order.setDiscountAmount(rs.getDouble("discount_amount"));
                    order.setPromoCode(rs.getString("promo_code"));
                    order.setShippingFee(rs.getDouble("shipping_fee"));
                    order.setTotalPayment(rs.getDouble("total_payment"));

                    // Load Items
                    java.util.List<SaleOrderItem> items = new java.util.ArrayList<>();
                    try (PreparedStatement psItems = getConnection().prepareStatement(itemsSql)) {
                        psItems.setInt(1, orderId);
                        try (ResultSet rsItem = psItems.executeQuery()) {
                            while (rsItem.next()) {
                                SaleOrderItem soi = new SaleOrderItem();
                                soi.setSaleItemId(rsItem.getInt("sale_item_id"));
                                soi.setSaleOrderId(rsItem.getInt("sale_order_id"));
                                soi.setProductId(rsItem.getInt("product_id"));
                                soi.setQuantity(rsItem.getInt("quantity"));
                                soi.setUnitPrice(rsItem.getDouble("unit_price"));
                                
                                model.Product p = new model.Product();
                                p.setId(rsItem.getInt("product_id"));
                                p.setName(rsItem.getNString("product_name"));
                                p.setImage(rsItem.getString("image_url"));
                                soi.setProduct(p);

                                items.add(soi);
                            }
                        }
                    }
                    order.setItems(items);
                    return order;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * Retrieves all orders that contain at least one product owned by the given shop owner.
     * Also loads each order's items (filtered to the shop owner's products) and basic customer info.
     */
    public java.util.List<SaleOrder> getOrdersByShopOwner(int shopOwnerId) {
        java.util.List<SaleOrder> list = new java.util.ArrayList<>();
        // Get distinct orders that include at least one product from this shop owner
        String orderSql = """
            SELECT DISTINCT so.sale_order_id, so.order_date, so.created_by, so.order_status,
                   so.payment_method, so.payment_status, so.shipping_address, so.shipping_phone,
                   so.discount_amount, so.promo_code, so.shipping_fee, so.total_payment,
                   ui.full_name AS customer_name
            FROM Sale_Order so
            JOIN Sale_Order_Item soi ON so.sale_order_id = soi.sale_order_id
            JOIN Product p ON soi.product_id = p.product_id
            LEFT JOIN UserInfo ui ON so.created_by = ui.user_id
            WHERE p.shop_owner_id = ?
            ORDER BY so.order_date DESC
        """;

        String itemsSql = """
            SELECT soi.sale_item_id, soi.sale_order_id, soi.product_id, soi.quantity, soi.unit_price,
                   p.product_name,
                   (SELECT TOP 1 image_url FROM Product_Image WHERE product_id = p.product_id ORDER BY image_id ASC) AS image_url
            FROM Sale_Order_Item soi
            JOIN Product p ON soi.product_id = p.product_id
            WHERE soi.sale_order_id = ? AND p.shop_owner_id = ?
        """;

        try (PreparedStatement psOrder = getConnection().prepareStatement(orderSql)) {
            psOrder.setInt(1, shopOwnerId);
            try (ResultSet rs = psOrder.executeQuery()) {
                while (rs.next()) {
                    SaleOrder order = new SaleOrder();
                    order.setSaleOrderId(rs.getInt("sale_order_id"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setCreatedBy(rs.getInt("created_by"));
                    order.setOrderStatus(rs.getString("order_status"));
                    order.setPaymentMethod(rs.getString("payment_method"));
                    order.setPaymentStatus(rs.getString("payment_status"));
                    order.setShippingAddress(rs.getString("shipping_address"));
                    order.setShippingPhone(rs.getString("shipping_phone"));
                    order.setDiscountAmount(rs.getDouble("discount_amount"));
                    order.setPromoCode(rs.getString("promo_code"));
                    order.setShippingFee(rs.getDouble("shipping_fee"));
                    order.setTotalPayment(rs.getDouble("total_payment"));
                    order.setCustomerName(rs.getString("customer_name"));

                    // Load items (only products from this shop owner)
                    java.util.List<SaleOrderItem> items = new java.util.ArrayList<>();
                    try (PreparedStatement psItems = getConnection().prepareStatement(itemsSql)) {
                        psItems.setInt(1, order.getSaleOrderId());
                        psItems.setInt(2, shopOwnerId);
                        try (ResultSet rsItem = psItems.executeQuery()) {
                            while (rsItem.next()) {
                                SaleOrderItem soi = new SaleOrderItem();
                                soi.setSaleItemId(rsItem.getInt("sale_item_id"));
                                soi.setSaleOrderId(rsItem.getInt("sale_order_id"));
                                soi.setProductId(rsItem.getInt("product_id"));
                                soi.setQuantity(rsItem.getInt("quantity"));
                                soi.setUnitPrice(rsItem.getDouble("unit_price"));
                                model.Product prod = new model.Product();
                                prod.setId(rsItem.getInt("product_id"));
                                prod.setName(rsItem.getNString("product_name"));
                                prod.setImage(rsItem.getString("image_url"));
                                soi.setProduct(prod);
                                items.add(soi);
                            }
                        }
                    }
                    order.setItems(items);
                    list.add(order);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     * Updates the status of an order. Used by Shop Owner to confirm/reject/ship orders.
     * Allowed target statuses: Processing, Shipping, Delivered, Cancelled.
     */
    public boolean updateOrderStatus(int orderId, String newStatus) {
        String sql = "UPDATE Sale_Order SET order_status = ? WHERE sale_order_id = ?";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setNString(1, newStatus);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     * Cancels an order, restoring the inventory stock quantities.
     * Only works if the order is currently 'Pending'.
     */
    public boolean cancelOrder(int orderId, int userId) {
        String checkSql = "SELECT order_status FROM Sale_Order WHERE sale_order_id = ? AND created_by = ?";
        String updateStatusSql = "UPDATE Sale_Order SET order_status = 'Cancelled' WHERE sale_order_id = ? AND created_by = ?";
        String getItemsSql = "SELECT product_id, quantity FROM Sale_Order_Item WHERE sale_order_id = ?";
        String restoreInventorySql = "UPDATE Inventory SET quantity = quantity + ? WHERE product_id = ?";

        try {
            // Get connection and start transaction
            getConnection().setAutoCommit(false);

            // 1. Check current status
            String currentStatus = null;
            try (PreparedStatement psCheck = getConnection().prepareStatement(checkSql)) {
                psCheck.setInt(1, orderId);
                psCheck.setInt(2, userId);
                try (ResultSet rs = psCheck.executeQuery()) {
                    if (rs.next()) {
                        currentStatus = rs.getString("order_status");
                    }
                }
            }

            if (currentStatus == null || !"Pending".equalsIgnoreCase(currentStatus)) {
                // Order is not Pending or doesn't exist, cannot cancel
                getConnection().rollback();
                return false;
            }

            // 2. Update status to Cancelled
            try (PreparedStatement psUpdate = getConnection().prepareStatement(updateStatusSql)) {
                psUpdate.setInt(1, orderId);
                psUpdate.setInt(2, userId);
                int updated = psUpdate.executeUpdate();
                if (updated == 0) {
                    getConnection().rollback();
                    return false;
                }
            }

            // 3. Retrieve items to restore stock
            java.util.List<SaleOrderItem> items = new java.util.ArrayList<>();
            try (PreparedStatement psGetItems = getConnection().prepareStatement(getItemsSql)) {
                psGetItems.setInt(1, orderId);
                try (ResultSet rs = psGetItems.executeQuery()) {
                    while (rs.next()) {
                        SaleOrderItem soi = new SaleOrderItem();
                        soi.setProductId(rs.getInt("product_id"));
                        soi.setQuantity(rs.getInt("quantity"));
                        items.add(soi);
                    }
                }
            }

            // 4. Restore Inventory quantity
            try (PreparedStatement psRestore = getConnection().prepareStatement(restoreInventorySql)) {
                for (SaleOrderItem item : items) {
                    psRestore.setInt(1, item.getQuantity());
                    psRestore.setInt(2, item.getProductId());
                    psRestore.executeUpdate();
                }
            }

            getConnection().commit();
            return true;

        } catch (SQLException ex) {
            try {
                getConnection().rollback();
            } catch (SQLException rollbackEx) {
                Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, "Rollback failed", rollbackEx);
            }
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, "Failed to cancel order", ex);
        } finally {
            try {
                getConnection().setAutoCommit(true);
            } catch (SQLException e) {
                Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return false;
    }

    /**
     * Updates the payment status of an order (e.g. Pending, Paid, Failed).
     */
    public boolean updatePaymentStatus(int orderId, String newStatus) {
        String sql = "UPDATE Sale_Order SET payment_status = ? WHERE sale_order_id = ?";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setNString(1, newStatus);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     * Updates both the order status and payment status (e.g. Processing and Paid).
     */
    public boolean updateOrderStatusAndPaymentStatus(int orderId, String newOrderStatus, String newPaymentStatus) {
        String sql = "UPDATE Sale_Order SET order_status = ?, payment_status = ? WHERE sale_order_id = ?";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setNString(1, newOrderStatus);
            ps.setNString(2, newPaymentStatus);
            ps.setInt(3, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}


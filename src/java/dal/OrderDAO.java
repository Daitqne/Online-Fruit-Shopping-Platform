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
}

  package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Delivery;

public class DeliveryDAO extends DBContext{
    //create a delivery for an order
    public boolean createDelivery(int orderId, String shippingAddress){
        if (getDeliveryByOrderId(orderId) != null) {
            return false;
        }
        String sql = "insert into Delivery (order_id, shipping_address) values (?, ?)";
        try{
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.setString(2, shippingAddress);
            return ps.executeUpdate()>0;
        } 
        catch(SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    //check if order has a delivery
    public Delivery getDeliveryByOrderId(int orderId){
        String sql = "select * from Delivery "
                   + "where order_id=?";
        try{
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Delivery d = new Delivery();
                    d.setDeliveryId(rs.getInt("delivery_id"));
                    d.setOrderId(rs.getInt("order_id"));
                    d.setShipperId(rs.getInt("shipper_id"));
                    d.setStatus(rs.getString("status"));
                    d.setShippingAddress(rs.getString("shipping_address"));
                    d.setShippedDate(rs.getTimestamp("shipped_date"));
                    d.setDeliveredDate(rs.getTimestamp("delivered_date"));
                    return d;
                }
            }
        }
        catch(SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    //view all pending deliveries
    public List<Delivery> getUnassignedDeliveries(){
        List<Delivery> list = new ArrayList<>();
        String sql = "select * from Delivery "
                   + "where shipper_id is null and status = 'Pending'";
        try{
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Delivery d = new Delivery();
                d.setDeliveryId(rs.getInt("delivery_id"));
                d.setOrderId(rs.getInt("order_id"));
                d.setShipperId(rs.getInt("shipper_id"));
                d.setStatus(rs.getString("status"));
                d.setShippingAddress(rs.getString("shipping_address"));
                d.setShippedDate(rs.getTimestamp("shipped_date"));
                d.setDeliveredDate(rs.getTimestamp("delivered_date"));
                list.add(d);
            }
        } 
        catch(SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Delivery> getDeliveriesByStaff(int staffId) {
        List<Delivery> list = new ArrayList<>();
        String sql = "select * from Delivery where shipper_id=?";
        try{
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, staffId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Delivery d = new Delivery();
                d.setDeliveryId(rs.getInt("delivery_id"));
                d.setOrderId(rs.getInt("order_id"));
                d.setShipperId(rs.getInt("shipper_id"));
                d.setStatus(rs.getString("status"));
                d.setShippingAddress(rs.getString("shipping_address"));
                d.setShippedDate(rs.getTimestamp("shipped_date"));
                d.setDeliveredDate(rs.getTimestamp("delivered_date"));
                list.add(d);
            }
        } 
        catch(SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    //delivery shipper assigns deliveries to self
    public boolean claimDelivery(int deliveryId, int staffId) {
        String sql = "update Delivery set shipper_id = ?, status = 'Shipping', shipped_date=? "
                   + "where delivery_id=? and shipper_id is null and status = 'Pending'";
        try{
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, staffId);
            ps.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            ps.setInt(3, deliveryId);
            return ps.executeUpdate() > 0;
        } 
        catch(SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private int getOrderIdByDeliveryId(int deliveryId) {
        String sql = "select order_id from Delivery where delivery_id = ?";
        try{
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, deliveryId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("order_id");
            }
        } 
        catch(SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
    
    //update order status
    private boolean syncOrderDelivered(int orderId) {
        String sql = "update Sale_Order set order_status = 'Delivered', delivered_date = ? where sale_order_id=?";
        try{
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } 
        catch(SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    //update delivery status
    public boolean confirmDelivery(int deliveryId, int staffId) {
        String sql = "update Delivery set status = 'Delivered', delivered_date=? "
                   + "where delivery_id=? and shipper_id=? and status = 'Shipping'";
        try{
            //update both tables at the same time
            connection.setAutoCommit(false);

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            ps.setInt(2, deliveryId);
            ps.setInt(3, staffId);
            int updated = ps.executeUpdate();
            if (updated == 0) {
                connection.rollback();
                return false;
            }

            int orderId = getOrderIdByDeliveryId(deliveryId);
            //no order found
            if (orderId == -1) {
                connection.rollback();
                return false;
            }
            syncOrderDelivered(orderId);
            connection.commit();
            return true;

        } 
        catch(SQLException e) {
            try{
                connection.rollback();
            } 
            catch(SQLException re) {
                re.printStackTrace();
            }
            e.printStackTrace();
        } 
        finally{
            try{
                connection.setAutoCommit(true);
            }
            catch(SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }
}

package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.CustomerAddress;

public class AddressDAO extends DBContext {

    // Lấy tất cả địa chỉ của một user
    public List<CustomerAddress> getByUserId(int userId) {
        List<CustomerAddress> list = new ArrayList<>();
        String sql = "SELECT * FROM CustomerAddresses WHERE user_id = ? ORDER BY is_default DESC, address_id ASC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy một địa chỉ theo ID
    public CustomerAddress getById(int addressId) {
        String sql = "SELECT * FROM CustomerAddresses WHERE address_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, addressId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm địa chỉ mới
    public boolean insert(CustomerAddress a) {
        try {
            connection.setAutoCommit(false);

            // Nếu là địa chỉ mặc định → bỏ mặc định của các địa chỉ cũ
            if (a.isDefault()) {
                unsetDefault(a.getUserId());
            }

            String sql = "INSERT INTO CustomerAddresses (user_id, label, receiver_name, receiver_phone, address_details, is_default) "
                       + "VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setInt(1, a.getUserId());
                ps.setNString(2, a.getLabel());
                ps.setNString(3, a.getReceiverName());
                ps.setNString(4, a.getReceiverPhone());
                ps.setNString(5, a.getAddressDetails());
                ps.setBoolean(6, a.isDefault());
                ps.executeUpdate();
            }

            connection.commit();
            return true;
        } catch (SQLException e) {
            try { connection.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
        } finally {
            try { connection.setAutoCommit(true); } catch (SQLException e) { e.printStackTrace(); }
        }
        return false;
    }

    // Cập nhật địa chỉ
    public boolean update(CustomerAddress a) {
        try {
            connection.setAutoCommit(false);

            if (a.isDefault()) {
                unsetDefault(a.getUserId());
            }

            String sql = "UPDATE CustomerAddresses SET label=?, receiver_name=?, receiver_phone=?, address_details=?, is_default=? "
                       + "WHERE address_id=? AND user_id=?";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setNString(1, a.getLabel());
                ps.setNString(2, a.getReceiverName());
                ps.setNString(3, a.getReceiverPhone());
                ps.setNString(4, a.getAddressDetails());
                ps.setBoolean(5, a.isDefault());
                ps.setInt(6, a.getAddressId());
                ps.setInt(7, a.getUserId());
                ps.executeUpdate();
            }

            connection.commit();
            return true;
        } catch (SQLException e) {
            try { connection.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
        } finally {
            try { connection.setAutoCommit(true); } catch (SQLException e) { e.printStackTrace(); }
        }
        return false;
    }

    // Xóa địa chỉ (chỉ cho phép xóa địa chỉ của chính user đó)
    public boolean delete(int addressId, int userId) {
        String sql = "DELETE FROM CustomerAddresses WHERE address_id=? AND user_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, addressId);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Đặt một địa chỉ làm mặc định
    public boolean setDefault(int addressId, int userId) {
        try {
            connection.setAutoCommit(false);

            unsetDefault(userId);

            String sql = "UPDATE CustomerAddresses SET is_default=1 WHERE address_id=? AND user_id=?";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setInt(1, addressId);
                ps.setInt(2, userId);
                ps.executeUpdate();
            }

            connection.commit();
            return true;
        } catch (SQLException e) {
            try { connection.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
        } finally {
            try { connection.setAutoCommit(true); } catch (SQLException e) { e.printStackTrace(); }
        }
        return false;
    }

    // Helper: bỏ tất cả is_default của user
    private void unsetDefault(int userId) throws SQLException {
        String sql = "UPDATE CustomerAddresses SET is_default=0 WHERE user_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        }
    }

    // Helper: map ResultSet → CustomerAddress
    private CustomerAddress mapRow(ResultSet rs) throws SQLException {
        CustomerAddress a = new CustomerAddress();
        a.setAddressId(rs.getInt("address_id"));
        a.setUserId(rs.getInt("user_id"));
        a.setLabel(rs.getNString("label"));
        a.setReceiverName(rs.getNString("receiver_name"));
        a.setReceiverPhone(rs.getNString("receiver_phone"));
        a.setAddressDetails(rs.getNString("address_details"));
        a.setDefault(rs.getBoolean("is_default"));
        return a;
    }
}

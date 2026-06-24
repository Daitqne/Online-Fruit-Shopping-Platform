package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.PackagingOption;

public class PackagingDAO extends DBContext {

    public List<PackagingOption> getPackagingByProductId(int productId) {
        List<PackagingOption> list = new ArrayList<>();
        String sql = "SELECT packaging_id, product_id, packaging_name, price_adjustment FROM Product_Packaging WHERE product_id = ? ORDER BY price_adjustment ASC, packaging_id ASC";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, productId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    PackagingOption p = new PackagingOption();
                    p.setPackagingId(rs.getInt("packaging_id"));
                    p.setProductId(rs.getInt("product_id"));
                    p.setPackagingName(rs.getNString("packaging_name"));
                    p.setPriceAdjustment(rs.getDouble("price_adjustment"));
                    list.add(p);
                }
            }
        } catch (SQLException ex) {
            System.err.println("[PackagingDAO Error] Failed to fetch packaging options!");
            Logger.getLogger(PackagingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public boolean addPackaging(PackagingOption packaging) {
        String sql = "INSERT INTO Product_Packaging (product_id, packaging_name, price_adjustment) VALUES (?, ?, ?)";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, packaging.getProductId());
            st.setNString(2, packaging.getPackagingName());
            st.setDouble(3, packaging.getPriceAdjustment());
            return st.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.err.println("[PackagingDAO Error] Failed to add packaging option!");
            Logger.getLogger(PackagingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean deletePackaging(int packagingId) {
        String sql = "DELETE FROM Product_Packaging WHERE packaging_id = ?";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, packagingId);
            return st.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.err.println("[PackagingDAO Error] Failed to delete packaging option!");
            Logger.getLogger(PackagingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean deletePackagingByProductId(int productId) {
        String sql = "DELETE FROM Product_Packaging WHERE product_id = ?";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, productId);
            return st.executeUpdate() >= 0;
        } catch (SQLException ex) {
            System.err.println("[PackagingDAO Error] Failed to delete packaging options for product!");
            Logger.getLogger(PackagingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}

package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.WeightVariant;

public class WeightVariantDAO extends DBContext {

    public List<WeightVariant> getVariantsByProductId(int productId) {
        List<WeightVariant> list = new ArrayList<>();
        String sql = "SELECT variant_id, product_id, weight_label, price_adjustment FROM Product_Weight_Variant WHERE product_id = ? ORDER BY price_adjustment ASC, variant_id ASC";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, productId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    WeightVariant v = new WeightVariant();
                    v.setVariantId(rs.getInt("variant_id"));
                    v.setProductId(rs.getInt("product_id"));
                    v.setWeightLabel(rs.getNString("weight_label"));
                    v.setPriceAdjustment(rs.getDouble("price_adjustment"));
                    list.add(v);
                }
            }
        } catch (SQLException ex) {
            System.err.println("[WeightVariantDAO Error] Failed to fetch weight variants!");
            Logger.getLogger(WeightVariantDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public boolean addVariant(WeightVariant variant) {
        String sql = "INSERT INTO Product_Weight_Variant (product_id, weight_label, price_adjustment) VALUES (?, ?, ?)";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, variant.getProductId());
            st.setNString(2, variant.getWeightLabel());
            st.setDouble(3, variant.getPriceAdjustment());
            return st.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.err.println("[WeightVariantDAO Error] Failed to add weight variant!");
            Logger.getLogger(WeightVariantDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean deleteVariant(int variantId) {
        String sql = "DELETE FROM Product_Weight_Variant WHERE variant_id = ?";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, variantId);
            return st.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.err.println("[WeightVariantDAO Error] Failed to delete weight variant!");
            Logger.getLogger(WeightVariantDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean deleteVariantsByProductId(int productId) {
        String sql = "DELETE FROM Product_Weight_Variant WHERE product_id = ?";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, productId);
            return st.executeUpdate() >= 0;
        } catch (SQLException ex) {
            System.err.println("[WeightVariantDAO Error] Failed to delete variants for product!");
            Logger.getLogger(WeightVariantDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}

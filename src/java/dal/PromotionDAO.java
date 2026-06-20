package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Promotion;

public class PromotionDAO extends DBContext {

    /**
     * Retrieves a promotion details by its unique promotional code.
     * @param code The promo code to query.
     * @return Promotion object if found, otherwise null.
     */
    public Promotion getPromotionByCode(String code) {
        if (code == null || code.trim().isEmpty()) {
            return null;
        }
        
        String sql = "SELECT promo_id, promo_code, discount_value, discount_type, start_date, end_date, min_order_value FROM Promotions WHERE promo_code = ?";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setString(1, code.trim());
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    Promotion promo = new Promotion();
                    promo.setPromoId(rs.getInt("promo_id"));
                    promo.setPromoCode(rs.getString("promo_code"));
                    promo.setDiscountValue(rs.getDouble("discount_value"));
                    promo.setDiscountType(rs.getString("discount_type"));
                    promo.setStartDate(rs.getTimestamp("start_date"));
                    promo.setEndDate(rs.getTimestamp("end_date"));
                    promo.setMinOrderValue(rs.getDouble("min_order_value"));
                    return promo;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(PromotionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * Retrieves all promotions that are currently active (valid start and end dates).
     * @return List of active Promotion objects.
     */
    public List<Promotion> getActivePromotions() {
        List<Promotion> list = new ArrayList<>();
        String sql = "SELECT promo_id, promo_code, discount_value, discount_type, start_date, end_date, min_order_value " +
                     "FROM Promotions WHERE GETDATE() BETWEEN start_date AND end_date";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Promotion promo = new Promotion();
                    promo.setPromoId(rs.getInt("promo_id"));
                    promo.setPromoCode(rs.getString("promo_code"));
                    promo.setDiscountValue(rs.getDouble("discount_value"));
                    promo.setDiscountType(rs.getString("discount_type"));
                    promo.setStartDate(rs.getTimestamp("start_date"));
                    promo.setEndDate(rs.getTimestamp("end_date"));
                    promo.setMinOrderValue(rs.getDouble("min_order_value"));
                    list.add(promo);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(PromotionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}

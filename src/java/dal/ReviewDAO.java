package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Review;

public class ReviewDAO extends DBContext {

    public boolean addReview(Review review) {
        String sql = "INSERT INTO Reviews (user_id, product_id, rating, comment, status, created_at) VALUES (?, ?, ?, ?, ?, GETDATE())";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, review.getUserId());
            st.setInt(2, review.getProductId());
            st.setInt(3, review.getRating());
            st.setNString(4, review.getComment());
            st.setNString(5, review.getStatus() != null ? review.getStatus() : "Approved");
            return st.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.err.println("[ReviewDAO Error] Failed to add review!");
            Logger.getLogger(ReviewDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public List<Review> getReviewsByProductId(int productId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT r.review_id, r.user_id, r.product_id, r.rating, r.comment, r.status, r.created_at, ui.full_name " +
                     "FROM Reviews r " +
                     "JOIN UserInfo ui ON r.user_id = ui.user_id " +
                     "WHERE r.product_id = ? AND r.status = 'Approved' " +
                     "ORDER BY r.created_at DESC";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, productId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Review r = new Review();
                    r.setReviewId(rs.getInt("review_id"));
                    r.setUserId(rs.getInt("user_id"));
                    r.setProductId(rs.getInt("product_id"));
                    r.setRating(rs.getInt("rating"));
                    r.setComment(rs.getNString("comment"));
                    r.setStatus(rs.getNString("status"));
                    r.setCreatedAt(rs.getTimestamp("created_at"));
                    r.setUserFullName(rs.getString("full_name"));
                    list.add(r);
                }
            }
        } catch (SQLException ex) {
            System.err.println("[ReviewDAO Error] Failed to retrieve reviews by product ID!");
            Logger.getLogger(ReviewDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Review> getReviewsByUserId(int userId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT review_id, user_id, product_id, rating, comment, status, created_at FROM Reviews WHERE user_id = ? ORDER BY created_at DESC";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, userId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Review r = new Review();
                    r.setReviewId(rs.getInt("review_id"));
                    r.setUserId(rs.getInt("user_id"));
                    r.setProductId(rs.getInt("product_id"));
                    r.setRating(rs.getInt("rating"));
                    r.setComment(rs.getNString("comment"));
                    r.setStatus(rs.getNString("status"));
                    r.setCreatedAt(rs.getTimestamp("created_at"));
                    list.add(r);
                }
            }
        } catch (SQLException ex) {
            System.err.println("[ReviewDAO Error] Failed to retrieve reviews by user ID!");
            Logger.getLogger(ReviewDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public Review getReviewByUserIdAndProductId(int userId, int productId) {
        String sql = "SELECT review_id, user_id, product_id, rating, comment, status, created_at FROM Reviews WHERE user_id = ? AND product_id = ?";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, userId);
            st.setInt(2, productId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    Review r = new Review();
                    r.setReviewId(rs.getInt("review_id"));
                    r.setUserId(rs.getInt("user_id"));
                    r.setProductId(rs.getInt("product_id"));
                    r.setRating(rs.getInt("rating"));
                    r.setComment(rs.getNString("comment"));
                    r.setStatus(rs.getNString("status"));
                    r.setCreatedAt(rs.getTimestamp("created_at"));
                    return r;
                }
            }
        } catch (SQLException ex) {
            System.err.println("[ReviewDAO Error] Failed to retrieve review by user ID and product ID!");
            Logger.getLogger(ReviewDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}

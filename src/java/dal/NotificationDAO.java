package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Notification;

public class NotificationDAO extends DBContext {

    public boolean addNotification(int userId, String title, String content) {
        String sql = "INSERT INTO Notifications (user_id, title, content, is_read, created_at) VALUES (?, ?, ?, ?, GETDATE())";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, userId);
            st.setNString(2, title);
            st.setNString(3, content);
            st.setBoolean(4, false);
            return st.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.err.println("[NotificationDAO Error] Failed to add notification!");
            Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public List<Notification> getNotificationsByUserId(int userId) {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT notification_id, user_id, title, content, is_read, created_at FROM Notifications WHERE user_id = ? ORDER BY created_at DESC";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, userId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Notification n = new Notification();
                    n.setNotificationId(rs.getInt("notification_id"));
                    n.setUserId(rs.getInt("user_id"));
                    n.setTitle(rs.getNString("title"));
                    n.setContent(rs.getNString("content"));
                    n.setRead(rs.getBoolean("is_read"));
                    n.setCreatedAt(rs.getTimestamp("created_at"));
                    list.add(n);
                }
            }
        } catch (SQLException ex) {
            System.err.println("[NotificationDAO Error] Failed to fetch notifications!");
            Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public boolean markAllAsRead(int userId) {
        String sql = "UPDATE Notifications SET is_read = 1 WHERE user_id = ? AND is_read = 0";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, userId);
            return st.executeUpdate() >= 0;
        } catch (SQLException ex) {
            System.err.println("[NotificationDAO Error] Failed to mark notifications as read!");
            Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}

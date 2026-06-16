package dal;

import java.sql.*;
import dal.DBContext;

public class ResetPasswordTokenDAO extends DBContext{

    // ===============================
    // SAVE TOKEN
    // ===============================
    public void saveToken(int userId, String token, Timestamp expiry) {

        String sql = """
            INSERT INTO ResetPasswordToken
            (user_id, token, expiry_time, used)
            VALUES (?, ?, ?, 0)
        """;

        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setString(2, token);
            ps.setTimestamp(3, expiry);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ===============================
    // CHECK TOKEN VALID
    // ===============================
    public boolean isValidToken(String token) {

        String sql = """
            SELECT 1
            FROM ResetPasswordToken
            WHERE token = ?
              AND used = 0
              AND expiry_time > GETDATE()
        """;

        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();

            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ===============================
    // GET USER ID BY TOKEN
    // ===============================
    public Integer getUserIdByToken(String token) {

        String sql = """
            SELECT user_id
            FROM ResetPasswordToken
            WHERE token = ?
              AND used = 0
              AND expiry_time > GETDATE()
        """;

        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("user_id");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ===============================
    // MARK TOKEN USED
    // ===============================
    public void markTokenUsed(String token) {

        String sql = """
            UPDATE ResetPasswordToken
            SET used = 1
            WHERE token = ?
        """;

        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, token);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

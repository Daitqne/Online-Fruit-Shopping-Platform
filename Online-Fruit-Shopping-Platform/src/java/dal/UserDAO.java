/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import model.User;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

/**
 *
 * @author LAPTOP-WIN
 */
public class UserDAO extends DBContext{

    public User login(String username, String password) {
        String sql = "SELECT * FROM Users "
                + "WHERE username = ? AND password = ? AND status = 'Active'";
        try {
            
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("user_id"));   
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setStatus(rs.getString("status"));
                return u;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<User> getAll() throws Exception {
        List<User> list = new ArrayList<>();
        
        Statement st = connection.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM Users");

        while (rs.next()) {
            User u = new User();
            u.setId(rs.getInt("id"));
            u.setFullName(rs.getString("full_name"));
            u.setEmail(rs.getString("email"));
            u.setPhone(rs.getString("phone"));
            u.setRole(rs.getString("role"));
            u.setStatus(rs.getString("status"));
            list.add(u);
        }
        connection.close();
        return list;
    }

    public void insert(User u) throws Exception {
        
        PreparedStatement ps = connection.prepareStatement(
                "INSERT INTO Users(full_name,email,password,phone,role,status) VALUES(?,?,?,?,?,?)"
        );
        ps.setString(1, u.getFullName());
        ps.setString(2, u.getEmail());
        ps.setString(3, u.getPassword());
        ps.setString(4, u.getPhone());
        ps.setString(5, u.getRole());
        ps.setString(6, u.getStatus());
        ps.executeUpdate();
        connection.close();
    }

    public void delete(int id) throws Exception {
        
        PreparedStatement ps = connection.prepareStatement("DELETE FROM Users WHERE id=?");
        ps.setInt(1, id);
        ps.executeUpdate();
        connection.close();
    }

    public static void main(String[] args) {

        UserDAO dao = new UserDAO();

        // Test dữ liệu (đổi theo dữ liệu trong DB)
        String username = "admin";
        String password = "admin123";

        User user = dao.login(username, password);

        if (user != null) {
            System.out.println("Login SUCCESS");
            System.out.println("ID: " + user.getId());
            System.out.println("Full Name: " + user.getFullName());
            System.out.println("Email: " + user.getEmail());
            System.out.println("Phone: " + user.getPhone());
            System.out.println("Role: " + user.getRole());
            System.out.println("Status: " + user.getStatus());
        } else {
            System.out.println("Login FAILED");
        }
    }
}

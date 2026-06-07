package model;

public class Authen {

    // ===== Users =====
    private int id;
    private String username;
    private String password;
    private String status;

    // ===== UserInfo =====
    private String fullName;
    private String phone;
    private String email;

    // ===== Role =====
    private int roleId;
    private String role;

    // ===== getter / setter =====

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    // ⚠️ chỉ dùng nội bộ
    public String getPassword() {
        return password;
    }

    // ⚠️ chỉ dùng khi signup
    public void setPassword(String password) {
        this.password = password;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}

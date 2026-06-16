package controller;

import dal.AuthenDAO;
import model.Authen;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "EditProfileServlet", urlPatterns = {"/edit-profile"})
public class EditProfileServlet extends HttpServlet {

    private final AuthenDAO authenDAO = new AuthenDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        request.getRequestDispatcher("/edit_profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        Authen user = (Authen) session.getAttribute("user");
        
        // Nhận tham số từ form
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String avatar = request.getParameter("avatar");
        
        // Validate dữ liệu
        if (fullName == null || fullName.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            
            request.setAttribute("error", "Họ tên, số điện thoại và email không được bỏ trống!");
            request.getRequestDispatcher("/edit_profile.jsp").forward(request, response);
            return;
        }
        
        // Cập nhật các thuộc tính
        user.setFullName(fullName.trim());
        user.setPhone(phone.trim());
        user.setEmail(email.trim());
        user.setGender(gender != null ? gender.trim() : "");
        user.setDob(dob != null ? dob.trim() : "");
        user.setAddress(address != null ? address.trim() : "");
        user.setAvatar(avatar != null ? avatar.trim() : "");
        
        // Lưu vào CSDL
        boolean success = authenDAO.updateProfile(user);
        
        if (success) {
            // Cập nhật lại session
            session.setAttribute("user", user);
            response.sendRedirect(request.getContextPath() + "/profile?success=true");
        } else {
            request.setAttribute("error", "Cập nhật hồ sơ thất bại! Hãy thử lại.");
            request.getRequestDispatcher("/edit_profile.jsp").forward(request, response);
        }
    }
}

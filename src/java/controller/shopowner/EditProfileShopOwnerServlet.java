package controller.shopowner;

import dal.AuthenDAO;
import model.Authen;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "EditProfileShopOwnerServlet", urlPatterns = {"/edit-profile-shop-owner"})
public class EditProfileShopOwnerServlet extends HttpServlet {

    private final AuthenDAO authenDAO = new AuthenDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        Authen user = (Authen) session.getAttribute("user");
        if (!"Shop Owner".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }
        
        request.getRequestDispatcher("/shopowner/edit_profile_shop_owner.jsp").forward(request, response);
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
        if (!"Shop Owner".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }
        
        // Nhận tham số từ form
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String avatar = request.getParameter("avatar");
        
        // ====== VALIDATION ======
        StringBuilder errorMsg = new StringBuilder();
        
        // 1. Check trường bắt buộc
        if (fullName == null || fullName.trim().isEmpty()) {
            errorMsg.append("Họ và tên không được bỏ trống!<br>");
        }
        if (phone == null || phone.trim().isEmpty()) {
            errorMsg.append("Số điện thoại không được bỏ trống!<br>");
        }
        if (email == null || email.trim().isEmpty()) {
            errorMsg.append("Email không được bỏ trống!<br>");
        }
        
        // 2. Validate format email
        if (email != null && !email.trim().isEmpty()) {
            String emailPattern = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
            if (!email.trim().matches(emailPattern)) {
                errorMsg.append("Email không đúng định dạng!<br>");
            }
        }
        
        // 3. Validate format số điện thoại (10-11 số, bắt đầu bằng 0)
        if (phone != null && !phone.trim().isEmpty()) {
            String phonePattern = "^0[0-9]{9,10}$";
            if (!phone.trim().matches(phonePattern)) {
                errorMsg.append("Số điện thoại không hợp lệ! (Phải là 10-11 số, bắt đầu bằng 0)<br>");
            }
        }
        
        // 4. Validate độ dài họ tên
        if (fullName != null && !fullName.trim().isEmpty()) {
            if (fullName.trim().length() < 2) {
                errorMsg.append("Họ và tên phải có ít nhất 2 ký tự!<br>");
            }
            if (fullName.trim().length() > 100) {
                errorMsg.append("Họ và tên không được quá 100 ký tự!<br>");
            }
            // Validate ký tự hợp lệ
            String namePattern = "^[a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s]+$";
            if (!fullName.trim().matches(namePattern)) {
                errorMsg.append("Họ và tên chỉ được chứa chữ cái và khoảng trắng!<br>");
            }
        }
        
        // 5. Validate ngày sinh (phải >= 18 tuổi)
        if (dob != null && !dob.trim().isEmpty()) {
            try {
                java.time.LocalDate birthDate = java.time.LocalDate.parse(dob);
                java.time.LocalDate today = java.time.LocalDate.now();
                int age = java.time.Period.between(birthDate, today).getYears();
                
                if (age < 18) {
                    errorMsg.append("Bạn phải đủ 18 tuổi trở lên!<br>");
                }
                if (age > 120) {
                    errorMsg.append("Ngày sinh không hợp lệ!<br>");
                }
            } catch (Exception e) {
                errorMsg.append("Ngày sinh không đúng định dạng!<br>");
            }
        }
        
        // 6. Validate độ dài địa chỉ
        if (address != null && !address.trim().isEmpty() && address.trim().length() > 500) {
            errorMsg.append("Địa chỉ không được quá 500 ký tự!<br>");
        }
        
        // 7. Nếu có lỗi → trả về form với thông báo lỗi và giữ lại dữ liệu
        if (errorMsg.length() > 0) {
            request.setAttribute("error", errorMsg.toString());
            
            // Giữ lại dữ liệu đã nhập
            request.setAttribute("inputFullName", fullName);
            request.setAttribute("inputPhone", phone);
            request.setAttribute("inputEmail", email);
            request.setAttribute("inputGender", gender);
            request.setAttribute("inputDob", dob);
            request.setAttribute("inputAddress", address);
            request.setAttribute("inputAvatar", avatar);
            
            request.getRequestDispatcher("/shopowner/edit_profile_shop_owner.jsp").forward(request, response);
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
            response.sendRedirect(request.getContextPath() + "/shop-owner-profile?success=true");
        } else {
            request.setAttribute("error", "Cập nhật hồ sơ thất bại! Hãy thử lại.");
            request.getRequestDispatcher("/shopowner/edit_profile_shop_owner.jsp").forward(request, response);
        }
    }
}

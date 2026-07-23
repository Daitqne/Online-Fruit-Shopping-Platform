package controller.auth;

import dal.AuthenDAO;
import model.Authen;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    private final AuthenDAO authenDAO = new AuthenDAO();

  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/auth/register.jsp")
               .forward(request, response);
    }

 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String roleIdParam = request.getParameter("roleId");

       
        if (fullName == null || username == null || email == null
                || password == null || confirmPassword == null
                || roleIdParam == null
                || fullName.isBlank() || username.isBlank()
                || email.isBlank() || password.isBlank()) {

            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không trùng khớp!");
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
            return;
        }

      
        if (authenDAO.isUsernameExists(username)) {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
            return;
        }

        if (authenDAO.isEmailExists(email)) {
            request.setAttribute("error", "Email đã được sử dụng!");
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
            return;
        }

     
        Authen a = new Authen();
        a.setUsername(username);
        a.setPassword(password); 
        a.setFullName(fullName);
        a.setEmail(email);
        a.setPhone(phone);

        int roleId = 1;
        try {
            roleId = Integer.parseInt(roleIdParam);
        } catch (NumberFormatException ignored) {
        }
        if (roleId == 4) {
            a.setRoleId(4);
        } else if (roleId == 5) {
            a.setRoleId(5);
        } else {
            a.setRoleId(1);
        }

       
        boolean success = authenDAO.register(a);

        if (success) {
            request.setAttribute("success",
                    "Đăng ký thành công! Vui lòng đăng nhập.");
        } else {
            request.setAttribute("error",
                    "Có lỗi xảy ra trong quá trình đăng ký!");
        }

        request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
    }
}

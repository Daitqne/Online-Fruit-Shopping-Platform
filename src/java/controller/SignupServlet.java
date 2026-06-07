package controller;

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

    // =========================
    // OPEN REGISTER PAGE
    // =========================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/register.jsp")
               .forward(request, response);
    }

    // =========================
    // HANDLE REGISTER
    // =========================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // =========================
        // GET PARAMS
        // =========================
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // =========================
        // VALIDATE
        // =========================
        if (fullName == null || username == null || email == null
                || password == null || confirmPassword == null
                || fullName.isBlank() || username.isBlank()
                || email.isBlank() || password.isBlank()) {

            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không trùng khớp!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // =========================
        // CHECK EXISTS
        // =========================
        if (authenDAO.isUsernameExists(username)) {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (authenDAO.isEmailExists(email)) {
            request.setAttribute("error", "Email đã được sử dụng!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // =========================
        // CREATE AUTHEN OBJECT
        // =========================
        Authen a = new Authen();
        a.setUsername(username);
        a.setPassword(password); // DAO tự BCrypt
        a.setFullName(fullName);
        a.setEmail(email);
        a.setPhone(phone);

        // DEFAULT ROLE = CUSTOMER
        a.setRoleId(1);

        // =========================
        // REGISTER
        // =========================
        boolean success = authenDAO.register(a);

        if (success) {
            request.setAttribute("success",
                    "Đăng ký thành công! Vui lòng đăng nhập.");
        } else {
            request.setAttribute("error",
                    "Có lỗi xảy ra trong quá trình đăng ký!");
        }

        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }
}

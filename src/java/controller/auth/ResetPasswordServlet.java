package controller.auth;

import dal.AuthenDAO;
import dal.ResetPasswordTokenDAO;
import model.Authen;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {

    private final ResetPasswordTokenDAO tokenDAO = new ResetPasswordTokenDAO();
    private final AuthenDAO authenDAO = new AuthenDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");

        if (token == null || token.isBlank()) {
            request.setAttribute("error", "Link không hợp lệ!");
            request.getRequestDispatcher("/auth/reset-password.jsp").forward(request, response);
            return;
        }

        Integer userId = tokenDAO.getUserIdByToken(token);

        if (userId == null) {
            request.setAttribute("error", "Link đã hết hạn hoặc không hợp lệ!");
            request.getRequestDispatcher("/auth/reset-password.jsp").forward(request, response);
            return;
        }

        request.setAttribute("token", token);
        request.getRequestDispatcher("/auth/reset-password.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirmPassword");

        if (password == null || confirm == null || password.isBlank()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/auth/reset-password.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirm)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/auth/reset-password.jsp").forward(request, response);
            return;
        }

        Integer userId = tokenDAO.getUserIdByToken(token);

        if (userId == null) {
            request.setAttribute("error", "Token không hợp lệ hoặc đã hết hạn!");
            request.getRequestDispatcher("/auth/reset-password.jsp").forward(request, response);
            return;
        }

        authenDAO.updatePassword(userId, password);

        tokenDAO.markTokenUsed(token);

        request.setAttribute("success", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập.");
        request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
    }
}

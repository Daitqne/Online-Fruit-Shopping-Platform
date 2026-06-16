/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AuthenDAO;
import dal.ResetPasswordTokenDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.UUID;
import model.Authen;
import model.MailUtil;

/**
 *
 * @author Admin
 */
@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    private AuthenDAO authenDAO = new AuthenDAO();
    private ResetPasswordTokenDAO tokenDAO = new ResetPasswordTokenDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Hiển thị trang nhập email
        request.getRequestDispatcher("/forgot-password.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");

        Authen user = authenDAO.findByEmail(email);
        if (user == null) {
            req.setAttribute("error", "Email không tồn tại!");
            req.getRequestDispatcher("/forgot-password.jsp").forward(req, resp);
            return;
        }

        String token = UUID.randomUUID().toString();
        Timestamp expiry = Timestamp.valueOf(
                LocalDateTime.now().plusMinutes(15));

        tokenDAO.saveToken(user.getId(), token, expiry);

        MailUtil.sendResetPasswordMail(email, token);

        req.setAttribute("success",
                "Đã gửi link đặt lại mật khẩu, vui lòng kiểm tra email!");
        req.getRequestDispatcher("/forgot-password.jsp").forward(req, resp);
    }
}

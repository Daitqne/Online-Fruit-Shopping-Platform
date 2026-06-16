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

@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/change-password"})
public class ChangePasswordServlet extends HttpServlet {

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
        String jspPath = "Shop Owner".equals(user.getRole()) ? "/change_password_shop_owner.jsp" : "/change-password.jsp";
        request.getRequestDispatcher(jspPath).forward(request, response);
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
        String jspPath = "Shop Owner".equals(user.getRole()) ? "/change_password_shop_owner.jsp" : "/change-password.jsp";
        
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        if (oldPassword == null || oldPassword.trim().isEmpty() ||
            newPassword == null || newPassword.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher(jspPath).forward(request, response);
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher(jspPath).forward(request, response);
            return;
        }
        
        if (newPassword.equals(oldPassword)) {
            request.setAttribute("error", "Mật khẩu mới không được trùng với mật khẩu cũ!");
            request.getRequestDispatcher(jspPath).forward(request, response);
            return;
        }
        
        // Kiểm tra mật khẩu cũ
        boolean isOldPasswordCorrect = authenDAO.checkOldPassword(user.getId(), oldPassword);
        if (!isOldPasswordCorrect) {
            request.setAttribute("error", "Mật khẩu cũ không chính xác!");
            request.getRequestDispatcher(jspPath).forward(request, response);
            return;
        }
        
        // Cập nhật mật khẩu mới
        authenDAO.updatePassword(user.getId(), newPassword);
        
        if ("Shop Owner".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/shop-owner-profile?success=password");
        } else {
            response.sendRedirect(request.getContextPath() + "/profile?success=password");
        }
    }
}

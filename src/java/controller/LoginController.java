package controller;

import dal.AuthenDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Authen;

import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    private AuthenDAO authenDAO = new AuthenDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null ||
            username.trim().isEmpty() || password.trim().isEmpty()) {

            request.setAttribute("error", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        Authen user = authenDAO.login(username, password);

        if (user == null) {
            request.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession(true);
        session.setAttribute("user", user);
        session.setAttribute("role", user.getRole());

        switch (user.getRole()) {

            case "Admin":
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                break;

            case "Customer":
                response.sendRedirect(request.getContextPath() + "/home");
                break;

            case "Staff":
                response.sendRedirect(request.getContextPath() + "/home");
                break;
                
            case "Shop Owner":
                response.sendRedirect(request.getContextPath() + "/products-shop-owner");
                break;
                
            case "Delivery":
                response.sendRedirect(request.getContextPath() + "/home");
                break;

            default:
                session.invalidate();
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Role không hợp lệ");
        }
    }
}

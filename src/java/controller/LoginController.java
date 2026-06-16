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

        // 1. Validate
        if (username == null || password == null ||
            username.trim().isEmpty() || password.trim().isEmpty()) {

            request.setAttribute("error", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // 2. Login (BCrypt check nằm trong DAO)
        Authen user = authenDAO.login(username, password);

        if (user == null) {
            request.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // 3. Set session
        HttpSession session = request.getSession(true);
        session.setAttribute("user", user);
        session.setAttribute("role", user.getRole());

        // 3.5. Initialize cart and load cart count
        if ("Customer".equals(user.getRole())) {
            dal.CartDAO cartDAO = new dal.CartDAO();
            model.Cart cart = cartDAO.getCartByUserId(user.getId());
            if (cart != null) {
                session.setAttribute("cartCount", cartDAO.getCartItemsCount(cart.getCartId()));
            }
        }

        // 4. Phân quyền
        switch (user.getRole()) {

            case "Admin":
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                break;

            case "Customer":
                String redirectUrl = (String) session.getAttribute("redirectUrl");
                if (redirectUrl != null) {
                    session.removeAttribute("redirectUrl");
                    response.sendRedirect(redirectUrl);
                } else {
                    response.sendRedirect(request.getContextPath() + "/home");
                }
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

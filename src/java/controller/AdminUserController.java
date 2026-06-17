package controller;

import dal.AdminDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Authen;
import model.User;

@WebServlet(name = "AdminUserController", urlPatterns = {"/admin-user"})
public class AdminUserController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Authen user = (Authen) session.getAttribute("user");
        
        // Debug logging
        System.out.println("[AdminUserController] User: " + (user != null ? user.getUsername() : "null"));
        System.out.println("[AdminUserController] Role: " + (user != null ? user.getRole() : "null"));
        
        // Kiểm tra quyền Admin
        if (user == null || user.getRole() == null || !user.getRole().equalsIgnoreCase("Admin")) {
            System.out.println("[AdminUserController] Access denied - redirecting to login");
            response.sendRedirect("login");
            return;
        }
        
        AdminDAO adminDAO = new AdminDAO();
        String action = request.getParameter("action");
        
        // Xử lý toggle status
        if (action != null && action.equals("toggleStatus")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String currentStatus = request.getParameter("status");
            String typeParam = request.getParameter("type");
            if (typeParam == null) typeParam = "customer";
            
            String newStatus = currentStatus.equalsIgnoreCase("Active") ? "Inactive" : "Active";
            System.out.println("[AdminUserController] Toggle status for user " + id + " from " + currentStatus + " to " + newStatus);
            adminDAO.changeUserStatus(id, newStatus);
            
            response.sendRedirect("admin-user?type=" + typeParam);
            return;
        }

        String type = request.getParameter("type");
        if (type == null) {
            type = "customer";
        }
        
        System.out.println("[AdminUserController] Loading users with type: " + type);
        
        List<User> userList;
        if (type.equalsIgnoreCase("shopowner")) {
            userList = adminDAO.getUsersByRole("Shop Owner");
            request.setAttribute("pageTitle", "Quản lý Shop Owner");
        } else {
            userList = adminDAO.getUsersByRole("Customer");
            request.setAttribute("pageTitle", "Quản lý Khách hàng");
        }
        
        System.out.println("[AdminUserController] Found " + (userList != null ? userList.size() : 0) + " users");
        
        request.setAttribute("userList", userList);
        request.setAttribute("currentType", type);
        
        request.getRequestDispatcher("admin_user.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

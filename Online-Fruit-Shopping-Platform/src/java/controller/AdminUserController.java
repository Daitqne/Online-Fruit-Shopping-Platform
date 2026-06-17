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
import model.Authen; // 1. ĐỔI IMPORT: Chuyển từ model.User sang model.Authen
import model.User;   // Vẫn giữ import này nếu danh sách bên dưới dùng List<User>

@WebServlet(name = "AdminUserController", urlPatterns = {"/admin-user"})
public class AdminUserController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // 2. SỬA DÒNG 23 TẠI ĐÂY: Ép kiểu sang Authen thay vì User
        Authen user = (Authen) session.getAttribute("user"); 
        
        // 3. KIỂM TRA QUYỀN BẰNG AUTHEN
        if (user == null || user.getRole() == null || !user.getRole().equalsIgnoreCase("Admin")) {
            // Nếu không phải Admin thì đẩy về trang login hoặc home
            response.sendRedirect("login"); 
            return; 
        }
        
        // --- TOÀN BỘ PHẦN CODE ĐỔ DATA XUỐNG DƯỚI GIỮ NGUYÊN ---
        AdminDAO adminDAO = new AdminDAO();
        String action = request.getParameter("action");
        
        if (action != null && action.equals("toggleStatus")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String currentStatus = request.getParameter("status");
            String typeParam = request.getParameter("type"); 
            if (typeParam == null) typeParam = "customer";
            
            String newStatus = currentStatus.equalsIgnoreCase("Active") ? "Inactive" : "Active";
            adminDAO.changeUserStatus(id, newStatus);
            
            response.sendRedirect("admin-user?type=" + typeParam);
            return;
        }

        String type = request.getParameter("type");
        if (type == null) {
            type = "customer"; 
        }
        
        List<User> userList; // Giữ nguyên List<User> này để hứng data từ AdminDAO đổ lên bảng
        if (type.equalsIgnoreCase("shopowner")) {
            userList = adminDAO.getUsersByRole("Shop Owner"); 
            request.setAttribute("pageTitle", "Quản lý Tài khoản Shop Owners");
        } else {
            userList = adminDAO.getUsersByRole("Customer"); 
            request.setAttribute("pageTitle", "Quản lý Tài khoản Khách hàng");
        }
        
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
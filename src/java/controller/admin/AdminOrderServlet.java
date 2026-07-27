package controller.admin;

import dal.AdminOrderDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.AdminSaleOrder;
import model.Authen;
import model.UserInfo;

@WebServlet(name = "AdminOrderServlet", urlPatterns = {"/admin-orders"})
public class AdminOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin tài khoản đăng nhập từ session
        HttpSession session = request.getSession();
        Authen user = (Authen) session.getAttribute("user");

        // Kiểm tra quyền Admin
        if (user == null || user.getRole() == null || !user.getRole().equalsIgnoreCase("Admin")) {
            response.sendRedirect("login");
            return;
        }

        System.out.println("===== ADMIN ORDER SERVLET =====");
        AdminOrderDAO dao = new AdminOrderDAO();

        try {
            // 1. Luôn luôn lấy danh sách toàn bộ khách hàng để hiển thị ở menu bên trái
            String keyword = request.getParameter("keyword");
            System.out.println("Keyword = " + keyword);

            List<UserInfo> customers;

            if (keyword != null && !keyword.trim().isEmpty()) {
                customers = dao.searchCustomers(keyword.trim());
            } else {
                customers = dao.getCustomers();
            }

            request.setAttribute("customers", customers);
            request.setAttribute("keyword", keyword);

            // 2. Kiểm tra xem Admin có đang chọn xem đơn hàng của một khách cụ thể nào không
            String userIdRaw = request.getParameter("customerId");
            if (userIdRaw != null && !userIdRaw.isEmpty()) {
                try {
                    int userId = Integer.parseInt(userIdRaw);

                    // Lấy lịch sử đơn hàng của khách đó
                    List<AdminSaleOrder> orders = dao.getOrdersByCustomer(userId);
                    request.setAttribute("orders", orders);

                    // Gửi lại ID để giữ trạng thái active/highlight khách hàng đang chọn trên giao diện
                    request.setAttribute("selectedCustomerId", userId);
                } catch (Exception e) {
                    // Đổi thành Exception chung để nếu lỗi câu lệnh SQL hay Database bên trong DAO 
                    // thì nó sẽ in ra ở console chứ không làm crash sập tiến trình forward trang
                    System.err.println("Lỗi khi lấy đơn hàng của khách hàng ID " + userIdRaw + ":");
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            System.err.println("Lỗi khi tải danh sách khách hàng:");
            e.printStackTrace();
        }

        // 3. Chuyển tiếp dữ liệu sang trang JSP nằm trong thư mục admin
        // Thêm dấu '/' vào đầu đường dẫn để đảm bảo Tomcat định tuyến chuẩn xác tuyệt đối từ gốc ứng dụng
        request.getRequestDispatcher("/admin/order-tracking.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy thông tin tài khoản đăng nhập từ session
        HttpSession session = request.getSession();
        Authen user = (Authen) session.getAttribute("user");

        // Kiểm tra quyền Admin
        if (user == null || user.getRole() == null || !user.getRole().equalsIgnoreCase("Admin")) {
            response.sendRedirect("login");
            return;
        }

        // Xử lý hành động KHÓA ĐƠN khi Admin nhấn nút hủy
        String orderIdRaw = request.getParameter("orderId");
        String customerIdRaw = request.getParameter("customerId"); // Lấy ID để khi reload quay lại đúng ông khách đó

        if (orderIdRaw != null && !orderIdRaw.isEmpty()) {
            try {
                int orderId = Integer.parseInt(orderIdRaw);
                AdminOrderDAO dao = new AdminOrderDAO();

                boolean isLocked = dao.lockOrder(orderId);

                if (isLocked) {
                    request.getSession().setAttribute("msgSuccess", "Khóa và hủy đơn hàng thành công, đã hoàn số lượng vào kho!");
                } else {
                    request.getSession().setAttribute("msgError", "Không thể khóa đơn hàng này (Đơn đã giao hoặc đã hủy trước đó)!");
                }
            } catch (Exception e) {
                // Đổi thành Exception chung để bắt cả lỗi ép kiểu lẫn lỗi phát sinh khi chạy hàm lockOrder của DAO
                System.err.println("Lỗi khi thực hiện khóa đơn hàng ID " + orderIdRaw + ":");
                e.printStackTrace();
                request.getSession().setAttribute("msgError", "Đã xảy ra hệ thống lỗi khi thực hiện khóa đơn!");
            }
        }

        // Khóa xong thì chuyển hướng quay lại đúng trang của khách hàng đang xem để cập nhật trạng thái mới
        if (customerIdRaw != null && !customerIdRaw.isEmpty()) {
            response.sendRedirect("admin-orders?customerId=" + customerIdRaw);
        } else {
            response.sendRedirect("admin-orders");
        }
    }
}

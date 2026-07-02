package controller.admin;

import dal.PromotionDAO;
import model.Promotion;
import model.Authen;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AdminPromotionController", urlPatterns = {"/admin-promotions"})
public class AdminPromotionController extends HttpServlet {

    // 1. Hàm doGet: Chạy khi Admin bấm vào menu "Quản lý Voucher"
    // Nhiệm vụ: Lấy toàn bộ danh sách mã từ DB và chuyển sang trang JSP để hiển thị lên bảng
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Authen user = (Authen) session.getAttribute("user");
        
        // Kiểm tra quyền Admin
        if (user == null || user.getRole() == null || !user.getRole().equalsIgnoreCase("Admin")) {
            response.sendRedirect("login");
            return;
        }

        PromotionDAO dao = new PromotionDAO();
        List<Promotion> list = dao.getAllPromotions();
        
        // Đọc thông báo thành công nếu có
        String msg = request.getParameter("msg");
        if ("success".equals(msg)) {
            request.setAttribute("successMessage", "Thêm mã khuyến mãi mới thành công!");
        }
        
        // Đẩy danh sách list này sang file JSP với tên biến là "promotionList" để khớp với JSP
        request.setAttribute("promotionList", list);
        request.getRequestDispatcher("/admin/admin-promotions.jsp").forward(request, response);
    }

    // 2. Hàm doPost: Chạy khi Admin điền form điền thông tin và bấm nút "Tạo mã" gửi lên
    // Nhiệm vụ: Đọc dữ liệu từ form, gọi hàm insert trong DAO để lưu xuống DB
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Authen user = (Authen) session.getAttribute("user");
        
        // Kiểm tra quyền Admin
        if (user == null || user.getRole() == null || !user.getRole().equalsIgnoreCase("Admin")) {
            response.sendRedirect("login");
            return;
        }

        try {
            // Lấy dữ liệu từ các ô input của Form
            String code = request.getParameter("code");
            String type = request.getParameter("discountType");
            
            // Xử lý và làm sạch dữ liệu số
            double value = parseDiscountValue(request.getParameter("discountValue"), type);
            double minOrder = parseMinOrderValue(request.getParameter("minOrderValue"));
            
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            
            // Kiểm tra tính hợp lệ của ngày tháng
            if (startDate == null || endDate == null || startDate.isEmpty() || endDate.isEmpty()) {
                throw new IllegalArgumentException("Ngày bắt đầu và ngày kết thúc không được để trống!");
            }
            java.sql.Date start = java.sql.Date.valueOf(startDate);
            java.sql.Date end = java.sql.Date.valueOf(endDate);
            if (end.before(start)) {
                throw new IllegalArgumentException("Ngày hết hạn phải sau hoặc bằng ngày bắt đầu!");
            }

            PromotionDAO dao = new PromotionDAO();
            boolean success = dao.insertPromotion(code, value, type, startDate, endDate, minOrder);

            if (success) {
                // Nếu thêm thành công, chuyển hướng chuyển về lại trang này kèm theo tham báo msg=success
                response.sendRedirect("admin-promotions?msg=success");
            } else {
                // Nếu thất bại (trùng mã code chẳng hạn)
                request.setAttribute("error", "Mã khuyến mãi đã tồn tại hoặc lưu dữ liệu thất bại!");
                doGet(request, response); // Gọi lại doGet để vừa giữ lại thông báo lỗi, vừa tải lại bảng dữ liệu
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Vui lòng nhập đúng định dạng số cho mức giảm và đơn tối thiểu!");
            doGet(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            doGet(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            doGet(request, response);
        }
    }

    // Hàm hỗ trợ làm sạch và phân tích mức giảm giá nhập vào
    private double parseDiscountValue(String rawValue, String type) {
        if (rawValue == null || rawValue.trim().isEmpty()) {
            throw new IllegalArgumentException("Mức giảm giá không được để trống!");
        }
        
        // Loại bỏ ký tự %, đ, chữ VND và các khoảng trắng
        String cleanValue = rawValue.trim().replaceAll("(?i)[%đđ\\s]|vnd", "");
        
        if ("Percentage".equalsIgnoreCase(type)) {
            // Đối với phần trăm, đổi dấu phẩy thành dấu chấm thập phân (VD: 10,5 -> 10.5)
            cleanValue = cleanValue.replace(",", ".");
            double val = Double.parseDouble(cleanValue);
            if (val <= 0 || val > 100) {
                throw new IllegalArgumentException("Mức giảm phần trăm phải nằm trong khoảng từ 0% đến 100%!");
            }
            return val;
        } else {
            // Đối với số tiền cố định, loại bỏ tất cả dấu chấm/dấu phẩy phân tách hàng nghìn (VD: 50.000 hoặc 50,000 -> 50000)
            cleanValue = cleanValue.replace(".", "").replace(",", "");
            double val = Double.parseDouble(cleanValue);
            if (val <= 0) {
                throw new IllegalArgumentException("Số tiền giảm giá phải lớn hơn 0 đ!");
            }
            return val;
        }
    }

    // Hàm hỗ trợ làm sạch và phân tích giá trị đơn hàng tối thiểu
    private double parseMinOrderValue(String rawValue) {
        if (rawValue == null || rawValue.trim().isEmpty()) {
            return 0; // Mặc định không có đơn tối thiểu nếu trống
        }
        
        // Loại bỏ ký tự đ, chữ VND và các khoảng trắng, dấu chấm/dấu phẩy
        String cleanValue = rawValue.trim()
                .replaceAll("(?i)[đđ\\s]|vnd", "")
                .replace(".", "")
                .replace(",", "");
                
        double val = Double.parseDouble(cleanValue);
        if (val < 0) {
            throw new IllegalArgumentException("Giá trị đơn tối thiểu không được âm!");
        }
        return val;
    }
}

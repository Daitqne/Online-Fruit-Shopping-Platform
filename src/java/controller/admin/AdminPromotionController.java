package controller.admin;

import dal.PromotionDAO;
import model.Promotion;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminPromotionController", urlPatterns = {"/admin-promotions"})
public class AdminPromotionController extends HttpServlet {

    // 1. Hàm doGet: Chạy khi Admin bấm vào menu "Quản lý Voucher"
    // Nhiệm vụ: Lấy toàn bộ danh sách mã từ DB và chuyển sang trang JSP để hiển thị lên bảng
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PromotionDAO dao = new PromotionDAO();
        List<Promotion> list = dao.getAllPromotions();
        
        // Đẩy danh sách list này sang file JSP với tên biến là "promoList"
        request.setAttribute("promoList", list);
        request.getRequestDispatcher("/admin/admin-promotions.jsp").forward(request, response);
    }

    // 2. Hàm doPost: Chạy khi Admin điền form điền thông tin và bấm nút "Tạo mã" gửi lên
    // Nhiệm vụ: Đọc dữ liệu từ form, gọi hàm insert trong DAO để lưu xuống DB
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ các ô input của Form dựa theo thuộc tính name="..."
            String code = request.getParameter("promoCode");
            double value = Double.parseDouble(request.getParameter("discountValue"));
            String type = request.getParameter("discountType");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            double minOrder = Double.parseDouble(request.getParameter("minOrderValue"));

            PromotionDAO dao = new PromotionDAO();
            boolean success = dao.insertPromotion(code, value, type, startDate, endDate, minOrder);

            if (success) {
                // Nếu thêm thành công, chuyển hướng chuyển về lại trang này kèm theo tham báo msg=success
                response.sendRedirect("admin-promotions?msg=success");
            } else {
                // Nếu thất bại (trùng mã code chẳng hạn)
                request.setAttribute("error", "Mã khuyến mãi đã tồn tại hoặc dữ liệu lỗi!");
                doGet(request, response); // Gọi lại doGet để vừa giữ lại thông báo lỗi, vừa tải lại bảng dữ liệu
            }
        } catch (Exception e) {
            request.setAttribute("error", "Dữ liệu nhập vào không đúng định dạng!");
            doGet(request, response);
        }
    }
}

package controller.admin;

import dal.MembershipDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Authen;
import model.Membership;
import model.MembershipTier;

@WebServlet(name = "AdminMembershipController", urlPatterns = {"/admin-membership"})
public class AdminMembershipController extends HttpServlet {

    private MembershipDAO membershipDAO;

    @Override
    public void init() {
        membershipDAO = new MembershipDAO();
    }

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

        membershipDAO = new MembershipDAO();

        // 1. Đọc tham số Tìm kiếm & Lọc từ request
        String txtSearch = request.getParameter("searchName");
        String selectedTier = request.getParameter("tierFilter");

        // 2. Gọi hàm lấy danh sách Membership người dùng và danh sách các Hạng quy định (MembershipTier)
        List<Membership> membershipList = membershipDAO.searchAndFilterMembership(txtSearch, selectedTier);
        List<MembershipTier> tierList = membershipDAO.getAllTiers();

        // 3. Gửi các giá trị về lại trang JSP để hiển thị lên giao diện
        request.setAttribute("searchName", txtSearch);
        request.setAttribute("tierFilter", selectedTier);
        request.setAttribute("membershipList", membershipList);
        request.setAttribute("tierList", tierList);

        request.getRequestDispatcher("/admin/admin-membership.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        membershipDAO = new MembershipDAO();
        String action = request.getParameter("action");

        // Cập nhật cấu hình chung các Hạng thành viên (MembershipTier)
        if ("updateRule".equals(action)) {
            try {
                int pointConversionRate = Integer.parseInt(request.getParameter("pointConversionRate"));
                int silverMinPoint = Integer.parseInt(request.getParameter("silverMinPoint"));
                int silverDiscount = Integer.parseInt(request.getParameter("silverDiscountPercent"));
                int goldMinPoint = Integer.parseInt(request.getParameter("goldMinPoint"));
                int goldDiscount = Integer.parseInt(request.getParameter("goldDiscountPercent"));
                int diamondMinPoint = Integer.parseInt(request.getParameter("diamondMinPoint"));
                int diamondDiscount = Integer.parseInt(request.getParameter("diamondDiscountPercent"));

                boolean success = membershipDAO.updateMembershipRule(
                        pointConversionRate,
                        silverMinPoint,
                        silverDiscount,
                        goldMinPoint,
                        goldDiscount,
                        diamondMinPoint,
                        diamondDiscount
                );

                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin-membership?ruleSuccess=1");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin-membership?ruleError=1");
                }

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/admin-membership?ruleError=1");
            }

            return;
        }

        response.sendRedirect(request.getContextPath() + "/admin-membership");
    }
}

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
        // 1. Đọc tham số Tìm kiếm & Lọc từ request
        String txtSearch = request.getParameter("searchName");
        String selectedTier = request.getParameter("tierFilter");

        // 2. Gọi hàm tìm kiếm lọc tương ứng
        List<Membership> membershipList = membershipDAO.searchAndFilterMembership(txtSearch, selectedTier);

        // 3. Lấy cấu hình quy định hiện tại (Membership Rule) từ cơ sở dữ liệu
        // Các thuộc tính quy định (như mốc điểm, tỷ lệ giảm giá) được lưu đồng bộ trên các bản ghi membership.
        // Ta lấy bản ghi đầu tiên trong danh sách lọc, hoặc từ toàn bộ danh sách nếu danh sách lọc trống.
        Membership currentRule = null;
        if (membershipList != null && !membershipList.isEmpty()) {
            currentRule = membershipList.get(0);
        } else {
            List<Membership> allMembership = membershipDAO.getAllMembership();
            if (allMembership != null && !allMembership.isEmpty()) {
                currentRule = allMembership.get(0);
            }
        }

        // 4. Gửi các giá trị về lại trang JSP để hiển thị lên giao diện
        request.setAttribute("searchName", txtSearch);
        request.setAttribute("tierFilter", selectedTier);
        request.setAttribute("membershipList", membershipList);
        request.setAttribute("currentRule", currentRule); // Truyền cấu hình quy định hiện tại sang JSP

        request.getRequestDispatcher("/admin/admin-membership.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Nhận hành động từ form
        String action = request.getParameter("action");

        if ("updateMembership".equals(action)) {
            System.out.println("UPDATE RULE CLICKED");

            System.out.println(request.getParameter("pointConversionRate"));
            System.out.println(request.getParameter("silverMinPoint"));
            System.out.println(request.getParameter("silverDiscountPercent"));
            System.out.println(request.getParameter("goldMinPoint"));
            System.out.println(request.getParameter("goldDiscountPercent"));
            System.out.println(request.getParameter("diamondMinPoint"));
            System.out.println(request.getParameter("diamondDiscountPercent"));
            try {
                int userId = Integer.parseInt(request.getParameter("editUserId"));
                int currentPoints = Integer.parseInt(request.getParameter("editPoints"));
                String currentTier = request.getParameter("editTier");
                boolean manualOverride = request.getParameter("editManualOverride") != null; // checkbox checked -> true

                // Lấy đối tượng cũ từ DB lên trước
                Membership m = membershipDAO.getMembershipByUserId(userId);
                if (m != null) {
                    m.setCurrentPoints(currentPoints);

                    // Nếu chỉnh sửa thủ công bị tắt -> Tự động tính hạng theo các mốc điểm từ DB
                    if (!manualOverride) {
                        if (currentPoints >= m.getDiamondMinPoint()) {
                            currentTier = "Diamond";
                        } else if (currentPoints >= m.getGoldMinPoint()) {
                            currentTier = "Gold";
                        } else if (currentPoints >= m.getSilverMinPoint()) {
                            currentTier = "Silver";
                        } else {
                            currentTier = "Normal";
                        }
                    }

                    m.setCurrentTier(currentTier);
                    m.setManualOverride(manualOverride);

                    // Cập nhật xuống DB
                    boolean isSuccess = membershipDAO.updateMembership(m);
                    System.out.println("Update success = " + isSuccess);
                    System.out.println("User ID = " + userId);
                    System.out.println("Points = " + currentPoints);
                    System.out.println("Tier = " + currentTier);
                    System.out.println("Override = " + manualOverride);
                    if (isSuccess) {
                        response.sendRedirect(request.getContextPath()
                                + "/admin-membership?success=1");
                    } else {
                        response.sendRedirect(
                                request.getContextPath()
                                + "/admin-membership?error=1");
                    }
                } else {
                    response.sendRedirect(
                            request.getContextPath()
                            + "/admin-membership?error=2");
                }
                return;

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(
                        request.getContextPath()
                        + "/admin-membership?error=3");
                return;
            }
        }
        if ("updateRule".equals(action)) {

            try {
                int pointConversionRate = Integer.parseInt(
                        request.getParameter("pointConversionRate"));

                int silverMinPoint = Integer.parseInt(
                        request.getParameter("silverMinPoint"));

                int silverDiscount = Integer.parseInt(
                        request.getParameter("silverDiscountPercent"));

                int goldMinPoint = Integer.parseInt(
                        request.getParameter("goldMinPoint"));

                int goldDiscount = Integer.parseInt(
                        request.getParameter("goldDiscountPercent"));

                int diamondMinPoint = Integer.parseInt(
                        request.getParameter("diamondMinPoint"));

                int diamondDiscount = Integer.parseInt(
                        request.getParameter("diamondDiscountPercent"));

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
                    response.sendRedirect(
                            request.getContextPath()
                            + "/admin-membership?ruleSuccess=1");
                } else {
                    response.sendRedirect(
                            request.getContextPath()
                            + "/admin-membership?ruleError=1");
                }

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(
                        request.getContextPath()
                        + "/admin-membership?ruleError=1");
            }

            return;
        }
    }

}

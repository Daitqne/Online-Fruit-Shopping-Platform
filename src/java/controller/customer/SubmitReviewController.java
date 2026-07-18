package controller.customer;

import dal.ReviewDAO;
import model.Authen;
import model.Review;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "SubmitReviewController", urlPatterns = {"/customer/submit-review"})
public class SubmitReviewController extends HttpServlet {

    private final ReviewDAO reviewDAO = new ReviewDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Authen user = (Authen) session.getAttribute("user");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"success\":false,\"message\":\"Chưa đăng nhập\"}");
            return;
        }

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");

            if (rating < 1 || rating > 5) {
                response.getWriter().write("{\"success\":false,\"message\":\"Số sao đánh giá phải từ 1 đến 5\"}");
                return;
            }

            // Check if already reviewed
            Review existing = reviewDAO.getReviewByUserIdAndProductId(user.getId(), productId);
            if (existing != null) {
                response.getWriter().write("{\"success\":false,\"message\":\"Bạn đã đánh giá sản phẩm này rồi!\"}");
                return;
            }

            Review review = new Review();
            review.setUserId(user.getId());
            review.setProductId(productId);
            review.setRating(rating);
            review.setComment(comment != null ? comment.trim() : "");
            review.setStatus("Approved"); // Auto approved for convenience, or "Pending" if admin moderation is needed

            boolean success = reviewDAO.addReview(review);
            if (success) {
                response.getWriter().write("{\"success\":true,\"message\":\"Đánh giá của bạn đã được gửi thành công!\"}");
            } else {
                response.getWriter().write("{\"success\":false,\"message\":\"Không thể lưu đánh giá vào cơ sở dữ liệu\"}");
            }

        } catch (NumberFormatException e) {
            response.getWriter().write("{\"success\":false,\"message\":\"Tham số không hợp lệ\"}");
        }
    }
}

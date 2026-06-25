package controller.admin;

import dal.AdminDAO;
import dal.NotificationDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Authen;
import model.Product;

@WebServlet(name = "AdminProductController", urlPatterns = {"/admin-products"})
public class AdminProductController extends HttpServlet {

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
        
        AdminDAO adminDAO = new AdminDAO();
        String action = request.getParameter("action");
        
        // Xử lý toggle product status (Available <-> Unavailable)
        if (action != null && action.equals("toggleStatus")) {
            int productId = Integer.parseInt(request.getParameter("id"));
            String currentStatus = request.getParameter("status");
            String newStatus = currentStatus.equalsIgnoreCase("Available") || currentStatus.equalsIgnoreCase("Approved") 
                               ? "Unavailable" : "Available";
            adminDAO.changeProductStatus(productId, newStatus);
            response.sendRedirect("admin-products");
            return;
        }
        
        // Xử lý duyệt sản phẩm (Pending -> Approved)
        if (action != null && action.equals("approve")) {
            int productId = Integer.parseInt(request.getParameter("id"));
            // Lấy thông tin sản phẩm để biết shopOwnerId
            List<Product> allProducts = adminDAO.getAllProducts();
            int shopOwnerId = allProducts.stream()
                .filter(p -> p.getId() == productId)
                .mapToInt(p -> p.getShopOwnerId())
                .findFirst().orElse(0);
            
            adminDAO.changeProductStatus(productId, "Approved");
            
            // Gửi thông báo đến Shop Owner
            if (shopOwnerId > 0) {
                NotificationDAO notiDAO = new NotificationDAO();
                notiDAO.addNotification(shopOwnerId,
                    "Sản phẩm được duyệt",
                    "Sản phẩm #" + productId + " của bạn đã được Admin PHÊ DUYỆT và hiện có thể hiển thị cho khách hàng."
                );
            }
            response.sendRedirect("admin-products?approved=true");
            return;
        }
        
        // Xử lý từ chối sản phẩm (Pending -> Rejected)
        if (action != null && action.equals("reject")) {
            int productId = Integer.parseInt(request.getParameter("id"));
            String reason = request.getParameter("reason");
            if (reason == null || reason.trim().isEmpty()) {
                reason = "Sản phẩm không đáp ứng tiêu chuẩn.";
            }
            // Lấy shopOwnerId
            List<Product> allProducts = adminDAO.getAllProducts();
            int shopOwnerId = allProducts.stream()
                .filter(p -> p.getId() == productId)
                .mapToInt(p -> p.getShopOwnerId())
                .findFirst().orElse(0);
            
            adminDAO.changeProductStatus(productId, "Rejected");
            
            // Gửi thông báo đến Shop Owner
            if (shopOwnerId > 0) {
                NotificationDAO notiDAO = new NotificationDAO();
                notiDAO.addNotification(shopOwnerId,
                    "Sản phẩm bị từ chối",
                    "Sản phẩm #" + productId + " của bạn đã bị Admin TỪ CHỐI. Lý do: " + reason.trim() + ". Vui lòng chỉnh sửa và gửi lại."
                );
            }
            response.sendRedirect("admin-products?rejected=true");
            return;
        }

        // Lấy danh sách tất cả sản phẩm
        List<Product> productList = adminDAO.getAllProducts();
        
        request.setAttribute("productList", productList);
        request.setAttribute("pageTitle", "Quản lý Sản phẩm");
        
        request.getRequestDispatcher("/admin/admin_products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

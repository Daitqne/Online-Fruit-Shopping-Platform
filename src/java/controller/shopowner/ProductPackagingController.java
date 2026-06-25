package controller.shopowner;

import dal.ProductDAO;
import dal.PackagingDAO;
import model.Product;
import model.PackagingOption;
import model.Authen;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ProductPackagingController", urlPatterns = {"/product-packaging"})
public class ProductPackagingController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        Authen user = (Authen) session.getAttribute("user");
        if (!"Shop Owner".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập!");
            return;
        }

        String productIdStr = request.getParameter("productId");
        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            response.sendRedirect("products-shop-owner");
            return;
        }

        int productId = Integer.parseInt(productIdStr);
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productId);

        if (product == null || product.getShopOwnerId() != user.getId()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Sản phẩm không tồn tại hoặc không thuộc quyền quản lý của bạn!");
            return;
        }

        PackagingDAO packagingDAO = new PackagingDAO();
        List<PackagingOption> packagings = packagingDAO.getPackagingByProductId(productId);

        request.setAttribute("product", product);
        request.setAttribute("packagings", packagings);
        request.getRequestDispatcher("/shopowner/product_packaging.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        Authen user = (Authen) session.getAttribute("user");
        if (!"Shop Owner".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền thực hiện hành động này!");
            return;
        }

        String productIdStr = request.getParameter("productId");
        String action = request.getParameter("action");
        if (productIdStr == null || action == null) {
            response.sendRedirect("products-shop-owner");
            return;
        }

        int productId = Integer.parseInt(productIdStr);
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productId);

        if (product == null || product.getShopOwnerId() != user.getId()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Sản phẩm không hợp lệ!");
            return;
        }

        PackagingDAO packagingDAO = new PackagingDAO();

        if ("add".equals(action)) {
            String name = request.getParameter("packagingName");
            String adjStr = request.getParameter("priceAdjustment");
            if (name != null && !name.trim().isEmpty() && adjStr != null) {
                double adj = Double.parseDouble(adjStr);
                PackagingOption option = new PackagingOption();
                option.setProductId(productId);
                option.setPackagingName(name.trim());
                option.setPriceAdjustment(adj);
                packagingDAO.addPackaging(option);
            }
        } else if ("delete".equals(action)) {
            String packagingIdStr = request.getParameter("packagingId");
            if (packagingIdStr != null) {
                int packagingId = Integer.parseInt(packagingIdStr);
                packagingDAO.deletePackaging(packagingId);
            }
        }

        response.sendRedirect("product-packaging?productId=" + productId);
    }
}

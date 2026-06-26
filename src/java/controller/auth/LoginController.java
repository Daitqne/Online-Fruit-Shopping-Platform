package controller.auth;

import dal.AuthenDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Authen;

import java.io.IOException;
import java.util.List;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    private AuthenDAO authenDAO = new AuthenDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null ||
            username.trim().isEmpty() || password.trim().isEmpty()) {

            request.setAttribute("error", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!");
            request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
            return;
        }

        Authen user = authenDAO.login(username, password);

        if (user == null) {
            request.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
            request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession(true);
        session.setAttribute("user", user);
        session.setAttribute("role", user.getRole());

        // 3.5. Initialize cart and load cart count
        if ("Customer".equals(user.getRole())) {
            dal.CartDAO cartDAO = new dal.CartDAO();
            dal.ProductDAO productDAO = new dal.ProductDAO();
            model.Cart cart = cartDAO.getCartByUserId(user.getId());
            if (cart != null) {
                List<model.CartItem> guestCart = (List<model.CartItem>) session.getAttribute("guestCart");
                if (guestCart != null && !guestCart.isEmpty()) {
                    List<model.CartItem> dbItems = cartDAO.getCartItems(cart.getCartId());
                    boolean wasCapped = false;
                    
                    for (model.CartItem guestItem : guestCart) {
                        int productId = guestItem.getProductId();
                        int guestQty = guestItem.getQuantity();
                        int dbQty = 0;
                        for (model.CartItem dbItem : dbItems) {
                            if (dbItem.getProductId() == productId) {
                                dbQty = dbItem.getQuantity();
                                break;
                            }
                        }
                        
                        int availableStock = productDAO.getProductStock(productId);
                        int finalQty = dbQty + guestQty;
                        if (finalQty > availableStock) {
                            finalQty = availableStock;
                            wasCapped = true;
                        }
                        
                        int qtyToAdd = finalQty - dbQty;
                        if (qtyToAdd > 0) {
                            cartDAO.addOrUpdateCartItem(cart.getCartId(), productId, qtyToAdd);
                        }
                    }
                    
                    session.removeAttribute("guestCart");
                    
                    if (wasCapped) {
                        session.setAttribute("cartSuccess", "Đã gộp giỏ hàng tạm thời của bạn thành công. Một số sản phẩm được điều chỉnh theo số lượng tồn kho thực tế.");
                    } else {
                        session.setAttribute("cartSuccess", "Đã gộp giỏ hàng tạm thời của bạn thành công!");
                    }
                }
                session.setAttribute("cartCount", cartDAO.getCartItemsCount(cart.getCartId()));
            }
        }


        // 4. Phân quyền
        switch (user.getRole()) {

            case "Admin":
                response.sendRedirect(request.getContextPath() + "/admin-user");
                break;

            case "Customer":
                String redirectUrl = (String) session.getAttribute("redirectUrl");
                if (redirectUrl != null) {
                    session.removeAttribute("redirectUrl");
                    response.sendRedirect(redirectUrl);
                } else {
                    response.sendRedirect(request.getContextPath() + "/home");
                }
                break;

            case "Staff":
                response.sendRedirect(request.getContextPath() + "/home");
                break;
                
            case "Shop Owner":
                response.sendRedirect(request.getContextPath() + "/products-shop-owner");
                break;
                
            case "Delivery":
                response.sendRedirect(request.getContextPath() + "/delivery");
                break;

            default:
                session.invalidate();
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Role không hợp lệ");
        }
    }
}

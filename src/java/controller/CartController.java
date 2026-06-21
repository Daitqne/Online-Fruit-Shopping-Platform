package controller;

import dal.CartDAO;
import dal.PromotionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import model.Authen;
import model.Cart;
import model.CartItem;
import model.Promotion;

@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();
    private final PromotionDAO promotionDAO = new PromotionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Authen user = (Authen) session.getAttribute("user");
        
        // 1. Check login
        if (user == null) {
            session.setAttribute("redirectUrl", request.getRequestURI() + (request.getQueryString() != null ? "?" + request.getQueryString() : ""));
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }

        Cart cart = cartDAO.getCartByUserId(user.getId());
        if (cart == null) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể khởi tạo giỏ hàng.");
            return;
        }

        switch (action) {
            case "add":
                handleAdd(request, response, session, cart);
                break;
            case "update":
                handleUpdate(request, response, session, cart);
                break;
            case "delete":
                handleDelete(request, response, session, cart);
                break;
            case "applyPromo":
                handleApplyPromo(request, response, session, cart);
                break;
            case "removePromo":
                handleRemovePromo(request, response, session);
                break;
            case "view":
            default:
                handleView(request, response, cart);
                break;
        }
    }

    private void handleView(HttpServletRequest request, HttpServletResponse response, Cart cart)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cartItems = cartDAO.getCartItems(cart.getCartId());
        double totalAmount = 0;
        for (CartItem item : cartItems) {
            totalAmount += item.getQuantity() * item.getProduct().getPrice();
        }
        
        // Calculate shipping fee:
        // Free shipping if totalAmount >= 150000. If cart is empty (totalAmount == 0), shipping fee is 0.
        // Otherwise, shipping fee is 30000.
        double shippingFee = 0;
        if (totalAmount > 0) {
            shippingFee = (totalAmount >= 150000) ? 0 : 30000;
        }
        
        // Re-validate and calculate discount if a promotion is applied
        double discount = 0;
        Promotion appliedPromo = (Promotion) session.getAttribute("appliedPromo");
        if (appliedPromo != null) {
            Timestamp now = new Timestamp(System.currentTimeMillis());
            boolean isValid = true;
            String invalidReason = "";
            
            // Check dates
            if (now.before(appliedPromo.getStartDate()) || now.after(appliedPromo.getEndDate())) {
                isValid = false;
                invalidReason = "Mã giảm giá đã hết hạn hoặc chưa có hiệu lực.";
            }
            // Check minimum order value
            else if (totalAmount < appliedPromo.getMinOrderValue()) {
                isValid = false;
                invalidReason = "Đơn hàng tối thiểu để sử dụng mã " + appliedPromo.getPromoCode() + " là " 
                        + String.format("%,.0fđ", appliedPromo.getMinOrderValue()) + ".";
            }
            
            if (isValid) {
                if ("Percentage".equalsIgnoreCase(appliedPromo.getDiscountType())) {
                    discount = totalAmount * (appliedPromo.getDiscountValue() / 100.0);
                } else if ("Fixed".equalsIgnoreCase(appliedPromo.getDiscountType())) {
                    discount = appliedPromo.getDiscountValue();
                }
                // Discount cannot exceed the subtotal
                if (discount > totalAmount) {
                    discount = totalAmount;
                }
            } else {
                // Invalidate promotion from session
                session.removeAttribute("appliedPromo");
                session.setAttribute("promoError", "Mã giảm giá đã tự động gỡ bỏ: " + invalidReason);
                appliedPromo = null;
            }
        }
        
        // Calculate total payment
        double totalPayment = totalAmount + shippingFee - discount;
        if (totalPayment < 0) {
            totalPayment = 0;
        }
        
        // Pass validation messages to request and clear them from session (flash behavior)
        String promoError = (String) session.getAttribute("promoError");
        String promoSuccess = (String) session.getAttribute("promoSuccess");
        session.removeAttribute("promoError");
        session.removeAttribute("promoSuccess");
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("shippingFee", shippingFee);
        request.setAttribute("discount", discount);
        request.setAttribute("appliedPromo", appliedPromo);
        request.setAttribute("totalPayment", totalPayment);
        request.setAttribute("promoError", promoError);
        request.setAttribute("promoSuccess", promoSuccess);
        
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response, HttpSession session, Cart cart)
            throws IOException {
        boolean success = false;
        int totalCount = 0;
        String message = "";
        
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            String qtyStr = request.getParameter("quantity");
            int quantity = (qtyStr == null || qtyStr.trim().isEmpty()) ? 1 : Integer.parseInt(qtyStr);
            
            if (quantity > 0) {
                cartDAO.addOrUpdateCartItem(cart.getCartId(), productId, quantity);
                success = true;
                message = "Đã thêm sản phẩm vào giỏ hàng";
            }
            
            // Update cart items count in session
            totalCount = cartDAO.getCartItemsCount(cart.getCartId());
            session.setAttribute("cartCount", totalCount);
            
        } catch (NumberFormatException e) {
            message = "Thông tin sản phẩm không hợp lệ";
        }
        
        // Check if request is AJAX
        String requestedWith = request.getHeader("X-Requested-With");
        if ("XMLHttpRequest".equalsIgnoreCase(requestedWith)) {
            // Return JSON response for AJAX
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(
                "{\"success\":" + success + 
                ",\"cartCount\":" + totalCount + 
                ",\"message\":\"" + message + "\"}"
            );
        } else {
            // Normal redirect for non-AJAX requests
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session, Cart cart)
            throws IOException {
        try {
            int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            cartDAO.updateCartItemQuantity(cartItemId, quantity);
            
            // Update cart items count in session
            int totalCount = cartDAO.getCartItemsCount(cart.getCartId());
            session.setAttribute("cartCount", totalCount);
            
        } catch (NumberFormatException e) {
            // Log and ignore
        }
        response.sendRedirect(request.getContextPath() + "/cart");
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response, HttpSession session, Cart cart)
            throws IOException {
        try {
            int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
            
            cartDAO.deleteCartItem(cartItemId);
            
            // Update cart items count in session
            int totalCount = cartDAO.getCartItemsCount(cart.getCartId());
            session.setAttribute("cartCount", totalCount);
            
        } catch (NumberFormatException e) {
            // Log and ignore
        }
        response.sendRedirect(request.getContextPath() + "/cart");
    }

    private void handleApplyPromo(HttpServletRequest request, HttpServletResponse response, HttpSession session, Cart cart)
            throws IOException {
        String promoCode = request.getParameter("promoCode");
        if (promoCode == null || promoCode.trim().isEmpty()) {
            session.setAttribute("promoError", "Vui lòng nhập mã giảm giá.");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        Promotion promo = promotionDAO.getPromotionByCode(promoCode.trim());
        if (promo == null) {
            session.setAttribute("promoError", "Mã giảm giá không tồn tại.");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        // Calculate subtotal
        List<CartItem> cartItems = cartDAO.getCartItems(cart.getCartId());
        double totalAmount = 0;
        for (CartItem item : cartItems) {
            totalAmount += item.getQuantity() * item.getProduct().getPrice();
        }
        
        Timestamp now = new Timestamp(System.currentTimeMillis());
        if (now.before(promo.getStartDate()) || now.after(promo.getEndDate())) {
            session.setAttribute("promoError", "Mã giảm giá đã hết hạn hoặc chưa có hiệu lực.");
        } else if (totalAmount < promo.getMinOrderValue()) {
            session.setAttribute("promoError", "Giá trị đơn hàng chưa đạt mức tối thiểu " 
                    + String.format("%,.0fđ", promo.getMinOrderValue()) + " để áp dụng mã.");
        } else {
            session.setAttribute("appliedPromo", promo);
            session.setAttribute("promoSuccess", "Áp dụng mã giảm giá thành công!");
        }
        
        response.sendRedirect(request.getContextPath() + "/cart");
    }

    private void handleRemovePromo(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {
        session.removeAttribute("appliedPromo");
        session.setAttribute("promoSuccess", "Đã gỡ mã giảm giá.");
        response.sendRedirect(request.getContextPath() + "/cart");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

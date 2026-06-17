package controller;

import dal.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Authen;
import model.Cart;
import model.CartItem;

@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();

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
            case "view":
            default:
                handleView(request, response, cart);
                break;
        }
    }

    private void handleView(HttpServletRequest request, HttpServletResponse response, Cart cart)
            throws ServletException, IOException {
        List<CartItem> cartItems = cartDAO.getCartItems(cart.getCartId());
        double totalAmount = 0;
        for (CartItem item : cartItems) {
            totalAmount += item.getQuantity() * item.getProduct().getPrice();
        }
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalAmount", totalAmount);
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

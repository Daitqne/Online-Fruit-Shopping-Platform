package controller.customer;

import dal.AddressDAO;
import dal.CartDAO;
import dal.OrderDAO;
import dal.PromotionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Map;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Collections;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.ArrayList;
import java.util.List;
import model.Authen;
import model.Cart;
import model.CartItem;
import model.CustomerAddress;
import model.Promotion;
import model.SaleOrder;
import model.SaleOrderItem;
import utils.VNPayConfig;

@WebServlet(name = "CheckoutController", urlPatterns = {"/checkout"})
public class CheckoutController extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();
    private final AddressDAO addressDAO = new AddressDAO();
    private final PromotionDAO promotionDAO = new PromotionDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Authen user = (Authen) session.getAttribute("user");
        
        if (user == null) {
            session.setAttribute("redirectUrl", request.getRequestURI() + (request.getQueryString() != null ? "?" + request.getQueryString() : ""));
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if ("applyPromo".equals(action)) {
            handleApplyPromo(request, response, session, user);
            return;
        } else if ("removePromo".equals(action)) {
            handleRemovePromo(request, response, session);
            return;
        }

        if ("success".equals(action)) {
            String orderIdStr = request.getParameter("orderId");
            if (orderIdStr != null && !orderIdStr.trim().isEmpty()) {
                try {
                    int orderId = Integer.parseInt(orderIdStr);
                    SaleOrder order = orderDAO.getOrderById(orderId);
                    request.setAttribute("order", order);
                } catch (Exception e) {
                    // Ignore
                }
            }
            request.setAttribute("orderId", orderIdStr);
            request.getRequestDispatcher("/customer/checkout-success.jsp").forward(request, response);
            return;
        }

        Cart cart = cartDAO.getCartByUserId(user.getId());
        if (cart == null) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể tải giỏ hàng.");
            return;
        }

        List<CartItem> cartItems = cartDAO.getCartItems(cart.getCartId());
        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Validate stock before checkout
        dal.ProductDAO productDAO = new dal.ProductDAO();
        for (CartItem item : cartItems) {
            int availableStock = productDAO.getProductStock(item.getProductId());
            if (item.getQuantity() > availableStock) {
                session.setAttribute("cartError", "Sản phẩm \"" + item.getProduct().getName() + "\" vượt quá số lượng tồn kho (Còn lại: " + availableStock + "). Vui lòng cập nhật lại giỏ hàng.");
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
        }

        // Calculate totals
        double totalAmount = 0;
        for (CartItem item : cartItems) {
            totalAmount += item.getQuantity() * item.getProduct().getEffectivePrice();
        }

        double shippingFee = (totalAmount >= 150000) ? 0 : 30000;

        // Validate applied promo if any
        double discount = 0;
        Promotion appliedPromo = (Promotion) session.getAttribute("appliedPromo");
        if (appliedPromo != null) {
            Timestamp now = new Timestamp(System.currentTimeMillis());
            boolean isValid = true;
            String invalidReason = "";

            if (now.before(appliedPromo.getStartDate()) || now.after(appliedPromo.getEndDate())) {
                isValid = false;
                invalidReason = "Mã giảm giá đã hết hạn hoặc chưa có hiệu lực.";
            } else if (totalAmount < appliedPromo.getMinOrderValue()) {
                isValid = false;
                invalidReason = "Giá trị đơn hàng tối thiểu chưa đạt " 
                        + String.format("%,.0fđ", appliedPromo.getMinOrderValue()) + ".";
            }

            if (isValid) {
                if ("Percentage".equalsIgnoreCase(appliedPromo.getDiscountType())) {
                    discount = totalAmount * (appliedPromo.getDiscountValue() / 100.0);
                } else if ("Fixed".equalsIgnoreCase(appliedPromo.getDiscountType())) {
                    discount = appliedPromo.getDiscountValue();
                }
                if (discount > totalAmount) {
                    discount = totalAmount;
                }
            } else {
                session.removeAttribute("appliedPromo");
                session.setAttribute("promoError", "Mã giảm giá đã tự động gỡ bỏ: " + invalidReason);
                appliedPromo = null;
            }
        }

        double totalPayment = totalAmount + shippingFee - discount;
        if (totalPayment < 0) {
            totalPayment = 0;
        }

        // Load Customer Addresses
        List<CustomerAddress> addresses = addressDAO.getByUserId(user.getId());

        // Load Active Promotions
        List<Promotion> activePromotions = promotionDAO.getActivePromotions();

        // Flush validation messages from session to request attributes
        String promoError = (String) session.getAttribute("promoError");
        String promoSuccess = (String) session.getAttribute("promoSuccess");
        String checkoutError = (String) session.getAttribute("checkoutError");
        session.removeAttribute("promoError");
        session.removeAttribute("promoSuccess");
        session.removeAttribute("checkoutError");

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("shippingFee", shippingFee);
        request.setAttribute("discount", discount);
        request.setAttribute("totalPayment", totalPayment);
        request.setAttribute("appliedPromo", appliedPromo);
        request.setAttribute("addresses", addresses);
        request.setAttribute("activePromotions", activePromotions);
        request.setAttribute("promoError", promoError);
        request.setAttribute("promoSuccess", promoSuccess);
        request.setAttribute("checkoutError", checkoutError);

        request.getRequestDispatcher("/customer/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Authen user = (Authen) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if ("applyPromo".equals(action)) {
            handleApplyPromo(request, response, session, user);
        } else if ("removePromo".equals(action)) {
            handleRemovePromo(request, response, session);
        } else {
            handlePlaceOrder(request, response, session, user);
        }
    }

    private void handleApplyPromo(HttpServletRequest request, HttpServletResponse response, HttpSession session, Authen user)
            throws IOException {
        String promoCode = request.getParameter("promoCode");
        if (promoCode == null || promoCode.trim().isEmpty()) {
            session.setAttribute("promoError", "Vui lòng nhập mã giảm giá.");
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }

        Promotion promo = promotionDAO.getPromotionByCode(promoCode.trim());
        if (promo == null) {
            session.setAttribute("promoError", "Mã giảm giá không tồn tại.");
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }

        Cart cart = cartDAO.getCartByUserId(user.getId());
        List<CartItem> cartItems = cartDAO.getCartItems(cart.getCartId());
        double totalAmount = 0;
        for (CartItem item : cartItems) {
            totalAmount += item.getQuantity() * item.getProduct().getEffectivePrice();
        }

        Timestamp now = new Timestamp(System.currentTimeMillis());
        if (now.before(promo.getStartDate()) || now.after(promo.getEndDate())) {
            session.setAttribute("promoError", "Mã giảm giá đã hết hạn hoặc chưa có hiệu lực.");
        } else if (totalAmount < promo.getMinOrderValue()) {
            session.setAttribute("promoError", "Giá trị đơn hàng chưa đạt mức tối thiểu " 
                    + String.format("%,.0fđ", promo.getMinOrderValue()) + " để áp dụng.");
        } else {
            session.setAttribute("appliedPromo", promo);
            session.setAttribute("promoSuccess", "Áp dụng mã giảm giá thành công!");
        }

        response.sendRedirect(request.getContextPath() + "/checkout");
    }

    private void handleRemovePromo(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {
        session.removeAttribute("appliedPromo");
        session.setAttribute("promoSuccess", "Đã gỡ mã giảm giá.");
        response.sendRedirect(request.getContextPath() + "/checkout");
    }

    private void handlePlaceOrder(HttpServletRequest request, HttpServletResponse response, HttpSession session, Authen user)
            throws IOException {
        
        String addressIdStr = request.getParameter("addressId");
        String paymentMethod = request.getParameter("paymentMethod");
        String shipperNote = request.getParameter("shipperNote");

        if (addressIdStr == null || addressIdStr.trim().isEmpty()) {
            session.setAttribute("checkoutError", "Vui lòng chọn địa chỉ giao hàng.");
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }

        int addressId;
        try {
            addressId = Integer.parseInt(addressIdStr);
        } catch (NumberFormatException e) {
            session.setAttribute("checkoutError", "Địa chỉ giao hàng không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }

        CustomerAddress address = addressDAO.getById(addressId);
        if (address == null || address.getUserId() != user.getId()) {
            session.setAttribute("checkoutError", "Địa chỉ giao hàng không hợp lệ hoặc không thuộc về bạn.");
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }

        Cart cart = cartDAO.getCartByUserId(user.getId());
        List<CartItem> cartItems = cartDAO.getCartItems(cart.getCartId());
        if (cartItems == null || cartItems.isEmpty()) {
            session.setAttribute("checkoutError", "Giỏ hàng của bạn đang trống.");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Validate stock before placing order
        dal.ProductDAO productDAO = new dal.ProductDAO();
        for (CartItem item : cartItems) {
            int availableStock = productDAO.getProductStock(item.getProductId());
            if (item.getQuantity() > availableStock) {
                session.setAttribute("cartError", "Sản phẩm \"" + item.getProduct().getName() + "\" vượt quá số lượng tồn kho (Còn lại: " + availableStock + "). Vui lòng cập nhật lại giỏ hàng trước khi đặt hàng.");
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
        }


        // Calculate pricing
        double totalAmount = 0;
        for (CartItem item : cartItems) {
            totalAmount += item.getQuantity() * item.getProduct().getEffectivePrice();
        }

        double shippingFee = (totalAmount >= 150000) ? 0 : 30000;

        double discount = 0;
        Promotion appliedPromo = (Promotion) session.getAttribute("appliedPromo");
        if (appliedPromo != null) {
            if ("Percentage".equalsIgnoreCase(appliedPromo.getDiscountType())) {
                discount = totalAmount * (appliedPromo.getDiscountValue() / 100.0);
            } else if ("Fixed".equalsIgnoreCase(appliedPromo.getDiscountType())) {
                discount = appliedPromo.getDiscountValue();
            }
            if (discount > totalAmount) {
                discount = totalAmount;
            }
        }

        double totalPayment = totalAmount + shippingFee - discount;
        if (totalPayment < 0) {
            totalPayment = 0;
        }

        // Build SaleOrder object
        SaleOrder order = new SaleOrder();
        order.setCreatedBy(user.getId());
        order.setOrderDate(new Timestamp(System.currentTimeMillis()));
        order.setOrderStatus("Pending");
        order.setPaymentMethod(paymentMethod != null ? paymentMethod : "COD");
        order.setPaymentStatus("Pending");
        
        // Save the detailed address string
        String fullAddress = address.getLabel() + ": " + address.getReceiverName() + " (" + address.getReceiverPhone() + ") - " + address.getAddressDetails();
        order.setShippingAddress(fullAddress);
        order.setShippingPhone(address.getReceiverPhone());
        order.setShipperNote(shipperNote);
        
        order.setDiscountAmount(discount);
        order.setPromoCode(appliedPromo != null ? appliedPromo.getPromoCode() : null);
        order.setShippingFee(shippingFee);
        order.setTotalPayment(totalPayment);

        // Map items
        List<SaleOrderItem> orderItems = new ArrayList<>();
        for (CartItem ci : cartItems) {
            SaleOrderItem soi = new SaleOrderItem();
            soi.setProductId(ci.getProductId());
            soi.setQuantity(ci.getQuantity());
            soi.setUnitPrice(ci.getProduct().getEffectivePrice());
            orderItems.add(soi);
        }
        order.setItems(orderItems);

        // Save order to Database via OrderDAO transaction
        boolean success = orderDAO.insertOrder(order);
        if (success) {
            // Empty the cart
            cartDAO.clearCart(cart.getCartId());
            session.setAttribute("cartCount", 0);
            session.removeAttribute("appliedPromo");
            //notify customer
            dal.NotificationDAO notifDAO = new dal.NotificationDAO();
            notifDAO.addNotification(user.getId(),
                "Đặt hàng thành công",
                "Đơn hàng #" + order.getSaleOrderId() + " đã được đặt thành công! Tổng thanh toán: " 
                + String.format("%,.0fđ", order.getTotalPayment()) + ". Cảm ơn bạn đã mua hàng tại GreenStock!");
            
            if ("VNPAY".equals(paymentMethod)) {
                try {
                    // Generate VNPay URL
                    String vnp_Version = "2.1.0";
                    String vnp_Command = "pay";
                    String orderType = "190000"; // Grocery / Food
                    long amount = Math.round(order.getTotalPayment() * 100);
                    
                    String vnp_TxnRef = String.valueOf(order.getSaleOrderId());
                    String vnp_IpAddr = VNPayConfig.getIpAddress(request);
                    String vnp_TmnCode = VNPayConfig.vnp_TmnCode;
                    
                    Map<String, String> vnp_Params = new HashMap<>();
                    vnp_Params.put("vnp_Version", vnp_Version);
                    vnp_Params.put("vnp_Command", vnp_Command);
                    vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
                    vnp_Params.put("vnp_Amount", String.valueOf(amount));
                    vnp_Params.put("vnp_CurrCode", "VND");
                    vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
                    vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang #" + order.getSaleOrderId());
                    vnp_Params.put("vnp_OrderType", orderType);
                    vnp_Params.put("vnp_Locale", "vn");
                    
                    // Dynamically build return URL
                    String baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
                    vnp_Params.put("vnp_ReturnUrl", baseUrl + "/vnpay-return");
                    vnp_Params.put("vnp_IpAddr", vnp_IpAddr);
                    
                    SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
                    String vnp_CreateDate = formatter.format(new Date());
                    vnp_Params.put("vnp_CreateDate", vnp_CreateDate);
                    
                    List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
                    Collections.sort(fieldNames);
                    StringBuilder hashData = new StringBuilder();
                    StringBuilder query = new StringBuilder();
                    Iterator<String> itr = fieldNames.iterator();
                    while (itr.hasNext()) {
                        String fieldName = itr.next();
                        String fieldValue = vnp_Params.get(fieldName);
                        if ((fieldValue != null) && (fieldValue.length() > 0)) {
                            // Build hash data
                            hashData.append(fieldName);
                            hashData.append('=');
                            hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()).replaceAll("\\+", "%20"));
                            
                            // Build query
                            query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()).replaceAll("\\+", "%20"));
                            query.append('=');
                            query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()).replaceAll("\\+", "%20"));
                            
                            if (itr.hasNext()) {
                                query.append('&');
                                hashData.append('&');
                            }
                        }
                    }
                    
                    String queryUrl = query.toString();
                    String vnp_SecureHash = VNPayConfig.hmacSHA512(VNPayConfig.vnp_HashSecret, hashData.toString());
                    queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
                    String paymentUrl = VNPayConfig.vnp_PayUrl + "?" + queryUrl;
                    
                    response.sendRedirect(paymentUrl);
                } catch (Exception e) {
                    session.setAttribute("checkoutError", "Không thể khởi tạo thanh toán VNPAY: " + e.getMessage());
                    response.sendRedirect(request.getContextPath() + "/checkout");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/checkout?action=success&orderId=" + order.getSaleOrderId());
            }
        } else {
            session.setAttribute("checkoutError", "Đã xảy ra lỗi hệ thống trong quá trình đặt hàng. Vui lòng thử lại sau.");
            response.sendRedirect(request.getContextPath() + "/checkout");
        }
    }
}

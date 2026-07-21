<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán đơn hàng - GreenStock</title>
    
    <%@include file="../common/head.jsp" %>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/customer/checkout.css">
</head>
<body>

    <!-- HEADER -->
    <%@include file="../common/header.jsp" %>

    <!-- CHECKOUT WRAPPER -->
    <div class="checkout-wrapper">
        <h1 class="checkout-title">
            <i class="fa-solid fa-credit-card"></i> Thanh toán đơn hàng
        </h1>

        <!-- Form main đặt hàng -->
        <form id="checkoutForm" action="checkout" method="POST" style="display: contents;">
            
            <!-- LEFT COLUMN -->
            <div class="checkout-left">
                
                <!-- Hiển thị lỗi nếu có -->
                <c:if test="${not empty checkoutError}">
                    <div class="alert-error">
                        <i class="fa-solid fa-circle-exclamation"></i> ${checkoutError}
                    </div>
                </c:if>

                <!-- SECTION 1: ĐỊA CHỈ GIAO HÀNG -->
                <div class="checkout-section">
                    <h2 class="section-title">
                        <i class="fa-solid fa-location-dot"></i> 1. Địa chỉ giao hàng
                    </h2>
                    
                    <c:choose>
                        <c:when test="${not empty addresses}">
                            <div class="address-grid">
                                <c:forEach items="${addresses}" var="addr">
                                    <div class="address-card ${addr.isDefault() ? 'active' : ''}" onclick="selectAddress(this, ${addr.addressId})">
                                        <input type="radio" name="addressId" value="${addr.addressId}" 
                                               class="address-radio" ${addr.isDefault() ? 'checked' : ''} 
                                               onclick="event.stopPropagation();">
                                        <div class="address-info">
                                            <div class="address-header">
                                                <span class="receiver-name">${addr.receiverName}</span>
                                                <span class="receiver-phone">${addr.receiverPhone}</span>
                                                <span class="address-label">${addr.label}</span>
                                                <c:if test="${addr.isDefault()}">
                                                    <span class="address-default">Mặc định</span>
                                                </c:if>
                                            </div>
                                            <div class="address-details">${addr.addressDetails}</div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="no-address-alert">
                                <i class="fa-solid fa-circle-question animate-bounce"></i>
                                <p style="font-weight: 600; margin-bottom: 0.5rem;">Bạn chưa lưu địa chỉ nhận hàng nào!</p>
                                <p style="font-size: 0.85rem; margin-bottom: 1rem;">Hãy thêm một địa chỉ để có thể hoàn thành việc đặt hàng nhanh chóng.</p>
                                <a href="address" class="btn-apply-coupon" style="text-decoration: none; display: inline-block;">Thêm địa chỉ ngay</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    
                    <div style="display: flex; justify-content: flex-end; margin-top: 1rem;">
                        <a href="address" class="btn-manage-address">
                            <i class="fa-solid fa-gear"></i> Quản lý địa chỉ giao hàng
                        </a>
                    </div>
                </div>

                <!-- SECTION 2: KHUYẾN MÃI / MÃ GIẢM GIÁ -->
                <div class="checkout-section">
                    <h2 class="section-title">
                        <i class="fa-solid fa-tag"></i> 2. Chương trình khuyến mãi
                    </h2>

                    <!-- Thống báo kết quả áp dụng -->
                    <c:if test="${not empty promoError}">
                        <div class="alert-error" style="margin-bottom: 1rem; padding: 0.75rem 1rem;">
                            <i class="fa-solid fa-circle-exclamation"></i> ${promoError}
                        </div>
                    </c:if>
                    <c:if test="${not empty promoSuccess}">
                        <div class="alert-success" style="margin-bottom: 1rem; padding: 0.75rem 1rem;">
                            <i class="fa-solid fa-circle-check"></i> ${promoSuccess}
                        </div>
                    </c:if>

                    <c:choose>
                        <c:when test="${not empty appliedPromo}">
                            <div class="applied-coupon-wrapper">
                                <div class="applied-coupon-info">
                                    <i class="fa-solid fa-circle-check"></i>
                                    <div>
                                        <strong>Đang áp dụng: ${appliedPromo.promoCode}</strong>
                                        <div style="font-size: 0.8rem; font-weight: normal; margin-top: 0.1rem;">
                                            Giảm <fmt:formatNumber value="${appliedPromo.discountValue}" maxFractionDigits="0"/>${appliedPromo.discountType == 'Percentage' ? '%' : 'đ'} 
                                            (Đơn tối thiểu <fmt:formatNumber value="${appliedPromo.minOrderValue}" maxFractionDigits="0"/>đ)
                                        </div>
                                    </div>
                                </div>
                                <a href="checkout?action=removePromo" class="btn-remove-coupon">
                                    <i class="fa-solid fa-circle-xmark"></i> Gỡ bỏ
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="coupon-box">
                                <input type="text" id="promoCodeInput" placeholder="Nhập mã giảm giá (ví dụ: FRUIT10)..." class="coupon-input">
                                <button type="button" class="btn-apply-coupon" onclick="applyCouponCode()">Áp dụng</button>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <!-- Danh sách khuyến mãi khả dụng -->
                    <c:if test="${not empty activePromotions}">
                        <div class="available-promos-title">Mã giảm giá dành cho bạn:</div>
                        <div class="promos-list">
                            <c:forEach items="${activePromotions}" var="promo">
                                <c:if test="${promo.promoCode != appliedPromo.promoCode}">
                                    <div class="promo-item">
                                        <div class="promo-details">
                                            <h5>
                                                <i class="fa-solid fa-ticket" style="color: var(--primary);"></i> 
                                                ${promo.promoCode}
                                                <span>Giảm ${promo.discountType == 'Percentage' ? '' : 'cố định' } ${promo.discountType == 'Percentage' ? promo.discountValue : ''}${promo.discountType == 'Percentage' ? '%' : ''}</span>
                                            </h5>
                                            <p>
                                                Áp dụng cho đơn hàng từ <fmt:formatNumber value="${promo.minOrderValue}" maxFractionDigits="0"/>đ.
                                                HSD: <fmt:formatDate value="${promo.endDate}" pattern="dd/MM/yyyy"/>.
                                            </p>
                                        </div>
                                        <a href="checkout?action=applyPromo&promoCode=${promo.promoCode}" class="btn-select-promo">Sử dụng</a>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>

                <!-- SECTION 3: PHƯƠNG THỨC THANH TOÁN & GHI CHÚ -->
                <div class="checkout-section">
                    <h2 class="section-title">
                        <i class="fa-solid fa-truck-fast"></i> 3. Thanh toán & Giao hàng
                    </h2>

                    <div class="payment-options">
                        <div class="payment-card active" onclick="selectPayment(this, 'COD')">
                            <input type="radio" name="paymentMethod" value="COD" checked onclick="event.stopPropagation();">
                            <div>
                                <div class="payment-text">Thanh toán khi nhận hàng (COD)</div>
                                <div class="payment-desc">Thanh toán bằng tiền mặt khi shipper giao hàng tận nơi.</div>
                            </div>
                        </div>
                        <div class="payment-card" onclick="selectPayment(this, 'Bank Transfer')">
                            <input type="radio" name="paymentMethod" value="Bank Transfer" onclick="event.stopPropagation();">
                            <div>
                                <div class="payment-text">Chuyển khoản ngân hàng</div>
                                <div class="payment-desc">Thực hiện thanh toán qua tài khoản ngân hàng GreenStock.</div>
                            </div>
                        </div>
                        <div class="payment-card" onclick="selectPayment(this, 'VNPAY')">
                            <input type="radio" name="paymentMethod" value="VNPAY" onclick="event.stopPropagation();">
                            <div>
                                <div class="payment-text">Cổng thanh toán VNPAY</div>
                                <div class="payment-desc">Thanh toán quét mã QR VNPAY hoặc thẻ ATM nội địa / Quốc tế.</div>
                            </div>
                        </div>
                    </div>

                    <!-- Hướng dẫn chuyển khoản -->
                    <div id="bankInfoBox" class="bank-info-box">
                        <h5><i class="fa-solid fa-circle-info"></i> Thông tin chuyển khoản ngân hàng:</h5>
                        <p><strong>Ngân hàng:</strong> Vietcombank (VCB)</p>
                        <p><strong>Số tài khoản:</strong> 1234567890</p>
                        <p><strong>Chủ tài khoản:</strong> CÔNG TY CỔ PHẦN GREENSTOCK VIỆT NAM</p>
                        <p><strong>Nội dung chuyển khoản:</strong> GS <span style="color:var(--primary); font-weight:700;">[Số điện thoại của bạn]</span></p>
                        <p style="margin-top: 0.5rem; font-size: 0.8rem; color: #DC2626;">* Đơn hàng sẽ được xử lý ngay sau khi hệ thống nhận được thanh toán.</p>
                    </div>

                    <div style="margin-top: 1.5rem;">
                        <label style="display:block; font-weight: 700; color: var(--dark); margin-bottom: 0.5rem;">Ghi chú gửi shipper:</label>
                        <textarea name="shipperNote" placeholder="Ví dụ: Giao giờ hành chính, gọi trước khi giao 15 phút..." class="shipper-note-textarea"></textarea>
                    </div>
                </div>
            </div>

            <!-- RIGHT COLUMN: ORDER SUMMARY (STICKY) -->
            <div class="checkout-right">
                <div class="summary-sidebar">
                    <h3 style="font-family: var(--font-display); font-size: 1.35rem; font-weight: 800; margin-bottom: 1.25rem; color: var(--dark);">Tóm tắt đơn hàng</h3>
                    
                    <!-- Items -->
                    <div class="summary-items">
                        <c:forEach items="${cartItems}" var="item">
                            <div class="summary-item-row">
                                <img src="${not empty item.product.image ? item.product.image : 'https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?auto=format&fit=crop&q=80&w=600'}" 
                                     alt="${item.product.name}" class="item-thumb">
                                <div class="item-details">
                                    <div class="item-name">${item.product.name}</div>
                                    <c:if test="${not empty item.weightLabel || not empty item.packagingName}">
                                        <div style="font-size: 0.75rem; color: var(--slate-600); margin-top: 0.15rem; font-weight: 600;">
                                            <c:if test="${not empty item.weightLabel}">
                                                <span style="background: var(--slate-200); padding: 0.1rem 0.3rem; border-radius: 4px; margin-right: 4px;">
                                                    ${item.weightLabel}
                                                </span>
                                            </c:if>
                                            <c:if test="${not empty item.packagingName}">
                                                <span style="background: var(--slate-200); padding: 0.1rem 0.3rem; border-radius: 4px;">
                                                    ${item.packagingName}
                                                </span>
                                            </c:if>
                                        </div>
                                    </c:if>
                                    <div class="item-meta">
                                        SL: ${item.quantity} x 
                                        <c:choose>
                                            <c:when test="${item.product.discountPrice > 0 && item.product.discountPrice < item.product.price}">
                                                <span style="text-decoration: line-through; color: var(--slate-400); font-size: 0.9em; margin-right: 4px;">
                                                    <fmt:formatNumber value="${item.product.price + item.variantPriceAdjustment + item.packagingPriceAdjustment}" maxFractionDigits="0"/>đ
                                                </span>
                                                <span style="color: var(--primary); font-weight: 600;">
                                                    <fmt:formatNumber value="${item.effectiveUnitPrice}" maxFractionDigits="0"/>đ
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:formatNumber value="${item.effectiveUnitPrice}" maxFractionDigits="0"/>đ
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="item-total-price">
                                    <fmt:formatNumber value="${item.quantity * item.effectiveUnitPrice}" maxFractionDigits="0"/>đ
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Prices breakdown -->
                    <div class="price-breakdown">
                        <div class="breakdown-row">
                            <span>Tạm tính</span>
                            <span><fmt:formatNumber value="${totalAmount}" maxFractionDigits="0"/>đ</span>
                        </div>
                        <div class="breakdown-row">
                            <span>Phí vận chuyển</span>
                            <span>
                                <c:choose>
                                    <c:when test="${shippingFee > 0}"><fmt:formatNumber value="${shippingFee}" maxFractionDigits="0"/>đ</c:when>
                                    <c:otherwise>Miễn phí</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <c:if test="${discount > 0}">
                            <div class="breakdown-row" style="color: var(--primary); font-weight:600;">
                                <span>Khuyến mãi (${appliedPromo.promoCode})</span>
                                <span>-<fmt:formatNumber value="${discount}" maxFractionDigits="0"/>đ</span>
                            </div>
                        </c:if>
                        <%-- Hiển thị thông tin giảm giá theo Hạng thành viên --%>
                        <c:if test="${memberDiscount > 0}">
                            <div class="breakdown-row" style="color: #6366f1; font-weight:600;">
                                <span>Giảm giá Hạng (${membership.currentTier} - ${memberDiscountPercent}%)</span>
                                <span>-<fmt:formatNumber value="${memberDiscount}" maxFractionDigits="0"/>đ</span>
                            </div>
                        </c:if>
                        <c:if test="${weekendDiscount > 0}">
        <div class="breakdown-row" style="color: var(--primary); font-weight:600;">
            <span><i class="fa-solid fa-calendar-days"></i> Ưu đãi cuối tuần (Giảm 5%)</span>
            <span>-<fmt:formatNumber value="${weekendDiscount}" maxFractionDigits="0"/>đ</span>
        </div>
    </c:if>
                        <div class="breakdown-row total">
                            <span>Tổng thanh toán</span>
                            <span class="total-price"><fmt:formatNumber value="${totalPayment}" maxFractionDigits="0"/>đ</span>
                        </div>
                    </div>

                    <!-- Place Order Button -->
                    <button type="submit" class="btn-place-order">Xác nhận đặt hàng</button>
                    
                    <a href="cart" class="btn-back-to-cart">
                        <i class="fa-solid fa-arrow-left"></i> Quay lại giỏ hàng
                    </a>
                </div>
            </div>
        </form>
    </div>

    <!-- FOOTER -->
    <%@include file="../common/footer.jsp" %>

    <!-- SCRIPTS -->
    <script>
        // Chọn địa chỉ
        function selectAddress(card, addressId) {
            // Remove active style from all cards
            document.querySelectorAll('.address-card').forEach(c => {
                c.classList.remove('active');
            });
            // Add active style to clicked card
            card.classList.add('active');
            
            // Check the radio button inside the card
            const radio = card.querySelector('.address-radio');
            if (radio) {
                radio.checked = true;
            }
        }

        // Chọn phương thức thanh toán
        function selectPayment(card, method) {
            document.querySelectorAll('.payment-card').forEach(c => {
                c.classList.remove('active');
            });
            card.classList.add('active');
            
            const radio = card.querySelector('input[type="radio"]');
            if (radio) {
                radio.checked = true;
            }

            // Show/hide bank instructions
            const bankBox = document.getElementById('bankInfoBox');
            if (method === 'Bank Transfer') {
                bankBox.style.display = 'block';
            } else {
                bankBox.style.display = 'none';
            }
        }

        // Áp dụng mã giảm giá bằng text input
        function applyCouponCode() {
            const code = document.getElementById('promoCodeInput').value.trim();
            if (code === '') {
                alert('Vui lòng nhập mã giảm giá.');
                return;
            }
            window.location.href = 'checkout?action=applyPromo&promoCode=' + encodeURIComponent(code);
        }
    </script>
</body>
</html>

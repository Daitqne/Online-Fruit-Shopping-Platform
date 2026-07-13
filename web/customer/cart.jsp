<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng - GreenStock</title>
    
    <%@include file="../common/head.jsp" %>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/customer/cart.css">
</head>
<body>

    <!-- HEADER -->
    <%@include file="../common/header.jsp" %>

    <!-- MAIN WRAPPER -->
    <div class="cart-wrapper">
        <h1 class="cart-title"><i class="fa-solid fa-cart-shopping"></i> Giỏ Hàng Của Bạn</h1>
        
        <c:if test="${not empty sessionScope.cartError}">
            <div class="alert alert-danger" style="background: #FEE2E2; color: #EF4444; border: 1px solid #FCA5A5; padding: 1rem; border-radius: 12px; margin-bottom: 1.5rem; font-weight: 500; display: flex; align-items: center; gap: 0.5rem; font-family: var(--font-body); font-size: 0.95rem;">
                <i class="fa-solid fa-circle-exclamation" style="font-size: 1.1rem;"></i>
                <span>${sessionScope.cartError}</span>
            </div>
            <c:remove var="cartError" scope="session"/>
        </c:if>
        <c:if test="${not empty sessionScope.cartSuccess}">
            <div class="alert alert-success" style="background: var(--primary-light); color: var(--primary-hover); border: 1px solid var(--primary); padding: 1rem; border-radius: 12px; margin-bottom: 1.5rem; font-weight: 500; display: flex; align-items: center; gap: 0.5rem; font-family: var(--font-body); font-size: 0.95rem;">
                <i class="fa-solid fa-circle-check" style="font-size: 1.1rem;"></i>
                <span>${sessionScope.cartSuccess}</span>
            </div>
            <c:remove var="cartSuccess" scope="session"/>
        </c:if>

        
        <c:choose>
            <c:when test="${not empty cartItems}">
                <!-- Cart Items List -->
                <div class="cart-list-container">
                    <table class="cart-table">
                        <thead>
                            <tr>
                                <th style="width: 45%;">Sản phẩm</th>
                                <th style="width: 15%;">Đơn giá</th>
                                <th style="width: 20%;">Số lượng</th>
                                <th style="width: 15%;">Thành tiền</th>
                                <th style="width: 5%;"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${cartItems}">
                                <tr>
                                    <td>
                                        <div class="product-col">
                                            <img src="${item.product.image}" alt="${item.product.name}" class="product-img">
                                            <div class="product-meta">
                                                <h4>${item.product.name}</h4>
                                                <span>${item.product.category}</span>
                                                <c:if test="${not empty item.weightLabel || not empty item.packagingName}">
                                                    <div style="font-size: 0.8rem; color: var(--slate-600); margin-top: 0.25rem;">
                                                        <c:if test="${not empty item.weightLabel}">
                                                            <span style="background: var(--slate-200); padding: 0.15rem 0.4rem; border-radius: 4px; margin-right: 4px; font-weight: 600;">
                                                                Trọng lượng: ${item.weightLabel}
                                                            </span>
                                                        </c:if>
                                                        <c:if test="${not empty item.packagingName}">
                                                            <span style="background: var(--slate-200); padding: 0.15rem 0.4rem; border-radius: 4px; font-weight: 600;">
                                                                Đóng gói: ${item.packagingName}
                                                            </span>
                                                        </c:if>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="price-text">
                                            <c:choose>
                                                <c:when test="${item.product.discountPrice > 0 && item.product.discountPrice < item.product.price}">
                                                    <span style="text-decoration: line-through; color: var(--slate-400); font-size: 0.9em; margin-right: 8px;">
                                                        <fmt:formatNumber value="${item.product.price + item.variantPriceAdjustment + item.packagingPriceAdjustment}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                                    </span>
                                                    <span style="color: var(--primary); font-weight: 600;">
                                                        <fmt:formatNumber value="${item.effectiveUnitPrice}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <fmt:formatNumber value="${item.effectiveUnitPrice}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </td>
                                    <td>
                                        <div class="qty-selector">
                                            <a href="cart?action=update&cartItemId=${item.cartItemId}&quantity=${item.quantity - 1}" class="btn-qty-btn decrease" title="Giảm số lượng">
                                                <i class="fa-solid fa-minus"></i>
                                            </a>
                                            <span class="qty-value">${item.quantity}</span>
                                            <a href="cart?action=update&cartItemId=${item.cartItemId}&quantity=${item.quantity + 1}" class="btn-qty-btn increase" title="Tăng số lượng">
                                                <i class="fa-solid fa-plus"></i>
                                            </a>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="total-item-price">
                                            <fmt:formatNumber value="${item.quantity * item.effectiveUnitPrice}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                        </span>
                                    </td>
                                    <td>
                                        <a href="cart?action=delete&cartItemId=${item.cartItemId}" class="btn-delete-item" title="Xóa khỏi giỏ hàng">
                                            <i class="fa-solid fa-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <!-- Order Summary Sidebar -->
                <div class="summary-card">
                    <h3>Tóm tắt đơn hàng</h3>
                    <div class="summary-row">
                        <span>Tạm tính</span>
                        <span class="price-text">
                            <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                        </span>
                    </div>
                    <div class="summary-row">
                        <span>Phí vận chuyển</span>
                        <span class="price-text">
                            <c:choose>
                                <c:when test="${shippingFee > 0}">
                                    <fmt:formatNumber value="${shippingFee}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                </c:when>
                                <c:otherwise>Miễn phí</c:otherwise>
                            </c:choose>
                        </span>
                    </div>


                    <div class="summary-row total">
                        <span>Tổng thanh toán</span>
                        <span class="total-price price-text">
                            <fmt:formatNumber value="${totalPayment}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                        </span>
                    </div>
                    
                    <a href="${pageContext.request.contextPath}/checkout" class="btn-checkout">Tiến hành thanh toán</a>
                    <a href="products" class="btn-continue-shopping">Tiếp tục mua sắm</a>
                </div>
            </c:when>
            
            <c:otherwise>
                <!-- Empty Cart State -->
                <div class="cart-list-container" style="grid-column: span 2;">
                    <div class="empty-cart">
                        <i class="fa-solid fa-basket-shopping"></i>
                        <h2>Giỏ hàng của bạn đang trống!</h2>
                        <p>Hãy lấp đầy giỏ hàng của bạn bằng những trái cây tươi ngon, hữu cơ chất lượng cao từ GreenStock ngay hôm nay.</p>
                        <a href="products" class="btn-checkout" style="display: inline-block; padding: 0.9rem 2rem;">Mua sắm ngay</a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- FOOTER -->
    <%@include file="../common/footer.jsp" %>

</body>
</html>

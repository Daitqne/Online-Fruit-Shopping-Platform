<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng - GreenStock</title>
    
    <%@include file="../common/head.jsp" %>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/customer/order-details.css">
</head>
<body>

    <!-- HEADER -->
    <%@include file="../common/header.jsp" %>

    <!-- WRAPPER -->
    <div class="detail-wrapper">
        <div class="detail-header-section">
            <h1 class="detail-title">Đơn hàng #${order.saleOrderId}</h1>
            <a href="orders" class="btn-back-history">
                <i class="fa-solid fa-arrow-left-long"></i> Lịch sử mua hàng
            </a>
        </div>

        <!-- LEFT COLUMN -->
        <div class="detail-left">
            
            <!-- Success/Error Alert -->
            <c:if test="${not empty orderSuccess}">
                <div class="alert alert-success">
                    <i class="fa-solid fa-circle-check"></i> ${orderSuccess}
                </div>
            </c:if>
            <c:if test="${not empty orderError}">
                <div class="alert alert-error">
                    <i class="fa-solid fa-circle-exclamation"></i> ${orderError}
                </div>
            </c:if>

            <!-- TIMELINE TRẠNG THÁI ĐƠN HÀNG (STATUS TRACKING) -->
            <div class="timeline-card">
                <c:choose>
                    <c:when test="${order.orderStatus == 'Cancelled'}">
                        <!-- Hiển thị banner đã hủy -->
                        <div class="cancelled-banner">
                            <i class="fa-solid fa-circle-xmark animate-pulse"></i>
                            <div>
                                <div class="cancelled-title">Đơn hàng này đã bị hủy</div>
                                <div class="cancelled-desc">
                                    Đơn hàng đã được hủy vào lúc hệ thống ghi nhận. Số tiền tạm tính chưa thanh toán và số lượng sản phẩm đã hoàn kho.
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Tiến trình trạng thái (Pending -> Processing -> Shipped -> Delivered) -->
                        <div class="status-timeline">
                            
                            <!-- Tính toán chiều rộng thanh tiến trình xanh dựa theo trạng thái -->
                            <c:set var="progressBarWidth" value="0%" />
                            <c:choose>
                                <c:when test="${order.orderStatus == 'Pending'}"><c:set var="progressBarWidth" value="0%" /></c:when>
                                <c:when test="${order.orderStatus == 'Processing'}"><c:set var="progressBarWidth" value="33.3%" /></c:when>
                                <c:when test="${order.orderStatus == 'Shipped'}"><c:set var="progressBarWidth" value="66.6%" /></c:when>
                                <c:when test="${order.orderStatus == 'Delivered'}"><c:set var="progressBarWidth" value="100%" /></c:when>
                            </c:choose>

                            <div class="timeline-progress-bar" style="width: ${progressBarWidth};"></div>
                            
                            <!-- Bước 1: Pending -->
                            <div class="timeline-step ${order.orderStatus == 'Pending' ? 'active' : ''} ${order.orderStatus != 'Pending' ? 'completed' : ''}">
                                <div class="step-icon"><i class="fa-solid fa-clock"></i></div>
                                <div class="step-label">Chờ xử lý</div>
                            </div>
                            
                            <!-- Bước 2: Processing -->
                            <div class="timeline-step ${order.orderStatus == 'Processing' ? 'active' : ''} ${(order.orderStatus == 'Shipped' || order.orderStatus == 'Delivered') ? 'completed' : ''}">
                                <div class="step-icon"><i class="fa-solid fa-gears"></i></div>
                                <div class="step-label">Đang xử lý</div>
                            </div>
                            
                            <!-- Bước 3: Shipped -->
                            <div class="timeline-step ${order.orderStatus == 'Shipped' ? 'active' : ''} ${order.orderStatus == 'Delivered' ? 'completed' : ''}">
                                <div class="step-icon"><i class="fa-solid fa-truck-fast"></i></div>
                                <div class="step-label">Đang giao</div>
                            </div>
                            
                            <!-- Bước 4: Delivered -->
                            <div class="timeline-step ${order.orderStatus == 'Delivered' ? 'active' : ''}">
                                <div class="step-icon"><i class="fa-solid fa-circle-check"></i></div>
                                <div class="step-label">Hoàn thành</div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- THÔNG TIN GIAO HÀNG & THANH TOÁN -->
            <div class="info-card">
                <h2 class="info-title"><i class="fa-solid fa-location-dot"></i> Thông tin giao nhận & Thanh toán</h2>
                <div class="info-grid">
                    <div class="info-block">
                        <h4>Địa chỉ nhận hàng</h4>
                        <p style="font-weight: 500; font-size: 0.95rem; color: var(--slate-600); line-height: 1.5; margin-top: 0.25rem;">
                            ${order.shippingAddress}
                        </p>
                    </div>
                    <div class="info-grid" style="grid-template-columns: 1fr; gap: 0.75rem;">
                        <div class="info-block">
                            <h4>Phương thức thanh toán</h4>
                            <p>
                                <c:choose>
                                    <c:when test="${order.paymentMethod == 'COD'}">Thanh toán khi nhận hàng (COD)</c:when>
                                    <c:when test="${order.paymentMethod == 'Bank Transfer'}">Chuyển khoản ngân hàng</c:when>
                                    <c:when test="${order.paymentMethod == 'VNPAY'}">Cổng thanh toán VNPAY</c:when>
                                    <c:otherwise>${order.paymentMethod}</c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div class="info-block">
                            <h4>Trạng thái thanh toán</h4>
                            <p style="display:flex; align-items:center; gap: 0.4rem; font-size: 0.9rem;">
                                <c:choose>
                                    <c:when test="${order.paymentStatus == 'Paid'}">
                                        <span class="status-badge pay-paid" style="padding: 0.2rem 0.5rem;"><i class="fa-solid fa-circle-check"></i> Đã thanh toán</span>
                                    </c:when>
                                    <c:when test="${order.paymentStatus == 'Failed'}">
                                        <span class="status-badge pay-failed" style="padding: 0.2rem 0.5rem; background-color: #FEF2F2; color: #EF4444; border: 1px solid #FCA5A5; border-radius: 6px; font-weight: 600;"><i class="fa-solid fa-circle-xmark"></i> Thanh toán thất bại</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge pay-pending" style="padding: 0.2rem 0.5rem;"><i class="fa-solid fa-clock"></i> Chưa thanh toán</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Hiển thị VietQR thanh toán nếu chọn Chuyển khoản ngân hàng và chưa thanh toán -->
                <fmt:formatNumber value="${order.totalPayment}" pattern="#" var="formattedAmount"/>
                <c:if test="${order.paymentMethod == 'Bank Transfer' && order.paymentStatus != 'Paid'}">
                    <div style="margin-top: 1.5rem; padding: 1.25rem; border: 1px dashed var(--primary); border-radius: 16px; background-color: var(--primary-light); display: flex; flex-direction: column; align-items: center; text-align: center;">
                        <h4 style="font-family: var(--font-display); font-size: 1.1rem; font-weight: 700; color: var(--primary-hover); margin-bottom: 0.5rem;">
                            <i class="fa-solid fa-qrcode"></i> Quét VietQR thanh toán nhanh
                        </h4>
                        <p style="font-size: 0.8rem; color: var(--slate-600); margin-bottom: 0.75rem; max-width: 450px; line-height: 1.4;">
                            Quét mã này bằng ứng dụng ngân hàng để chuyển khoản thanh toán tự động điền sẵn thông tin.
                        </p>
                        <img src="https://img.vietqr.io/image/vietcombank-1234567890-compact.png?amount=${formattedAmount}&addInfo=GS${order.saleOrderId}&accountName=CONG%20TY%20CO%20PHAN%20GREENSTOCK%20VIET%20NAM" 
                             alt="VietQR Code" 
                             style="max-width: 180px; border-radius: 10px; box-shadow: var(--shadow-md); border: 1px solid var(--slate-200); background-color: white; padding: 4px; margin-bottom: 0.5rem;">
                        <div style="font-size: 0.85rem; font-weight: 700; color: var(--dark);">
                            Số tiền: <span style="color:#DC2626;"><fmt:formatNumber value="${order.totalPayment}" maxFractionDigits="0"/>đ</span>
                        </div>
                        <div style="font-size: 0.85rem; font-weight: 700; color: var(--dark);">
                            Nội dung: <span style="color:var(--primary-hover);">GS${order.saleOrderId}</span>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${not empty order.shipperNote}">
                    <div class="info-block" style="margin-top: 1.5rem; border-top: 1px solid var(--slate-100); padding-top: 1rem;">
                        <h4>Ghi chú đơn hàng</h4>
                        <p style="font-weight: 500; color: var(--slate-600); font-style: italic;">"${order.shipperNote}"</p>
                    </div>
                </c:if>
            </div>

            <!-- CHI TIẾT SẢN PHẨM MUA -->
            <div class="info-card">
                <h2 class="info-title"><i class="fa-solid fa-basket-shopping"></i> Danh sách mặt hàng</h2>
                <div>
                    <c:forEach items="${order.items}" var="item">
                        <div class="item-row">
                            <img src="${not empty item.product.image ? item.product.image : 'https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?auto=format&fit=crop&q=80&w=600'}" 
                                 alt="${item.product.name}" class="item-img">
                            <div class="item-main">
                                <div class="item-name">${item.product.name}</div>
                                <div class="item-meta">Số lượng: ${item.quantity} x <fmt:formatNumber value="${item.unitPrice}" maxFractionDigits="0"/>đ</div>
                            </div>
                            <div class="item-price">
                                <fmt:formatNumber value="${item.quantity * item.unitPrice}" maxFractionDigits="0"/>đ
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <!-- RIGHT COLUMN (ORDER SUMMARY SIDEBAR) -->
        <div class="detail-right">
            <div class="sidebar-card">
                <h3 class="summary-title">Tóm tắt thanh toán</h3>
                
                <!-- Tính toán tạm tính từ các mặt hàng -->
                <c:set var="subTotal" value="0" />
                <c:forEach items="${order.items}" var="item">
                    <c:set var="subTotal" value="${subTotal + (item.quantity * item.unitPrice)}" />
                </c:forEach>

                <div class="price-row">
                    <span>Tổng tiền hàng</span>
                    <span><fmt:formatNumber value="${subTotal}" maxFractionDigits="0"/>đ</span>
                </div>
                <div class="price-row">
                    <span>Phí vận chuyển</span>
                    <span>
                        <c:choose>
                            <c:when test="${order.shippingFee > 0}"><fmt:formatNumber value="${order.shippingFee}" maxFractionDigits="0"/>đ</c:when>
                            <c:otherwise>Miễn phí</c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <c:if test="${order.discountAmount > 0}">
                    <div class="price-row" style="color: var(--primary); font-weight: 600;">
                        <span>Khuyến mãi giảm giá ${not empty order.promoCode ? '('.concat(order.promoCode).concat(')') : ''}</span>
                        <span>-<fmt:formatNumber value="${order.discountAmount}" maxFractionDigits="0"/>đ</span>
                    </div>
                </c:if>
                <div class="price-row total">
                    <span>Tổng thanh toán</span>
                    <span class="total-val"><fmt:formatNumber value="${order.totalPayment}" maxFractionDigits="0"/>đ</span>
                </div>

                <!-- INVOICE & RECEIPT BUTTONS -->
                <a href="${pageContext.request.contextPath}/orders?action=invoice&id=${order.saleOrderId}" target="_blank" class="btn-cancel-order" style="background-color: var(--primary-light); color: var(--primary-hover); border-color: var(--primary); margin-top: 1.5rem; text-decoration: none;">
                    <i class="fa-solid fa-file-invoice"></i> Xem hóa đơn điện tử
                </a>
                <a href="${pageContext.request.contextPath}/orders?action=invoice&id=${order.saleOrderId}&download=true" target="_blank" class="btn-cancel-order" style="background-color: var(--slate-100); color: var(--dark); border-color: var(--slate-300); margin-top: 0.5rem; text-decoration: none;">
                    <i class="fa-solid fa-download"></i> Tải biên lai (PDF)
                </a>

                <!-- NÚT HỦY ĐƠN HÀNG (CHỈ KHI TRẠNG THÁI LÀ PENDING) -->
                <c:if test="${order.orderStatus == 'Pending'}">
                    <button type="button" class="btn-cancel-order" onclick="confirmCancelOrder(${order.saleOrderId})" style="margin-top: 0.5rem;">
                        <i class="fa-solid fa-circle-xmark"></i> Hủy đơn hàng này
                    </button>
                </c:if>
            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <%@include file="../common/footer.jsp" %>

    <!-- CONFIRMATION SCRIPTS -->
    <script>
        function confirmCancelOrder(orderId) {
            if (confirm("Bạn có chắc chắn muốn hủy đơn hàng #" + orderId + " không?\nLưu ý: Thao tác này không thể hoàn tác và số lượng sản phẩm sẽ được hoàn trả lại vào kho hàng.")) {
                window.location.href = "${pageContext.request.contextPath}/orders?action=cancel&id=" + orderId;
            }
        }
    </script>
</body>
</html>

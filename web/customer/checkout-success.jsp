<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt hàng thành công - GreenStock</title>
    
    <%@include file="../common/head.jsp" %>
    
    <style>
        :root {
            --primary: #10B981;
            --primary-hover: #059669;
            --primary-light: #E6F4EA;
            --secondary: #F59E0B;
            --dark: #0F172A;
            --light: #F8FAFC;
            --slate-100: #F1F5F9;
            --slate-200: #E2E8F0;
            --slate-300: #CBD5E1;
            --slate-600: #475569;
            --white: #FFFFFF;
            --font-display: 'Outfit', sans-serif;
            --font-body: 'Plus Jakarta Sans', sans-serif;
            --shadow-lg: 0 10px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.05);
            --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.08), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: var(--font-body);
            background-color: var(--light);
            color: var(--dark);
            line-height: 1.6;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* --- SUCCESS CONTAINER --- */
        .success-wrapper {
            max-width: 800px;
            margin: 8rem auto 4rem;
            padding: 0 1.5rem;
            animation: slideUp 0.5s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .success-card {
            background: var(--white);
            border-radius: 24px;
            box-shadow: var(--shadow-xl);
            border: 1px solid var(--slate-200);
            padding: 3rem 2.5rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        /* Confetti Canvas styling */
        #confetti-canvas {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 1;
        }

        .success-icon {
            width: 90px;
            height: 90px;
            background-color: var(--primary-light);
            color: var(--primary);
            font-size: 2.8rem;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            box-shadow: 0 0 0 10px rgba(16, 185, 129, 0.06);
            animation: pop 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275) both;
            position: relative;
            z-index: 2;
        }

        @keyframes pop {
            0% { transform: scale(0); }
            100% { transform: scale(1); }
        }

        .success-title {
            font-family: var(--font-display);
            font-size: 2.2rem;
            font-weight: 800;
            color: var(--dark);
            margin-bottom: 0.75rem;
            position: relative;
            z-index: 2;
        }

        .success-desc {
            color: var(--slate-600);
            font-size: 1.1rem;
            margin-bottom: 2.5rem;
            max-width: 580px;
            margin-left: auto;
            margin-right: auto;
            position: relative;
            z-index: 2;
        }

        /* --- ORDER TIMELINE --- */
        .order-timeline {
            display: flex;
            justify-content: space-between;
            position: relative;
            margin-bottom: 3.5rem;
            padding: 0 1rem;
        }

        .order-timeline::before {
            content: '';
            position: absolute;
            top: 20px;
            left: 3.5rem;
            right: 3.5rem;
            height: 4px;
            background-color: var(--slate-200);
            z-index: 1;
        }

        .timeline-step {
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
            z-index: 2;
            flex: 1;
        }

        .step-icon {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background-color: var(--slate-200);
            color: var(--slate-600);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            font-weight: bold;
            margin-bottom: 0.75rem;
            transition: all 0.3s;
            border: 4px solid var(--white);
            box-shadow: var(--shadow-sm);
        }

        .step-label {
            font-size: 0.85rem;
            font-weight: 700;
            color: var(--slate-600);
            transition: all 0.3s;
            text-align: center;
        }

        /* Active/Completed states */
        .timeline-step.completed .step-icon {
            background-color: var(--primary-light);
            color: var(--primary);
        }

        .timeline-step.active .step-icon {
            background-color: var(--primary);
            color: var(--white);
            box-shadow: 0 0 0 5px rgba(16, 185, 129, 0.2);
        }

        .timeline-step.active .step-label {
            color: var(--primary);
        }

        /* Progress line highlight (requires static style block) */
        .order-timeline-progress {
            position: absolute;
            top: 20px;
            left: 3.5rem;
            height: 4px;
            background-color: var(--primary);
            z-index: 1;
            transition: width 0.5s ease;
        }

        /* --- DETAILED CARDS --- */
        .details-grid {
            display: grid;
            grid-template-columns: 1.2fr 1fr;
            gap: 2rem;
            text-align: left;
            margin-bottom: 3rem;
        }

        @media (max-width: 768px) {
            .details-grid {
                grid-template-columns: 1fr;
            }
        }

        .info-card {
            background: var(--slate-100);
            border-radius: 20px;
            padding: 1.5rem;
            border: 1px solid var(--slate-200);
        }

        .card-title {
            font-family: var(--font-display);
            font-size: 1.15rem;
            font-weight: 800;
            color: var(--dark);
            margin-bottom: 1.25rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid var(--slate-200);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .card-title i {
            color: var(--primary);
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.75rem;
            font-size: 0.95rem;
        }

        .info-row:last-child {
            margin-bottom: 0;
        }

        .info-label {
            color: var(--slate-600);
            font-weight: 500;
        }

        .info-value {
            font-weight: 700;
            color: var(--dark);
        }

        /* --- PRODUCTS CARD --- */
        .products-card {
            background: var(--white);
            border: 1px solid var(--slate-200);
            border-radius: 20px;
            padding: 1.5rem;
            margin-bottom: 3rem;
            text-align: left;
        }

        .product-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem 0;
            border-bottom: 1px solid var(--slate-200);
        }

        .product-item:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }

        .product-item:first-child {
            padding-top: 0;
        }

        .product-img {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            object-fit: cover;
            border: 1px solid var(--slate-200);
            background-color: var(--slate-100);
        }

        .product-info {
            flex-grow: 1;
        }

        .product-name {
            font-weight: 700;
            font-size: 0.95rem;
            color: var(--dark);
            margin-bottom: 0.25rem;
        }

        .product-meta {
            font-size: 0.8rem;
            color: var(--slate-600);
            display: flex;
            gap: 0.75rem;
        }

        .product-pricing {
            text-align: right;
        }

        .product-price {
            font-weight: 700;
            color: var(--dark);
            font-size: 0.95rem;
        }

        .product-quantity {
            font-size: 0.8rem;
            color: var(--slate-600);
        }

        /* --- BILLING TOTALS --- */
        .billing-totals {
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px dashed var(--slate-300);
        }

        .billing-row {
            display: flex;
            justify-content: space-between;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }

        .billing-row.grand-total {
            font-size: 1.15rem;
            font-weight: 800;
            color: var(--dark);
            margin-top: 0.5rem;
            margin-bottom: 0;
        }

        .grand-total .info-value {
            color: #DC2626; /* Crimson Red for Emphasis */
            font-size: 1.25rem;
        }

        /* --- VIETQR BOX --- */
        .qr-card {
            background-color: var(--primary-light);
            border: 1.5px dashed var(--primary);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 3rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        .qr-title {
            font-family: var(--font-display);
            font-size: 1.25rem;
            font-weight: 800;
            color: var(--primary-hover);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .qr-desc {
            font-size: 0.9rem;
            color: var(--slate-600);
            max-width: 500px;
            margin-bottom: 1.5rem;
            line-height: 1.5;
        }

        .qr-code-img {
            max-width: 200px;
            border-radius: 16px;
            box-shadow: var(--shadow-lg);
            border: 4px solid var(--white);
            background-color: white;
            padding: 8px;
            margin-bottom: 1.5rem;
            transition: transform 0.3s;
        }

        .qr-code-img:hover {
            transform: scale(1.05);
        }

        .copy-details-table {
            background-color: var(--white);
            padding: 1rem 1.5rem;
            border-radius: 12px;
            border: 1px solid var(--slate-200);
            width: 100%;
            max-width: 420px;
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }

        .copy-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.9rem;
        }

        .copy-btn {
            background: var(--slate-100);
            border: 1px solid var(--slate-200);
            border-radius: 6px;
            padding: 4px 10px;
            font-size: 0.75rem;
            font-weight: 700;
            color: var(--primary);
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 4px;
            transition: all 0.2s;
            font-family: var(--font-body);
        }

        .copy-btn:hover {
            background: var(--primary);
            color: var(--white);
            border-color: var(--primary);
        }

        /* Toast Tooltip Notification */
        .toast-copy {
            position: fixed;
            bottom: 30px;
            left: 50%;
            transform: translateX(-50%) translateY(20px);
            background: rgba(15, 23, 42, 0.9);
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            font-size: 0.9rem;
            font-weight: 600;
            z-index: 2000;
            opacity: 0;
            pointer-events: none;
            transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.3);
        }

        .toast-copy.show {
            opacity: 1;
            transform: translateX(-50%) translateY(0);
        }

        /* --- ACTIONS --- */
        .actions-group {
            display: flex;
            gap: 1.25rem;
            justify-content: center;
            position: relative;
            z-index: 2;
        }

        .btn-primary-custom {
            background-color: var(--primary);
            color: var(--white);
            border: none;
            padding: 1rem 2.25rem;
            border-radius: 16px;
            font-family: var(--font-body);
            font-weight: 700;
            text-decoration: none;
            transition: all 0.3s;
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.25);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            cursor: pointer;
        }

        .btn-primary-custom:hover {
            background-color: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(16, 185, 129, 0.35);
        }

        .btn-outline-custom {
            background-color: transparent;
            color: var(--slate-600);
            border: 2px solid var(--slate-300);
            padding: 0.9rem 2.25rem;
            border-radius: 16px;
            font-family: var(--font-body);
            font-weight: 700;
            text-decoration: none;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            cursor: pointer;
        }

        .btn-outline-custom:hover {
            background-color: var(--slate-100);
            color: var(--dark);
            border-color: var(--slate-600);
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

    <!-- HEADER -->
    <%@include file="../common/header.jsp" %>

    <!-- SUCCESS WRAPPER -->
    <div class="success-wrapper">
        <div class="success-card">
            <!-- Confetti Canvas -->
            <canvas id="confetti-canvas"></canvas>

            <div class="success-icon">
                <i class="fa-solid fa-check"></i>
            </div>
            <h1 class="success-title">Đặt hàng thành công!</h1>
            <p class="success-desc">
                Cảm ơn bạn đã tin tưởng mua sắm tại <strong>GreenStock</strong>. Đơn hàng của bạn đã được ghi nhận trên hệ thống và sẽ được xử lý sớm nhất.
            </p>

            <!-- ORDER TIMELINE -->
            <div class="order-timeline">
                <div class="order-timeline-progress" style="width: 25%;"></div>
                
                <div class="timeline-step completed">
                    <div class="step-icon"><i class="fa-solid fa-cart-shopping"></i></div>
                    <span class="step-label">Đặt hàng</span>
                </div>
                <div class="timeline-step active">
                    <div class="step-icon"><i class="fa-solid fa-clock"></i></div>
                    <span class="step-label">Chờ xác nhận</span>
                </div>
                <div class="timeline-step">
                    <div class="step-icon"><i class="fa-solid fa-box"></i></div>
                    <span class="step-label">Đang chuẩn bị</span>
                </div>
                <div class="timeline-step">
                    <div class="step-icon"><i class="fa-solid fa-truck-fast"></i></div>
                    <span class="step-label">Đang giao</span>
                </div>
                <div class="timeline-step">
                    <div class="step-icon"><i class="fa-solid fa-circle-check"></i></div>
                    <span class="step-label">Đã giao</span>
                </div>
            </div>

            <!-- DETAILS GRID -->
            <div class="details-grid">
                <!-- Order Status & Information -->
                <div class="info-card">
                    <h3 class="card-title"><i class="fa-solid fa-file-invoice"></i> Thông tin đơn hàng</h3>
                    <div class="info-row">
                        <span class="info-label">Mã đơn hàng:</span>
                        <span class="info-value" style="color: var(--primary); font-size: 1.05rem;">#${orderId}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Ngày đặt:</span>
                        <span class="info-value" id="orderTime">Vừa xong</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Trạng thái xử lý:</span>
                        <span class="info-value" style="color: var(--secondary);">
                            <c:choose>
                                <c:when test="${order.orderStatus == 'Pending'}">Chờ xác nhận (Pending)</c:when>
                                <c:when test="${order.orderStatus == 'Processing'}">Đang chuẩn bị (Processing)</c:when>
                                <c:when test="${order.orderStatus == 'Shipping'}">Đang giao hàng (Shipping)</c:when>
                                <c:when test="${order.orderStatus == 'Delivered'}">Giao thành công (Delivered)</c:when>
                                <c:when test="${order.orderStatus == 'Cancelled'}">Đã hủy (Cancelled)</c:when>
                                <c:otherwise>Chờ xác nhận (Pending)</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Thanh toán:</span>
                        <span class="info-value" style="color: ${order.paymentStatus == 'Paid' ? 'var(--primary)' : '#EF4444'}">
                            <c:choose>
                                <c:when test="${order.paymentStatus == 'Paid'}">Đã thanh toán (Paid)</c:when>
                                <c:when test="${order.paymentStatus == 'Failed'}">Thanh toán thất bại</c:when>
                                <c:otherwise>Chưa thanh toán</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Phương thức:</span>
                        <span class="info-value">
                            <c:choose>
                                <c:when test="${order.paymentMethod == 'COD'}">Thanh toán khi nhận hàng (COD)</c:when>
                                <c:when test="${order.paymentMethod == 'Bank Transfer'}">Chuyển khoản ngân hàng</c:when>
                                <c:when test="${order.paymentMethod == 'VNPAY'}">Thanh toán trực tuyến VNPAY</c:when>
                                <c:otherwise>${order.paymentMethod}</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>

                <!-- Delivery Information -->
                <div class="info-card">
                    <h3 class="card-title"><i class="fa-solid fa-truck"></i> Thông tin giao hàng</h3>
                    <div class="info-row">
                        <span class="info-label">Người nhận:</span>
                        <span class="info-value">${sessionScope.user.fullName}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Số điện thoại:</span>
                        <span class="info-value">${order.shippingPhone}</span>
                    </div>
                    <div class="info-row" style="flex-direction: column; gap: 0.25rem;">
                        <span class="info-label">Địa chỉ nhận hàng:</span>
                        <span class="info-value" style="font-weight: 500; font-size: 0.9rem; margin-top: 2px;">${order.shippingAddress}</span>
                    </div>
                </div>
            </div>

            <!-- DETAILED PRODUCTS CARD -->
            <c:if test="${order != null && not empty order.items}">
                <div class="products-card">
                    <h3 class="card-title"><i class="fa-solid fa-basket-shopping"></i> Danh sách sản phẩm đặt mua</h3>
                    
                    <c:forEach items="${order.items}" var="item">
                        <div class="product-item">
                            <img src="${not empty item.product.image ? item.product.image : 'https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?auto=format&fit=crop&q=80&w=600'}" 
                                 alt="${item.product.name}" 
                                 class="product-img" 
                                 onerror="this.onerror=null;this.src='https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?auto=format&fit=crop&q=80&w=600'">
                            <div class="product-info">
                                <h4 class="product-name">${item.product.name}</h4>
                                <div class="product-meta">
                                    <c:if test="${not empty item.weightLabel}">
                                        <span><i class="fa-solid fa-scale-balanced"></i> ${item.weightLabel}</span>
                                    </c:if>
                                    <c:if test="${not empty item.packagingName}">
                                        <span><i class="fa-solid fa-box-open"></i> Đóng gói: ${item.packagingName}</span>
                                    </c:if>
                                </div>
                            </div>
                            <div class="product-pricing">
                                <span class="product-price"><fmt:formatNumber value="${item.unitPrice}" maxFractionDigits="0"/>đ</span>
                                <div class="product-quantity">x${item.quantity}</div>
                            </div>
                        </div>
                    </c:forEach>

                    <!-- Billing Calculations -->
                    <div class="billing-totals">
                        <div class="billing-row">
                            <span class="info-label">Tạm tính:</span>
                            <span class="info-value">
                                <fmt:formatNumber value="${order.totalPayment - order.shippingFee + order.discountAmount}" maxFractionDigits="0"/>đ
                            </span>
                        </div>
                        <div class="billing-row">
                            <span class="info-label">Phí giao hàng:</span>
                            <span class="info-value">+<fmt:formatNumber value="${order.shippingFee}" maxFractionDigits="0"/>đ</span>
                        </div>
                        <c:if test="${order.discountAmount > 0}">
                            <div class="billing-row" style="color: var(--primary);">
                                <span class="info-label">Khuyến mãi (${order.promoCode}):</span>
                                <span class="info-value">-<fmt:formatNumber value="${order.discountAmount}" maxFractionDigits="0"/>đ</span>
                            </div>
                        </c:if>
                        <div class="billing-row grand-total">
                            <span class="info-label">Tổng thanh toán:</span>
                            <span class="info-value"><fmt:formatNumber value="${order.totalPayment}" maxFractionDigits="0"/>đ</span>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- VIETQR BANK TRANSFER OPTION -->
            <fmt:formatNumber value="${order.totalPayment}" pattern="#" var="formattedAmount"/>
            <c:if test="${order.paymentMethod == 'Bank Transfer' && order.paymentStatus != 'Paid'}">
                <div class="qr-card">
                    <h4 class="qr-title">
                        <i class="fa-solid fa-qrcode animate-pulse"></i> Quét mã VietQR thanh toán nhanh
                    </h4>
                    <p class="qr-desc">
                        Mở ứng dụng ngân hàng (Mobile Banking) của bạn và quét mã QR bên dưới. Thông tin số tiền và nội dung chuyển khoản đã được điền tự động chính xác tuyệt đối.
                    </p>
                    
                    <img src="https://img.vietqr.io/image/vietcombank-1234567890-compact.png?amount=${formattedAmount}&addInfo=GS${order.saleOrderId}&accountName=CONG%20TY%20CO%20PHAN%20GREENSTOCK%20VIET%20NAM" 
                         alt="VietQR Code" 
                         class="qr-code-img">
                         
                    <div class="copy-details-table">
                        <div class="copy-row">
                            <span class="info-label">Ngân hàng:</span>
                            <span class="info-value">Vietcombank (VCB)</span>
                        </div>
                        <div class="copy-row">
                            <span class="info-label">Chủ tài khoản:</span>
                            <span class="info-value" style="font-size:0.85rem;">CONG TY CO PHAN GREENSTOCK VIET NAM</span>
                        </div>
                        <div class="copy-row">
                            <span class="info-label">Số tài khoản:</span>
                            <div style="display:flex; align-items:center; gap:8px;">
                                <span class="info-value" id="bank-acc">1234567890</span>
                                <button class="copy-btn" onclick="copyText('1234567890', 'Số tài khoản')">
                                    <i class="fa-regular fa-copy"></i> Copy
                                </button>
                            </div>
                        </div>
                        <div class="copy-row" style="border-top: 1px dashed var(--slate-200); padding-top: 0.5rem;">
                            <span class="info-label">Số tiền:</span>
                            <div style="display:flex; align-items:center; gap:8px;">
                                <span class="info-value" style="color: #DC2626;" id="bank-amount"><fmt:formatNumber value="${order.totalPayment}" maxFractionDigits="0"/>đ</span>
                                <button class="copy-btn" onclick="copyText('${formattedAmount}', 'Số tiền')">
                                    <i class="fa-regular fa-copy"></i> Copy
                                </button>
                            </div>
                        </div>
                        <div class="copy-row">
                            <span class="info-label">Nội dung CK:</span>
                            <div style="display:flex; align-items:center; gap:8px;">
                                <span class="info-value" style="color: var(--primary-hover);" id="bank-desc">GS${order.saleOrderId}</span>
                                <button class="copy-btn" onclick="copyText('GS${order.saleOrderId}', 'Nội dung chuyển khoản')">
                                    <i class="fa-regular fa-copy"></i> Copy
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- ACTIONS BUTTONS -->
            <div class="actions-group">
                <a href="${pageContext.request.contextPath}/products" class="btn-primary-custom">
                    <i class="fa-solid fa-basket-shopping"></i> Tiếp tục mua sắm
                </a>
                <a href="${pageContext.request.contextPath}/home" class="btn-outline-custom">
                    <i class="fa-solid fa-house"></i> Quay về trang chủ
                </a>
            </div>
        </div>
    </div>

    <!-- TOAST NOTIFICATION FOR COPY -->
    <div class="toast-copy" id="copy-toast">
        <i class="fa-solid fa-circle-check" style="color: var(--primary);"></i>
        <span id="toast-message">Đã sao chép vào bộ nhớ tạm!</span>
    </div>

    <!-- FOOTER -->
    <%@include file="../common/footer.jsp" %>

    <!-- CONFETTI EFFECT SCRIPT -->
    <script>
        // Set dynamic local time for the order placement
        const now = new Date();
        const timeString = now.toLocaleTimeString('vi-VN', { hour: '2-digit', minute: '2-digit' }) + ' - ' + now.toLocaleDateString('vi-VN');
        document.getElementById('orderTime').innerText = timeString;

        // Copy Clipboard Helper
        function copyText(text, label) {
            navigator.clipboard.writeText(text).then(function() {
                showToast("Đã sao chép " + label + " thành công!");
            }, function(err) {
                console.error('Không thể sao chép: ', err);
            });
        }

        function showToast(message) {
            const toast = document.getElementById("copy-toast");
            document.getElementById("toast-message").innerText = message;
            toast.classList.add("show");
            setTimeout(function() {
                toast.classList.remove("show");
            }, 2500);
        }

        // --- CSS-ONLY CONFETTI CANVAS IMPLEMENTATION ---
        (function() {
            const canvas = document.getElementById('confetti-canvas');
            const ctx = canvas.getContext('2d');
            let width = canvas.width = canvas.offsetWidth;
            let height = canvas.height = canvas.offsetHeight;
            
            window.addEventListener('resize', () => {
                width = canvas.width = canvas.offsetWidth;
                height = canvas.height = canvas.offsetHeight;
            });

            const colors = ['#10B981', '#F59E0B', '#3B82F6', '#EF4444', '#EC4899'];
            const pieces = [];

            class Piece {
                constructor() {
                    this.x = Math.random() * width;
                    this.y = Math.random() * -height - 20;
                    this.rotation = Math.random() * 360;
                    this.rotationSpeed = Math.random() * 10 - 5;
                    this.color = colors[Math.floor(Math.random() * colors.length)];
                    this.width = Math.random() * 8 + 6;
                    this.height = Math.random() * 12 + 8;
                    this.speed = Math.random() * 3 + 2;
                }

                update() {
                    this.y += this.speed;
                    this.rotation += this.rotationSpeed;
                }

                draw() {
                    ctx.save();
                    ctx.translate(this.x + this.width / 2, this.y + this.height / 2);
                    ctx.rotate(this.rotation * Math.PI / 180);
                    ctx.fillStyle = this.color;
                    ctx.fillRect(-this.width / 2, -this.height / 2, this.width, this.height);
                    ctx.restore();
                }
            }

            // Generate initial particles
            for (let i = 0; i < 80; i++) {
                pieces.push(new Piece());
            }

            function animate() {
                ctx.clearRect(0, 0, width, height);
                let alive = false;
                pieces.forEach(p => {
                    p.update();
                    p.draw();
                    if (p.y < height) {
                        alive = true;
                    }
                });
                
                if (alive) {
                    requestAnimationFrame(animate);
                } else {
                    ctx.clearRect(0, 0, width, height);
                }
            }

            // Start animation delay slightly
            setTimeout(animate, 200);
        })();
    </script>
</body>
</html>

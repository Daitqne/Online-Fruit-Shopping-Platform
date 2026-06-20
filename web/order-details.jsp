<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng - GreenStock</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
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
            --slate-400: #94A3B8;
            --slate-600: #475569;
            --white: #FFFFFF;
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
            --font-display: 'Outfit', sans-serif;
            --font-body: 'Plus Jakarta Sans', sans-serif;
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

        /* --- HEADER & NAVIGATION --- */
        header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border-bottom: 1px solid rgba(226, 232, 240, 0.8);
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-family: var(--font-display);
            font-size: 1.6rem;
            font-weight: 800;
            color: var(--primary);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .logo i {
            color: var(--secondary);
        }

        .nav-menu {
            display: flex;
            list-style: none;
            gap: 2rem;
            align-items: center;
        }

        .nav-link {
            text-decoration: none;
            color: var(--slate-600);
            font-weight: 600;
        }

        .nav-actions {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        /* --- USER MENU --- */
        .user-menu {
            position: relative;
            display: flex;
            align-items: center;
        }

        .user-menu-btn {
            background: var(--primary-light);
            color: var(--primary);
            border: none;
            padding: 0.6rem 1.2rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.95rem;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            font-family: var(--font-body);
        }

        .user-dropdown {
            display: none;
            position: absolute;
            top: 100%; 
            right: 0;
            background: var(--white);
            border-radius: 14px;
            box-shadow: var(--shadow-lg);
            border: 1px solid rgba(226, 232, 240, 0.8);
            min-width: 180px;
            overflow: hidden;
            z-index: 999;
        }

        .user-menu:hover .user-dropdown {
            display: block;
        }

        .user-dropdown a {
            display: flex;
            align-items: center;
            gap: 0.6rem;
            padding: 0.75rem 1.2rem;
            color: var(--dark);
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
        }

        .user-dropdown a:hover {
            background: var(--primary-light);
            color: var(--primary);
        }

        .user-dropdown a.logout {
            color: #EF4444;
            border-top: 1px solid rgba(226, 232, 240, 0.8);
        }

        /* --- CONTENT WRAPPER --- */
        .detail-wrapper {
            max-width: 1200px;
            margin: 8rem auto 5rem;
            padding: 0 2rem;
            display: grid;
            grid-template-columns: 1.6fr 1fr;
            gap: 2.5rem;
            width: 100%;
        }

        @media (max-width: 992px) {
            .detail-wrapper {
                grid-template-columns: 1fr;
                margin-top: 6.5rem;
                padding: 0 1rem;
            }
        }

        .detail-header-section {
            grid-column: 1 / -1;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid var(--slate-200);
            padding-bottom: 1.25rem;
            margin-bottom: 0.5rem;
        }

        @media (max-width: 576px) {
            .detail-header-section {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
        }

        .detail-title {
            font-family: var(--font-display);
            font-size: 2rem;
            font-weight: 800;
            color: var(--dark);
        }

        .btn-back-history {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
            color: var(--slate-600);
            font-weight: 700;
            transition: color 0.2s;
            font-size: 0.95rem;
        }

        .btn-back-history:hover {
            color: var(--primary);
        }

        /* --- STATE TIMELINE BAR --- */
        .timeline-card {
            background-color: var(--white);
            border-radius: 20px;
            padding: 2.25rem;
            border: 1px solid var(--slate-200);
            box-shadow: var(--shadow-sm);
            margin-bottom: 2rem;
        }

        .status-timeline {
            display: flex;
            justify-content: space-between;
            position: relative;
            margin-top: 1rem;
        }

        .status-timeline::before {
            content: '';
            position: absolute;
            top: 20px;
            left: 5%;
            right: 5%;
            height: 4px;
            background-color: var(--slate-200);
            z-index: 1;
        }

        .timeline-progress-bar {
            position: absolute;
            top: 20px;
            left: 5%;
            height: 4px;
            background-color: var(--primary);
            z-index: 2;
            transition: width 0.4s ease;
        }

        .timeline-step {
            display: flex;
            flex-direction: column;
            align-items: center;
            z-index: 3;
            width: 20%;
            position: relative;
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
            transition: all 0.3s;
            border: 3px solid var(--white);
            box-shadow: 0 0 0 1px var(--slate-200);
        }

        .timeline-step.active .step-icon {
            background-color: var(--primary);
            color: var(--white);
            box-shadow: 0 0 0 4px var(--primary-light);
        }

        .timeline-step.completed .step-icon {
            background-color: var(--primary);
            color: var(--white);
        }

        .step-label {
            margin-top: 0.75rem;
            font-size: 0.8rem;
            font-weight: 700;
            color: var(--slate-600);
            text-align: center;
        }

        .timeline-step.active .step-label {
            color: var(--primary-hover);
        }

        .timeline-step.completed .step-label {
            color: var(--dark);
        }

        .cancelled-banner {
            background-color: #FEF2F2;
            border: 1px solid #FCA5A5;
            border-radius: 16px;
            padding: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1.25rem;
            color: #DC2626;
        }

        .cancelled-banner i {
            font-size: 2.2rem;
        }

        .cancelled-title {
            font-family: var(--font-display);
            font-size: 1.15rem;
            font-weight: 800;
            margin-bottom: 0.2rem;
        }

        .cancelled-desc {
            font-size: 0.9rem;
            color: #7F1D1D;
        }

        /* --- ORDER DETAILS SECTIONS --- */
        .info-card {
            background-color: var(--white);
            border-radius: 20px;
            padding: 2rem;
            border: 1px solid var(--slate-200);
            box-shadow: var(--shadow-sm);
            margin-bottom: 2rem;
        }

        .info-title {
            font-family: var(--font-display);
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 1.25rem;
            display: flex;
            align-items: center;
            gap: 0.6rem;
            border-bottom: 1px solid var(--slate-100);
            padding-bottom: 0.75rem;
        }

        .info-title i {
            color: var(--primary);
        }

        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        @media (max-width: 576px) {
            .info-grid {
                grid-template-columns: 1fr;
            }
        }

        .info-block h4 {
            font-size: 0.85rem;
            text-transform: uppercase;
            color: var(--slate-600);
            letter-spacing: 0.05em;
            margin-bottom: 0.4rem;
        }

        .info-block p {
            font-size: 0.95rem;
            color: var(--dark);
            font-weight: 600;
        }

        /* --- ITEMS TABLE --- */
        .item-row {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem 0;
            border-bottom: 1px solid var(--slate-100);
        }

        .item-row:last-child {
            border-bottom: none;
        }

        .item-img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 12px;
            background-color: var(--slate-100);
        }

        .item-main {
            flex: 1;
        }

        .item-name {
            font-weight: 700;
            color: var(--dark);
            font-size: 0.95rem;
        }

        .item-meta {
            font-size: 0.85rem;
            color: var(--slate-600);
        }

        .item-price {
            font-weight: 700;
            color: var(--dark);
            text-align: right;
            font-size: 0.95rem;
        }

        /* --- SIDEBAR SUMMARY --- */
        .sidebar-card {
            background-color: var(--white);
            border-radius: 20px;
            padding: 2rem;
            border: 1px solid var(--slate-200);
            box-shadow: var(--shadow-sm);
            position: sticky;
            top: 7rem;
        }

        .summary-title {
            font-family: var(--font-display);
            font-size: 1.25rem;
            font-weight: 800;
            color: var(--dark);
            margin-bottom: 1.25rem;
        }

        .price-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.75rem;
            font-size: 0.95rem;
            color: var(--slate-600);
        }

        .price-row.total {
            border-top: 1px dashed var(--slate-200);
            padding-top: 1rem;
            margin-top: 1rem;
            font-weight: 800;
            color: var(--dark);
            font-size: 1.15rem;
        }

        .price-row.total .total-val {
            color: var(--primary);
            font-family: var(--font-display);
            font-size: 1.3rem;
        }

        /* --- BUTTONS --- */
        .btn-cancel-order {
            display: block;
            width: 100%;
            background-color: #FEF2F2;
            color: #DC2626;
            border: 1px solid #FCA5A5;
            padding: 1rem;
            border-radius: 14px;
            font-family: var(--font-body);
            font-weight: 700;
            font-size: 1rem;
            cursor: pointer;
            text-align: center;
            transition: all 0.2s;
            margin-top: 1.5rem;
        }

        .btn-cancel-order:hover {
            background-color: #FEE2E2;
            transform: translateY(-1px);
        }

        .btn-cancel-order:active {
            transform: translateY(0);
        }

        /* --- ALERTS --- */
        .alert {
            padding: 1rem 1.25rem;
            border-radius: 12px;
            font-size: 0.9rem;
            font-weight: 500;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .alert-success {
            background-color: var(--primary-light);
            border: 1px solid var(--primary);
            color: var(--primary-hover);
        }

        .alert-error {
            background-color: #FEF2F2;
            border: 1px solid #FCA5A5;
            color: #DC2626;
        }

        /* --- FOOTER --- */
        footer {
            background-color: var(--dark);
            color: var(--white);
            padding: 5rem 2rem 2rem;
            font-size: 0.95rem;
            margin-top: auto;
        }

        .footer-container {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 2fr 1fr 1.5fr;
            gap: 4rem;
            margin-bottom: 4rem;
        }

        .footer-logo {
            font-family: var(--font-display);
            font-size: 1.8rem;
            font-weight: 800;
            color: var(--primary);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .footer-logo i {
            color: var(--secondary);
        }

        .footer-column h3 {
            font-family: var(--font-display);
            font-size: 1.2rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            position: relative;
        }

        .footer-bottom {
            max-width: 1200px;
            margin: 0 auto;
            padding-top: 2rem;
            border-top: 1px solid rgba(255, 255, 255, 0.08);
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: var(--slate-400);
            font-size: 0.85rem;
        }
    </style>
</head>
<body>

    <!-- HEADER -->
    <header>
        <div class="nav-container">
            <a href="home" class="logo">
                <i class="fa-solid fa-leaf"></i> GreenStock
            </a>
            
            <ul class="nav-menu">
                <li><a href="home" class="nav-link">Trang chủ</a></li>
                <li><a href="products" class="nav-link">Sản phẩm</a></li>
                <li><a href="#" class="nav-link">Giới thiệu</a></li>
                <li><a href="#" class="nav-link">Liên hệ</a></li>
            </ul>
            
            <div class="nav-actions">
                <a href="cart" style="color: var(--primary); font-size: 1.25rem; position: relative;">
                    <i class="fa-solid fa-cart-shopping"></i>
                    <span style="position: absolute; top: -8px; right: -10px; background: var(--secondary); color: var(--white); border-radius: 50%; font-size: 0.7rem; width: 18px; height: 18px; display: flex; align-items: center; justify-content: center; font-weight: 700;">
                        ${sessionScope.cartCount != null ? sessionScope.cartCount : 0}
                    </span>
                </a>
                
                <div class="user-menu">
                    <button class="user-menu-btn">
                        <i class="fa-solid fa-circle-user"></i>
                        Xin chào, ${sessionScope.user.fullName}
                        <i class="fa-solid fa-chevron-down" style="font-size:0.75rem;"></i>
                    </button>
                    <div class="user-dropdown">
                        <a href="profile"><i class="fa-solid fa-user"></i> Tài khoản</a>
                        <a href="orders"><i class="fa-solid fa-bag-shopping"></i> Đơn hàng</a>
                        <a href="logout" class="logout"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
                    </div>
                </div>
            </div>
        </div>
    </header>

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
                            <p>${order.paymentMethod == 'COD' ? 'Thanh toán khi nhận hàng (COD)' : 'Chuyển khoản ngân hàng'}</p>
                        </div>
                        <div class="info-block">
                            <h4>Trạng thái thanh toán</h4>
                            <p style="display:flex; align-items:center; gap: 0.4rem; font-size: 0.9rem;">
                                <c:choose>
                                    <c:when test="${order.paymentStatus == 'Paid'}">
                                        <span class="status-badge pay-paid" style="padding: 0.2rem 0.5rem;"><i class="fa-solid fa-circle-check"></i> Đã thanh toán</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge pay-pending" style="padding: 0.2rem 0.5rem;"><i class="fa-solid fa-clock"></i> Chưa thanh toán</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>
                </div>
                
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

                <!-- NÚT HỦY ĐƠN HÀNG (CHỈ KHI TRẠNG THÁI LÀ PENDING) -->
                <c:if test="${order.orderStatus == 'Pending'}">
                    <button type="button" class="btn-cancel-order" onclick="confirmCancelOrder(${order.saleOrderId})">
                        <i class="fa-solid fa-circle-xmark"></i> Hủy đơn hàng này
                    </button>
                </c:if>
            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <footer>
        <div class="footer-container">
            <div class="footer-column">
                <div class="footer-logo">
                    <i class="fa-solid fa-leaf"></i> GreenStock
                </div>
                <p class="footer-desc">Cung cấp nguồn dinh dưỡng sạch tự nhiên và an tâm trọn vẹn.</p>
            </div>
            <div class="footer-column">
                <h3>Khám phá</h3>
                <ul class="footer-links">
                    <li><a href="home" style="color:var(--slate-300); text-decoration:none;">Trang chủ</a></li>
                    <li><a href="products" style="color:var(--slate-300); text-decoration:none;">Sản phẩm</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>Chính sách</h3>
                <p style="color:var(--slate-300);">Bảo vệ sức khỏe và quyền lợi của người tiêu dùng.</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2026 GreenStock. All rights reserved.</p>
        </div>
    </footer>

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

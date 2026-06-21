<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử đơn hàng - GreenStock</title>
    
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
            transition: all 0.3s ease;
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
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-4px); }
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
            transition: color 0.2s ease;
        }

        .nav-link:hover {
            color: var(--primary);
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

        .user-menu-btn:hover {
            background: var(--primary);
            color: var(--white);
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
            animation: fadeIn 0.2s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-6px); }
            to   { opacity: 1; transform: translateY(0); }
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
            transition: background 0.2s ease;
        }

        .user-dropdown a:hover {
            background: var(--primary-light);
            color: var(--primary);
        }

        .user-dropdown a.logout {
            color: #EF4444;
            border-top: 1px solid rgba(226, 232, 240, 0.8);
        }

        .user-dropdown a.logout:hover {
            background: #FEF2F2;
            color: #DC2626;
        }

        /* --- CONTENT WRAPPER --- */
        .orders-wrapper {
            max-width: 1200px;
            margin: 8rem auto 5rem;
            padding: 0 2rem;
            width: 100%;
        }

        @media (max-width: 768px) {
            .orders-wrapper {
                margin-top: 6.5rem;
                padding: 0 1rem;
            }
        }

        .orders-header {
            margin-bottom: 2rem;
        }

        .orders-title {
            font-family: var(--font-display);
            font-size: 2.2rem;
            font-weight: 800;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .orders-title i {
            color: var(--primary);
        }

        .orders-subtitle {
            color: var(--slate-600);
            font-size: 0.95rem;
            margin-top: 0.25rem;
        }

        /* --- ORDERS TABLE --- */
        .orders-card {
            background: var(--white);
            border-radius: 24px;
            padding: 2rem;
            box-shadow: var(--shadow-sm);
            border: 1px solid var(--slate-200);
            overflow-x: auto;
        }

        @media (max-width: 576px) {
            .orders-card {
                padding: 1rem;
            }
        }

        .orders-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        .orders-table th {
            padding: 1.2rem 1rem;
            font-weight: 700;
            color: var(--slate-600);
            border-bottom: 2px solid var(--slate-100);
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .orders-table td {
            padding: 1.25rem 1rem;
            border-bottom: 1px solid var(--slate-100);
            font-size: 0.95rem;
            vertical-align: middle;
        }

        .orders-table tr:last-child td {
            border-bottom: none;
        }

        .order-id {
            font-weight: 700;
            color: var(--primary);
            text-decoration: none;
        }

        .order-id:hover {
            color: var(--primary-hover);
        }

        .order-date {
            color: var(--slate-600);
            font-weight: 500;
        }

        .order-price {
            font-weight: 700;
            color: var(--dark);
        }

        /* --- STATUS BADGES --- */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            font-size: 0.8rem;
            font-weight: 700;
            padding: 0.35rem 0.75rem;
            border-radius: 50px;
        }

        /* Order Statuses */
        .status-pending {
            background-color: #FEF3C7;
            color: #D97706;
        }
        .status-processing {
            background-color: #DBEAFE;
            color: #2563EB;
        }
        .status-shipped {
            background-color: #E0F2FE;
            color: #0284C7;
        }
        .status-delivered {
            background-color: var(--primary-light);
            color: var(--primary-hover);
        }
        .status-cancelled {
            background-color: #FEE2E2;
            color: #DC2626;
        }

        /* Payment Statuses */
        .pay-pending {
            background-color: #F1F5F9;
            color: #475569;
        }
        .pay-paid {
            background-color: var(--primary-light);
            color: var(--primary-hover);
        }

        .btn-view-detail {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            background-color: var(--slate-100);
            color: var(--dark);
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 10px;
            font-weight: 700;
            font-size: 0.85rem;
            transition: all 0.2s;
            border: 1px solid var(--slate-200);
        }

        .btn-view-detail:hover {
            background-color: var(--primary);
            color: var(--white);
            border-color: var(--primary);
        }

        /* --- EMPTY STATE --- */
        .empty-orders {
            text-align: center;
            padding: 4rem 2rem;
        }

        .empty-orders i {
            font-size: 3.5rem;
            color: var(--slate-300);
            margin-bottom: 1.5rem;
            display: block;
        }

        .empty-orders h2 {
            font-family: var(--font-display);
            font-size: 1.6rem;
            font-weight: 800;
            color: var(--dark);
            margin-bottom: 0.5rem;
        }

        .empty-orders p {
            color: var(--slate-600);
            margin-bottom: 2rem;
            font-size: 0.95rem;
        }

        .btn-shop-now {
            display: inline-block;
            background-color: var(--primary);
            color: var(--white);
            border: none;
            padding: 0.8rem 2rem;
            border-radius: 12px;
            font-weight: 700;
            text-decoration: none;
            transition: background-color 0.2s;
            box-shadow: 0 4px 10px rgba(16, 185, 129, 0.2);
        }

        .btn-shop-now:hover {
            background-color: var(--primary-hover);
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

        @media (max-width: 768px) {
            .footer-container {
                grid-template-columns: 1fr 1fr;
                gap: 2rem;
            }
        }

        @media (max-width: 480px) {
            .footer-container {
                grid-template-columns: 1fr;
            }
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

        .footer-desc {
            color: var(--slate-300);
            margin-bottom: 1.5rem;
        }

        .footer-column h3 {
            font-family: var(--font-display);
            font-size: 1.2rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            position: relative;
        }

        .footer-column h3::after {
            content: '';
            position: absolute;
            width: 35px;
            height: 2px;
            bottom: -6px;
            left: 0;
            background-color: var(--primary);
        }

        .footer-links {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 0.8rem;
        }

        .footer-links a {
            color: var(--slate-300);
            text-decoration: none;
            transition: color 0.2s ease;
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
                
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
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
                    </c:when>
                    <c:otherwise>
                        <a href="login" class="user-menu-btn" style="text-decoration: none;"><i class="fa-solid fa-right-to-bracket"></i> Đăng nhập</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>

    <!-- MAIN LỊCH SỬ ĐƠN HÀNG -->
    <div class="orders-wrapper">
        <div class="orders-header">
            <h1 class="orders-title">
                <i class="fa-solid fa-box-open"></i> Lịch sử đơn hàng
            </h1>
            <p class="orders-subtitle">Quản lý và xem lại tất cả các đơn hàng bạn đã mua tại GreenStock.</p>
        </div>

        <div class="orders-card">
            <c:choose>
                <c:when test="${not empty orders}">
                    <table class="orders-table">
                        <thead>
                            <tr>
                                <th>Mã đơn hàng</th>
                                <th>Ngày đặt</th>
                                <th>Thanh toán</th>
                                <th>Trạng thái</th>
                                <th>Tổng tiền</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${orders}" var="ord">
                                <tr>
                                    <td>
                                        <a href="orders?action=detail&id=${ord.saleOrderId}" class="order-id">
                                            #${ord.saleOrderId}
                                        </a>
                                    </td>
                                    <td class="order-date">
                                        <fmt:formatDate value="${ord.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${ord.paymentStatus == 'Paid'}">
                                                <span class="status-badge pay-paid">
                                                    <i class="fa-solid fa-circle-check"></i> Đã thanh toán
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge pay-pending">
                                                    <i class="fa-solid fa-clock"></i> Chưa thanh toán
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${ord.orderStatus == 'Pending'}">
                                                <span class="status-badge status-pending">
                                                    <i class="fa-solid fa-circle-notch fa-spin"></i> Chờ xử lý
                                                </span>
                                            </c:when>
                                            <c:when test="${ord.orderStatus == 'Processing'}">
                                                <span class="status-badge status-processing">
                                                    <i class="fa-solid fa-gears"></i> Đang xử lý
                                                </span>
                                            </c:when>
                                            <c:when test="${ord.orderStatus == 'Shipped'}">
                                                <span class="status-badge status-shipped">
                                                    <i class="fa-solid fa-truck-fast"></i> Đang giao hàng
                                                </span>
                                            </c:when>
                                            <c:when test="${ord.orderStatus == 'Delivered'}">
                                                <span class="status-badge status-delivered">
                                                    <i class="fa-solid fa-circle-check"></i> Đã giao thành công
                                                </span>
                                            </c:when>
                                            <c:when test="${ord.orderStatus == 'Cancelled'}">
                                                <span class="status-badge status-cancelled">
                                                    <i class="fa-solid fa-circle-xmark"></i> Đã hủy đơn
                                                </span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td class="order-price">
                                        <fmt:formatNumber value="${ord.totalPayment}" maxFractionDigits="0"/>đ
                                    </td>
                                    <td>
                                        <a href="orders?action=detail&id=${ord.saleOrderId}" class="btn-view-detail">
                                            <i class="fa-solid fa-eye"></i> Xem chi tiết
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                
                <c:otherwise>
                    <!-- Empty Orders State -->
                    <div class="empty-orders">
                        <i class="fa-solid fa-basket-shopping"></i>
                        <h2>Bạn chưa đặt đơn hàng nào!</h2>
                        <p>Hãy bắt đầu mua sắm những trái cây hữu cơ tươi ngon của GreenStock ngay hôm nay.</p>
                        <a href="products" class="btn-shop-now">Mua sắm ngay</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- FOOTER -->
    <footer>
        <div class="footer-container">
            <div class="footer-column">
                <div class="footer-logo">
                    <i class="fa-solid fa-leaf"></i> GreenStock
                </div>
                <p class="footer-desc">Trái cây sạch hữu cơ tốt cho sức khỏe gia đình bạn.</p>
            </div>
            <div class="footer-column">
                <h3>Liên kết nhanh</h3>
                <ul class="footer-links">
                    <li><a href="home">Trang chủ</a></li>
                    <li><a href="products">Sản phẩm</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>Liên hệ</h3>
                <ul class="footer-links" style="color: var(--slate-300);">
                    <li><i class="fa-solid fa-location-dot"></i> Khu Công Nghệ Cao, Quận 9, TP. HCM</li>
                    <li><i class="fa-solid fa-phone"></i> +84 999 999 999</li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2026 GreenStock. All rights reserved.</p>
        </div>
    </footer>

</body>
</html>

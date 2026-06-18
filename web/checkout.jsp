<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán đơn hàng - GreenStock</title>
    
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
            overflow-x: hidden;
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

        /* --- CHECKOUT LAYOUT --- */
        .checkout-wrapper {
            max-width: 1200px;
            margin: 8rem auto 5rem;
            padding: 0 2rem;
            display: grid;
            grid-template-columns: 1.6fr 1fr;
            gap: 2.5rem;
            align-items: start;
        }

        @media (max-width: 992px) {
            .checkout-wrapper {
                grid-template-columns: 1fr;
                margin-top: 6.5rem;
            }
        }

        .checkout-title {
            grid-column: 1 / -1;
            font-family: var(--font-display);
            font-size: 2.2rem;
            font-weight: 800;
            color: var(--dark);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .checkout-title i {
            color: var(--primary);
        }

        .checkout-section {
            background: var(--white);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: var(--shadow-sm);
            border: 1px solid var(--slate-200);
            margin-bottom: 2rem;
        }

        .section-title {
            font-family: var(--font-display);
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            border-bottom: 2px solid var(--slate-100);
            padding-bottom: 0.75rem;
        }

        .section-title i {
            color: var(--primary);
        }

        /* --- ADDRESS SELECTION --- */
        .address-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 1.25rem;
            margin-bottom: 1.5rem;
        }

        .address-card {
            border: 2px solid var(--slate-200);
            border-radius: 16px;
            padding: 1.25rem;
            cursor: pointer;
            position: relative;
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            gap: 1rem;
            align-items: flex-start;
        }

        .address-card:hover {
            border-color: var(--slate-300);
            background-color: var(--slate-100);
        }

        .address-card.active {
            border-color: var(--primary);
            background-color: var(--primary-light);
        }

        .address-radio {
            margin-top: 0.25rem;
            accent-color: var(--primary);
            transform: scale(1.15);
        }

        .address-info {
            flex: 1;
        }

        .address-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 0.5rem;
        }

        .address-label {
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            padding: 0.25rem 0.6rem;
            background-color: var(--slate-200);
            color: var(--slate-600);
            border-radius: 6px;
        }

        .address-card.active .address-label {
            background-color: var(--primary);
            color: var(--white);
        }

        .address-default {
            font-size: 0.75rem;
            font-weight: 600;
            padding: 0.25rem 0.6rem;
            background-color: var(--secondary);
            color: var(--white);
            border-radius: 6px;
        }

        .receiver-name {
            font-weight: 700;
            color: var(--dark);
            font-size: 1rem;
        }

        .receiver-phone {
            color: var(--slate-600);
            font-weight: 500;
        }

        .address-details {
            font-size: 0.925rem;
            color: var(--slate-600);
        }

        .no-address-alert {
            padding: 2rem;
            background: #FFFBEB;
            border: 1px dashed var(--secondary);
            border-radius: 16px;
            text-align: center;
            color: #B45309;
            margin-bottom: 1.5rem;
        }

        .no-address-alert i {
            font-size: 2rem;
            margin-bottom: 0.75rem;
        }

        .btn-manage-address {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
            color: var(--primary);
            font-weight: 700;
            font-size: 0.95rem;
            transition: color 0.2s;
        }

        .btn-manage-address:hover {
            color: var(--primary-hover);
        }

        /* --- PROMOTION SECTION --- */
        .coupon-box {
            display: flex;
            gap: 0.75rem;
            margin-bottom: 1.25rem;
        }

        .coupon-input {
            flex: 1;
            padding: 0.8rem 1rem;
            border: 2px solid var(--slate-200);
            border-radius: 12px;
            font-family: var(--font-body);
            font-size: 0.95rem;
            outline: none;
            transition: all 0.2s;
        }

        .coupon-input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.1);
        }

        .btn-apply-coupon {
            background-color: var(--primary);
            color: var(--white);
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 12px;
            font-weight: 700;
            cursor: pointer;
            transition: background-color 0.2s;
            font-family: var(--font-body);
        }

        .btn-apply-coupon:hover {
            background-color: var(--primary-hover);
        }

        .applied-coupon-wrapper {
            background-color: var(--primary-light);
            border: 1px solid var(--primary);
            border-radius: 12px;
            padding: 0.9rem 1.25rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .applied-coupon-info {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            color: var(--primary-hover);
            font-weight: 600;
        }

        .applied-coupon-info i {
            font-size: 1.2rem;
        }

        .btn-remove-coupon {
            color: #EF4444;
            text-decoration: none;
            font-weight: 700;
            font-size: 0.9rem;
            transition: color 0.2s;
        }

        .btn-remove-coupon:hover {
            color: #DC2626;
        }

        .available-promos-title {
            font-size: 0.9rem;
            font-weight: 700;
            color: var(--slate-600);
            margin-bottom: 0.75rem;
        }

        .promos-list {
            display: grid;
            grid-template-columns: 1fr;
            gap: 0.75rem;
        }

        .promo-item {
            background-color: var(--slate-100);
            border-radius: 12px;
            padding: 0.9rem 1.25rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border: 1px solid var(--slate-200);
            transition: border-color 0.2s;
        }

        .promo-item:hover {
            border-color: var(--slate-300);
        }

        .promo-details h5 {
            font-family: var(--font-display);
            font-size: 0.95rem;
            font-weight: 700;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .promo-details h5 span {
            background-color: var(--secondary);
            color: var(--white);
            font-size: 0.7rem;
            padding: 0.15rem 0.4rem;
            border-radius: 4px;
        }

        .promo-details p {
            font-size: 0.825rem;
            color: var(--slate-600);
            margin-top: 0.2rem;
        }

        .btn-select-promo {
            background-color: var(--white);
            color: var(--primary);
            border: 1px solid var(--primary);
            padding: 0.4rem 0.9rem;
            border-radius: 8px;
            font-size: 0.85rem;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s;
        }

        .btn-select-promo:hover {
            background-color: var(--primary);
            color: var(--white);
        }

        /* --- PAYMENT & NOTES --- */
        .payment-options {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        @media (max-width: 576px) {
            .payment-options {
                grid-template-columns: 1fr;
            }
        }

        .payment-card {
            border: 2px solid var(--slate-200);
            border-radius: 14px;
            padding: 1.25rem;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .payment-card:hover {
            border-color: var(--slate-300);
        }

        .payment-card.active {
            border-color: var(--primary);
            background-color: var(--primary-light);
        }

        .payment-card input {
            accent-color: var(--primary);
            transform: scale(1.15);
        }

        .payment-text {
            font-weight: 600;
            color: var(--dark);
            font-size: 0.95rem;
        }

        .payment-desc {
            font-size: 0.8rem;
            color: var(--slate-600);
            margin-top: 0.25rem;
        }

        .bank-info-box {
            display: none;
            background-color: var(--slate-100);
            border: 1px solid var(--slate-200);
            border-radius: 12px;
            padding: 1.25rem;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
        }

        .bank-info-box h5 {
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 0.5rem;
        }

        .bank-info-box p {
            color: var(--slate-600);
            line-height: 1.5;
        }

        .shipper-note-textarea {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 2px solid var(--slate-200);
            border-radius: 12px;
            font-family: var(--font-body);
            font-size: 0.95rem;
            outline: none;
            resize: vertical;
            min-height: 90px;
            transition: border-color 0.2s;
        }

        .shipper-note-textarea:focus {
            border-color: var(--primary);
        }

        /* --- ORDER SUMMARY SIDEBAR --- */
        .summary-sidebar {
            background-color: var(--white);
            border-radius: 24px;
            padding: 2rem;
            box-shadow: var(--shadow-sm);
            border: 1px solid var(--slate-200);
            position: sticky;
            top: 7rem;
        }

        .summary-items {
            max-height: 250px;
            overflow-y: auto;
            margin-bottom: 1.5rem;
            padding-right: 0.5rem;
        }

        .summary-item-row {
            display: flex;
            gap: 1rem;
            align-items: center;
            padding: 0.75rem 0;
            border-bottom: 1px solid var(--slate-100);
        }

        .summary-item-row:last-child {
            border-bottom: none;
        }

        .item-thumb {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 10px;
            background-color: var(--slate-100);
        }

        .item-details {
            flex: 1;
        }

        .item-name {
            font-weight: 600;
            font-size: 0.9rem;
            color: var(--dark);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 150px;
        }

        .item-meta {
            font-size: 0.8rem;
            color: var(--slate-600);
        }

        .item-total-price {
            font-weight: 700;
            color: var(--dark);
            font-size: 0.9rem;
        }

        .price-breakdown {
            border-top: 1px solid var(--slate-200);
            padding-top: 1.25rem;
            margin-bottom: 1.5rem;
        }

        .breakdown-row {
            display: flex;
            justify-content: space-between;
            font-size: 0.95rem;
            color: var(--slate-600);
            margin-bottom: 0.75rem;
        }

        .breakdown-row.total {
            border-top: 1px dashed var(--slate-200);
            padding-top: 1rem;
            font-weight: 800;
            color: var(--dark);
            font-size: 1.2rem;
            margin-bottom: 0;
        }

        .breakdown-row.total .total-price {
            color: var(--primary);
            font-family: var(--font-display);
            font-size: 1.35rem;
        }

        .btn-place-order {
            display: block;
            width: 100%;
            background-color: var(--primary);
            color: var(--white);
            border: none;
            padding: 1.1rem;
            border-radius: 16px;
            font-family: var(--font-body);
            font-weight: 700;
            font-size: 1.1rem;
            cursor: pointer;
            transition: all 0.25s;
            text-align: center;
            box-shadow: 0 4px 14px rgba(16, 185, 129, 0.25);
        }

        .btn-place-order:hover {
            background-color: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(16, 185, 129, 0.35);
        }

        .btn-place-order:active {
            transform: translateY(0);
        }

        .btn-back-to-cart {
            display: block;
            text-align: center;
            text-decoration: none;
            color: var(--slate-600);
            font-size: 0.9rem;
            font-weight: 600;
            margin-top: 1rem;
            transition: color 0.2s;
        }

        .btn-back-to-cart:hover {
            color: var(--dark);
        }

        /* --- ALERTS --- */
        .alert-error {
            background-color: #FEF2F2;
            border: 1px solid #FCA5A5;
            color: #DC2626;
            padding: 1rem 1.25rem;
            border-radius: 12px;
            font-size: 0.9rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-weight: 500;
        }

        .alert-success {
            background-color: var(--primary-light);
            border: 1px solid var(--primary);
            color: var(--primary-hover);
            padding: 1rem 1.25rem;
            border-radius: 12px;
            font-size: 0.9rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-weight: 500;
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
            grid-template-columns: 2fr 1fr 1fr 1.5fr;
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

        .footer-links a:hover {
            color: var(--primary);
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
                                <a href="#"><i class="fa-solid fa-bag-shopping"></i> Đơn hàng</a>
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
                                    <div class="item-meta">SL: ${item.quantity} x <fmt:formatNumber value="${item.product.price}" maxFractionDigits="0"/>đ</div>
                                </div>
                                <div class="item-total-price">
                                    <fmt:formatNumber value="${item.quantity * item.product.price}" maxFractionDigits="0"/>đ
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
    <footer>
        <div class="footer-container">
            <div class="footer-column">
                <div class="footer-logo">
                    <i class="fa-solid fa-leaf"></i> GreenStock
                </div>
                <p class="footer-desc">Hệ thống cung cấp trái cây tươi ngon, hữu cơ chất lượng cao hàng đầu Việt Nam. Cam kết 100% sạch, an toàn cho gia đình bạn.</p>
                <div style="display:flex; gap:1rem;">
                    <a href="#" style="color:white; font-size:1.25rem;"><i class="fa-brands fa-facebook"></i></a>
                    <a href="#" style="color:white; font-size:1.25rem;"><i class="fa-brands fa-instagram"></i></a>
                    <a href="#" style="color:white; font-size:1.25rem;"><i class="fa-brands fa-youtube"></i></a>
                </div>
            </div>
            
            <div class="footer-column">
                <h3>Liên kết nhanh</h3>
                <ul class="footer-links">
                    <li><a href="home">Trang chủ</a></li>
                    <li><a href="products">Sản phẩm</a></li>
                    <li><a href="#">Giới thiệu</a></li>
                    <li><a href="#">Liên hệ</a></li>
                </ul>
            </div>
            
            <div class="footer-column">
                <h3>Chính sách</h3>
                <ul class="footer-links">
                    <li><a href="#">Chính sách giao hàng</a></li>
                    <li><a href="#">Chính sách bảo mật</a></li>
                    <li><a href="#">Điều khoản sử dụng</a></li>
                    <li><a href="#">Chính sách hoàn tiền</a></li>
                </ul>
            </div>
            
            <div class="footer-column">
                <h3>Liên hệ chúng tôi</h3>
                <ul class="footer-links" style="color: var(--slate-300);">
                    <li><i class="fa-solid fa-location-dot"></i> Khu Công Nghệ Cao, Quận 9, TP. HCM</li>
                    <li><i class="fa-solid fa-phone"></i> +84 999 999 999</li>
                    <li><i class="fa-solid fa-envelope"></i> support@greenstock.vn</li>
                </ul>
            </div>
        </div>
        
        <div class="footer-bottom">
            <p>&copy; 2026 GreenStock. All rights reserved.</p>
            <p>Phát triển bởi Nhóm 3 - SWP391</p>
        </div>
    </footer>

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

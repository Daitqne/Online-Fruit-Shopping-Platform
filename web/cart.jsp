<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng - GreenStock</title>
    
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
            position: relative;
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

        /* --- MAIN CONTENT --- */
        .cart-wrapper {
            max-width: 1200px;
            margin: 8rem auto 5rem;
            padding: 0 2rem;
            display: grid;
            grid-template-columns: 2.5fr 1fr;
            gap: 2rem;
        }

        @media (max-width: 992px) {
            .cart-wrapper {
                grid-template-columns: 1fr;
            }
        }

        .cart-title {
            grid-column: 1 / -1;
            font-family: var(--font-display);
            font-size: 2.2rem;
            font-weight: 800;
            color: var(--dark);
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .cart-title i {
            color: var(--primary);
        }

        .cart-list-container {
            background: var(--white);
            border-radius: 24px;
            padding: 2rem;
            box-shadow: var(--shadow-sm);
            border: 1px solid var(--slate-200);
        }

        .cart-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        .cart-table th {
            padding: 1rem;
            font-weight: 700;
            color: var(--slate-600);
            border-bottom: 2px solid var(--slate-200);
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.05em;
        }

        .cart-table td {
            padding: 1.5rem 1rem;
            border-bottom: 1px solid var(--slate-200);
            vertical-align: middle;
        }

        .product-col {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .product-img {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 12px;
            background: #F1F5F9;
        }

        .product-meta h4 {
            font-family: var(--font-display);
            font-size: 1.05rem;
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 0.2rem;
        }

        .product-meta span {
            font-size: 0.75rem;
            background: var(--primary-light);
            color: var(--primary);
            padding: 0.15rem 0.5rem;
            border-radius: 50px;
            font-weight: 700;
        }

        .price-text {
            font-family: var(--font-display);
            font-weight: 700;
            color: var(--dark);
        }

        .total-item-price {
            font-family: var(--font-display);
            font-weight: 800;
            color: var(--primary);
            font-size: 1.05rem;
        }

        /* QTY SELECTOR */
        .qty-selector {
            display: inline-flex;
            align-items: center;
            background: var(--light);
            border: 1px solid var(--slate-300);
            border-radius: 12px;
            padding: 0.2rem;
            gap: 0.5rem;
        }

        .btn-qty-btn {
            background-color: var(--white);
            color: var(--slate-600);
            border: 1px solid var(--slate-200);
            width: 32px;
            height: 32px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
            font-size: 0.85rem;
        }

        .btn-qty-btn:hover {
            background-color: var(--primary-light);
            color: var(--primary);
            border-color: var(--primary);
        }

        .qty-value {
            font-family: var(--font-body);
            font-weight: 700;
            font-size: 1rem;
            min-width: 30px;
            text-align: center;
            color: var(--dark);
        }

        .btn-delete-item {
            color: #EF4444;
            background: #FEF2F2;
            border: 1px solid #FECACA;
            width: 34px;
            height: 34px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            transition: all 0.2s ease;
        }

        .btn-delete-item:hover {
            background: #EF4444;
            color: var(--white);
            transform: scale(1.08);
        }

        /* --- CART SUMMARY SIDEBAR --- */
        .summary-card {
            background: var(--white);
            border-radius: 24px;
            padding: 2rem;
            box-shadow: var(--shadow-sm);
            border: 1px solid var(--slate-200);
            height: fit-content;
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .summary-card h3 {
            font-family: var(--font-display);
            font-size: 1.3rem;
            font-weight: 800;
            color: var(--dark);
            border-bottom: 1px solid var(--slate-200);
            padding-bottom: 0.75rem;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.95rem;
            color: var(--slate-600);
        }

        .summary-row.total {
            font-size: 1.1rem;
            font-weight: 800;
            color: var(--dark);
            border-top: 1px dashed var(--slate-200);
            padding-top: 1.25rem;
        }

        .summary-row.total span.total-price {
            color: var(--primary);
            font-size: 1.4rem;
        }

        .btn-checkout {
            background-color: var(--primary);
            color: var(--white);
            text-decoration: none;
            text-align: center;
            padding: 1rem;
            border-radius: 14px;
            font-weight: 700;
            font-size: 1.05rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.25);
            display: block;
        }

        .btn-checkout:hover {
            background-color: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(16, 185, 129, 0.35);
        }

        .btn-continue-shopping {
            background-color: transparent;
            color: var(--slate-600);
            text-decoration: none;
            text-align: center;
            padding: 0.8rem;
            border: 2px solid var(--slate-200);
            border-radius: 14px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: block;
        }

        .btn-continue-shopping:hover {
            background-color: var(--light);
            color: var(--dark);
            border-color: var(--slate-300);
        }

        /* --- EMPTY CART SCREEN --- */
        .empty-cart {
            text-align: center;
            padding: 5rem 2rem;
            background: var(--white);
            border-radius: 24px;
            border: 1px dashed var(--slate-300);
        }

        .empty-cart i {
            font-size: 5rem;
            color: var(--slate-300);
            margin-bottom: 1.5rem;
        }

        .empty-cart h2 {
            font-family: var(--font-display);
            font-size: 1.8rem;
            color: var(--dark);
            margin-bottom: 0.5rem;
            font-weight: 800;
        }

        .empty-cart p {
            color: var(--slate-600);
            margin-bottom: 2rem;
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
            color: var(--slate-600);
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
                                <a href="#"><i class="fa-solid fa-user"></i> Tài khoản</a>
                                <a href="#"><i class="fa-solid fa-bag-shopping"></i> Đơn hàng</a>
                                <a href="logout" class="logout"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="login" class="btn-login">
                            <i class="fa-solid fa-user"></i> Đăng nhập
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>

    <!-- MAIN WRAPPER -->
    <div class="cart-wrapper">
        <h1 class="cart-title"><i class="fa-solid fa-cart-shopping"></i> Giỏ Hàng Của Bạn</h1>
        
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
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="price-text">
                                            <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
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
                                            <fmt:formatNumber value="${item.quantity * item.product.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
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
                        <span>Giao hàng</span>
                        <span>Miễn phí</span>
                    </div>
                    <div class="summary-row total">
                        <span>Tổng tiền</span>
                        <span class="total-price price-text">
                            <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                        </span>
                    </div>
                    
                    <a href="#" class="btn-checkout">Tiến hành thanh toán</a>
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
    <footer>
        <div class="footer-container">
            <div class="footer-column">
                <div class="footer-logo">
                    <i class="fa-solid fa-leaf"></i> GreenStock
                </div>
                <p class="footer-desc">Nền tảng mua sắm trái cây tươi sạch hàng đầu Việt Nam. Bảo đảm chất lượng 100% hữu cơ tự nhiên.</p>
            </div>
            <div class="footer-column">
                <h3>Liên kết nhanh</h3>
                <ul class="footer-links">
                    <li><a href="home">Trang chủ</a></li>
                    <li><a href="products">Sản phẩm</a></li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2026 GreenStock. Tất cả quyền được bảo lưu.</p>
        </div>
    </footer>

</body>
</html>

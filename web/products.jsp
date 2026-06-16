<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sản phẩm - GreenStock</title>

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
                0%, 100% {
                    transform: translateY(0);
                }
                50% {
                    transform: translateY(-4px);
                }
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

            .nav-link::after {
                content: '';
                position: absolute;
                width: 0;
                height: 2px;
                bottom: -4px;
                left: 0;
                background-color: var(--primary);
                transition: width 0.25s ease;
            }

            .nav-link:hover::after {
                width: 100%;
            }

            .nav-link.active-menu::after {
                width: 100%;
            }

            .nav-link.active-menu {
                color: var(--primary);
            }

            .nav-actions {
                display: flex;
                align-items: center;
                gap: 1.5rem;
            }

            .btn-login {
                background-color: var(--primary);
                color: var(--white);
                text-decoration: none;
                padding: 0.6rem 1.4rem;
                border-radius: 50px;
                font-weight: 600;
                transition: all 0.3s ease;
                box-shadow: 0 4px 10px rgba(16, 185, 129, 0.25);
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .btn-login:hover {
                background-color: var(--primary-hover);
                transform: translateY(-2px);
                box-shadow: 0 6px 15px rgba(16, 185, 129, 0.35);
            }

            /* --- PRODUCTS PAGE BANNER --- */
            .products-banner {
                padding: 8rem 2rem 4rem;
                background: linear-gradient(135deg, #E6F4EA 0%, #FFFFFF 100%);
                text-align: center;
                border-bottom: 1px solid var(--slate-200);
            }

            .products-banner h1 {
                font-family: var(--font-display);
                font-size: 2.5rem;
                font-weight: 800;
                color: var(--dark);
                margin-bottom: 0.5rem;
            }

            .products-banner p {
                color: var(--slate-600);
                max-width: 600px;
                margin: 0 auto;
            }

            /* --- FILTER & SEARCH TOOLBAR --- */
            .toolbar-section {
                padding: 2.5rem 2rem 0;
                max-width: 1200px;
                margin: 0 auto;
            }

            .toolbar-container {
                background: var(--white);
                border-radius: 20px;
                padding: 1.5rem;
                box-shadow: var(--shadow-sm);
                border: 1px solid var(--slate-200);
                display: flex;
                flex-direction: column;
                gap: 1.5rem;
            }

            .search-row {
                display: flex;
                gap: 1rem;
                width: 100%;
            }

            .search-form {
                display: flex;
                width: 100%;
                gap: 0.75rem;
            }

            .search-input-wrapper {
                position: relative;
                flex-grow: 1;
                display: flex;
                align-items: center;
            }

            .search-input-wrapper i {
                position: absolute;
                left: 1.25rem;
                color: var(--slate-400);
                font-size: 1.1rem;
            }

            .search-input {
                width: 100%;
                padding: 0.8rem 1rem 0.8rem 3rem;
                border-radius: 12px;
                border: 1px solid var(--slate-300);
                font-family: var(--font-body);
                font-size: 0.95rem;
                background-color: var(--light);
                outline: none;
                transition: all 0.3s ease;
            }

            .search-input:focus {
                border-color: var(--primary);
                background-color: var(--white);
                box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.15);
            }

            .btn-search {
                background-color: var(--primary);
                color: var(--white);
                border: none;
                padding: 0 1.75rem;
                border-radius: 12px;
                font-family: var(--font-body);
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .btn-search:hover {
                background-color: var(--primary-hover);
            }

            .filter-row {
                display: flex;
                flex-direction: column;
                gap: 0.75rem;
            }

            .filter-label {
                font-size: 0.9rem;
                font-weight: 700;
                color: var(--slate-600);
                text-transform: uppercase;
                letter-spacing: 0.05em;
            }

            .filter-pills {
                display: flex;
                flex-wrap: wrap;
                gap: 0.75rem;
                list-style: none;
            }

            .filter-pill {
                text-decoration: none;
                background-color: var(--light);
                color: var(--slate-600);
                padding: 0.5rem 1.25rem;
                border-radius: 50px;
                font-size: 0.9rem;
                font-weight: 600;
                border: 1px solid var(--slate-300);
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                cursor: pointer;
            }

            .filter-pill:hover {
                background-color: var(--primary-light);
                color: var(--primary);
                border-color: var(--primary);
            }

            .filter-pill.active {
                background-color: var(--primary);
                color: var(--white);
                border-color: var(--primary);
                box-shadow: 0 4px 10px rgba(16, 185, 129, 0.25);
            }

            /* --- PRODUCT GRID SECTION --- */
            .products-section {
                padding: 3rem 2rem 6rem;
                max-width: 1200px;
                margin: 0 auto;
            }

            .product-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 2rem;
            }

            .product-card {
                background: var(--white);
                border-radius: 20px;
                overflow: hidden;
                box-shadow: var(--shadow-sm);
                border: 1px solid rgba(226, 232, 240, 0.8);
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                display: flex;
                flex-direction: column;
                position: relative;
            }

            .product-card:hover {
                transform: translateY(-8px);
                box-shadow: var(--shadow-lg);
                border-color: var(--primary-light);
            }

            .product-image-container {
                width: 100%;
                height: 220px;
                overflow: hidden;
                position: relative;
                background: #F1F5F9;
            }

            .product-image-container img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.5s ease;
            }

            .product-card:hover .product-image-container img {
                transform: scale(1.08);
            }

            .product-category {
                position: absolute;
                top: 1rem;
                left: 1rem;
                background: rgba(255, 255, 255, 0.9);
                backdrop-filter: blur(4px);
                color: var(--primary-hover);
                padding: 0.25rem 0.75rem;
                border-radius: 50px;
                font-size: 0.75rem;
                font-weight: 700;
                box-shadow: var(--shadow-sm);
            }

            .product-info {
                padding: 1.25rem;
                display: flex;
                flex-direction: column;
                flex-grow: 1;
            }

            .product-title {
                font-family: var(--font-display);
                font-size: 1.15rem;
                font-weight: 700;
                color: var(--dark);
                margin-bottom: 0.5rem;
                text-decoration: none;
                transition: color 0.2s ease;
                min-height: 48px;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            .product-title:hover {
                color: var(--primary);
            }

            .product-description {
                font-size: 0.85rem;
                color: var(--slate-600);
                margin-bottom: 1rem;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                min-height: 38px;
            }

            .product-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: auto;
                padding-top: 1rem;
                border-top: 1px solid rgba(241, 245, 249, 0.8);
            }

            .product-price {
                font-family: var(--font-display);
                font-size: 1.2rem;
                font-weight: 800;
                color: var(--primary);
            }

            .btn-add-cart {
                background-color: var(--primary-light);
                color: var(--primary);
                border: none;
                width: 40px;
                height: 40px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                transition: all 0.3s ease;
            }
            .btn-add-cart:hover {
                background-color: var(--primary);
                color: var(--white);
                transform: scale(1.1);
            }

            .btn-action {
                width: 38px;
                height: 38px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                text-decoration: none;
                transition: all 0.3s ease;
                font-size: 0.85rem;
            }
            .btn-edit {
                background-color: #EFF6FF;
                color: #3B82F6;
                border: 1px solid #BFDBFE;
            }
            .btn-edit:hover {
                background-color: #3B82F6;
                color: var(--white);
                transform: scale(1.1);
            }
            .btn-delete {
                background-color: #FEF2F2;
                color: #EF4444;
                border: 1px solid #FECACA;
            }
            .btn-delete:hover {
                background-color: #EF4444;
                color: var(--white);
                transform: scale(1.1);
            }

            /* --- FALLBACK SECTION --- */
            .fallback-section {
                grid-column: span 4;
                text-align: center;
                padding: 5rem 2rem;
                background: var(--white);
                border-radius: 24px;
                border: 1px dashed var(--slate-300);
                box-shadow: var(--shadow-sm);
            }

            .fallback-section i {
                font-size: 4rem;
                color: var(--slate-400);
                margin-bottom: 1.5rem;
            }

            .fallback-section h2 {
                font-family: var(--font-display);
                font-size: 1.8rem;
                color: var(--dark);
                margin-bottom: 0.5rem;
            }

            .fallback-section p {
                color: var(--slate-600);
                margin-bottom: 2rem;
            }

            .btn-reset {
                background-color: var(--primary);
                color: var(--white);
                text-decoration: none;
                padding: 0.75rem 1.75rem;
                border-radius: 12px;
                font-weight: 600;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                transition: all 0.3s ease;
                box-shadow: 0 4px 10px rgba(16, 185, 129, 0.2);
            }

            .btn-reset:hover {
                background-color: var(--primary-hover);
                transform: translateY(-2px);
            }

            /* --- FOOTER --- */
            footer {
                background-color: var(--dark);
                color: var(--white);
                padding: 5rem 2rem 2rem;
                font-size: 0.95rem;
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

            .social-links {
                display: flex;
                gap: 1rem;
            }

            .social-link {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background-color: rgba(255, 255, 255, 0.08);
                color: var(--white);
                display: flex;
                align-items: center;
                justify-content: center;
                text-decoration: none;
                transition: all 0.3s ease;
            }

            .social-link:hover {
                background-color: var(--primary);
                transform: translateY(-3px);
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
                padding-left: 4px;
            }

            .contact-info {
                list-style: none;
                display: flex;
                flex-direction: column;
                gap: 1rem;
                color: var(--slate-300);
            }

            .contact-info li {
                display: flex;
                gap: 0.8rem;
                align-items: flex-start;
            }

            .contact-info i {
                color: var(--primary);
                margin-top: 0.25rem;
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

            .footer-bottom p {
                color: var(--slate-300);
            }

            /* --- RESPONSIVE STYLES --- */
            @media (max-width: 1024px) {
                .product-grid {
                    grid-template-columns: repeat(3, 1fr);
                }
                .footer-container {
                    grid-template-columns: repeat(2, 1fr);
                    gap: 2rem;
                }
            }

            @media (max-width: 768px) {
                .product-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
                .nav-menu {
                    display: none;
                }
                .toolbar-container {
                    padding: 1rem;
                }
            }

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
                top: calc(100% + 10px);
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
                from {
                    opacity: 0;
                    transform: translateY(-6px);
                }
                to   {
                    opacity: 1;
                    transform: translateY(0);
                }
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

            @media (max-width: 480px) {
                .product-grid {
                    grid-template-columns: 1fr;
                }
                .footer-container {
                    grid-template-columns: 1fr;
                }
                .footer-bottom {
                    flex-direction: column;
                    gap: 1rem;
                    text-align: center;
                }
                .search-row {
                    flex-direction: column;
                }
                .btn-search {
                    padding: 0.8rem;
                    justify-content: center;
                }
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
                    <a href="#" style="color: var(--slate-600); font-size: 1.25rem;"><i class="fa-solid fa-magnifying-glass"></i></a>
                    <a href="cart" style="color: var(--slate-600); font-size: 1.25rem; position: relative;">
                        <i class="fa-solid fa-cart-shopping"></i>
                        <span style="position: absolute; top: -8px; right: -10px; background: var(--secondary); color: var(--white); border-radius: 50%; font-size: 0.7rem; width: 18px; height: 18px; display: flex; align-items: center; justify-content: center; font-weight: 700;">${sessionScope.cartCount != null ? sessionScope.cartCount : 0}</span>
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

        <!-- PRODUCTS BANNER -->
        <section class="products-banner">
            <h1>Cửa Hàng Trái Cây Sạch</h1>
            <p>Cung cấp trái cây nhập khẩu thượng hạng và đặc sản vùng miền tươi ngon sạch 100% đạt chuẩn hữu cơ.</p>
        </section>

        <!-- TOOLBAR (SEARCH & FILTERS) -->
        <section class="toolbar-section">
            <div class="toolbar-container">
                <!-- Search bar -->
                <div class="search-row">
                    <form action="products" method="GET" class="search-form">
                        <!-- Preserve category value when searching -->
                        <input type="hidden" name="category" value="${selectedCategory}">
                        <div class="search-input-wrapper">
                            <i class="fa-solid fa-magnifying-glass"></i>
                            <input type="text" name="search" class="search-input" placeholder="Tìm kiếm trái cây tươi ngon..." value="${searchQuery}">
                        </div>
                        <button type="submit" class="btn-search">
                            Tìm kiếm <i class="fa-solid fa-arrow-right"></i>
                        </button>
                    </form>

                    <a href="add-product" class="btn-search" style="background-color: var(--secondary); text-decoration: none; white-space: nowrap;">
                        Thêm sản phẩm <i class="fa-solid fa-plus"></i>
                    </a>
                </div>

                <!-- Categories Filter -->
                <div class="filter-row">
                    <span class="filter-label">Danh mục trái cây:</span>
                    <ul class="filter-pills">
                        <!-- "All" category pill -->
                        <li>
                            <a href="products?category=All&search=${searchQuery}" class="filter-pill ${selectedCategory == 'All' ? 'active' : ''}">
                                Tất cả
                            </a>
                        </li>

                        <!-- Dynamic categories pills -->
                        <c:forEach var="cat" items="${categories}">
                            <li>
                                <a href="products?category=${cat}&search=${searchQuery}" class="filter-pill ${selectedCategory == cat ? 'active' : ''}">
                                    ${cat}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </section>

        <!-- PRODUCTS GRID -->
        <section class="products-section">
            <div class="product-grid">
                <c:choose>
                    <c:when test="${not empty products}">
                        <c:forEach var="p" items="${products}">
                            <div class="product-card">
                                <div class="product-image-container">
                                    <span class="product-category">${p.category}</span>
                                    <img src="${p.image}" alt="${p.name}" loading="lazy">
                                </div>
                                <div class="product-info">
                                    <a href="#" class="product-title">${p.name}</a>
                                    <p class="product-description">${p.description}</p>
                                    <div class="product-footer">
                                        <span class="product-price">
                                            <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                        </span>
                                        <a href="cart?action=add&productId=${p.id}" class="btn-add-cart" title="Thêm vào giỏ hàng" style="text-decoration: none;">
                                            <i class="fa-solid fa-cart-plus"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <!-- Fallback UI if search or category returns empty -->
                        <div class="fallback-section">
                            <i class="fa-solid fa-basket-shopping"></i>
                            <h2>Không tìm thấy sản phẩm</h2>
                            <p>Xin lỗi! Không có sản phẩm nào phù hợp với bộ lọc tìm kiếm hiện tại của bạn.</p>
                            <a href="products" class="btn-reset">
                                <i class="fa-solid fa-rotate-left"></i> Xóa tất cả bộ lọc
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <!-- FOOTER -->
        <footer>
            <div class="footer-container">
                <div class="footer-column">
                    <a href="home" class="footer-logo">
                        <i class="fa-solid fa-leaf"></i> GreenStock
                    </a>
                    <p class="footer-desc">Đơn vị tiên phong cung cấp các giải pháp thực phẩm sạch và trái cây tươi hữu cơ, mang đến bữa ăn an toàn và dinh dưỡng cho mọi gia đình Việt.</p>
                    <div class="social-links">
                        <a href="#" class="social-link"><i class="fa-brands fa-facebook-f"></i></a>
                        <a href="#" class="social-link"><i class="fa-brands fa-instagram"></i></a>
                        <a href="#" class="social-link"><i class="fa-brands fa-tiktok"></i></a>
                        <a href="#" class="social-link"><i class="fa-brands fa-youtube"></i></a>
                    </div>
                </div>

                <div class="footer-column">
                    <h3>Về chúng tôi</h3>
                    <ul class="footer-links">
                        <li><a href="#">Giới thiệu công ty</a></li>
                        <li><a href="#">Hệ thống cửa hàng</a></li>
                        <li><a href="#">Tuyển dụng</a></li>
                        <li><a href="#">Tin tức & Sự kiện</a></li>
                    </ul>
                </div>

                <div class="footer-column">
                    <h3>Chính sách mua bán</h3>
                    <ul class="footer-links">
                        <li><a href="#">Chính sách giao nhận</a></li>
                        <li><a href="#">Chính sách đổi trả hàng</a></li>
                        <li><a href="#">Chính sách bảo mật</a></li>
                        <li><a href="#">Hướng dẫn thanh toán</a></li>
                    </ul>
                </div>

                <div class="footer-column">
                    <h3>Liên hệ & Hỗ trợ</h3>
                    <ul class="contact-info">
                        <li>
                            <i class="fa-solid fa-location-dot"></i>
                            <span>Khu Công nghệ cao Hòa Lạc, Thạch Thất, Hà Nội, Việt Nam</span>
                        </li>
                        <li>
                            <i class="fa-solid fa-phone"></i>
                            <span>Hotline: 1900 8198</span>
                        </li>
                        <li>
                            <i class="fa-solid fa-envelope"></i>
                            <span>support@greenstock.vn</span>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="footer-bottom">
                <p>&copy; 2026 GreenStock. All rights reserved. Designed with ❤️ for healthy living.</p>
                <div style="display: flex; gap: 1.5rem;">
                    <a href="#" style="color: var(--slate-300); text-decoration: none;">Điều khoản sử dụng</a>
                    <a href="#" style="color: var(--slate-300); text-decoration: none;">Bảo mật thông tin</a>
                </div>
            </div>
        </footer>

        <script>
            function confirmDelete(productName) {
                return confirm('Bạn có chắc chắn muốn xóa sản phẩm "' + productName + '" không?\nHành động này không thể hoàn tác!');
            }
        </script>

    </body>
</html>

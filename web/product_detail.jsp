<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.name} - GreenStock</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #10B981; --primary-hover: #059669; --primary-light: #E6F4EA;
            --secondary: #F59E0B; --dark: #0F172A; --light: #F8FAFC;
            --slate-200: #E2E8F0; --slate-300: #CBD5E1; --slate-400: #94A3B8;
            --slate-600: #475569; --white: #FFFFFF;
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0/0.05);
            --shadow-md: 0 4px 6px -1px rgb(0 0 0/0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0/0.1);
            --font-display: 'Outfit', sans-serif;
            --font-body: 'Plus Jakarta Sans', sans-serif;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: var(--font-body); background: var(--light); color: var(--dark); }

        /* HEADER */
        header {
            position: fixed; top: 0; left: 0; right: 0; z-index: 1000;
            background: rgba(255,255,255,0.85); backdrop-filter: blur(16px);
            border-bottom: 1px solid rgba(226,232,240,0.8);
        }
        .nav-container {
            max-width: 1200px; margin: 0 auto; padding: 1rem 2rem;
            display: flex; justify-content: space-between; align-items: center;
        }
        .logo { font-family: var(--font-display); font-size: 1.6rem; font-weight: 800; color: var(--primary); text-decoration: none; display: flex; align-items: center; gap: 0.5rem; }
        .logo i { color: var(--secondary); }
        .nav-menu { display: flex; list-style: none; gap: 2rem; align-items: center; }
        .nav-link { text-decoration: none; color: var(--slate-600); font-weight: 600; transition: color 0.2s; }
        .nav-link:hover { color: var(--primary); }
        .nav-actions { display: flex; align-items: center; gap: 1.5rem; }
        .btn-login { background: var(--primary); color: var(--white); text-decoration: none; padding: 0.6rem 1.4rem; border-radius: 50px; font-weight: 600; display: flex; align-items: center; gap: 0.5rem; }
        .user-menu { position: relative; display: flex; align-items: center; }
        .user-menu-btn { background: var(--primary-light); color: var(--primary); border: none; padding: 0.6rem 1.2rem; border-radius: 50px; font-weight: 600; cursor: pointer; display: flex; align-items: center; gap: 0.5rem; font-family: var(--font-body); transition: all 0.3s; }
        .user-menu-btn:hover { background: var(--primary); color: var(--white); }
        .user-dropdown { display: none; position: absolute; top: 100%; right: 0; background: var(--white); border-radius: 14px; box-shadow: var(--shadow-lg); border: 1px solid rgba(226,232,240,0.8); min-width: 180px; overflow: hidden; z-index: 1001; }
        .user-menu:hover .user-dropdown { display: block; }
        .user-dropdown a { display: flex; align-items: center; gap: 0.6rem; padding: 0.75rem 1.2rem; color: var(--dark); text-decoration: none; font-size: 0.9rem; font-weight: 500; transition: background 0.2s; }
        .user-dropdown a:hover { background: var(--primary-light); color: var(--primary); }
        .user-dropdown a.logout { color: #EF4444; border-top: 1px solid rgba(226,232,240,0.8); }
        .user-dropdown a.logout:hover { background: #FEF2F2; color: #DC2626; }

        /* MAIN */
        .page-wrapper { max-width: 1200px; margin: 0 auto; padding: 90px 1.5rem 5rem; }

        /* BREADCRUMB */
        .breadcrumb { display: flex; align-items: center; gap: 0.5rem; font-size: 0.85rem; color: var(--slate-400); margin-bottom: 2rem; }
        .breadcrumb a { color: var(--slate-400); text-decoration: none; transition: color 0.2s; }
        .breadcrumb a:hover { color: var(--primary); }
        .breadcrumb i { font-size: 0.7rem; }

        /* PRODUCT DETAIL */
        .product-detail {
            display: grid; grid-template-columns: 1fr 1fr; gap: 3rem;
            background: var(--white); border-radius: 24px; padding: 2.5rem;
            box-shadow: var(--shadow-sm); border: 1px solid var(--slate-200);
            margin-bottom: 3rem;
        }

        /* IMAGE */
        .product-image-wrap { position: relative; border-radius: 20px; overflow: hidden; background: #F1F5F9; aspect-ratio: 1; }
        .product-image-wrap img { width: 100%; height: 100%; object-fit: cover; }
        .badge-sale {
            position: absolute; top: 1rem; right: 1rem;
            background: #EF4444; color: white; font-size: 0.8rem;
            font-weight: 700; padding: 0.3rem 0.8rem; border-radius: 50px;
        }
        .badge-featured {
            position: absolute; top: 1rem; left: 1rem;
            background: var(--primary); color: white; font-size: 0.75rem;
            font-weight: 700; padding: 0.3rem 0.8rem; border-radius: 50px;
        }

        /* INFO */
        .product-info-wrap { display: flex; flex-direction: column; gap: 1.2rem; }

        .product-category-tag {
            display: inline-flex; align-items: center; gap: 0.4rem;
            background: var(--primary-light); color: var(--primary);
            padding: 0.3rem 0.9rem; border-radius: 50px;
            font-size: 0.8rem; font-weight: 700; width: fit-content;
        }

        .product-name { font-family: var(--font-display); font-size: 2rem; font-weight: 800; line-height: 1.2; }

        .price-block { display: flex; align-items: baseline; gap: 1rem; }
        .price-main { font-family: var(--font-display); font-size: 2rem; font-weight: 800; color: var(--primary); }
        .price-original { font-size: 1rem; color: var(--slate-400); text-decoration: line-through; }
        .price-unit { font-size: 0.9rem; color: var(--slate-600); }

        .divider { border: none; border-top: 1px solid var(--slate-200); }

        .meta-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 0.8rem; }
        .meta-item { background: var(--light); padding: 0.8rem 1rem; border-radius: 12px; }
        .meta-item label { display: block; font-size: 0.75rem; color: var(--slate-400); font-weight: 600; text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 0.2rem; }
        .meta-item span { font-size: 0.95rem; font-weight: 600; color: var(--dark); }

        .product-description { font-size: 0.95rem; color: var(--slate-600); line-height: 1.7; }

        /* QUANTITY & ADD TO CART */
        .qty-cart-row { display: flex; gap: 1rem; align-items: center; }
        .qty-selector {
            display: flex; align-items: center; border: 1px solid var(--slate-300);
            border-radius: 12px; overflow: hidden;
        }
        .qty-btn {
            width: 40px; height: 44px; border: none; background: var(--light);
            font-size: 1.1rem; cursor: pointer; color: var(--slate-600);
            transition: background 0.2s;
        }
        .qty-btn:hover { background: var(--primary-light); color: var(--primary); }
        .qty-input {
            width: 50px; height: 44px; border: none; border-left: 1px solid var(--slate-300);
            border-right: 1px solid var(--slate-300); text-align: center;
            font-family: var(--font-body); font-size: 0.95rem; font-weight: 700;
            outline: none;
        }
        .btn-add-cart {
            flex: 1; background: var(--primary); color: var(--white); border: none;
            padding: 0.75rem 1.5rem; border-radius: 12px; font-family: var(--font-body);
            font-weight: 700; font-size: 0.95rem; cursor: pointer;
            display: flex; align-items: center; justify-content: center; gap: 0.5rem;
            transition: all 0.3s;
        }
        .btn-add-cart:hover { background: var(--primary-hover); transform: translateY(-2px); }
        .btn-buy-now {
            flex: 1; background: var(--secondary); color: var(--white); border: none;
            padding: 0.75rem 1.5rem; border-radius: 12px; font-family: var(--font-body);
            font-weight: 700; font-size: 0.95rem; cursor: pointer;
            display: flex; align-items: center; justify-content: center; gap: 0.5rem;
            transition: all 0.3s; text-decoration: none;
        }
        .btn-buy-now:hover { opacity: 0.9; transform: translateY(-2px); }

        /* STATUS BADGE */
        .status-available { color: var(--primary); font-weight: 700; font-size: 0.9rem; }
        .status-featured   { color: var(--secondary); font-weight: 700; font-size: 0.9rem; }
        .status-out        { color: #EF4444; font-weight: 700; font-size: 0.9rem; }

        /* RELATED PRODUCTS */
        .section-title {
            font-family: var(--font-display); font-size: 1.5rem; font-weight: 800;
            margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.5rem;
        }
        .section-title i { color: var(--primary); }

        .related-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 1.5rem; }

        .product-card {
            background: var(--white); border-radius: 20px; overflow: visible;
            box-shadow: var(--shadow-sm); border: 1px solid rgba(226,232,240,0.8);
            transition: all 0.3s; display: flex; flex-direction: column;
        }
        .product-card:hover { transform: translateY(-6px); box-shadow: var(--shadow-lg); }
        .product-card-img { width: 100%; height: 180px; overflow: hidden; border-radius: 20px 20px 0 0; background: #F1F5F9; position: relative; }
        .product-card-img img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.4s; }
        .product-card:hover .product-card-img img { transform: scale(1.06); }
        .product-card-body { padding: 1rem; display: flex; flex-direction: column; flex-grow: 1; }
        .product-card-name { font-family: var(--font-display); font-weight: 700; font-size: 1rem; margin-bottom: 0.4rem; text-decoration: none; color: var(--dark); }
        .product-card-name:hover { color: var(--primary); }
        .product-card-price { font-family: var(--font-display); font-weight: 800; color: var(--primary); font-size: 1.05rem; margin-top: auto; }

        /* RESPONSIVE */
        @media (max-width: 768px) {
            .product-detail { grid-template-columns: 1fr; gap: 1.5rem; }
            .related-grid { grid-template-columns: repeat(2, 1fr); }
            .nav-menu { display: none; }
        }
        @media (max-width: 480px) {
            .related-grid { grid-template-columns: 1fr; }
            .qty-cart-row { flex-direction: column; }
        }
    </style>
</head>
<body>

    <!-- HEADER -->
    <header>
        <div class="nav-container">
            <a href="home" class="logo"><i class="fa-solid fa-leaf"></i> GreenStock</a>
            <ul class="nav-menu">
                <li><a href="home" class="nav-link">Trang chủ</a></li>
                <li><a href="products" class="nav-link">Sản phẩm</a></li>
                <li><a href="#" class="nav-link">Giới thiệu</a></li>
                <li><a href="#" class="nav-link">Liên hệ</a></li>
            </ul>
            <div class="nav-actions">
                <a href="cart" style="color:var(--slate-600);font-size:1.25rem;position:relative;text-decoration:none;">
                    <i class="fa-solid fa-cart-shopping"></i>
                    <span style="position:absolute;top:-8px;right:-10px;background:var(--secondary);color:white;border-radius:50%;font-size:0.7rem;width:18px;height:18px;display:flex;align-items:center;justify-content:center;font-weight:700;">
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
                        <a href="login" class="btn-login"><i class="fa-solid fa-user"></i> Đăng nhập</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>

    <div class="page-wrapper">

        <!-- BREADCRUMB -->
        <div class="breadcrumb">
            <a href="home">Trang chủ</a>
            <i class="fa-solid fa-chevron-right"></i>
            <a href="products">Sản phẩm</a>
            <i class="fa-solid fa-chevron-right"></i>
            <span style="color:var(--dark);font-weight:600;">${product.name}</span>
        </div>

        <!-- PRODUCT DETAIL -->
        <div class="product-detail">

            <!-- ẢNH SẢN PHẨM -->
            <div class="product-image-wrap">
                <img src="${product.image}" alt="${product.name}"
                     onerror="this.src='https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?auto=format&fit=crop&q=80&w=600'">
                <c:if test="${product.discountPrice > 0}">
                    <span class="badge-sale">SALE</span>
                </c:if>
                <c:if test="${product.featured}">
                    <span class="badge-featured"><i class="fa-solid fa-star"></i> Nổi bật</span>
                </c:if>
            </div>

            <!-- THÔNG TIN SẢN PHẨM -->
            <div class="product-info-wrap">

                <span class="product-category-tag">
                    <i class="fa-solid fa-tag"></i> ${product.category}
                </span>

                <h1 class="product-name">${product.name}</h1>

                <!-- GIÁ -->
                <div class="price-block">
                    <c:choose>
                        <c:when test="${product.discountPrice > 0}">
                            <span class="price-main">
                                <fmt:formatNumber value="${product.discountPrice}" type="number" maxFractionDigits="0"/>đ
                            </span>
                            <span class="price-original">
                                <fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="0"/>đ
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="price-main">
                                <fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="0"/>đ
                            </span>
                        </c:otherwise>
                    </c:choose>
                    <span class="price-unit">/ ${product.unit}</span>
                </div>

                <hr class="divider">

                <!-- THÔNG SỐ -->
                <div class="meta-grid">
                    <div class="meta-item">
                        <label>Xuất xứ</label>
                        <span><i class="fa-solid fa-location-dot" style="color:var(--primary);margin-right:4px;"></i>${not empty product.origin ? product.origin : 'Việt Nam'}</span>
                    </div>
                    <div class="meta-item">
                        <label>Đơn vị</label>
                        <span><i class="fa-solid fa-scale-balanced" style="color:var(--primary);margin-right:4px;"></i>${product.unit}</span>
                    </div>
                    <div class="meta-item">
                        <label>Danh mục</label>
                        <span>${product.category}</span>
                    </div>
                    <div class="meta-item">
                        <label>Tình trạng</label>
                        <c:choose>
                            <c:when test="${product.status == 'Available'}">
                                <span class="status-available"><i class="fa-solid fa-circle-check"></i> Còn hàng</span>
                            </c:when>
                            <c:when test="${product.status == 'Featured'}">
                                <span class="status-featured"><i class="fa-solid fa-star"></i> Nổi bật</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-out"><i class="fa-solid fa-circle-xmark"></i> Hết hàng</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- MÔ TẢ -->
                <c:if test="${not empty product.description}">
                    <p class="product-description">${product.description}</p>
                </c:if>

                <hr class="divider">

                <!-- SỐ LƯỢNG & THÊM GIỎ HÀNG -->
                <div class="qty-cart-row">
                    <div class="qty-selector">
                        <button class="qty-btn" onclick="changeQty(-1)">−</button>
                        <input type="number" id="qty" class="qty-input" value="1" min="1" max="99">
                        <button class="qty-btn" onclick="changeQty(1)">+</button>
                    </div>
                    <button class="btn-add-cart" onclick="addToCart(${product.id})">
                        <i class="fa-solid fa-cart-plus"></i> Thêm vào giỏ
                    </button>
                    <a href="cart" class="btn-buy-now">
                        <i class="fa-solid fa-bolt"></i> Mua ngay
                    </a>
                </div>

            </div>
        </div>

        <!-- SẢN PHẨM LIÊN QUAN -->
        <c:if test="${not empty relatedProducts}">
            <div class="section-title">
                <i class="fa-solid fa-boxes-stacked"></i> Sản phẩm liên quan
            </div>
            <div class="related-grid">
                <c:forEach var="p" items="${relatedProducts}">
                    <div class="product-card">
                        <a href="product-detail?id=${p.id}" class="product-card-img">
                            <img src="${p.image}" alt="${p.name}"
                                 onerror="this.src='https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?auto=format&fit=crop&q=80&w=600'">
                        </a>
                        <div class="product-card-body">
                            <a href="product-detail?id=${p.id}" class="product-card-name">${p.name}</a>
                            <span class="product-card-price">
                                <c:choose>
                                    <c:when test="${p.discountPrice > 0}">
                                        <fmt:formatNumber value="${p.discountPrice}" type="number" maxFractionDigits="0"/>đ/${p.unit}
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:formatNumber value="${p.price}" type="number" maxFractionDigits="0"/>đ/${p.unit}
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>

    </div>

    <script>
        function changeQty(delta) {
            const input = document.getElementById('qty');
            let val = parseInt(input.value) + delta;
            if (val < 1) val = 1;
            if (val > 99) val = 99;
            input.value = val;
        }

        function addToCart(productId) {
            const qty = document.getElementById('qty').value;
            window.location.href = 'cart?action=add&productId=' + productId + '&quantity=' + qty;
        }
    </script>

</body>
</html>

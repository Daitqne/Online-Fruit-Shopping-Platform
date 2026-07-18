<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.name} - GreenStock</title>
    <%@include file="../common/head.jsp" %>
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
        .variant-label-card.active, .packaging-label-card.active {
            border-color: var(--primary) !important;
            background-color: var(--primary-light) !important;
            color: var(--primary) !important;
        }

        /* --- PRODUCT REVIEWS SECTION --- */
        .reviews-section {
            margin-top: 3rem;
            margin-bottom: 3rem;
        }

        .reviews-container {
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 2rem;
            align-items: start;
        }

        @media (max-width: 768px) {
            .reviews-container {
                grid-template-columns: 1fr;
            }
        }

        /* Summary Card */
        .reviews-summary-card {
            background: var(--white);
            border-radius: 20px;
            padding: 2rem;
            text-align: center;
            border: 1px solid var(--slate-200);
            box-shadow: var(--shadow-sm);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 220px;
        }

        .avg-score-big {
            font-family: var(--font-display);
            font-size: 3.5rem;
            font-weight: 800;
            color: var(--primary);
            line-height: 1;
            margin-bottom: 0.5rem;
        }

        .stars-big {
            font-size: 1.25rem;
            color: var(--secondary);
            margin-bottom: 0.5rem;
            display: flex;
            gap: 4px;
        }

        .total-reviews-count {
            font-size: 0.85rem;
            color: var(--slate-600);
            font-weight: 600;
        }

        /* List Card */
        .reviews-list-card {
            background: var(--white);
            border-radius: 20px;
            padding: 2rem;
            border: 1px solid var(--slate-200);
            box-shadow: var(--shadow-sm);
        }

        .reviews-list {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .review-item {
            border-bottom: 1px solid var(--slate-200);
            padding-bottom: 1.5rem;
        }

        .review-item:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }

        .review-item-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 0.75rem;
        }

        .reviewer-avatar {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background-color: var(--primary-light);
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 1.1rem;
            border: 1.5px solid var(--primary);
        }

        .reviewer-info {
            flex-grow: 1;
        }

        .reviewer-name {
            font-weight: 700;
            font-size: 0.95rem;
            color: var(--dark);
        }

        .review-date {
            font-size: 0.8rem;
            color: var(--slate-400);
            margin-top: 0.15rem;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .reviewer-stars {
            color: var(--secondary);
            font-size: 0.9rem;
            display: flex;
            gap: 2px;
        }

        .review-item-body {
            font-size: 0.92rem;
            color: var(--slate-600);
            line-height: 1.6;
            padding-left: 3.5rem;
        }

        @media (max-width: 480px) {
            .review-item-body {
                padding-left: 0;
            }
            .review-item-header {
                flex-wrap: wrap;
            }
            .reviewer-stars {
                width: 100%;
                margin-top: 0.5rem;
                padding-left: 3.5rem;
            }
        }

        /* No Reviews Empty State */
        .no-reviews-state {
            text-align: center;
            padding: 3rem 1rem;
            color: var(--slate-600);
        }

        .no-reviews-state i {
            font-size: 3rem;
            color: var(--slate-400);
            margin-bottom: 1rem;
        }

        .no-reviews-state h4 {
            font-family: var(--font-display);
            font-size: 1.2rem;
            font-weight: 800;
            color: var(--dark);
            margin-bottom: 0.25rem;
        }

        .no-reviews-state p {
            font-size: 0.9rem;
            color: var(--slate-600);
        }
    </style>
</head>
<body>

    <!-- HEADER -->
    <%@include file="../common/header.jsp" %>

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
                <c:if test="${product.discountPrice > 0 && product.discountPrice < product.price}">
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

                <c:if test="${reviewCount > 0}">
                    <div class="product-rating-summary-inline" style="display: flex; align-items: center; gap: 0.5rem; font-size: 0.9rem; margin-top: -0.5rem; margin-bottom: 0.5rem;">
                        <div class="stars-inline" style="color: var(--secondary);">
                            <c:forEach begin="1" end="5" var="i">
                                <c:choose>
                                    <c:when test="${i <= fullStars}">
                                        <i class="fa-solid fa-star"></i>
                                    </c:when>
                                    <c:when test="${i == fullStars + 1 && hasHalfStar}">
                                        <i class="fa-solid fa-star-half-stroke"></i>
                                    </c:when>
                                    <c:when test="${i == fullStars + 1 && roundUp}">
                                        <i class="fa-solid fa-star"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fa-regular fa-star"></i>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>
                        <span style="font-weight: 700; color: var(--dark);"><fmt:formatNumber value="${avgRating}" pattern="#.0"/>/5</span>
                        <span style="color: var(--slate-400);">(<a href="#reviews-section" style="color: var(--primary); text-decoration: none; font-weight: 600;">${reviewCount} đánh giá</a>)</span>
                    </div>
                </c:if>

                <!-- GIÁ -->
                <div class="price-block">
                    <c:choose>
                        <c:when test="${product.discountPrice > 0 && product.discountPrice < product.price}">
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
                            <c:when test="${stockQuantity > 0}">
                                <span class="status-available">
                                    <i class="fa-solid fa-circle-check"></i> 
                                    Còn hàng (${stockQuantity} sản phẩm)
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-out">
                                    <i class="fa-solid fa-circle-xmark"></i> Hết hàng
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- MÔ TẢ -->
                <c:if test="${not empty product.description}">
                    <p class="product-description">${product.description}</p>
                </c:if>

                <!-- BIẾN THỂ TRỌNG LƯỢNG & ĐÓNG GÓI -->
                <c:if test="${not empty weightVariants}">
                    <div style="margin-top: 1rem;">
                        <label style="display:block; font-weight: 700; color: var(--dark); margin-bottom: 0.5rem; font-size: 0.9rem;">Chọn trọng lượng:</label>
                        <div style="display: flex; gap: 0.75rem; flex-wrap: wrap;">
                            <c:forEach var="v" items="${weightVariants}" varStatus="status">
                                <label style="display: flex; align-items: center; gap: 0.4rem; background: var(--slate-100); padding: 0.5rem 1rem; border-radius: 50px; font-weight: 600; cursor: pointer; border: 2px solid transparent; transition: all 0.2s;" class="variant-label-card ${status.first ? 'active' : ''}" onclick="selectWeightVariant(this, ${v.variantId}, ${v.priceAdjustment}, '${v.weightLabel}')">
                                    <input type="radio" name="weightVariant" value="${v.variantId}" ${status.first ? 'checked' : ''} style="display: none;">
                                    ${v.weightLabel} 
                                    <c:if test="${v.priceAdjustment != 0}">
                                        <span style="font-size: 0.8rem; color: var(--primary); font-weight: normal;">
                                            (${v.priceAdjustment > 0 ? '+' : ''}<fmt:formatNumber value="${v.priceAdjustment}" maxFractionDigits="0"/>đ)
                                        </span>
                                    </c:if>
                                </label>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty packagingOptions}">
                    <div style="margin-top: 1rem;">
                        <label style="display:block; font-weight: 700; color: var(--dark); margin-bottom: 0.5rem; font-size: 0.9rem;">Chọn quy cách đóng gói:</label>
                        <div style="display: flex; gap: 0.75rem; flex-wrap: wrap;">
                            <label style="display: flex; align-items: center; gap: 0.4rem; background: var(--slate-100); padding: 0.5rem 1rem; border-radius: 50px; font-weight: 600; cursor: pointer; border: 2px solid transparent; transition: all 0.2s;" class="packaging-label-card active" onclick="selectPackagingOption(this, '', 0)">
                                <input type="radio" name="packagingOption" value="" checked style="display: none;">
                                Mặc định
                            </label>
                            <c:forEach var="k" items="${packagingOptions}">
                                <label style="display: flex; align-items: center; gap: 0.4rem; background: var(--slate-100); padding: 0.5rem 1rem; border-radius: 50px; font-weight: 600; cursor: pointer; border: 2px solid transparent; transition: all 0.2s;" class="packaging-label-card" onclick="selectPackagingOption(this, ${k.packagingId}, ${k.priceAdjustment})">
                                    <input type="radio" name="packagingOption" value="${k.packagingId}" style="display: none;">
                                    ${k.packagingName} 
                                    <c:if test="${k.priceAdjustment != 0}">
                                        <span style="font-size: 0.8rem; color: var(--primary); font-weight: normal;">
                                            (${k.priceAdjustment > 0 ? '+' : ''}<fmt:formatNumber value="${k.priceAdjustment}" maxFractionDigits="0"/>đ)
                                        </span>
                                    </c:if>
                                </label>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>

                <hr class="divider">

                <!-- SỐ LƯỢNG & THÊM GIỎ HÀNG -->
                <c:choose>
                    <c:when test="${stockQuantity > 0}">
                        <div class="qty-cart-row">
                            <div class="qty-selector">
                                <button class="qty-btn" onclick="changeQty(-1)">−</button>
                                <input type="number" id="qty" class="qty-input" value="1" min="1" max="${stockQuantity}">
                                <button class="qty-btn" onclick="changeQty(1)">+</button>
                            </div>
                            <button class="btn-add-cart" onclick="addToCart(${product.id})">
                                <i class="fa-solid fa-cart-plus"></i> Thêm vào giỏ
                            </button>
                            <button class="btn-buy-now" onclick="buyNow(${product.id})" style="border: none; cursor: pointer;">
                                <i class="fa-solid fa-bolt"></i> Mua ngay
                            </button>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div style="padding: 1rem; background: #FEF2F2; border: 1px solid #FCA5A5; border-radius: 12px; color: #DC2626; text-align: center;">
                            <i class="fa-solid fa-circle-exclamation"></i> 
                            <strong>Sản phẩm hiện tại hết hàng</strong>
                        </div>
                    </c:otherwise>
                </c:choose>

                <!-- THÔNG TIN CỬA HÀNG / SHOP OWNER INFO -->
                <c:if test="${not empty shopOwner}">
                    <div class="shop-owner-card" style="margin-top: 1.5rem; padding: 1.25rem; border: 1px solid var(--slate-200); border-radius: 16px; background-color: var(--light); display: flex; align-items: center; gap: 1rem;">
                        <img src="${not empty shopOwner.avatar ? shopOwner.avatar : 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&q=80&w=200'}" 
                             alt="${shopOwner.fullName}" 
                             style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; border: 2px solid var(--primary); padding: 2px;">
                        <div style="flex-grow: 1;">
                            <div style="font-size: 0.8rem; font-weight: 700; color: var(--primary); text-transform: uppercase; letter-spacing: 0.05em;">Nhà cung cấp</div>
                            <h4 style="font-family: var(--font-display); font-size: 1rem; font-weight: 800; color: var(--dark); margin: 0.1rem 0 0.3rem 0;">${shopOwner.fullName}</h4>
                            <div style="display: flex; gap: 1rem; flex-wrap: wrap; font-size: 0.82rem; color: var(--slate-600);">
                                <span><i class="fa-solid fa-phone" style="color: var(--primary); margin-right: 4px;"></i> ${shopOwner.phone}</span>
                                <span><i class="fa-solid fa-envelope" style="color: var(--primary); margin-right: 4px;"></i> ${shopOwner.email}</span>
                            </div>
                        </div>
                    </div>
                </c:if>

            </div>
        </div>

        <!-- ĐÁNH GIÁ CỦA KHÁCH HÀNG (REVIEWS SECTION) -->
        <div class="reviews-section" id="reviews-section">
            <div class="section-title">
                <i class="fa-solid fa-comments"></i> Đánh giá từ khách hàng
            </div>
            
            <div class="reviews-container">
                <!-- Cột trái: Tóm tắt điểm số -->
                <div class="reviews-summary-card">
                    <div class="avg-score-big">
                        <c:choose>
                            <c:when test="${reviewCount > 0}">
                                <fmt:formatNumber value="${avgRating}" pattern="0.0"/>
                            </c:when>
                            <c:otherwise>
                                0.0
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="stars-big">
                        <c:choose>
                            <c:when test="${reviewCount > 0}">
                                <c:forEach begin="1" end="5" var="i">
                                    <c:choose>
                                        <c:when test="${i <= fullStars}">
                                            <i class="fa-solid fa-star"></i>
                                        </c:when>
                                        <c:when test="${i == fullStars + 1 && hasHalfStar}">
                                            <i class="fa-solid fa-star-half-stroke"></i>
                                        </c:when>
                                        <c:when test="${i == fullStars + 1 && roundUp}">
                                            <i class="fa-solid fa-star"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fa-regular fa-star"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <i class="fa-regular fa-star"></i>
                                <i class="fa-regular fa-star"></i>
                                <i class="fa-regular fa-star"></i>
                                <i class="fa-regular fa-star"></i>
                                <i class="fa-regular fa-star"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="total-reviews-count">Dựa trên ${reviewCount} đánh giá</div>
                </div>
                
                <!-- Cột phải: Danh sách đánh giá chi tiết -->
                <div class="reviews-list-card">
                    <c:choose>
                        <c:when test="${not empty reviews}">
                            <div class="reviews-list">
                                <c:forEach var="rev" items="${reviews}">
                                    <div class="review-item">
                                        <div class="review-item-header">
                                            <div class="reviewer-avatar">
                                                ${not empty rev.userFullName ? rev.userFullName.substring(0, 1).toUpperCase() : "K"}
                                            </div>
                                            <div class="reviewer-info">
                                                <div class="reviewer-name">${not empty rev.userFullName ? rev.userFullName : "Khách hàng mua ẩn danh"}</div>
                                                <div class="review-date">
                                                    <i class="fa-regular fa-clock"></i> 
                                                    <fmt:formatDate value="${rev.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                                </div>
                                            </div>
                                            <div class="reviewer-stars">
                                                <c:forEach begin="1" end="${rev.rating}">
                                                    <i class="fa-solid fa-star"></i>
                                                </c:forEach>
                                                <c:forEach begin="${rev.rating + 1}" end="5">
                                                    <i class="fa-regular fa-star"></i>
                                                </c:forEach>
                                            </div>
                                        </div>
                                        <div class="review-item-body">
                                            <p>${not empty rev.comment ? rev.comment : "Người mua không để lại nhận xét bằng văn bản."}</p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="no-reviews-state">
                                <i class="fa-solid fa-face-meh"></i>
                                <h4>Sản phẩm này chưa có đánh giá nào</h4>
                                <p>Hãy là người mua đầu tiên sở hữu và đánh giá sản phẩm tươi ngon này nhé!</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
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
                                    <c:when test="${p.discountPrice > 0 && p.discountPrice < p.price}">
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
        const basePrice = ${product.discountPrice > 0 && product.discountPrice < product.price ? product.discountPrice : product.price};
        let selectedWeightAdjustment = 0;
        let selectedPackagingAdjustment = 0;
        
        let selectedWeightVariantId = null;
        let selectedPackagingOptionId = null;
        let selectedWeightLabel = '';
        
        const unit = '${product.unit}'.toLowerCase().trim();
        const isKg = (unit === 'kg' || unit === 'kilogam' || unit === 'kí' || unit === 'ky');
        
        <c:if test="${not empty weightVariants}">
            selectedWeightVariantId = ${weightVariants[0].variantId};
            selectedWeightAdjustment = ${weightVariants[0].priceAdjustment};
            selectedWeightLabel = '${weightVariants[0].weightLabel}';
        </c:if>

        function changeQty(delta) {
            const input = document.getElementById('qty');
            const max = parseInt(input.max);
            let val = parseInt(input.value) + delta;
            if (val < 1) val = 1;
            if (val > max) val = max;
            input.value = val;
        }

        function parseWeightToKg(label) {
            if (!label) return 1.0;
            label = label.toLowerCase().trim().replace(',', '.');
            
            let gMatch = label.match(/^([0-9.]+)\s*(g|gr|gram|grams)$/);
            if (gMatch) {
                return parseFloat(gMatch[1]) / 1000.0;
            }
            
            let kgMatch = label.match(/^([0-9.]+)\s*(kg|kilo|kilogam|ký|ky)$/);
            if (kgMatch) {
                return parseFloat(kgMatch[1]);
            }
            
            let numMatch = label.match(/^([0-9.]+)/);
            if (numMatch) {
                let val = parseFloat(numMatch[1]);
                if (val >= 50) {
                    return val / 1000.0;
                } else {
                    return val;
                }
            }
            return 1.0;
        }

        function updateDisplayPrice() {
            const multiplier = isKg ? parseWeightToKg(selectedWeightLabel) : 1.0;
            const currentPrice = (basePrice * multiplier) + selectedWeightAdjustment + selectedPackagingAdjustment;
            const formattedPrice = currentPrice.toLocaleString('vi-VN') + 'đ';
            document.querySelector('.price-main').innerText = formattedPrice;
        }

        function selectWeightVariant(card, variantId, adjustment, weightLabel) {
            document.querySelectorAll('.variant-label-card').forEach(c => c.classList.remove('active'));
            card.classList.add('active');
            
            selectedWeightVariantId = variantId;
            selectedWeightAdjustment = adjustment;
            selectedWeightLabel = weightLabel || '';
            
            const radio = card.querySelector('input[name="weightVariant"]');
            if (radio) radio.checked = true;
            
            updateDisplayPrice();
        }
        
        function selectPackagingOption(card, packagingId, adjustment) {
            document.querySelectorAll('.packaging-label-card').forEach(c => c.classList.remove('active'));
            card.classList.add('active');
            
            selectedPackagingOptionId = packagingId ? packagingId : null;
            selectedPackagingAdjustment = adjustment;
            
            const radio = card.querySelector('input[name="packagingOption"]');
            if (radio) radio.checked = true;
            
            updateDisplayPrice();
        }

        function addToCart(productId) {
            const qtyInput = document.getElementById('qty');
            const qty = parseInt(qtyInput.value);
            const max = parseInt(qtyInput.max);
            
            if (qty > max) {
                alert('Số lượng không được vượt quá ' + max + ' sản phẩm!');
                return;
            }
            
            let url = 'cart?action=add&productId=' + productId + '&quantity=' + qty;
            if (selectedWeightVariantId) {
                url += '&variantId=' + selectedWeightVariantId;
            }
            if (selectedPackagingOptionId) {
                url += '&packagingId=' + selectedPackagingOptionId;
            }
            
            window.location.href = url;
        }

        function buyNow(productId) {
            const qtyInput = document.getElementById('qty');
            const qty = parseInt(qtyInput.value);
            const max = parseInt(qtyInput.max);
            
            if (qty > max) {
                alert('Số lượng không được vượt quá ' + max + ' sản phẩm!');
                return;
            }
            
            let url = 'cart?action=add&productId=' + productId + '&quantity=' + qty;
            if (selectedWeightVariantId) {
                url += '&variantId=' + selectedWeightVariantId;
            }
            if (selectedPackagingOptionId) {
                url += '&packagingId=' + selectedPackagingOptionId;
            }
            
            window.location.href = url; // Thêm xong tự động redirect sang /cart theo logic controller
        }
    </script>

</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>GreenStock - Nền Tảng Trái Cây Tươi Hữu Cơ</title>
        <%@include file="../common/head.jsp" %>
        <!-- Search Autocomplete CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/search-autocomplete.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/customer/home.css">
    </head>
    <body>

        <%@include file="../common/header.jsp" %>

        <!-- HERO SECTION -->
        <!-- HERO SECTION -->
        <section class="hero">

            <div class="hero-container">

                <!-- TEXT -->
                <div class="hero-content">

                    <span class="section-tag">
                        100% Organic & Fresh
                    </span>

                    <h1>
                        Trái Cây Tươi
                        <span>Hữu Cơ</span>
                        Cho Mọi Nhà
                    </h1>

                    <p>
                        Khám phá bộ sưu tập trái cây tươi ngon,
                        an toàn và giàu dinh dưỡng tại GreenStock.
                    </p>

                    <div class="hero-buttons">

                        <a href="#products-section"
                           class="btn-hero-primary">
                            Mua ngay
                        </a>

                        <a href="products"
                           class="btn-hero-secondary">
                            Xem thêm
                        </a>

                    </div>

                </div>


                <!-- BANNER -->
                <div class="banner-slider">

                    <div class="slides">

                        <img
                            src="https://phanbonhieugiang.com/upload/news/656010387967.jpg"
                            class="slide active"
                            alt="banner">

                        <img
                            src="https://airasiacargo.vn/wp-content/uploads/2020/12/van-chuyen-trai-cay-can-tho-di-ha-noi-gia-re.jpg"
                            class="slide"
                            alt="banner">

                        <img
                            src="https://png.pngtree.com/thumb_back/fh260/background/20210915/pngtree-fruit-photography-image_881781.jpg"
                            class="slide"
                            alt="banner">

                    </div>

                    <button class="prev">
                        &#10094;
                    </button>

                    <button class="next">
                        &#10095;
                    </button>

                </div>

            </div>

        </section>
        <!-- FEATURED PRODUCTS SECTION -->
        <section id="products-section" class="featured-products">
            <div class="section-header">
                <span class="section-tag">Trái cây nổi bật</span>
                <h2>Sản Phẩm Đang Bán Chạy</h2>
                <p>Khám phá bộ sưu tập 8 loại trái cây tươi ngon, giàu dinh dưỡng đang được ưa chuộng nhất tuần này tại GreenStock.</p>
            </div>

            <div class="product-grid">
                <c:choose>
                    <c:when test="${not empty products}">            
                        <c:forEach var="p" items="${products}">
                            <div class="product-card" onclick="location.href='product-detail?id=${p.id}'" style="cursor:pointer;">
                                <div class="product-image-container">
                                    <span class="product-category">${p.category}</span>
                                    <c:if test="${p.discountPrice > 0}">
                                        <span style="position:absolute;top:1rem;right:1rem;background:#EF4444;color:#fff;font-size:0.7rem;font-weight:700;padding:0.2rem 0.6rem;border-radius:50px;">
                                            SALE
                                        </span>
                                    </c:if>
                                    <img src="${p.image}" alt="${p.name}" loading="lazy"
                                         onerror="this.src='https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?auto=format&fit=crop&q=80&w=600'">
                                </div>
                                <div class="product-info">
                                    <a href="product-detail?id=${p.id}" class="product-title">${p.name}</a>
                                    <p class="product-description">${p.description}</p>
                                    <div class="product-footer">
                                        <div>
                                            <c:choose>
                                                <c:when test="${p.discountPrice > 0}">
                                                    <span class="product-price"><fmt:formatNumber value="${p.discountPrice}" type="number" maxFractionDigits="0"/>đ/${p.unit}</span>
                                                    <span style="font-size:0.78rem;color:#94a3b8;text-decoration:line-through;display:block;">
                                                        <fmt:formatNumber value="${p.price}" type="number" maxFractionDigits="0"/>đ
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="product-price"><fmt:formatNumber value="${p.price}" type="number" maxFractionDigits="0"/>đ/${p.unit}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <button type="button" class="btn-add-cart" title="Thêm vào giỏ hàng" onclick="addToCart(event, ${p.id})">
                                            <i class="fa-solid fa-cart-plus"></i>
                                        </button>
                                    </div>
                                </div>
                             </div>
                         </c:forEach>
                     </c:when>
                     <c:otherwise>
                         <!-- Fallback UI if products are empty -->
                         <div style="grid-column: span 4; text-align: center; padding: 3rem; background: var(--white); border-radius: 20px;">
                             <i class="fa-solid fa-circle-exclamation" style="font-size: 3rem; color: var(--secondary); margin-bottom: 1rem;"></i>
                             <h3>Chưa có sản phẩm nào nổi bật</h3>
                             <p style="color: var(--slate-600); margin-top: 0.5rem;">Vui lòng kết nối database và chạy script database.sql để nạp dữ liệu mẫu!</p>
                         </div>
                     </c:otherwise>
                 </c:choose>
             </div>
         </section>

        <%@include file="../common/footer.jsp" %>

        <script>
            const slides = document.querySelectorAll(".slide");
            const prev = document.querySelector(".prev");
            const next = document.querySelector(".next");

            let current = 0;

            function showSlide(index) {
                slides.forEach(slide =>
                    slide.classList.remove("active")
                );

                slides[index].classList.add("active");
            }

            function nextSlide() {
                current++;

                if (current >= slides.length) {
                    current = 0;
                }

                showSlide(current);
            }

            function prevSlide() {
                current--;

                if (current < 0) {
                    current = slides.length - 1;
                }

                showSlide(current);
            }

            next.addEventListener("click", nextSlide);

            prev.addEventListener("click", prevSlide);

            // tự động chuyển ảnh mỗi 4 giây
            setInterval(nextSlide, 4000);
        </script>

        <script>
        function addToCart(event, productId) {
            event.stopPropagation(); // Prevent card click
            
            // Get the button element
            const button = event.currentTarget;
            const icon = button.querySelector('i');
            
            // Disable button during request
            button.disabled = true;
            icon.className = 'fa-solid fa-spinner fa-spin';
            
            // Make AJAX request
            fetch('cart?action=add&productId=' + productId + '&quantity=1', {
                method: 'GET',
                headers: {
                    'X-Requested-With': 'XMLHttpRequest'
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Update cart badge
                    const cartBadge = document.querySelector('.cart-badge');
                    if (cartBadge) {
                        cartBadge.textContent = data.cartCount;
                    }
                    
                    // Show success animation
                    icon.className = 'fa-solid fa-check';
                    button.style.backgroundColor = '#10B981';
                    button.style.color = '#fff';
                    
                    // Reset button after 1.5 seconds
                    setTimeout(() => {
                        icon.className = 'fa-solid fa-cart-plus';
                        button.style.backgroundColor = '';
                        button.style.color = '';
                        button.disabled = false;
                    }, 1500);
                } else {
                    // Show error
                    icon.className = 'fa-solid fa-xmark';
                    button.style.backgroundColor = '#EF4444';
                    button.style.color = '#fff';
                    
                    setTimeout(() => {
                        icon.className = 'fa-solid fa-cart-plus';
                        button.style.backgroundColor = '';
                        button.style.color = '';
                        button.disabled = false;
                    }, 1500);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                // Show error
                icon.className = 'fa-solid fa-xmark';
                button.style.backgroundColor = '#EF4444';
                button.style.color = '#fff';
                
                setTimeout(() => {
                    icon.className = 'fa-solid fa-cart-plus';
                    button.style.backgroundColor = '';
                    button.style.color = '';
                    button.disabled = false;
                }, 1500);
            });
        }
        </script>

        <%@include file="../common/search.jsp" %>

    </body>
</html>

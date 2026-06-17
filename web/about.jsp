<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Giới thiệu - GreenStock</title>

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

            /* --- HEADER --- */
            header {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1000;
                background: rgba(255, 255, 255, 0.85);
                backdrop-filter: blur(16px);
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

            .nav-link:hover,
            .nav-link.active {
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
            }

            /* --- PAGE BANNER --- */
            .page-banner {
                padding: 8rem 2rem 3rem;
                background: linear-gradient(135deg, #E6F4EA 0%, #FFFFFF 100%);
                text-align: center;
            }

            .page-banner h1 {
                font-family: var(--font-display);
                font-size: 3rem;
                font-weight: 800;
                color: var(--dark);
                margin-bottom: 1rem;
            }

            .page-banner p {
                color: var(--slate-600);
                font-size: 1.1rem;
                max-width: 700px;
                margin: 0 auto;
            }

            /* --- CONTENT SECTION --- */
            .content-section {
                max-width: 1200px;
                margin: 0 auto;
                padding: 5rem 2rem;
            }

            .about-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 4rem;
                align-items: center;
                margin-bottom: 6rem;
            }

            .about-image {
                width: 100%;
                border-radius: 24px;
                box-shadow: var(--shadow-lg);
            }

            .about-content h2 {
                font-family: var(--font-display);
                font-size: 2rem;
                font-weight: 700;
                color: var(--dark);
                margin-bottom: 1.5rem;
            }

            .about-content p {
                color: var(--slate-600);
                margin-bottom: 1rem;
                font-size: 1.05rem;
            }

            /* --- VALUES SECTION --- */
            .values-section {
                background: var(--white);
                border-radius: 24px;
                padding: 4rem;
                margin-bottom: 4rem;
                box-shadow: var(--shadow-sm);
            }

            .section-title {
                font-family: var(--font-display);
                font-size: 2.5rem;
                font-weight: 800;
                color: var(--dark);
                text-align: center;
                margin-bottom: 3rem;
            }

            .values-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 2rem;
            }

            .value-card {
                text-align: center;
                padding: 2rem;
            }

            .value-icon {
                width: 80px;
                height: 80px;
                background: var(--primary-light);
                color: var(--primary);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 2rem;
                margin: 0 auto 1.5rem;
            }

            .value-card h3 {
                font-family: var(--font-display);
                font-size: 1.3rem;
                font-weight: 700;
                color: var(--dark);
                margin-bottom: 0.8rem;
            }

            .value-card p {
                color: var(--slate-600);
                line-height: 1.6;
            }

            /* --- STATS SECTION --- */
            .stats-section {
                background: linear-gradient(135deg, var(--primary) 0%, var(--primary-hover) 100%);
                border-radius: 24px;
                padding: 4rem;
                color: var(--white);
            }

            .stats-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 2rem;
                text-align: center;
            }

            .stat-item h3 {
                font-family: var(--font-display);
                font-size: 3rem;
                font-weight: 800;
                margin-bottom: 0.5rem;
            }

            .stat-item p {
                font-size: 1.1rem;
                opacity: 0.9;
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
                text-align: center;
                color: var(--slate-300);
            }

            @media (max-width: 768px) {
                .about-grid {
                    grid-template-columns: 1fr;
                    gap: 2rem;
                }
                .values-grid {
                    grid-template-columns: 1fr;
                }
                .stats-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
                .nav-menu {
                    display: none;
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
                    <li><a href="about.jsp" class="nav-link active">Giới thiệu</a></li>
                    <li><a href="contact.jsp" class="nav-link">Liên hệ</a></li>
                </ul>

                <div class="nav-actions">
                    <a href="#" style="color: var(--slate-600); font-size: 1.25rem;"><i class="fa-solid fa-magnifying-glass"></i></a>
                    <a href="cart" style="color: var(--slate-600); font-size: 1.25rem; position: relative;">
                        <i class="fa-solid fa-cart-shopping"></i>
                        <span style="position: absolute; top: -8px; right: -10px; background: var(--secondary); color: var(--white); border-radius: 50%; font-size: 0.7rem; width: 18px; height: 18px; display: flex; align-items: center; justify-content: center; font-weight: 700;">${sessionScope.cartCount != null ? sessionScope.cartCount : 0}</span>
                    </a>
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <a href="profile" class="btn-login">
                                <i class="fa-solid fa-user"></i> ${sessionScope.user.fullName}
                            </a>
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

        <!-- PAGE BANNER -->
        <section class="page-banner">
            <h1>Về Chúng Tôi</h1>
            <p>GreenStock - Đối tác tin cậy mang đến thực phẩm sạch, tươi ngon cho mọi gia đình Việt</p>
        </section>

        <!-- CONTENT SECTION -->
        <section class="content-section">
            <!-- ABOUT GRID 1 -->
            <div class="about-grid">
                <div class="about-content">
                    <h2>Câu Chuyện Của Chúng Tôi</h2>
                    <p>GreenStock được thành lập với sứ mệnh mang đến nguồn thực phẩm sạch, an toàn và giàu dinh dưỡng cho mọi gia đình Việt Nam. Chúng tôi hiểu rằng sức khỏe là tài sản quý giá nhất, và thực phẩm chất lượng là nền tảng của một cuộc sống khỏe mạnh.</p>
                    <p>Từ những ngày đầu thành lập, chúng tôi đã cam kết hợp tác chặt chẽ với các nông trại hữu cơ địa phương, đảm bảo mỗi sản phẩm đều được trồng và chăm sóc theo tiêu chuẩn cao nhất, không sử dụng hóa chất độc hại.</p>
                    <p>Ngày nay, GreenStock tự hào là cầu nối giữa người nông dân và người tiêu dùng, mang lại lợi ích cho cả hai bên trong chuỗi giá trị bền vững.</p>
                </div>
                <img src="https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&q=80&w=800" alt="Về GreenStock" class="about-image">
            </div>

            <!-- ABOUT GRID 2 -->
            <div class="about-grid" style="direction: rtl;">
                <div class="about-content" style="direction: ltr;">
                    <h2>Tầm Nhìn & Sứ Mệnh</h2>
                    <p><strong>Tầm nhìn:</strong> Trở thành nền tảng thực phẩm sạch hàng đầu Việt Nam, nơi mọi người tin tưởng lựa chọn cho gia đình mình.</p>
                    <p><strong>Sứ mệnh:</strong> Cung cấp sản phẩm chất lượng cao, minh bạch nguồn gốc, giá cả hợp lý, đồng thời hỗ trợ nông dân phát triển bền vững.</p>
                    <p>Chúng tôi tin rằng thực phẩm sạch không chỉ là xu hướng mà là quyền lợi cơ bản của mỗi con người. Vì vậy, GreenStock không ngừng nỗ lực để làm cho thực phẩm hữu cơ trở nên dễ tiếp cận hơn với tất cả mọi người.</p>
                </div>
                <img src="https://images.unsplash.com/photo-1488459716781-31db52582fe9?auto=format&fit=crop&q=80&w=800" alt="Tầm nhìn" class="about-image">
            </div>

            <!-- VALUES SECTION -->
            <div class="values-section">
                <h2 class="section-title">Giá Trị Cốt Lõi</h2>
                <div class="values-grid">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fa-solid fa-leaf"></i>
                        </div>
                        <h3>100% Hữu Cơ</h3>
                        <p>Tất cả sản phẩm đều được trồng theo phương pháp hữu cơ, không sử dụng hóa chất độc hại, đảm bảo an toàn tuyệt đối.</p>
                    </div>
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fa-solid fa-certificate"></i>
                        </div>
                        <h3>Chứng Nhận Chất Lượng</h3>
                        <p>Sản phẩm được kiểm định nghiêm ngặt và có đầy đủ chứng nhận từ các cơ quan có thẩm quyền.</p>
                    </div>
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fa-solid fa-truck-fast"></i>
                        </div>
                        <h3>Giao Hàng Nhanh</h3>
                        <p>Cam kết giao hàng tươi ngon trong vòng 24h, đảm bảo sản phẩm luôn ở trạng thái tốt nhất.</p>
                    </div>
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fa-solid fa-shield-halved"></i>
                        </div>
                        <h3>Minh Bạch Nguồn Gốc</h3>
                        <p>Mỗi sản phẩm đều có thông tin rõ ràng về nguồn gốc, nông trại, quy trình sản xuất.</p>
                    </div>
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fa-solid fa-handshake"></i>
                        </div>
                        <h3>Hỗ Trợ Nông Dân</h3>
                        <p>Chúng tôi làm việc trực tiếp với nông dân, đảm bảo họ nhận được giá trị xứng đáng cho công sức.</p>
                    </div>
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fa-solid fa-heart"></i>
                        </div>
                        <h3>Tận Tâm Phục Vụ</h3>
                        <p>Đội ngũ chăm sóc khách hàng luôn sẵn sàng hỗ trợ bạn 24/7 với thái độ nhiệt tình nhất.</p>
                    </div>
                </div>
            </div>

            <!-- STATS SECTION -->
            <div class="stats-section">
                <div class="stats-grid">
                    <div class="stat-item">
                        <h3>50,000+</h3>
                        <p>Khách hàng hài lòng</p>
                    </div>
                    <div class="stat-item">
                        <h3>200+</h3>
                        <p>Đối tác nông trại</p>
                    </div>
                    <div class="stat-item">
                        <h3>500+</h3>
                        <p>Sản phẩm tươi ngon</p>
                    </div>
                    <div class="stat-item">
                        <h3>99%</h3>
                        <p>Đánh giá tích cực</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- FOOTER -->
        <footer>
            <div class="footer-container">
                <div class="footer-column">
                    <div class="footer-logo">
                        <i class="fa-solid fa-leaf"></i> GreenStock
                    </div>
                    <p class="footer-desc">Đơn vị tiên phong cung cấp trái cây tươi hữu cơ, mang đến bữa ăn an toàn và dinh dưỡng cho mọi gia đình Việt.</p>
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
                        <li><a href="about.jsp">Giới thiệu công ty</a></li>
                        <li><a href="#">Hệ thống cửa hàng</a></li>
                        <li><a href="#">Tuyển dụng</a></li>
                        <li><a href="#">Tin tức & Sự kiện</a></li>
                    </ul>
                </div>

                <div class="footer-column">
                    <h3>Chính sách</h3>
                    <ul class="footer-links">
                        <li><a href="#">Chính sách đổi trả</a></li>
                        <li><a href="#">Chính sách bảo mật</a></li>
                        <li><a href="#">Phương thức thanh toán</a></li>
                        <li><a href="#">Điều khoản sử dụng</a></li>
                    </ul>
                </div>

                <div class="footer-column">
                    <h3>Liên hệ & Hỗ trợ</h3>
                    <ul class="contact-info">
                        <li>
                            <i class="fa-solid fa-location-dot"></i>
                            <span>Khu Công nghệ cao Hòa Lạc, Thạch Thất, Hà Nội</span>
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
            </div>
        </footer>

    </body>
</html>

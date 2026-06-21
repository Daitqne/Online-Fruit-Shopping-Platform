<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chỉnh sửa hồ sơ - GreenStock</title>

        <!-- Google Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">

        <!-- FontAwesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        
        <!-- Profile Stylesheet -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css">

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

            /* --- FORM CONTROLS --- */
            .form-group {
                margin-bottom: 1.25rem;
            }
            .form-group label {
                display: block;
                font-weight: 600;
                margin-bottom: 0.5rem;
                color: var(--slate-600);
                font-size: 0.9rem;
            }
            .form-control {
                width: 100%;
                padding: 0.75rem 1rem;
                border-radius: 12px;
                border: 1px solid var(--slate-300);
                font-family: var(--font-body);
                font-size: 0.95rem;
                outline: none;
                transition: all 0.3s ease;
                background-color: var(--light);
            }
            .form-control:focus {
                border-color: var(--primary);
                background-color: var(--white);
                box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.15);
            }
            .gender-group {
                display: flex;
                gap: 1.5rem;
                align-items: center;
                margin-top: 0.25rem;
            }
            .gender-option {
                display: flex;
                align-items: center;
                gap: 0.4rem;
                cursor: pointer;
            }
            .gender-option input {
                cursor: pointer;
                accent-color: var(--primary);
                width: 18px;
                height: 18px;
            }
            .btn-save {
                background-color: var(--primary);
                color: var(--white);
                border: none;
                padding: 0.8rem 2rem;
                border-radius: 12px;
                font-family: var(--font-body);
                font-weight: 600;
                font-size: 1rem;
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 0 4px 10px rgba(16, 185, 129, 0.2);
            }
            .btn-save:hover {
                background-color: var(--primary-hover);
                transform: translateY(-2px);
                box-shadow: 0 6px 15px rgba(16, 185, 129, 0.3);
            }
            .btn-cancel {
                background-color: var(--slate-200);
                color: var(--slate-600);
                text-decoration: none;
                padding: 0.8rem 2rem;
                border-radius: 12px;
                font-weight: 600;
                font-size: 1rem;
                transition: all 0.3s ease;
                display: inline-block;
                text-align: center;
            }
            .btn-cancel:hover {
                background-color: var(--slate-300);
                color: var(--dark);
            }
            .alert-danger {
                background-color: #FDE8E8;
                border: 1px solid #F8B4B4;
                color: #9B1C1C;
                padding: 1rem;
                border-radius: 16px;
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                gap: 10px;
                box-shadow: var(--shadow-sm);
                animation: slideDown 0.3s ease;
            }

            @keyframes slideDown {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
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
                    <a href="#" style="color: var(--slate-600); font-size: 1.25rem; position: relative;">
                        <i class="fa-solid fa-cart-shopping"></i>
                        <span style="position: absolute; top: -8px; right: -10px; background: var(--secondary); color: var(--white); border-radius: 50%; font-size: 0.7rem; width: 18px; height: 18px; display: flex; align-items: center; justify-content: center; font-weight: 700;">0</span>
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
                                    <a href="${pageContext.request.contextPath}/orders"><i class="fa-solid fa-bag-shopping"></i> Đơn hàng</a>
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

        <!-- PROFILE SECTION -->
        <section class="profile-section">
            <div class="profile-container">

                <!-- LEFT CARD -->
                <div class="profile-card">
                    <div class="profile-header">
                        <div class="avatar-wrapper">
                            <img id="avatar-preview" src="${not empty sessionScope.user.avatar ? sessionScope.user.avatar : 'https://cdn-icons-png.flaticon.com/512/149/149071.png'}"
                                 alt="Avatar"
                                 class="profile-avatar">
                        </div>

                        <h2>${sessionScope.user.fullName}</h2>

                        <span class="profile-role">
                            ${sessionScope.user.role}
                        </span>

                        <p class="member-date">
                            Thành viên từ 2026
                        </p>

                        <a href="profile" class="btn-edit" style="background-color: var(--slate-200); color: var(--slate-600);">
                            <i class="fa-solid fa-arrow-left"></i>
                            Quay lại hồ sơ
                        </a>
                    </div>
                </div>

                <!-- RIGHT CONTENT (EDIT FORM) -->
                <div class="profile-content">

                    <!-- Alert Error -->
                    <c:if test="${not empty error}">
                        <div class="alert-danger">
                            <i class="fa-solid fa-circle-exclamation" style="font-size: 1.25rem;"></i>
                            <span>${error}</span>
                        </div>
                    </c:if>

                    <!-- Form Box -->
                    <div class="info-box">
                        <div class="box-title">
                            <i class="fa-solid fa-user-pen"></i>
                            Chỉnh sửa hồ sơ cá nhân
                        </div>

                        <form action="edit-profile" method="POST">
                            
                            <div class="form-group">
                                <label for="fullName">Họ và tên <span style="color:red;">*</span></label>
                                <input type="text" id="fullName" name="fullName" class="form-control" value="${sessionScope.user.fullName}" required>
                            </div>

                            <div class="form-group">
                                <label for="phone">Số điện thoại <span style="color:red;">*</span></label>
                                <input type="text" id="phone" name="phone" class="form-control" value="${sessionScope.user.phone}" required>
                            </div>

                            <div class="form-group">
                                <label for="email">Email <span style="color:red;">*</span></label>
                                <input type="email" id="email" name="email" class="form-control" value="${sessionScope.user.email}" required>
                            </div>

                            <div class="form-group">
                                <label>Giới tính</label>
                                <div class="gender-group">
                                    <label class="gender-option">
                                        <input type="radio" name="gender" value="Nam" ${sessionScope.user.gender eq 'Nam' ? 'checked' : ''}> Nam
                                    </label>
                                    <label class="gender-option">
                                        <input type="radio" name="gender" value="Nữ" ${sessionScope.user.gender eq 'Nữ' ? 'checked' : ''}> Nữ
                                    </label>
                                    <label class="gender-option">
                                        <input type="radio" name="gender" value="Khác" ${sessionScope.user.gender eq 'Khác' ? 'checked' : ''}> Khác
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="dob">Ngày sinh</label>
                                <input type="date" id="dob" name="dob" class="form-control" value="${sessionScope.user.dob}">
                            </div>

                            <div class="form-group">
                                <label for="avatar">Đường dẫn ảnh đại diện (URL)</label>
                                <input type="text" id="avatar" name="avatar" class="form-control" value="${sessionScope.user.avatar}" oninput="updateAvatarPreview(this.value)" placeholder="https://example.com/avatar.jpg">
                            </div>

                            <div class="form-group">
                                <label for="address">Địa chỉ giao hàng</label>
                                <textarea id="address" name="address" class="form-control" rows="3" placeholder="Nhập địa chỉ giao hàng của bạn...">${sessionScope.user.address}</textarea>
                            </div>

                            <div style="display: flex; gap: 1rem; margin-top: 2rem;">
                                <button type="submit" class="btn-save">Lưu thay đổi</button>
                                <a href="profile" class="btn-cancel">Hủy</a>
                            </div>

                        </form>
                    </div>

                </div>

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
            function updateAvatarPreview(url) {
                var preview = document.getElementById('avatar-preview');
                if (url && url.trim().length > 0) {
                    preview.src = url.trim();
                } else {
                    preview.src = 'https://cdn-icons-png.flaticon.com/512/149/149071.png';
                }
            }
        </script>
    </body>
</html>

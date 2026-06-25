<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Liên hệ - GreenStock</title>
        <%@include file="../common/head.jsp" %>

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
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .btn-login:hover {
                background-color: var(--primary-hover);
                transform: translateY(-2px);
            }

            /* Style cho user đã login (màu xanh nhạt giống home/products) */
            .btn-login.user-logged-in {
                background: var(--primary-light);
                color: var(--primary);
            }

            .btn-login.user-logged-in:hover {
                background: var(--primary);
                color: var(--white);
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

            /* --- CONTACT SECTION --- */
            .contact-section {
                max-width: 1200px;
                margin: 0 auto;
                padding: 5rem 2rem;
            }

            .contact-grid {
                display: grid;
                grid-template-columns: 1fr 1.5fr;
                gap: 4rem;
                align-items: start;
            }

            /* --- CONTACT INFO --- */
            .contact-info-box {
                background: var(--white);
                border-radius: 24px;
                padding: 3rem;
                box-shadow: var(--shadow-lg);
            }

            .contact-info-box h2 {
                font-family: var(--font-display);
                font-size: 2rem;
                font-weight: 700;
                color: var(--dark);
                margin-bottom: 2rem;
            }

            .info-item {
                display: flex;
                gap: 1.5rem;
                margin-bottom: 2rem;
                padding-bottom: 2rem;
                border-bottom: 1px solid var(--slate-200);
            }

            .info-item:last-child {
                border-bottom: none;
                margin-bottom: 0;
                padding-bottom: 0;
            }

            .info-icon {
                width: 60px;
                height: 60px;
                background: var(--primary-light);
                color: var(--primary);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
                flex-shrink: 0;
            }

            .info-content h3 {
                font-family: var(--font-display);
                font-size: 1.1rem;
                font-weight: 700;
                color: var(--dark);
                margin-bottom: 0.5rem;
            }

            .info-content p {
                color: var(--slate-600);
                line-height: 1.6;
            }

            /* --- CONTACT FORM --- */
            .contact-form-box {
                background: var(--white);
                border-radius: 24px;
                padding: 3rem;
                box-shadow: var(--shadow-lg);
            }

            .contact-form-box h2 {
                font-family: var(--font-display);
                font-size: 2rem;
                font-weight: 700;
                color: var(--dark);
                margin-bottom: 1rem;
            }

            .contact-form-box p {
                color: var(--slate-600);
                margin-bottom: 2rem;
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-label {
                display: block;
                font-weight: 600;
                color: var(--dark);
                margin-bottom: 0.5rem;
            }

            .form-control {
                width: 100%;
                padding: 0.8rem 1rem;
                border: 1px solid var(--slate-300);
                border-radius: 12px;
                font-family: var(--font-body);
                font-size: 1rem;
                transition: all 0.3s ease;
            }

            .form-control:focus {
                outline: none;
                border-color: var(--primary);
                box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.15);
            }

            textarea.form-control {
                resize: vertical;
                min-height: 150px;
            }

            .btn-submit {
                background: var(--primary);
                color: var(--white);
                border: none;
                padding: 1rem 2.5rem;
                border-radius: 12px;
                font-family: var(--font-body);
                font-size: 1.05rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
            }

            .btn-submit:hover {
                background: var(--primary-hover);
                transform: translateY(-2px);
                box-shadow: 0 6px 16px rgba(16, 185, 129, 0.3);
            }

            /* --- MAP SECTION --- */
            .map-section {
                max-width: 1200px;
                margin: 0 auto 5rem;
                padding: 0 2rem;
            }

            .map-container {
                border-radius: 24px;
                overflow: hidden;
                box-shadow: var(--shadow-lg);
                height: 450px;
                background: var(--slate-200);
            }

            .map-container iframe {
                width: 100%;
                height: 100%;
                border: none;
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

            .footer-contact-info {
                list-style: none;
                display: flex;
                flex-direction: column;
                gap: 1rem;
                color: var(--slate-300);
            }

            .footer-contact-info li {
                display: flex;
                gap: 0.8rem;
                align-items: flex-start;
            }

            .footer-contact-info i {
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

            .success-message {
                background: #D1FAE5;
                color: #065F46;
                padding: 1rem;
                border-radius: 12px;
                margin-bottom: 1.5rem;
                display: none;
            }

            @media (max-width: 768px) {
                .contact-grid {
                    grid-template-columns: 1fr;
                    gap: 2rem;
                }
                .nav-menu {
                    display: none;
                }
            }
        </style>
    </head>
    <body>

        <%@include file="../common/header.jsp" %>

        <!-- PAGE BANNER -->
        <section class="page-banner">
            <h1>Liên Hệ Với Chúng Tôi</h1>
            <p>Chúng tôi luôn sẵn sàng lắng nghe và hỗ trợ bạn. Hãy liên hệ với GreenStock ngay hôm nay!</p>
        </section>

        <!-- CONTACT SECTION -->
        <section class="contact-section">
            <div class="contact-grid">
                <!-- CONTACT INFO -->
                <div class="contact-info-box">
                    <h2>Thông Tin Liên Hệ</h2>
                    
                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fa-solid fa-location-dot"></i>
                        </div>
                        <div class="info-content">
                            <h3>Địa chỉ văn phòng</h3>
                            <p>Khu Công nghệ cao Hòa Lạc<br>
                            Thạch Thất, Hà Nội, Việt Nam</p>
                        </div>
                    </div>

                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fa-solid fa-phone"></i>
                        </div>
                        <div class="info-content">
                            <h3>Số điện thoại</h3>
                            <p>Hotline: <strong>1900 8198</strong><br>
                            Thứ 2 - Chủ Nhật: 8:00 - 22:00</p>
                        </div>
                    </div>

                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fa-solid fa-envelope"></i>
                        </div>
                        <div class="info-content">
                            <h3>Email</h3>
                            <p>Hỗ trợ: <strong>support@greenstock.vn</strong><br>
                            Hợp tác: <strong>partner@greenstock.vn</strong></p>
                        </div>
                    </div>

                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fa-solid fa-clock"></i>
                        </div>
                        <div class="info-content">
                            <h3>Giờ làm việc</h3>
                            <p>Thứ 2 - Thứ 6: 8:00 - 18:00<br>
                            Thứ 7 - Chủ Nhật: 8:00 - 17:00</p>
                        </div>
                    </div>
                </div>

                <!-- CONTACT FORM -->
                <div class="contact-form-box">
                    <h2>Gửi Tin Nhắn Cho Chúng Tôi</h2>
                    <p>Điền thông tin vào form bên dưới và chúng tôi sẽ phản hồi trong vòng 24 giờ.</p>
                    
                    <div class="success-message" id="successMessage">
                        <i class="fa-solid fa-circle-check"></i> Cảm ơn bạn đã liên hệ! Chúng tôi sẽ phản hồi sớm nhất.
                    </div>

                    <form id="contactForm" onsubmit="return handleSubmit(event)">
                        <div class="form-group">
                            <label class="form-label">Họ và tên *</label>
                            <input type="text" class="form-control" name="name" required placeholder="Nhập họ và tên của bạn">
                        </div>

                        <div class="form-group">
                            <label class="form-label">Email *</label>
                            <input type="email" class="form-control" name="email" required placeholder="example@email.com">
                        </div>

                        <div class="form-group">
                            <label class="form-label">Số điện thoại *</label>
                            <input type="tel" class="form-control" name="phone" required placeholder="0912 345 678">
                        </div>

                        <div class="form-group">
                            <label class="form-label">Tiêu đề *</label>
                            <input type="text" class="form-control" name="subject" required placeholder="Chủ đề bạn muốn trao đổi">
                        </div>

                        <div class="form-group">
                            <label class="form-label">Nội dung *</label>
                            <textarea class="form-control" name="message" required placeholder="Viết nội dung tin nhắn của bạn tại đây..."></textarea>
                        </div>

                        <button type="submit" class="btn-submit">
                            <i class="fa-solid fa-paper-plane"></i>
                            Gửi tin nhắn
                        </button>
                    </form>
                </div>
            </div>
        </section>

        <!-- MAP SECTION -->
        <section class="map-section">
            <div class="map-container">
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3723.6731960091597!2d105.52438931493237!3d21.046407185990893!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31345b465a4e65fb%3A0xaac1295f2f4d315d!2zSOG7jWEgTOG6oWM!5e0!3m2!1svi!2s!4v1234567890123!5m2!1svi!2s" 
                        allowfullscreen="" 
                        loading="lazy" 
                        referrerpolicy="no-referrer-when-downgrade">
                </iframe>
            </div>
        </section>

        <!-- FOOTER -->
        <%@include file="../common/footer.jsp" %>

        <script>
        function handleSubmit(event) {
            event.preventDefault();
            
            // Hiển thị thông báo thành công
            const successMsg = document.getElementById('successMessage');
            successMsg.style.display = 'block';
            
            // Reset form
            document.getElementById('contactForm').reset();
            
            // Ẩn thông báo sau 5 giây
            setTimeout(() => {
                successMsg.style.display = 'none';
            }, 5000);
            
            // Scroll to top của form
            successMsg.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
            
            return false;
        }
        </script>

    </body>
</html>

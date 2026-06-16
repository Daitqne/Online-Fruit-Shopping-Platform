<%-- 
    Document   : signup
    Created on : Feb 03, 2026, 7:21:13 PM
    Author     : LAPTOP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>GreenStock - Đăng ký</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            :root {
                --primary: #10b981;
                --primary-dark: #059669;
                --primary-light: #ecfdf5;
                --secondary: #f59e0b;
                --text-primary: #1f2937;
                --text-secondary: #6b7280;
                --bg-light: #f9fafb;
                --border-color: #e5e7eb;
                --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
                --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1);
                --shadow-lg: 0 20px 40px rgba(0, 0, 0, 0.12);
                --error: #ef4444;
                --success: #10b981;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, var(--primary-light) 0%, #f0fdf4 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 20px;
            }

            .signup-wrapper {
                display: grid;
                grid-template-columns: 1.1fr 1fr;
                gap: 60px;
                max-width: 1200px;
                width: 100%;
                align-items: center;
            }

            /* ===== BRAND SECTION ===== */
            .brand-section {
                color: white;
                animation: slideInLeft 0.8s ease-out;
                padding: 20px;
            }

            .brand-logo {
                font-size: 44px;
                font-weight: 800;
                margin-bottom: 15px;
                color: var(--primary-dark);
                display: flex;
                align-items: center;
                gap: 15px;
                letter-spacing: -1px;
            }

            .brand-logo::before {
                content: '🍎';
                font-size: 50px;
                display: inline-block;
                animation: bounce 2s infinite;
            }

            @keyframes bounce {
                0%, 100% {
                    transform: translateY(0);
                }
                50% {
                    transform: translateY(-8px);
                }
            }

            .brand-tagline {
                font-size: 17px;
                color: var(--text-primary);
                margin-bottom: 45px;
                font-weight: 500;
                line-height: 1.5;
            }

            .brand-features {
                list-style: none;
                margin: 0;
                padding: 0;
            }

            .brand-features li {
                font-size: 15px;
                color: var(--text-primary);
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 14px;
                font-weight: 500;
                line-height: 1.4;
            }

            .brand-features li::before {
                content: '✓';
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 26px;
                height: 26px;
                min-width: 26px;
                background: var(--primary);
                color: white;
                border-radius: 50%;
                font-weight: 700;
                font-size: 14px;
                flex-shrink: 0;
            }

            /* ===== SIGNUP FORM ===== */
            .signup-form-wrapper {
                background: white;
                border-radius: 16px;
                padding: 55px;
                box-shadow: var(--shadow-lg);
                max-height: 90vh;
                overflow-y: auto;
            }

            .signup-form-wrapper::-webkit-scrollbar {
                width: 6px;
            }

            .signup-form-wrapper::-webkit-scrollbar-track {
                background: var(--bg-light);
                border-radius: 10px;
            }

            .signup-form-wrapper::-webkit-scrollbar-thumb {
                background: var(--border-color);
                border-radius: 10px;
            }

            .signup-form-wrapper::-webkit-scrollbar-thumb:hover {
                background: var(--text-secondary);
            }

            .form-header {
                margin-bottom: 35px;
                text-align: center;
            }

            .form-title {
                font-size: 32px;
                color: var(--text-primary);
                margin-bottom: 12px;
                font-weight: 700;
                letter-spacing: -0.5px;
            }

            .form-subtitle {
                font-size: 15px;
                color: var(--text-secondary);
                font-weight: 400;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-row {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 15px;
            }

            .form-row .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                font-size: 13px;
                font-weight: 600;
                color: var(--text-primary);
                margin-bottom: 10px;
                text-transform: uppercase;
                letter-spacing: 0.6px;
            }

            .input-wrapper {
                position: relative;
                display: flex;
                align-items: center;
            }

            input[type="text"],
            input[type="email"],
            input[type="password"],
            input[type="tel"] {
                width: 100%;
                padding: 14px 16px;
                border: 2px solid var(--border-color);
                border-radius: 10px;
                font-size: 15px;
                background: var(--bg-light);
                color: var(--text-primary);
                font-weight: 500;
            }

            input[type="text"]:focus,
            input[type="email"]:focus,
            input[type="password"]:focus,
            input[type="tel"]:focus {
                outline: none;
                border-color: var(--primary);
                background: white;
                box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.12);
            }

            input::placeholder {
                color: var(--text-secondary);
                font-weight: 400;
            }

            /* CSS cho độ mạnh mật khẩu */
            .password-strength-container {
                margin-top: 8px;
            }
            .strength-text {
                font-size: 12px;
                font-weight: 600;
                color: var(--text-secondary);
            }
            .strength-bar {
                width: 100%;
                height: 5px;
                background: #e5e7eb;
                border-radius: 3px;
                margin-top: 4px;
                overflow: hidden;
            }
            .strength-fill {
                height: 100%;
                width: 0%;
                transition: all 0.3s ease;
            }

            .terms-checkbox {
                display: flex;
                align-items: flex-start;
                gap: 12px;
                margin-bottom: 24px;
                padding: 14px;
                background: var(--primary-light);
                border-radius: 8px;
            }

            .terms-checkbox input[type="checkbox"] {
                width: 20px;
                height: 20px;
                min-width: 20px;
                cursor: pointer;
                accent-color: var(--primary);
                margin-top: 2px;
            }

            .terms-text {
                font-size: 13px;
                color: var(--text-primary);
                line-height: 1.5;
            }

            .terms-text a {
                color: var(--primary);
                text-decoration: none;
                font-weight: 600;
            }

            .terms-text a:hover {
                text-decoration: underline;
                color: var(--primary-dark);
            }

            .signup-btn {
                width: 100%;
                padding: 14px 16px;
                background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
                color: white;
                border: none;
                border-radius: 10px;
                font-size: 15px;
                font-weight: 700;
                cursor: pointer;
                text-transform: uppercase;
                letter-spacing: 0.6px;
                margin-bottom: 20px;
                box-shadow: 0 4px 12px rgba(16, 185, 129, 0.25);
            }

            .signup-btn:hover {
                transform: translateY(-3px);
                box-shadow: 0 10px 28px rgba(16, 185, 129, 0.35);
            }

            .divider {
                display: flex;
                align-items: center;
                margin: 24px 0;
                gap: 12px;
                color: var(--text-secondary);
                font-size: 13px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .divider::before,
            .divider::after {
                content: '';
                flex: 1;
                height: 1px;
                background: var(--border-color);
            }

            .login-section {
                text-align: center;
            }

            .login-text {
                font-size: 14px;
                color: var(--text-primary);
                font-weight: 500;
            }

            .login-text a {
                color: var(--primary);
                text-decoration: none;
                font-weight: 700;
            }

            .login-text a:hover {
                color: var(--primary-dark);
                text-decoration: underline;
            }

            .error-message {
                color: var(--error);
                font-size: 13px;
                font-weight: 600;
                margin-top: 8px;
                padding: 10px;
                background: rgba(239, 68, 68, 0.1);
                border-radius: 6px;
                border-left: 3px solid var(--error);
            }

            .success-message {
                color: var(--success);
                font-size: 13px;
                font-weight: 600;
                margin-bottom: 20px;
                padding: 10px;
                background: rgba(16, 185, 129, 0.1);
                border-radius: 6px;
                border-left: 3px solid var(--success);
            }

            @keyframes slideInLeft {
                from { opacity: 0; transform: translateX(-40px); }
                to { opacity: 1; transform: translateX(0); }
            }

            /* Responsive giữ nguyên */
            @media (max-width: 768px) {
                .signup-wrapper { grid-template-columns: 1fr; gap: 30px; }
                .brand-section { display: none; }
                .signup-form-wrapper { padding: 40px 30px; max-height: none; }
                .form-title { font-size: 24px; }
            }
            input, button, a { transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); }
        </style>
    </head>
    <body>
        <div class="signup-wrapper">
            <div class="brand-section">
                <div class="brand-logo">GreenStock</div>
                <p class="brand-tagline">Rau cải, trái cây tươi sạch hàng ngày</p>

                <ul class="brand-features">
                    <li>Sản phẩm tươi mới từ nông dân</li>
                    <li>Giao hàng nhanh chóng tận nhà</li>
                    <li>Giá cạnh tranh, chất lượng cao</li>
                    <li>Hỗ trợ khách hàng 24/7</li>
                </ul>
            </div>

            <div class="signup-form-wrapper">
                <div class="form-header">
                    <h1 class="form-title">Tạo tài khoản</h1>
                    <p class="form-subtitle">Đăng ký để bắt đầu mua sắm</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="error-message" id="serverError">${error}</div>
                </c:if>

                <c:if test="${not empty success}">
                    <div class="success-message">${success}</div>
                </c:if>

                <div class="error-message" id="jsError" style="display: none; margin-bottom: 15px;"></div>

                <form action="${pageContext.request.contextPath}/signup" method="post" id="signupForm" onsubmit="return validateForm()">

                    <div class="form-group">
                        <label for="fullName">Họ và tên</label>
                        <div class="input-wrapper">
                            <input 
                                type="text"
                                id="fullName"
                                name="fullName"
                                placeholder="Nguyễn Văn A"
                                value="<c:out value='${param.fullName}'/>"
                                required
                                minlength="3">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="username">Tên đăng nhập</label>
                        <div class="input-wrapper">
                            <input 
                                type="text"
                                id="username"
                                name="username"
                                placeholder="Tên đăng nhập"
                                value="<c:out value='${param.username}'/>"
                                required
                                minlength="5">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email">Email</label>
                        <div class="input-wrapper">
                            <input 
                                type="email"
                                id="email"
                                name="email"
                                placeholder="email@gmail.com"
                                value="<c:out value='${param.email}'/>"
                                required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="phone">Số điện thoại</label>
                        <div class="input-wrapper">
                            <input 
                                type="tel"
                                id="phone"
                                name="phone"
                                placeholder="0123456789"
                                value="<c:out value='${param.phone}'/>"
                                required
                                pattern="[0-9]{10,11}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="password">Mật khẩu</label>
                        <div class="input-wrapper">
                            <input 
                                type="password"
                                id="password"
                                name="password"
                                placeholder="Nhập mật khẩu"
                                required
                                minlength="8"
                                oninput="checkPasswordStrength()">
                        </div>
                        <div class="password-strength-container">
                            <span class="strength-text" id="strengthText">Độ mạnh: Chưa nhập</span>
                            <div class="strength-bar">
                                <div class="strength-fill" id="strengthFill"></div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword">Xác nhận mật khẩu</label>
                        <div class="input-wrapper">
                            <input 
                                type="password"
                                id="confirmPassword"
                                name="confirmPassword"
                                placeholder="Nhập lại mật khẩu"
                                required>
                        </div>
                    </div>

                    <div class="terms-checkbox">
                        <input type="checkbox" id="terms" required>
                        <label for="terms" style="margin:0;">
                            <span class="terms-text">
                                Tôi đồng ý với <a href="#">Điều khoản dịch vụ</a>
                            </span>
                        </label>
                    </div>

                    <button type="submit" class="signup-btn" id="submitBtn">
                        Tạo tài khoản
                    </button>

                    <div class="divider">hoặc</div>

                    <div class="login-section">
                        <p class="login-text">
                            Đã có tài khoản?
                            <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                        </p>
                    </div>

                </form>
            </div>
        </div>

        <script>
            // 1. Kiểm tra độ mạnh mật khẩu theo thời gian thực (Real-time)
            function checkPasswordStrength() {
                const password = document.getElementById('password').value;
                const strengthText = document.getElementById('strengthText');
                const strengthFill = document.getElementById('strengthFill');
                
                if (password.length === 0) {
                    strengthText.innerText = "Độ mạnh: Chưa nhập";
                    strengthText.style.color = "var(--text-secondary)";
                    strengthFill.style.width = "0%";
                    return;
                }

                let score = 0;
                if (password.length >= 8) score++;
                if (/[A-Z]/.test(password)) score++; // Có chữ hoa
                if (/[0-9]/.test(password)) score++; // Có chữ số
                if (/[^A-Za-z0-9]/.test(password)) score++; // Có ký tự đặc biệt

                // Thay đổi giao diện thanh trạng thái dựa trên điểm số
                if (score <= 2) {
                    strengthText.innerText = "Độ mạnh: Yếu";
                    strengthText.style.color = "var(--error)";
                    strengthFill.style.width = "33%";
                    strengthFill.style.backgroundColor = "var(--error)";
                } else if (score === 3) {
                    strengthText.innerText = "Độ mạnh: Trung bình";
                    strengthText.style.color = "var(--secondary)";
                    strengthFill.style.width = "66%";
                    strengthFill.style.backgroundColor = "var(--secondary)";
                } else {
                    strengthText.innerText = "Độ mạnh: Khỏe";
                    strengthText.style.color = "var(--success)";
                    strengthFill.style.width = "100%";
                    strengthFill.style.backgroundColor = "var(--success)";
                }
            }

            // 2. Chặn submit form nếu mật khẩu khớp nhau không chuẩn
            function validateForm() {
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                const jsError = document.getElementById('jsError');
                const serverError = document.getElementById('serverError');

                // Ẩn lỗi cũ của server nếu có
                if (serverError) serverError.style.display = 'none';

                if (password !== confirmPassword) {
                    jsError.innerText = "Mật khẩu xác nhận không trùng khớp. Vui lòng kiểm tra lại!";
                    jsError.style.display = 'block';
                    document.getElementById('confirmPassword').focus();
                    return false; // Chặn gửi request lên servlet
                }

                jsError.style.display = 'none';
                return true; // Hợp lệ, cho phép gửi dữ liệu
            }
        </script>
    </body>
</html>
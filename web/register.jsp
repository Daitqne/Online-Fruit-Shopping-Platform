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
                animation: slideInRight 0.8s ease-out;
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
            input[type="tel"],
            select {
                width: 100%;
                padding: 14px 16px;
                border: 2px solid var(--border-color);
                border-radius: 10px;
                font-size: 15px;
                background: var(--bg-light);
                transition: all 0.3s ease;
                color: var(--text-primary);
                font-weight: 500;
            }

            input[type="text"]:focus,
            input[type="email"]:focus,
            input[type="password"]:focus,
            input[type="tel"]:focus,
            select:focus {
                outline: none;
                border-color: var(--primary);
                background: white;
                box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.12);
            }

            input::placeholder {
                color: var(--text-secondary);
                font-weight: 400;
            }

            .password-toggle {
                position: absolute;
                right: 16px;
                top: 50%;
                transform: translateY(-50%);
                background: none;
                border: none;
                cursor: pointer;
                color: var(--text-secondary);
                font-size: 20px;
                transition: color 0.3s ease;
                padding: 6px;
            }

            .password-toggle:hover {
                color: var(--primary);
            }

            .password-strength {
                margin-top: 8px;
                font-size: 12px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .strength-bar {
                width: 100%;
                height: 4px;
                background: var(--border-color);
                border-radius: 2px;
                margin-top: 6px;
                overflow: hidden;
            }

            .strength-fill {
                height: 100%;
                width: 0%;
                border-radius: 2px;
                transition: all 0.3s ease;
            }

            .strength-weak {
                background: var(--error);
            }

            .strength-medium {
                background: var(--secondary);
            }

            .strength-strong {
                background: var(--success);
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
                transition: all 0.3s ease;
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
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 0.6px;
                margin-bottom: 20px;
                box-shadow: 0 4px 12px rgba(16, 185, 129, 0.25);
            }

            .signup-btn:hover {
                transform: translateY(-3px);
                box-shadow: 0 10px 28px rgba(16, 185, 129, 0.35);
            }

            .signup-btn:active {
                transform: translateY(-1px);
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
                transition: color 0.3s ease;
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

            /* ===== ANIMATIONS ===== */
            @keyframes slideInLeft {
                from {
                    opacity: 0;
                    transform: translateX(-40px);
                }
                to {
                    opacity: 1;
                    transform: translateX(0);
                }
            }

            @keyframes slideInRight {
                from {
                    opacity: 0;
                    transform: translateX(40px);
                }
                to {
                    opacity: 1;
                    transform: translateX(0);
                }
            }

            /* ===== RESPONSIVE ===== */
            @media (max-width: 1024px) {
                .signup-wrapper {
                    gap: 40px;
                }

                .signup-form-wrapper {
                    padding: 45px;
                }

                .form-title {
                    font-size: 28px;
                }

                .brand-logo {
                    font-size: 38px;
                }
            }

            @media (max-width: 768px) {
                .signup-wrapper {
                    grid-template-columns: 1fr;
                    gap: 30px;
                }

                .brand-section {
                    display: none;
                }

                .signup-form-wrapper {
                    padding: 40px 30px;
                    border-radius: 12px;
                    max-height: none;
                }

                .form-header {
                    margin-bottom: 28px;
                }

                .form-title {
                    font-size: 24px;
                }

                .form-row {
                    grid-template-columns: 1fr;
                    gap: 0;
                }

                input[type="text"],
                input[type="email"],
                input[type="password"],
                input[type="tel"],
                select {
                    padding: 13px 14px;
                    font-size: 16px;
                }

                .form-group {
                    margin-bottom: 18px;
                }
            }

            @media (max-width: 480px) {
                .signup-form-wrapper {
                    padding: 30px 20px;
                }

                .form-header {
                    margin-bottom: 24px;
                }

                .form-title {
                    font-size: 20px;
                    margin-bottom: 10px;
                }

                .form-subtitle {
                    font-size: 14px;
                }

                input[type="text"],
                input[type="email"],
                input[type="password"],
                input[type="tel"],
                select {
                    padding: 12px 12px;
                    font-size: 16px;
                }

                .form-group {
                    margin-bottom: 16px;
                }

                .form-row {
                    grid-template-columns: 1fr;
                }

                .divider {
                    margin: 20px 0;
                    font-size: 12px;
                }

                .login-text {
                    font-size: 13px;
                }

                .terms-checkbox {
                    padding: 12px;
                }

                .terms-text {
                    font-size: 12px;
                }
            }

            /* ===== SMOOTH TRANSITIONS ===== */
            input, button, a {
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            }
        </style>
    </head>
    <body>
        <div class="signup-wrapper">
            <!-- Brand Section -->
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

            <!-- Signup Form -->
            <div class="signup-form-wrapper">
                <div class="form-header">
                    <h1 class="form-title">Tạo tài khoản</h1>
                    <p class="form-subtitle">Đăng ký để bắt đầu mua sắm</p>
                </div>

                <!-- Hiển thị thông báo lỗi -->
                <c:if test="${not empty error}">
                    <div class="error-message">${error}</div>
                </c:if>

                <!-- Hiển thị thông báo thành công -->
                <c:if test="${not empty success}">
                    <div class="success-message">${success}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/signup" method="post" id="signupForm">

                    <!-- Họ và tên -->
                    <div class="form-group">
                        <label for="fullName">Họ và tên</label>
                        <div class="input-wrapper">
                            <input 
                                type="text"
                                id="fullName"
                                name="fullName"
                                placeholder="Nguyễn Văn A"
                                required
                                minlength="3">
                        </div>
                    </div>

                    <!-- Username -->
                    <div class="form-group">
                        <label for="username">Tên đăng nhập</label>
                        <div class="input-wrapper">
                            <input 
                                type="text"
                                id="username"
                                name="username"
                                placeholder="Tên đăng nhập"
                                value="${param.username}"
                                required
                                minlength="5">
                        </div>
                    </div>

                    <!-- Email -->
                    <div class="form-group">
                        <label for="email">Email</label>
                        <div class="input-wrapper">
                            <input 
                                type="email"
                                id="email"
                                name="email"
                                placeholder="email@gmail.com"
                                value="${param.email}"
                                required>
                        </div>
                    </div>

                    <!-- Số điện thoại -->
                    <div class="form-group">
                        <label for="phone">Số điện thoại</label>
                        <div class="input-wrapper">
                            <input 
                                type="tel"
                                id="phone"
                                name="phone"
                                placeholder="0123456789"
                                value="${param.phone}"
                                pattern="[0-9]{10,11}">
                        </div>
                    </div>

                    <!-- Mật khẩu -->
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

                    </div>

                    <!-- Xác nhận mật khẩu -->
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

                    <!-- Vai trò -->
                    <div class="form-group">
                        <label for="roleId">Đăng ký với vai trò</label>
                        <div class="input-wrapper">
                            <select id="roleId" name="roleId" required>
                                <option value="1" <c:if test="${param.roleId == '1' || empty param.roleId}">selected</c:if>>Khách hàng (Customer)</option>
                                <option value="4" <c:if test="${param.roleId == '4'}">selected</c:if>>Chủ cửa hàng (Shop Owner)</option>
                            </select>
                        </div>
                    </div>

                    <!-- Điều khoản -->
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

    </body>
</html>

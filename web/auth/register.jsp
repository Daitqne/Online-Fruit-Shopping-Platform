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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/signup.css">
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
                                <option value="5" <c:if test="${param.roleId == '5'}">selected</c:if>>Nhân viên giao hàng (Shipper / Delivery)</option>
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

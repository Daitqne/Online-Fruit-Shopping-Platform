<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - GreenStock</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/auth.css">
</head>
<body>

    <div class="login-card">
        <!-- Back Home -->
        <a href="home" class="back-home">
            <i class="fa-solid fa-arrow-left"></i> Trang chủ
        </a>

        <!-- Logo / Header -->
        <div class="logo-header">
            <a href="home">
                <i class="fa-solid fa-leaf"></i> GreenStock
            </a>
            <p>Chào mừng bạn trở lại! Vui lòng đăng nhập.</p>
        </div>

        <!-- Error Alert if any -->
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message">
                <i class="fa-solid fa-circle-exclamation"></i>
                <span><%= request.getAttribute("error") %></span>
            </div>
        <% } %>

        <!-- Login Form -->
        <form action="login" method="POST">
            <div class="form-group">
                <label for="username">Tên tài khoản</label>
                <div class="input-wrapper">
                    <input type="text" id="username" name="username" class="form-control" placeholder="Nhập tên đăng nhập" required autocomplete="username">
                    <i class="fa-solid fa-user"></i>
                </div>
            </div>

            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <div class="input-wrapper">
                    <input type="password" id="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required autocomplete="current-password">
                    <i class="fa-solid fa-lock"></i>
                </div>
            </div>

            <div class="form-options">
                <label class="remember-me">
                    <input type="checkbox" name="remember"> Ghi nhớ đăng nhập
                </label>
                <a href="forgot-password" class="forgot-pass">Quên mật khẩu?</a>
            </div>

            <button type="submit" class="btn-submit">
                Đăng nhập <i class="fa-solid fa-right-to-bracket"></i>
            </button>
        </form>

        <div class="register-link">
            Chưa có tài khoản? <a href="signup">Đăng ký ngay</a>
        </div>
    </div>

</body>
</html>

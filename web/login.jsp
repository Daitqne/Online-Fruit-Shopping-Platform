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
    
    <style>
        :root {
            --primary: #10B981;
            --primary-hover: #059669;
            --primary-light: #E6F4EA;
            --secondary: #F59E0B;
            --dark: #0F172A;
            --light: #F8FAFC;
            --slate-300: #CBD5E1;
            --slate-400: #94A3B8;
            --slate-600: #475569;
            --white: #FFFFFF;
            --shadow-lg: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
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
            background: linear-gradient(135deg, #E6F4EA 0%, #FFFFFF 100%);
            color: var(--dark);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 1rem;
        }

        .login-card {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            width: 100%;
            max-width: 420px;
            border-radius: 24px;
            padding: 2.5rem;
            box-shadow: var(--shadow-lg);
            border: 1px solid rgba(255, 255, 255, 0.8);
            position: relative;
        }

        .back-home {
            position: absolute;
            top: 1.5rem;
            left: 1.5rem;
            text-decoration: none;
            color: var(--slate-600);
            font-size: 0.9rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.4rem;
            transition: color 0.2s ease;
        }

        .back-home:hover {
            color: var(--primary);
        }

        .logo-header {
            text-align: center;
            margin-bottom: 2rem;
            margin-top: 1rem;
        }

        .logo-header a {
            font-family: var(--font-display);
            font-size: 2rem;
            font-weight: 800;
            color: var(--primary);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .logo-header i {
            color: var(--secondary);
        }

        .logo-header p {
            color: var(--slate-600);
            font-size: 0.9rem;
            margin-top: 0.5rem;
        }

        .form-group {
            margin-bottom: 1.25rem;
            position: relative;
        }

        .form-group label {
            display: block;
            font-size: 0.85rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--slate-600);
        }

        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-wrapper i {
            position: absolute;
            left: 1rem;
            color: var(--slate-400);
            transition: color 0.2s ease;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem 1rem 0.75rem 2.5rem;
            border-radius: 12px;
            border: 1px solid var(--slate-300);
            background-color: var(--light);
            font-family: var(--font-body);
            font-size: 0.95rem;
            outline: none;
            transition: all 0.25s ease;
        }

        .form-control:focus {
            border-color: var(--primary);
            background-color: var(--white);
            box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.15);
        }

        .form-control:focus + i {
            color: var(--primary);
        }

        .form-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.85rem;
            margin-bottom: 1.5rem;
        }

        .remember-me {
            display: flex;
            align-items: center;
            gap: 0.4rem;
            cursor: pointer;
            color: var(--slate-600);
        }

        .remember-me input {
            accent-color: var(--primary);
        }

        .forgot-pass {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.2s ease;
        }

        .forgot-pass:hover {
            color: var(--primary-hover);
        }

        .btn-submit {
            width: 100%;
            background-color: var(--primary);
            color: var(--white);
            border: none;
            padding: 0.8rem;
            border-radius: 12px;
            font-family: var(--font-body);
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(16, 185, 129, 0.2);
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-submit:hover {
            background-color: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(16, 185, 129, 0.3);
        }

        .register-link {
            text-align: center;
            margin-top: 1.5rem;
            font-size: 0.85rem;
            color: var(--slate-600);
        }

        .register-link a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
        }

        .register-link a:hover {
            color: var(--primary-hover);
        }

        /* Error notification */
        .error-message {
            background-color: #FEE2E2;
            border: 1px solid #FCA5A5;
            color: #DC2626;
            padding: 0.75rem;
            border-radius: 10px;
            font-size: 0.85rem;
            margin-bottom: 1.25rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
    </style>
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
                <a href="#" class="forgot-pass">Quên mật khẩu?</a>
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

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt hàng thành công - GreenStock</title>
    
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
            --slate-600: #475569;
            --white: #FFFFFF;
            --font-display: 'Outfit', sans-serif;
            --font-body: 'Plus Jakarta Sans', sans-serif;
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
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
            display: flex;
            flex-direction: column;
            min-height: 100vh;
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
        }

        .nav-actions {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .user-menu-btn {
            background: var(--primary-light);
            color: var(--primary);
            border: none;
            padding: 0.6rem 1.2rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* --- SUCCESS CONTAINER --- */
        .success-container {
            max-width: 650px;
            margin: 10rem auto 6rem;
            padding: 3rem 2rem;
            background: var(--white);
            border-radius: 24px;
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--slate-200);
            text-align: center;
            animation: slideUp 0.4s ease-out;
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .success-icon {
            width: 80px;
            height: 80px;
            background-color: var(--primary-light);
            color: var(--primary);
            font-size: 2.5rem;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            box-shadow: 0 0 0 10px rgba(16, 185, 129, 0.08);
            animation: pop 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275) 0.2s both;
        }

        @keyframes pop {
            0% { transform: scale(0); }
            100% { transform: scale(1); }
        }

        .success-title {
            font-family: var(--font-display);
            font-size: 2rem;
            font-weight: 800;
            color: var(--dark);
            margin-bottom: 0.75rem;
        }

        .success-desc {
            color: var(--slate-600);
            font-size: 1.05rem;
            margin-bottom: 2rem;
            padding: 0 1rem;
        }

        .order-info-card {
            background-color: var(--light);
            border: 1px solid var(--slate-200);
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 2.5rem;
            text-align: left;
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            font-size: 0.95rem;
        }

        .info-label {
            color: var(--slate-600);
            font-weight: 500;
        }

        .info-value {
            font-weight: 700;
            color: var(--dark);
        }

        .actions-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
        }

        @media (max-width: 576px) {
            .actions-group {
                flex-direction: column;
            }
        }

        .btn-primary {
            background-color: var(--primary);
            color: var(--white);
            border: none;
            padding: 0.9rem 2rem;
            border-radius: 14px;
            font-family: var(--font-body);
            font-weight: 700;
            text-decoration: none;
            transition: all 0.2s;
            box-shadow: 0 4px 10px rgba(16, 185, 129, 0.2);
            display: inline-block;
        }

        .btn-primary:hover {
            background-color: var(--primary-hover);
            transform: translateY(-1px);
        }

        .btn-outline {
            background-color: transparent;
            color: var(--slate-600);
            border: 2px solid var(--slate-300);
            padding: 0.8rem 2rem;
            border-radius: 14px;
            font-family: var(--font-body);
            font-weight: 700;
            text-decoration: none;
            transition: all 0.2s;
            display: inline-block;
        }

        .btn-outline:hover {
            background-color: var(--slate-200);
            color: var(--dark);
        }

        /* --- FOOTER --- */
        footer {
            background-color: var(--dark);
            color: var(--white);
            padding: 5rem 2rem 2rem;
            font-size: 0.95rem;
            margin-top: auto;
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
    </style>
</head>
<body>

    <!-- HEADER -->
    <%@include file="../common/header.jsp" %>

    <!-- SUCCESS WRAPPER -->
    <div class="success-container">
        <div class="success-icon">
            <i class="fa-solid fa-check"></i>
        </div>
        <h1 class="success-title">Đặt hàng thành công!</h1>
        <p class="success-desc">
            Cảm ơn bạn đã tin tưởng mua sắm trái cây sạch tại GreenStock. Đơn hàng của bạn đã được ghi nhận trên hệ thống và sẽ được chuẩn bị sớm nhất có thể.
        </p>

        <div class="order-info-card">
            <div class="info-row">
                <span class="info-label">Mã đơn hàng:</span>
                <span class="info-value" style="color: var(--primary);">#${orderId}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Trạng thái đơn hàng:</span>
                <span class="info-value" style="color: var(--secondary);">Chờ xử lý (Pending)</span>
            </div>
            <div class="info-row">
                <span class="info-label">Trạng thái thanh toán:</span>
                <span class="info-value">Chưa thanh toán (Pending)</span>
            </div>
            <div class="info-row" style="border-top: 1px dashed var(--slate-300); padding-top: 0.75rem; margin-top: 0.25rem;">
                <span class="info-label" style="font-weight: 700; color: var(--dark);">Thời gian đặt:</span>
                <span class="info-value" id="orderTime">Vừa xong</span>
            </div>
        </div>

        <div class="actions-group">
            <a href="products" class="btn-primary">Tiếp tục mua sắm</a>
            <a href="home" class="btn-outline">Quay về trang chủ</a>
        </div>
    </div>

    <!-- FOOTER -->
    <%@include file="../common/footer.jsp" %>

    <script>
        // Set dynamic local time for the order placement
        const now = new Date();
        const timeString = now.toLocaleTimeString('vi-VN', { hour: '2-digit', minute: '2-digit' }) + ' - ' + now.toLocaleDateString('vi-VN');
        document.getElementById('orderTime').innerText = timeString;
    </script>
</body>
</html>

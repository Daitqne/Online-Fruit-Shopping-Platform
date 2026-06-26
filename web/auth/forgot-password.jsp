<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>GreenStock - Quên mật khẩu</title>
        <style>
            
            * {
                margin:0;
                padding:0;
                box-sizing:border-box;
            }
            :root {
                --primary:#10b981;
                --primary-dark:#059669;
                --primary-light:#ecfdf5;
                --text-primary:#1f2937;
                --text-secondary:#6b7280;
                --bg-light:#f9fafb;
                --border-color:#e5e7eb;
                --shadow-lg:0 20px 40px rgba(0,0,0,0.12);
            }
            body {
                font-family:'Segoe UI',Tahoma,Verdana,sans-serif;
                background:linear-gradient(135deg,var(--primary-light),#f0fdf4);
                min-height:100vh;
                display:flex;
                align-items:center;
                justify-content:center;
            }
            .box {
                background:#fff;
                padding:50px;
                border-radius:16px;
                width:420px;
                box-shadow:var(--shadow-lg);
            }
            h1 {
                text-align:center;
                margin-bottom:10px;
            }
            p {
                text-align:center;
                color:var(--text-secondary);
                margin-bottom:30px;
            }
            label {
                font-size:13px;
                font-weight:600;
                display:block;
                margin-bottom:8px;
            }
            input {
                width:100%;
                padding:14px;
                border-radius:10px;
                border:2px solid var(--border-color);
                margin-bottom:20px;
            }
            input:focus {
                outline:none;
                border-color:var(--primary);
            }
            button {
                width:100%;
                padding:14px;
                border:none;
                border-radius:10px;
                background:linear-gradient(135deg,var(--primary),var(--primary-dark));
                color:#fff;
                font-weight:700;
                cursor:pointer;
            }
            .msg {
                text-align:center;
                margin-bottom:15px;
            }
            a {
                display:block;
                text-align:center;
                margin-top:20px;
                color:var(--primary);
            }
        </style>
    </head>
    <body>

        <div class="box">
            <h1>Quên mật khẩu</h1>
            <p>Nhập email để nhận link đặt lại mật khẩu</p>

            <c:if test="${not empty error}">
                <div class="msg" style="color:red">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="msg" style="color:green">${success}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                <label>Email</label>
                <input type="email" name="email" placeholder="Nhập email của bạn" required>

                <button type="submit">Gửi yêu cầu</button>
            </form>

            <a href="${pageContext.request.contextPath}/login">← Quay lại đăng nhập</a>
        </div>

    </body>
</html>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>GreenStock - ${pageTitle}</title>

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">

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
                
                --danger: #EF4444;
                --danger-light: #FEF2F2;
                --danger-hover: #DC2626;
                
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

            .nav-actions {
                display: flex;
                align-items: center;
                gap: 1.5rem;
            }

            /* --- USER MENU --- */
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

            .user-dropdown {
                display: none;
                position: absolute;
                top: 100%;
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
                from { opacity: 0; transform: translateY(-6px); }
                to   { opacity: 1; transform: translateY(0); }
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
                color: var(--danger);
                border-top: 1px solid rgba(226, 232, 240, 0.8);
            }

            .user-dropdown a.logout:hover {
                background: var(--danger-light);
                color: var(--danger-hover);
            }

            /* --- ADMIN MANAGEMENT HUB --- */
            .admin-hub {
                padding: 9rem 2rem 5rem;
                max-width: 1200px;
                margin: 0 auto;
            }

            .admin-header {
                text-align: center;
                margin-bottom: 3rem;
            }

            .admin-header h2 {
                font-family: var(--font-display);
                font-size: 2.5rem;
                font-weight: 800;
                color: var(--dark);
                margin-top: 0.5rem;
            }

            /* --- TAB NAVIGATION SYSTEM --- */
            .tab-nav {
                display: flex;
                justify-content: center;
                gap: 1rem;
                margin-bottom: 2.5rem;
            }

            .tab-btn {
                font-family: var(--font-body);
                font-weight: 700;
                font-size: 1rem;
                text-decoration: none;
                padding: 0.75rem 2rem;
                border-radius: 14px;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                display: flex;
                align-items: center;
                gap: 0.6rem;
                border: 1px solid transparent;
            }

            .tab-btn.customer-tab {
                color: var(--slate-600);
                background: var(--white);
                border-color: rgba(226, 232, 240, 0.8);
            }

            .tab-btn.customer-tab.active {
                background: var(--primary-light);
                color: var(--primary);
                border-color: var(--primary);
            }

            .tab-btn.shop-tab {
                color: var(--slate-600);
                background: var(--white);
                border-color: rgba(226, 232, 240, 0.8);
            }

            .tab-btn.shop-tab.active {
                background: #FEF3C7;
                color: #D97706;
                border-color: var(--secondary);
            }

            .tab-btn:hover:not(.active) {
                transform: translateY(-2px);
                box-shadow: var(--shadow-md);
            }

            /* --- DATA TABLE CARD --- */
            .table-card {
                background: var(--white);
                border-radius: 24px;
                overflow: hidden;
                box-shadow: var(--shadow-sm);
                border: 1px solid rgba(226, 232, 240, 0.8);
                padding: 1.5rem;
            }

            .responsive-table {
                width: 100%;
                overflow-x: auto;
            }

            .management-table {
                width: 100%;
                border-collapse: collapse;
                text-align: left;
                font-size: 0.95rem;
            }

            .management-table th {
                background: #F8FAFC;
                padding: 1rem 1.25rem;
                color: var(--slate-600);
                font-weight: 700;
                font-family: var(--font-display);
                border-bottom: 2px solid #E2E8F0;
            }

            .management-table td {
                padding: 1.25rem;
                border-bottom: 1px solid #F1F5F9;
                color: var(--dark);
            }

            .management-table tr:last-child td {
                border-bottom: none;
            }

            .management-table tr:hover td {
                background-color: #F8FAFC;
            }

            .user-id-badge {
                font-family: var(--font-display);
                font-weight: 700;
                color: var(--slate-600);
            }

            /* --- CUSTOM STATUS BADGES --- */
            .status-badge {
                display: inline-flex;
                align-items: center;
                gap: 0.4rem;
                padding: 0.35rem 0.85rem;
                border-radius: 50px;
                font-size: 0.8rem;
                font-weight: 700;
                letter-spacing: 0.02em;
            }

            .status-badge.active {
                background: var(--primary-light);
                color: var(--primary);
            }

            .status-badge.inactive {
                background: var(--danger-light);
                color: var(--danger);
            }

            /* --- ACTION BUTTONS --- */
            .btn-action {
                font-family: var(--font-body);
                font-weight: 600;
                font-size: 0.85rem;
                padding: 0.5rem 1.25rem;
                border-radius: 10px;
                text-decoration: none;
                transition: all 0.2s ease;
                display: inline-flex;
                align-items: center;
                gap: 0.4rem;
                cursor: pointer;
                border: none;
            }

            .btn-action.block-type {
                background-color: var(--danger-light);
                color: var(--danger);
            }

            .btn-action.block-type:hover {
                background-color: var(--danger);
                color: var(--white);
            }

            .btn-action.unblock-type {
                background-color: var(--primary-light);
                color: var(--primary);
            }

            .btn-action.unblock-type:hover {
                background-color: var(--primary);
                color: var(--white);
            }

            /* --- FOOTER --- */
            footer {
                background-color: var(--dark);
                color: var(--white);
                padding: 3rem 2rem 2rem;
                font-size: 0.95rem;
                margin-top: 5rem;
            }

            .footer-bottom {
                max-width: 1200px;
                margin: 0 auto;
                padding-top: 1.5rem;
                border-top: 1px solid rgba(255, 255, 255, 0.08);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .footer-bottom p {
                color: var(--slate-300);
            }
        </style>
    </head>
    <body>

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
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <div class="user-menu">
                                <button class="user-menu-btn">
                                    <i class="fa-solid fa-circle-user"></i>
                                    Hệ thống Admin
                                    <i class="fa-solid fa-chevron-down" style="font-size:0.75rem;"></i>
                                </button>
                                <div class="user-dropdown">
                                    <a href="profile"><i class="fa-solid fa-user"></i> Tài khoản</a>
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

        <main class="admin-hub">
            <div class="admin-header">
                <span class="section-tag" style="background: var(--primary-light); color: var(--primary); padding: 0.3rem 1rem; border-radius: 50px; font-size: 0.85rem; font-weight: 700; text-transform: uppercase;">
                    Hệ Thống Quản Trị
                </span>
                <h2>${pageTitle}</h2>
            </div>

            <div class="tab-nav">
                <a href="admin-user?type=customer" class="tab-btn customer-tab ${currentType == 'customer' ? 'active' : ''}">
                    <i class="fa-solid fa-users"></i> Chức năng 1: Quản lý Customers
                </a>
                <a href="admin-user?type=shopowner" class="tab-btn shop-tab ${currentType == 'shopowner' ? 'active' : ''}">
                    <i class="fa-solid fa-store"></i> Chức năng 2: Quản lý Shop Owners
                </a>
            </div>

            <div class="table-card">
                <div class="responsive-table">
                    <table class="management-table">
                        <thead>
                            <tr>
                                <th>Mã ID</th>
                                <th>Tài khoản</th>
                                <th>Họ và Tên</th>
                                <th>Email</th>
                                <th>Số điện thoại</th>
                                <th>Trạng thái</th>
                                <th style="text-align: center;">Hành động (Chức năng 3)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty userList}">
                                    <c:forEach items="${userList}" var="u">
                                        <tr>
                                            <td class="user-id-badge">#${u.id}</td>
                                            <td style="font-weight: 600;">${u.username}</td>
                                            <td><c:out value="${u.fullName}" default="Chưa cập nhật"/></td>
                                            <td><c:out value="${u.email}" default="N/A"/></td>
                                            <td><c:out value="${u.phone}" default="N/A"/></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${u.status == 'Active'}">
                                                        <span class="status-badge active">
                                                            <i class="fa-solid fa-circle-check"></i> Active
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge inactive">
                                                            <i class="fa-solid fa-circle-xmark"></i> Inactive
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="text-align: center;">
                                                <c:choose>
                                                    <c:when test="${u.status == 'Active'}">
                                                        <a href="admin-user?action=toggleStatus&id=${u.id}&status=${u.status}&type=${currentType}" 
                                                           class="btn-action block-type" 
                                                           onclick="return confirm('Bạn có chắc chắn muốn KHÓA tài khoản [${u.username}] không?')">
                                                            <i class="fa-solid fa-lock"></i> Block
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="admin-user?action=toggleStatus&id=${u.id}&status=${u.status}&type=${currentType}" 
                                                           class="btn-action unblock-type" 
                                                           onclick="return confirm('Bạn có chắc chắn muốn MỞ KHÓA tài khoản [${u.username}] không?')">
                                                            <i class="fa-solid fa-lock-open"></i> Unblock
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7" style="text-align: center; color: var(--slate-400); padding: 3rem 0;">
                                            <i class="fa-regular fa-folder-open" style="font-size: 2rem; display: block; margin-bottom: 0.5rem;"></i>
                                            Không có tài khoản nào trong danh mục dữ liệu hiện tại.
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>

        <footer>
            <div class="footer-bottom">
                <p>&copy; 2026 GreenStock. Tất cả quyền được bảo lưu.</p>
                <p>Hệ thống quản trị nền tảng an toàn bảo mật.</p>
            </div>
        </footer>

    </body>
</html>
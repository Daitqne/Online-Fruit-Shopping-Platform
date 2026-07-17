<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Membership</title>
        <!-- Google Fonts (Inter) & Bootstrap 5 & FontAwesome 6 -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

        <style>
            :root {
                --sidebar-bg: #073523; /* Màu xanh lá đậm thương hiệu giống GreenStock */
                --sidebar-active: #0f8a5f;
                --bg-body: #f8fafc;
                --border-light: #e2e8f0;

                /* Màu của các hạng */
                --normal-color: #64748b;
                --silver-color: #94a3b8;
                --gold-color: #d97706;
                --diamond-color: #0284c7;
            }

            body {
                font-family: 'Inter', sans-serif;
                background-color: var(--bg-body);
                margin: 0;
                padding: 0;
            }

            /* Layout Container */
            .app-container {
                display: flex;
                min-height: 100vh;
            }

            /* SIDEBAR BÊN TRÁI */
            .sidebar {
                width: 260px;
                background-color: var(--sidebar-bg);
                color: #ffffff;
                display: flex;
                flex-direction: column;
                flex-shrink: 0;
            }

            .sidebar-brand {
                padding: 24px;
                font-size: 22px;
                font-weight: 700;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .sidebar-brand span {
                font-size: 11px;
                font-weight: 400;
                display: block;
                opacity: 0.7;
            }

            .sidebar-menu {
                list-style: none;
                padding: 20px 0;
                margin: 0;
                flex-grow: 1;
            }

            .sidebar-menu li {
                margin-bottom: 4px;
            }

            .sidebar-menu a {
                display: flex;
                align-items: center;
                gap: 12px;
                padding: 12px 24px;
                color: rgba(255, 255, 255, 0.75);
                text-decoration: none;
                font-size: 14px;
                font-weight: 500;
                transition: all 0.2s ease;
            }

            .sidebar-menu a:hover {
                color: #ffffff;
                background-color: rgba(255, 255, 255, 0.05);
            }

            .sidebar-menu li.active a {
                color: #ffffff;
                background-color: var(--sidebar-active);
                border-left: 4px solid #ffffff;
            }

            .sidebar-footer {
                padding: 20px 24px;
                border-top: 1px solid rgba(255, 255, 255, 0.1);
            }

            .sidebar-footer a {
                color: rgba(255, 255, 255, 0.75);
                text-decoration: none;
                font-size: 14px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            /* NỘI DUNG CHÍNH BÊN PHẢI */
            .main-content {
                flex-grow: 1;
                padding: 24px 40px;
                overflow-y: auto;
            }

            /* Top Navbar */
            .top-nav {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 24px;
            }

            .top-nav-right {
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .profile-dropdown {
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 8px;
                font-size: 14px;
                font-weight: 500;
            }

            /* Title Area */
            .page-title {
                font-size: 26px;
                font-weight: 700;
                color: #1e293b;
                margin-bottom: 2px;
            }

            .page-subtitle {
                font-size: 13px;
                color: #64748b;
                margin-bottom: 24px;
            }

            /* Bộ lọc Filter Bar */
            .filter-bar {
                background-color: #ffffff;
                border: 1px solid var(--border-light);
                border-radius: 12px;
                padding: 16px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 24px;
            }

            .search-box {
                position: relative;
                width: 280px;
            }

            .search-box input {
                padding: 8px 12px 8px 36px;
                font-size: 14px;
                border: 1px solid var(--border-light);
                border-radius: 8px;
                width: 100%;
            }

            .search-box i {
                position: absolute;
                left: 12px;
                top: 50%;
                transform: translateY(-50%);
                color: #94a3b8;
            }

            .btn-green-main {
                background-color: var(--sidebar-active);
                color: #ffffff;
                border: none;
                font-size: 14px;
                font-weight: 500;
                padding: 8px 16px;
                border-radius: 8px;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                transition: opacity 0.2s;
            }

            .btn-green-main:hover {
                opacity: 0.9;
                color: #ffffff;
            }

            /* Khung quy định hạng */
            .rules-card {
                background-color: #f0fdf4;
                border: 1px dashed #bbf7d0;
                border-radius: 12px;
                padding: 20px;
                margin-bottom: 24px;
            }

            .rules-title {
                font-size: 13px;
                font-weight: 600;
                color: #166534;
                margin-bottom: 16px;
            }

            .rule-item {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .rule-item-title {
                font-size: 13px;
                font-weight: 600;
                color: #334155;
            }

            .rule-item-desc {
                font-size: 12px;
                color: #64748b;
            }

            /* Bảng hiển thị thông tin */
            .table-container {
                background-color: #ffffff;
                border: 1px solid var(--border-light);
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 1px 3px rgba(0,0,0,0.02);
            }

            .table thead th {
                background-color: #f8fafc;
                color: #475569;
                font-size: 13px;
                font-weight: 600;
                padding: 14px 20px;
                border-bottom: 1px solid var(--border-light);
            }

            .table tbody td {
                padding: 14px 20px;
                font-size: 13.5px;
                border-bottom: 1px solid #f1f5f9;
                vertical-align: middle;
            }

            .table tbody tr:hover {
                background-color: #f8fafc;
            }

            /* Badge thiết kế dạng nút bo viên */
            .rank-badge {
                background-color: #f1f5f9;
                border: 1px solid var(--border-light);
                color: #475569;
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 11px;
                font-weight: 500;
                display: inline-flex;
                align-items: center;
                gap: 5px;
            }

            .rank-badge.Normal {
                color: var(--normal-color);
            }
            .rank-badge.Silver {
                color: var(--silver-color);
            }
            .rank-badge.Gold {
                color: var(--gold-color);
                border-color: #fde68a;
                background-color: #fef3c7;
            }
            .rank-badge.Diamond {
                color: var(--diamond-color);
                border-color: #bae6fd;
                background-color: #e0f2fe;
            }
            .rank-badge.None {
                color: #ef4444;
                background-color: #fee2e2;
                border-color: #fecaca;
            }

            .points-col {
                font-weight: 600;
                color: #2563eb;
            }

            /* Các nút hành động chính xác */
            .btn-edit-act {
                background-color: var(--sidebar-active);
                color: white !important;
                font-size: 12px;
                font-weight: 500;
                border: none;
                padding: 5px 14px;
                border-radius: 6px;
                display: inline-block;
            }

            .btn-edit-act:hover {
                opacity: 0.9;
            }

            .btn-history-act {
                background: transparent;
                color: var(--sidebar-active) !important;
                border: 1px solid var(--sidebar-active);
                font-size: 12px;
                font-weight: 500;
                padding: 4px 14px;
                border-radius: 6px;
                display: inline-block;
            }

            .btn-history-act:hover {
                background-color: #f0fdf4;
            }

            /* Phân trang Pagination */
            .pagination-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 16px 20px;
                background-color: #ffffff;
                border-top: 1px solid var(--border-light);
                font-size: 13px;
                color: #64748b;
            }
        </style>
    </head>
    <body>

        <div class="app-container">

            <!-- SIDEBAR BÊN TRÁI -->
            <aside class="sidebar">
                <div class="sidebar-brand">
                    <i class="fa-solid fa-leaf text-success me-1"></i> GreenStock
                    <span>Admin Dashboard</span>
                </div>
                <ul class="sidebar-menu">
                    <li>
                        <a href="admin-user?type=customer"><i class="fa-solid fa-users"></i> Quản lý người dùng</a>
                    </li>
                    <li>
                        <a href="admin-productss"><i class="fa-solid fa-box"></i> Quản lý sản phẩm</a>
                    </li>
                    <li>
                        <a href="admin-promotions"><i class="fa-solid fa-ticket"></i> Quản lý Voucher</a>
                    </li>
                    <li>
                        <a href="admin-orders">
                            <i class="fa-solid fa-clock-rotate-left">

                            </i> Theo dõi đơn hàng</a>
                    </li>
                    <li class="active">
                        <a href="admin-membership"><i class="fa-solid fa-star"></i> Quản lý Membership</a>
                    </li>
                </ul>
                <div class="sidebar-footer">
                    <a href="logout"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
                </div>
            </aside>

            <!-- NỘI DUNG CHÍNH BÊN PHẢI -->
            <main class="main-content">

                <!-- Header có ô Profile Admin -->
                <div class="top-nav">
                    <button class="btn btn-sm p-0 border-0" id="sidebar-toggle">
                        <i class="fa-solid fa-bars fs-4 text-secondary"></i>
                    </button>
                    <div class="top-nav-right">
                        <div class="profile-dropdown">
                            <i class="fa-solid fa-circle-user text-secondary fs-4"></i>
                            <span>Admin</span>
                            <i class="fa-solid fa-chevron-down fs-8 text-muted"></i>
                        </div>
                    </div>
                </div>

                <!-- Tiêu đề trang -->
                <h1 class="page-title">Quản lý Membership</h1>
                <div class="page-subtitle">Quản lý hạng thành viên và điểm tích lũy của khách hàng</div>

                <!-- Alert thông báo kết quả -->
                <%-- Banner hiển thị kết quả cập nhật Membership cá nhân --%>
                <c:if test="${not empty param.success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fa-solid fa-circle-check me-2"></i> <c:if test="${param.success == '1'}">
                            <div class="alert alert-success">
                                Cập nhật Membership thành công!
                            </div>
                        </c:if>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <c:if test="${not empty param.error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fa-solid fa-circle-exclamation me-2"></i> <c:if test="${param.error == '1'}">
                            <div class="alert alert-danger">
                                Cập nhật Membership thất bại!
                            </div>
                        </c:if>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <%-- Banner hiển thị kết quả cập nhật Quy định Membership chung --%>
                <c:if test="${not empty param.ruleSuccess}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fa-solid fa-circle-check me-2"></i> Cập nhật quy định Membership thành công!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <c:if test="${not empty param.ruleError}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fa-solid fa-circle-exclamation me-2"></i> Cập nhật quy định Membership thất bại!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <!-- Khung lọc & Tìm kiếm -->
                <form method="GET" action="admin-membership" class="filter-bar">
                    <div class="d-flex gap-2 align-items-center">
                        <div class="search-box">
                            <i class="fa-solid fa-magnifying-glass"></i>
                            <input type="text" name="searchName" value="${searchName}" placeholder="Tìm kiếm theo tên...">
                        </div>
                        <select name="tierFilter" class="form-select form-select-sm" style="width: 150px; border-radius: 8px;" onchange="this.form.submit()">
                            <option value="all" ${tierFilter eq 'all' || empty tierFilter ? 'selected' : ''}>Tất cả hạng</option>
                            <option value="Normal" ${tierFilter eq 'Normal' ? 'selected' : ''}>Normal</option>
                            <option value="Silver" ${tierFilter eq 'Silver' ? 'selected' : ''}>Silver</option>
                            <option value="Gold" ${tierFilter eq 'Gold' ? 'selected' : ''}>Gold</option>
                            <option value="Diamond" ${tierFilter eq 'Diamond' ? 'selected' : ''}>Diamond</option>
                        </select>
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-light btn-sm border" style="border-radius: 8px; font-size: 13.5px;">
                            <i class="fa-solid fa-file-excel text-success me-1"></i> Xuất Excel
                        </button>
                    </div>
                </form>

                <!-- Khung Quy định hạng thành viên -->
                <div class="rules-card">

                    <div class="d-flex justify-content-between align-items-center mb-3">

                        <div class="rules-title">
                            Quy định hạng thành viên
                        </div>

                        <button type="button"
                                class="btn btn-warning btn-sm"
                                data-bs-toggle="modal"
                                data-bs-target="#editRuleModal">

                            <i class="fa-solid fa-pen"></i>
                            Sửa quy định

                        </button>

                    </div>

                    <%-- Hiển thị thông số quy định hạng thành viên động từ DB, nếu rỗng sẽ fallback về giá trị mặc định cũ --%>
                    <div class="row text-center text-md-start">
                        <div class="col-md-3 mb-3 mb-md-0 border-end border-light">
                            <div class="rule-item">
                                <i class="fa-solid fa-circle-user text-secondary fs-4"></i>
                                <div>
                                    <div class="rule-item-title">Normal</div>
                                    <div class="rule-item-desc">0 - ${not empty currentRule ? (currentRule.silverMinPoint - 1) : 99} điểm | Giảm 0%</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3 mb-md-0 border-end border-light">
                            <div class="rule-item">
                                <i class="fa-solid fa-award text-muted fs-4"></i>
                                <div>
                                    <div class="rule-item-title">Silver</div>
                                    <div class="rule-item-desc">${not empty currentRule ? currentRule.silverMinPoint : 100} - ${not empty currentRule ? (currentRule.goldMinPoint - 1) : 499} điểm | Giảm ${not empty currentRule ? currentRule.silverDiscountPercent : 5}%</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3 mb-md-0 border-end border-light">
                            <div class="rule-item">
                                <i class="fa-solid fa-crown text-warning fs-4"></i>
                                <div>
                                    <div class="rule-item-title" style="color: var(--gold-color);">Gold</div>
                                    <div class="rule-item-desc">${not empty currentRule ? currentRule.goldMinPoint : 500} - ${not empty currentRule ? (currentRule.diamondMinPoint - 1) : 999} điểm | Giảm ${not empty currentRule ? currentRule.goldDiscountPercent : 10}%</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="rule-item">
                                <i class="fa-solid fa-gem text-info fs-4"></i>
                                <div>
                                    <div class="rule-item-title" style="color: var(--diamond-color);">Diamond</div>
                                    <div class="rule-item-desc">${not empty currentRule ? currentRule.diamondMinPoint : 1000}+ điểm | Giảm ${not empty currentRule ? currentRule.diamondDiscountPercent : 15}%</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- BẢNG DỮ LIỆU THỰC TẾ -->
                <div class="table-container">
                    <table class="table align-middle mb-0">
                        <thead>
                            <tr>
                                <th class="text-center" style="width: 80px;">STT</th>
                                <th style="width: 120px;">User ID</th>
                                <th>Họ và tên</th>
                                <th class="text-center" style="width: 150px;">Điểm hiện tại</th>
                                <th class="text-center" style="width: 180px;">Hạng hiện tại</th>
                                <th>Ngày cập nhật</th>
                                <th class="text-center" style="width: 220px;">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <%-- KIỂM TRA NẾU CÓ DỮ LIỆU GỬI TỪ SERVLET --%>
                                <c:when test="${not empty membershipList}">
                                    <c:forEach items="${membershipList}" var="m" varStatus="status">
                                        <tr>
                                            <td class="text-center fw-bold text-muted">${status.index + 1}</td>
                                            <td><span class="text-muted fw-semibold">#${m.userId}</span></td>
                                            <td class="fw-semibold ${m.currentPoints == 0 ? 'text-danger' : ''}">
                                                <c:choose>
                                                    <c:when test="${not empty m.fullName}">
                                                        ${m.fullName}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Khách chưa có tài khoản
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-center points-col">${m.currentPoints}</td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${m.currentTier eq 'Normal'}">
                                                        <span class="rank-badge Normal"><i class="fa-solid fa-circle-user"></i> Normal</span>
                                                    </c:when>
                                                    <c:when test="${m.currentTier eq 'Silver'}">
                                                        <span class="rank-badge Silver"><i class="fa-solid fa-award"></i> Silver</span>
                                                    </c:when>
                                                    <c:when test="${m.currentTier eq 'Gold'}">
                                                        <span class="rank-badge Gold"><i class="fa-solid fa-crown"></i> Gold</span>
                                                    </c:when>
                                                    <c:when test="${m.currentTier eq 'Diamond'}">
                                                        <span class="rank-badge Diamond"><i class="fa-solid fa-gem"></i> Diamond</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="rank-badge None">Chưa có</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-muted">
                                                <fmt:formatDate value="${m.tierUpdatedAt}" pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${m.currentPoints > 0 || not empty m.currentTier}">
                                                        <div class="d-flex gap-2 justify-content-center">
                                                            <button type="button" 
                                                                    class="btn btn-edit-act edit-membership-btn"
                                                                    data-userid="${m.userId}"
                                                                    data-fullname="${m.fullName != null ? m.fullName : 'Khách chưa có tài khoản'}"
                                                                    data-points="${m.currentPoints}"
                                                                    data-tier="${m.currentTier != null ? m.currentTier : 'Normal'}"
                                                                    data-override="${m.manualOverride}">
                                                                Sửa
                                                            </button>
                                                            <a href="#" class="btn btn-history-act text-decoration-none" onclick="alert('Chức năng lịch sử điểm đang được phát triển!')">Lịch sử</a>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button type="button" 
                                                                class="btn btn-green-main w-100 text-center py-1 edit-membership-btn" 
                                                                style="font-size: 11px; justify-content: center;"
                                                                data-userid="${m.userId}"
                                                                data-fullname="${m.fullName != null ? m.fullName : 'Khách chưa có tài khoản'}"
                                                                data-points="${m.currentPoints}"
                                                                data-tier="Normal"
                                                                data-override="${m.manualOverride}">
                                                            Thêm Membership
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>

                                <%-- TRƯỜNG HỢP LỖI HOẶC TRỐNG --%>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7" class="text-center text-muted py-4">
                                            Không thể tải dữ liệu từ database. Vui lòng kiểm tra lại kết nối.
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>

                    <!-- Phân trang -->
                    <div class="pagination-container">
                        <div>Hiển thị 1 đến ${membershipList.size()} của ${membershipList.size()} thành viên</div>
                        <nav>
                            <ul class="pagination pagination-sm m-0">
                                <li class="page-item disabled"><span class="page-link">&laquo;</span></li>
                                <li class="page-item active"><span class="page-link" style="background-color: var(--sidebar-active); border-color: var(--sidebar-active);">1</span></li>
                                <li class="page-item disabled"><span class="page-link">&raquo;</span></li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </main>

        </div>

        <!-- Modal Sửa Membership -->
        <!-- Modal sửa quy định Membership -->
        <div class="modal fade" id="editRuleModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <form action="admin-membership" method="POST">
                    <input type="hidden" name="action" value="updateRule">

                    <div class="modal-content">

                        <div class="modal-header">
                            <h5 class="modal-title">
                                Cập nhật quy định Membership
                            </h5>

                            <button type="button"
                                    class="btn-close"
                                    data-bs-dismiss="modal">
                            </button>
                        </div>

                        <div class="modal-body">

                             <%-- Điền dữ liệu cấu hình hiện tại vào modal sửa quy định, fallback về giá trị mặc định nếu chưa có --%>
                             <div class="mb-3">
                                 <label class="form-label">
                                     Bao nhiêu tiền = 1 điểm
                                 </label>

                                 <input type="number"
                                        class="form-control"
                                        name="pointConversionRate"
                                        value="${not empty currentRule ? currentRule.pointConversionRate : 10000}">
                             </div>

                             <div class="row">

                                 <div class="col-md-4">
                                     <label>Silver từ bao nhiêu điểm</label>

                                     <input type="number"
                                            class="form-control"
                                            name="silverMinPoint"
                                            value="${not empty currentRule ? currentRule.silverMinPoint : 100}">
                                 </div>

                                 <div class="col-md-4">
                                     <label>Gold từ bao nhiêu điểm</label>

                                     <input type="number"
                                            class="form-control"
                                            name="goldMinPoint"
                                            value="${not empty currentRule ? currentRule.goldMinPoint : 500}">
                                 </div>

                                 <div class="col-md-4">
                                     <label>Diamond từ bao nhiêu điểm</label>

                                     <input type="number"
                                            class="form-control"
                                            name="diamondMinPoint"
                                            value="${not empty currentRule ? currentRule.diamondMinPoint : 1000}">
                                 </div>

                             </div>

                             <hr>

                             <div class="row">

                                 <div class="col-md-4">
                                     <label>Giảm giá Silver (%)</label>

                                     <input type="number"
                                            class="form-control"
                                            name="silverDiscountPercent"
                                            value="${not empty currentRule ? currentRule.silverDiscountPercent : 5}">
                                 </div>

                                 <div class="col-md-4">
                                     <label>Giảm giá Gold (%)</label>

                                     <input type="number"
                                            class="form-control"
                                            name="goldDiscountPercent"
                                            value="${not empty currentRule ? currentRule.goldDiscountPercent : 10}">
                                 </div>

                                 <div class="col-md-4">
                                     <label>Giảm giá Diamond (%)</label>

                                     <input type="number"
                                            class="form-control"
                                            name="diamondDiscountPercent"
                                            value="${not empty currentRule ? currentRule.diamondDiscountPercent : 15}">
                                 </div>

                             </div>

                        </div>

                        <div class="modal-footer">

                            <button class="btn btn-secondary"
                                    data-bs-dismiss="modal">
                                Hủy
                            </button>

                            <button class="btn btn-success">
                                Lưu quy định
                            </button>

                        </div>

                    </div>
                </form>
            </div>
        </div>
        <div class="modal fade" id="editMembershipModal" tabindex="-1" aria-labelledby="editMembershipModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <form action="admin-membership" method="POST" class="modal-content">
                    <!-- Hidden action and user id inputs -->
                    <input type="hidden" name="action" value="updateMembership">
                    <input type="hidden" name="editUserId" id="editUserId">

                    <div class="modal-header">
                        <h5 class="modal-title" id="editMembershipModalLabel">Cập nhật Membership</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Khách hàng</label>
                            <input type="text" class="form-control bg-light" id="editFullName" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="editPoints" class="form-label fw-semibold">Điểm hiện tại</label>
                            <input type="number" class="form-control" name="editPoints" id="editPoints" min="0" required>
                        </div>
                        <div class="mb-3">
                            <label for="editTier" class="form-label fw-semibold">Hạng thành viên</label>
                            <select class="form-select" name="editTier" id="editTier">
                                <option value="Normal">Normal</option>
                                <option value="Silver">Silver</option>
                                <option value="Gold">Gold</option>
                                <option value="Diamond">Diamond</option>
                            </select>
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" name="editManualOverride" id="editManualOverride">
                            <label class="form-check-label fw-semibold" for="editManualOverride">Chỉnh sửa thủ công (Không tự động cập nhật theo điểm)</label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-success" style="background-color: var(--sidebar-active); border-color: var(--sidebar-active);">Lưu thay đổi</button>
                    </div>
                </form>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                                document.addEventListener('DOMContentLoaded', function () {
                                                                    const editButtons = document.querySelectorAll('.edit-membership-btn');
                                                                    const editModal = new bootstrap.Modal(document.getElementById('editMembershipModal'));

                                                                    editButtons.forEach(button => {
                                                                        button.addEventListener('click', function () {
                                                                            const userId = this.getAttribute('data-userid');
                                                                            const fullName = this.getAttribute('data-fullname');
                                                                            const points = this.getAttribute('data-points');
                                                                            const tier = this.getAttribute('data-tier');
                                                                            const override = this.getAttribute('data-override') === 'true';

                                                                            document.getElementById('editUserId').value = userId;
                                                                            document.getElementById('editFullName').value = fullName;
                                                                            document.getElementById('editPoints').value = points;
                                                                            document.getElementById('editTier').value = tier || 'Normal';
                                                                            document.getElementById('editManualOverride').checked = override;

                                                                            editModal.show();
                                                                        });
                                                                    });
                                                                });
        </script>
    </body>
</html>
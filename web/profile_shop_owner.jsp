<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
                <meta name="description" content="Hồ sơ cá nhân - GreenStock Shop Owner">
                <meta name="author" content="GreenStock">

                <link rel="preconnect" href="https://fonts.gstatic.com">
                <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icons/icon-48x48.png" />

                <title>Hồ sơ cá nhân | Shop Owner</title>

                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&amp;display=swap"
                    rel="stylesheet">

                <!-- AdminKit CSS -->
                <link href="${pageContext.request.contextPath}/css/light.css" rel="stylesheet">
                <style>
                    /* ---- Profile Card Styles ---- */
                    .profile-hero {
                        background: linear-gradient(135deg, #10B981 0%, #059669 50%, #047857 100%);
                        border-radius: 12px;
                        padding: 2.5rem;
                        color: #fff;
                        display: flex;
                        align-items: center;
                        gap: 2rem;
                        margin-bottom: 1.5rem;
                        position: relative;
                        overflow: hidden;
                    }

                    .profile-hero::before {
                        content: '';
                        position: absolute;
                        top: -50%;
                        right: -10%;
                        width: 300px;
                        height: 300px;
                        background: rgba(255, 255, 255, 0.06);
                        border-radius: 50%;
                    }

                    .profile-hero::after {
                        content: '';
                        position: absolute;
                        bottom: -60%;
                        right: 10%;
                        width: 200px;
                        height: 200px;
                        background: rgba(255, 255, 255, 0.04);
                        border-radius: 50%;
                    }

                    .profile-avatar-wrap {
                        position: relative;
                        flex-shrink: 0;
                    }

                    .profile-avatar-wrap img {
                        width: 110px;
                        height: 110px;
                        border-radius: 50%;
                        border: 4px solid rgba(255, 255, 255, 0.4);
                        object-fit: cover;
                        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.25);
                    }

                    .profile-avatar-badge {
                        position: absolute;
                        bottom: 4px;
                        right: 4px;
                        width: 28px;
                        height: 28px;
                        background: #F59E0B;
                        border-radius: 50%;
                        border: 3px solid #fff;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 0.7rem;
                        color: #fff;
                    }

                    .profile-hero-info h2 {
                        font-size: 1.75rem;
                        font-weight: 700;
                        margin: 0 0 0.3rem;
                        color: #fff;
                    }

                    .profile-hero-info .role-badge {
                        display: inline-block;
                        background: rgba(255, 255, 255, 0.2);
                        border: 1px solid rgba(255, 255, 255, 0.3);
                        color: #fff;
                        padding: 0.25rem 0.85rem;
                        border-radius: 50px;
                        font-size: 0.8rem;
                        font-weight: 600;
                        letter-spacing: 0.05em;
                        margin-bottom: 0.4rem;
                        text-transform: uppercase;
                    }

                    .profile-hero-info .member-since {
                        font-size: 0.85rem;
                        color: rgba(255, 255, 255, 0.75);
                        margin: 0;
                    }

                    .profile-hero-actions {
                        margin-left: auto;
                        display: flex;
                        gap: 0.75rem;
                        align-items: center;
                        flex-wrap: wrap;
                        z-index: 1;
                    }

                    .btn-hero-edit {
                        background: rgba(255, 255, 255, 0.95);
                        color: #059669;
                        border: none;
                        padding: 0.6rem 1.4rem;
                        border-radius: 8px;
                        font-weight: 600;
                        font-size: 0.875rem;
                        display: flex;
                        align-items: center;
                        gap: 0.45rem;
                        text-decoration: none;
                        transition: all 0.25s;
                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                    }

                    .btn-hero-edit:hover {
                        background: #fff;
                        color: #047857;
                        transform: translateY(-1px);
                        box-shadow: 0 6px 18px rgba(0, 0, 0, 0.2);
                    }

                    /* Info Cards */
                    .info-section-card {
                        background: #fff;
                        border-radius: 12px;
                        border: 1px solid #e2e8f0;
                        padding: 1.75rem;
                        margin-bottom: 1.25rem;
                        box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
                    }

                    .info-section-title {
                        font-size: 0.95rem;
                        font-weight: 700;
                        color: #334155;
                        letter-spacing: 0.03em;
                        text-transform: uppercase;
                        margin-bottom: 1.25rem;
                        display: flex;
                        align-items: center;
                        gap: 0.5rem;
                        padding-bottom: 0.75rem;
                        border-bottom: 2px solid #f1f5f9;
                    }

                    .info-section-title svg,
                    .info-section-title i {
                        color: #10B981;
                    }

                    .info-grid {
                        display: grid;
                        grid-template-columns: repeat(2, 1fr);
                        gap: 1.25rem 2rem;
                    }

                    .info-field label {
                        font-size: 0.78rem;
                        font-weight: 600;
                        color: #94a3b8;
                        text-transform: uppercase;
                        letter-spacing: 0.06em;
                        margin-bottom: 0.35rem;
                        display: block;
                    }

                    .info-field .field-value {
                        font-size: 0.95rem;
                        font-weight: 500;
                        color: #1e293b;
                    }

                    .info-field .field-value.empty {
                        color: #94a3b8;
                        font-style: italic;
                        font-weight: 400;
                    }

                    .address-value {
                        font-size: 0.95rem;
                        color: #1e293b;
                        background: #f8fafc;
                        border-radius: 8px;
                        padding: 0.85rem 1rem;
                        border: 1px solid #e2e8f0;
                        line-height: 1.6;
                    }

                    .address-value.empty {
                        color: #94a3b8;
                        font-style: italic;
                    }

                    /* Security Section */
                    .security-btn-group {
                        display: flex;
                        gap: 0.75rem;
                        flex-wrap: wrap;
                    }

                    .btn-change-pass {
                        background: #EFF6FF;
                        color: #2563EB;
                        border: 1px solid #BFDBFE;
                        padding: 0.6rem 1.25rem;
                        border-radius: 8px;
                        font-weight: 600;
                        font-size: 0.875rem;
                        text-decoration: none;
                        display: flex;
                        align-items: center;
                        gap: 0.4rem;
                        transition: all 0.2s;
                    }

                    .btn-change-pass:hover {
                        background: #2563EB;
                        color: #fff;
                        border-color: #2563EB;
                    }

                    .btn-logout-danger {
                        background: #FEF2F2;
                        color: #DC2626;
                        border: 1px solid #FECACA;
                        padding: 0.6rem 1.25rem;
                        border-radius: 8px;
                        font-weight: 600;
                        font-size: 0.875rem;
                        text-decoration: none;
                        display: flex;
                        align-items: center;
                        gap: 0.4rem;
                        transition: all 0.2s;
                    }

                    .btn-logout-danger:hover {
                        background: #DC2626;
                        color: #fff;
                        border-color: #DC2626;
                    }

                    /* Alert */
                    .alert-success-custom {
                        background: #ECFDF5;
                        border: 1px solid #6EE7B7;
                        color: #065F46;
                        padding: 0.9rem 1.25rem;
                        border-radius: 10px;
                        display: flex;
                        align-items: center;
                        gap: 0.65rem;
                        font-weight: 500;
                        font-size: 0.9rem;
                        margin-bottom: 1.25rem;
                        animation: slideDown 0.3s ease;
                    }

                    @keyframes slideDown {
                        from {
                            opacity: 0;
                            transform: translateY(-8px);
                        }

                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }

                    /* Stat tiles */
                    .stat-tiles {
                        display: grid;
                        grid-template-columns: repeat(3, 1fr);
                        gap: 1rem;
                        margin-bottom: 1.25rem;
                    }

                    .stat-tile {
                        background: #fff;
                        border: 1px solid #e2e8f0;
                        border-radius: 12px;
                        padding: 1.25rem;
                        text-align: center;
                        box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
                        transition: box-shadow 0.2s;
                    }

                    .stat-tile:hover {
                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                    }

                    .stat-tile-value {
                        font-size: 2rem;
                        font-weight: 800;
                        color: #10B981;
                        line-height: 1.1;
                    }

                    .stat-tile-label {
                        font-size: 0.78rem;
                        font-weight: 600;
                        color: #94a3b8;
                        text-transform: uppercase;
                        letter-spacing: 0.05em;
                        margin-top: 0.35rem;
                    }

                    @media (max-width: 768px) {
                        .profile-hero {
                            flex-direction: column;
                            text-align: center;
                        }

                        .profile-hero-actions {
                            margin-left: 0;
                            justify-content: center;
                        }

                        .info-grid {
                            grid-template-columns: 1fr;
                        }

                        .stat-tiles {
                            grid-template-columns: 1fr;
                        }
                    }
                </style>
            </head>

            <body data-theme="default" data-layout="fluid" data-sidebar-position="left" data-sidebar-layout="default">
                <div class="wrapper">

                    <!-- ========== SIDEBAR ========== -->
                    <nav id="sidebar" class="sidebar js-sidebar">
                        <div class="sidebar-content js-simplebar">
                            <a class="sidebar-brand" href="products-shop-owner">
                                <span class="sidebar-brand-text align-middle">
                                    Shop Owner
                                    <sup><small class="badge bg-primary text-uppercase">Pro</small></sup>
                                </span>
                                <svg class="sidebar-brand-icon align-middle" width="32px" height="32px"
                                    viewBox="0 0 24 24" fill="none" stroke="#FFFFFF" stroke-width="1.5"
                                    stroke-linecap="square" stroke-linejoin="miter" color="#FFFFFF"
                                    style="margin-left: -3px">
                                    <path d="M12 4L20 8.00004L12 12L4 8.00004L12 4Z"></path>
                                    <path d="M20 12L12 16L4 12"></path>
                                    <path d="M20 16L12 20L4 16"></path>
                                </svg>
                            </a>

                            <div class="sidebar-user">
                                <div class="d-flex justify-content-center">
                                    <div class="flex-shrink-0">
                                        <img src="${not empty sessionScope.user.avatar ? sessionScope.user.avatar : 'https://cdn-icons-png.flaticon.com/512/149/149071.png'}"
                                            class="avatar img-fluid rounded me-1" alt="Avatar" />
                                    </div>
                                    <div class="flex-grow-1 ps-2">
                                        <a class="sidebar-user-title dropdown-toggle" href="#"
                                            data-bs-toggle="dropdown">
                                            ${sessionScope.user.fullName}
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-start">
                                            <a class="dropdown-item" href="shop-owner-profile">
                                                <i class="align-middle me-1" data-feather="user"></i> Hồ sơ
                                            </a>
                                            <div class="dropdown-divider"></div>
                                            <a class="dropdown-item" href="logout">
                                                <i class="align-middle me-1" data-feather="log-out"></i> Đăng xuất
                                            </a>
                                        </div>
                                        <div class="sidebar-user-subtitle">${sessionScope.user.role}</div>
                                    </div>
                                </div>
                            </div>

                            <ul class="sidebar-nav">
                                <li class="sidebar-header">Pages</li>

                                <li class="sidebar-item">
                                    <a class="sidebar-link" href="products-shop-owner">
                                        <i class="align-middle" data-feather="list"></i>
                                        <span class="align-middle">Sản phẩm</span>
                                    </a>
                                </li>

                                <li class="sidebar-item active">
                                    <a class="sidebar-link" href="shop-owner-profile">
                                        <i class="align-middle" data-feather="user"></i>
                                        <span class="align-middle">Hồ sơ cá nhân</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </nav>

                    <!-- ========== MAIN ========== -->
                    <div class="main">

                        <!-- Top Navbar -->
                        <nav class="navbar navbar-expand navbar-light navbar-bg">
                            <a class="sidebar-toggle js-sidebar-toggle">
                                <i class="hamburger align-self-center"></i>
                            </a>

                            <div class="navbar-collapse collapse">
                                <ul class="navbar-nav navbar-align">
                                    <li class="nav-item dropdown">
                                        <a class="nav-icon dropdown-toggle" href="#" id="alertsDropdown"
                                            data-bs-toggle="dropdown">
                                            <div class="position-relative">
                                                <i class="align-middle" data-feather="bell"></i>
                                            </div>
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-end py-0"
                                            aria-labelledby="alertsDropdown">
                                            <div class="dropdown-menu-header">Thông báo</div>
                                            <div class="dropdown-menu-footer">
                                                <a href="#" class="text-muted">Xem tất cả thông báo</a>
                                            </div>
                                        </div>
                                    </li>

                                    <li class="nav-item">
                                        <a class="nav-icon js-fullscreen d-none d-lg-block" href="#">
                                            <div class="position-relative">
                                                <i class="align-middle" data-feather="maximize"></i>
                                            </div>
                                        </a>
                                    </li>

                                    <li class="nav-item dropdown">
                                        <a class="nav-icon pe-md-0 dropdown-toggle" href="#" data-bs-toggle="dropdown">
                                            <img src="${not empty sessionScope.user.avatar ? sessionScope.user.avatar : 'https://cdn-icons-png.flaticon.com/512/149/149071.png'}"
                                                class="avatar img-fluid rounded" alt="Avatar" />
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-end">
                                            <a class="dropdown-item" href="shop-owner-profile">
                                                <i class="align-middle me-1" data-feather="user"></i> Hồ sơ
                                            </a>
                                            <div class="dropdown-divider"></div>
                                            <a class="dropdown-item" href="logout">
                                                <i class="align-middle me-1" data-feather="log-out"></i> Đăng xuất
                                            </a>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </nav>

                        <!-- ========== CONTENT ========== -->
                        <main class="content">
                            <div class="container-fluid p-0">

                                <div class="d-flex align-items-center justify-content-between mb-3">
                                    <h1 class="h3 mb-0">Hồ sơ cá nhân</h1>
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb mb-0">
                                            <li class="breadcrumb-item">
                                                <a href="products-shop-owner">Dashboard</a>
                                            </li>
                                            <li class="breadcrumb-item active">Hồ sơ</li>
                                        </ol>
                                    </nav>
                                </div>

                                <!-- Success Alert -->
                                <c:if test="${param.success eq 'true'}">
                                    <div class="alert-success-custom">
                                        <i data-feather="check-circle" style="width:18px;height:18px;"></i>
                                        <span>Cập nhật thông tin cá nhân thành công!</span>
                                    </div>
                                </c:if>
                                <c:if test="${param.success eq 'password'}">
                                    <div class="alert-success-custom">
                                        <i data-feather="check-circle" style="width:18px;height:18px;"></i>
                                        <span>Đổi mật khẩu thành công!</span>
                                    </div>
                                </c:if>

                                <!-- Profile Hero Banner -->
                                <div class="profile-hero">
                                    <div class="profile-avatar-wrap">
                                        <img src="${not empty sessionScope.user.avatar ? sessionScope.user.avatar : 'https://cdn-icons-png.flaticon.com/512/149/149071.png'}"
                                            alt="Avatar">
                                        <div class="profile-avatar-badge">
                                            <i class="fa-solid fa-store" style="font-size:0.65rem;"></i>
                                        </div>
                                    </div>

                                    <div class="profile-hero-info">
                                        <h2>${sessionScope.user.fullName}</h2>
                                        <div class="role-badge">
                                            <c:choose>
                                                <c:when test="${sessionScope.user.role eq 'Shop Owner'}">Shop Owner
                                                </c:when>
                                                <c:otherwise>${sessionScope.user.role}</c:otherwise>
                                            </c:choose>
                                        </div>
                                        <p class="member-since">
                                            <i class="fa-regular fa-calendar" style="margin-right:4px;"></i>
                                            Thành viên từ 2026 &nbsp;•&nbsp;
                                            <i class="fa-solid fa-envelope" style="margin-right:4px;"></i>
                                            ${sessionScope.user.email}
                                        </p>
                                    </div>

                                    <div class="profile-hero-actions">
                                        <a href="edit-profile-shop-owner" class="btn-hero-edit">
                                            <i data-feather="edit-2" style="width:15px;height:15px;"></i>
                                            Chỉnh sửa hồ sơ
                                        </a>
                                    </div>
                                </div>

                                <!-- Stat Tiles -->
                                <div class="stat-tiles">
                                    <div class="stat-tile">
                                        <div class="stat-tile-value" id="stat-products">${totalProducts}</div>
                                        <div class="stat-tile-label">Tổng sản phẩm</div>
                                    </div>
                                    <div class="stat-tile">
                                        <div class="stat-tile-value" style="color:#F59E0B;">${featuredProducts}</div>
                                        <div class="stat-tile-label">Sản phẩm nổi bật</div>
                                    </div>
                                    <div class="stat-tile">
                                        <div class="stat-tile-value" style="color:#6366F1;">${totalCategories}</div>
                                        <div class="stat-tile-label">Danh mục</div>
                                    </div>
                                </div>

                                <div class="row">
                                    <!-- Left Column: Personal Info & Address -->
                                    <div class="col-12 col-lg-7">

                                        <!-- Personal Info -->
                                        <div class="info-section-card">
                                            <div class="info-section-title">
                                                <i data-feather="user" style="width:16px;height:16px;"></i>
                                                Thông tin cá nhân
                                            </div>
                                            <div class="info-grid">
                                                <div class="info-field">
                                                    <label>Họ và tên</label>
                                                    <div class="field-value">${sessionScope.user.fullName}</div>
                                                </div>
                                                <div class="info-field">
                                                    <label>Email</label>
                                                    <div class="field-value">${sessionScope.user.email}</div>
                                                </div>
                                                <div class="info-field">
                                                    <label>Số điện thoại</label>
                                                    <div
                                                        class="field-value <c:if test='${empty sessionScope.user.phone}'>empty</c:if>">
                                                        <c:choose>
                                                            <c:when test="${not empty sessionScope.user.phone}">
                                                                ${sessionScope.user.phone}</c:when>
                                                            <c:otherwise>Chưa cập nhật</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                                <div class="info-field">
                                                    <label>Giới tính</label>
                                                    <div
                                                        class="field-value <c:if test='${empty sessionScope.user.gender}'>empty</c:if>">
                                                        <c:choose>
                                                            <c:when test="${not empty sessionScope.user.gender}">
                                                                ${sessionScope.user.gender}</c:when>
                                                            <c:otherwise>Chưa cập nhật</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                                <div class="info-field">
                                                    <label>Ngày sinh</label>
                                                    <div
                                                        class="field-value <c:if test='${empty sessionScope.user.dob}'>empty</c:if>">
                                                        <c:choose>
                                                            <c:when test="${not empty sessionScope.user.dob}">
                                                                ${sessionScope.user.dob}</c:when>
                                                            <c:otherwise>Chưa cập nhật</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                                <div class="info-field">
                                                    <label>Vai trò</label>
                                                    <div class="field-value">
                                                        <span class="badge bg-success"
                                                            style="font-size:0.8rem;padding:0.35rem 0.75rem;">
                                                            ${sessionScope.user.role}
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Address -->
                                        <div class="info-section-card">
                                            <div class="info-section-title">
                                                <i data-feather="map-pin" style="width:16px;height:16px;"></i>
                                                Địa chỉ
                                            </div>
                                            <div
                                                class="address-value <c:if test='${empty sessionScope.user.address}'>empty</c:if>">
                                                <c:choose>
                                                    <c:when test="${not empty sessionScope.user.address}">
                                                        ${sessionScope.user.address}</c:when>
                                                    <c:otherwise>Chưa cập nhật địa chỉ.</c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Right Column: Security & Quick Links -->
                                    <div class="col-12 col-lg-5">

                                        <!-- Security -->
                                        <div class="info-section-card">
                                            <div class="info-section-title">
                                                <i data-feather="shield" style="width:16px;height:16px;"></i>
                                                Bảo mật &amp; Tài khoản
                                            </div>
                                            <div class="security-btn-group">
                                                <a href="change-password" class="btn-change-pass">
                                                    <i data-feather="lock" style="width:15px;height:15px;"></i>
                                                    Đổi mật khẩu
                                                </a>
                                                <a href="logout" class="btn-logout-danger">
                                                    <i data-feather="log-out" style="width:15px;height:15px;"></i>
                                                    Đăng xuất
                                                </a>
                                            </div>
                                        </div>

                                        <!-- Quick Actions -->
                                        <div class="info-section-card">
                                            <div class="info-section-title">
                                                <i data-feather="zap" style="width:16px;height:16px;"></i>
                                                Truy cập nhanh
                                            </div>
                                            <div class="d-grid gap-2">
                                                <a href="products-shop-owner"
                                                    class="btn btn-outline-success d-flex align-items-center gap-2">
                                                    <i data-feather="list" style="width:15px;height:15px;"></i>
                                                    Quản lý sản phẩm
                                                </a>
                                                <a href="add-product"
                                                    class="btn btn-outline-primary d-flex align-items-center gap-2">
                                                    <i data-feather="plus-circle" style="width:15px;height:15px;"></i>
                                                    Thêm sản phẩm mới
                                                </a>
                                                <a href="edit-profile-shop-owner"
                                                    class="btn btn-outline-secondary d-flex align-items-center gap-2">
                                                    <i data-feather="edit" style="width:15px;height:15px;"></i>
                                                    Chỉnh sửa hồ sơ
                                                </a>
                                            </div>
                                        </div>

                                        <!-- Account Status -->
                                        <div class="info-section-card">
                                            <div class="info-section-title">
                                                <i data-feather="info" style="width:16px;height:16px;"></i>
                                                Trạng thái tài khoản
                                            </div>
                                            <div class="d-flex align-items-center gap-3">
                                                <div>
                                                    <span class="badge bg-success"
                                                        style="font-size:0.85rem;padding:0.4rem 0.9rem;">
                                                        ● Đang hoạt động
                                                    </span>
                                                </div>
                                                <div style="font-size:0.82rem;color:#64748b;">
                                                    Tài khoản của bạn đang hoạt động bình thường.
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </main>

                        <!-- Footer -->
                        <footer class="footer">
                            <div class="container-fluid">
                                <div class="row text-muted">
                                    <div class="col-6 text-start">
                                        <p class="mb-0">
                                            <strong>GreenStock</strong> &copy; 2026 — Shop Owner Panel
                                        </p>
                                    </div>
                                    <div class="col-6 text-end">
                                        <ul class="list-inline">
                                            <li class="list-inline-item">
                                                <a class="text-muted" href="#">Hỗ trợ</a>
                                            </li>
                                            <li class="list-inline-item">
                                                <a class="text-muted" href="#">Bảo mật</a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </footer>

                    </div>
                </div>

                <!-- FontAwesome for profile avatar badge icon -->
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

                <script src="${pageContext.request.contextPath}/js/app.js"></script>

                <script>
                    // Feather Icons init (already done in app.js but re-run after alert icons)
                    document.addEventListener("DOMContentLoaded", function () {
                        if (typeof feather !== 'undefined') {
                            feather.replace();
                        }
                    });
                </script>
            </body>

            </html>
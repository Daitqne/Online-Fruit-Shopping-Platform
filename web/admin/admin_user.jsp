<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Quản lý người dùng - GreenStock Admin">
    <meta name="author" content="GreenStock">

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icons/icon-48x48.png" />

    <title>${pageTitle} | Admin</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&amp;display=swap" rel="stylesheet">

    <!-- AdminKit CSS -->
    <link href="${pageContext.request.contextPath}/css/vendor/light.css" rel="stylesheet">
    <style>
        /* ---- Alert Success Custom ---- */
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

        /* ---- Tab Navigation ---- */
        .nav-tabs-custom {
            border-bottom: 2px solid #e2e8f0;
            margin-bottom: 1.5rem;
        }

        .nav-tabs-custom .nav-link {
            border: none;
            color: #64748b;
            font-weight: 600;
            padding: 0.75rem 1.5rem;
            position: relative;
        }

        .nav-tabs-custom .nav-link:hover {
            color: #10B981;
        }

        .nav-tabs-custom .nav-link.active {
            color: #10B981;
            background: transparent;
        }

        .nav-tabs-custom .nav-link.active::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            right: 0;
            height: 2px;
            background: #10B981;
        }

        /* ---- Status Badges ---- */
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
            background: #ECFDF5;
            color: #10B981;
        }

        .status-badge.inactive {
            background: #FEF2F2;
            color: #EF4444;
        }

        /* ---- Action Buttons ---- */
        .btn-block-user {
            background-color: #FEF2F2;
            border-color: #FCA5A5;
            color: #EF4444;
            font-weight: 600;
            font-size: 0.85rem;
            padding: 0.4rem 1rem;
        }

        .btn-block-user:hover {
            background-color: #EF4444;
            border-color: #DC2626;
            color: #fff;
        }

        .btn-unblock-user {
            background-color: #ECFDF5;
            border-color: #6EE7B7;
            color: #10B981;
            font-weight: 600;
            font-size: 0.85rem;
            padding: 0.4rem 1rem;
        }

        .btn-unblock-user:hover {
            background-color: #10B981;
            border-color: #059669;
            color: #fff;
        }

        /* ---- Table Adjustments ---- */
        .table > :not(caption) > * > * {
            padding: 0.85rem 1rem;
            vertical-align: middle;
        }

        .user-id-badge {
            font-weight: 700;
            color: #64748b;
        }

        /* ---- Stat tiles ---- */
        .stat-tiles {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1rem;
            margin-bottom: 1.5rem;
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
                <a class="sidebar-brand" href="admin-user">
                    <span class="sidebar-brand-text align-middle">
                        Admin Panel
                        <sup><small class="badge bg-danger text-uppercase">Admin</small></sup>
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
                            <a>
                               <div class="sidebar-user-subtitle">${sessionScope.user.fullName}</div> 
                            </a>
                            <div class="sidebar-user-subtitle">${sessionScope.user.role}</div>
                        </div>
                    </div>
                </div>

                <ul class="sidebar-nav">
                    <li class="sidebar-header">Quản trị</li>

                    <li class="sidebar-item active">
                        <a class="sidebar-link" href="admin-user?type=customer">
                            <i class="align-middle" data-feather="users"></i>
                            <span class="align-middle">Quản lý người dùng</span>
                        </a>
                    </li>

                    <li class="sidebar-item">
                        <a class="sidebar-link" href="admin-products">
                            <i class="align-middle" data-feather="package"></i>
                            <span class="align-middle">Quản lý sản phẩm</span>
                        </a>
                    </li>
                    <li class="sidebar-item active">
                            <a class="sidebar-link" href="admin-promotions">
                                <i class="align-middle" data-feather="gift"></i> 
                                <span class="align-middle">Quản lý Voucher</span>
                            </a>
                        </li>
                        <li class="sidebar-item active">
                        <a class="sidebar-link" href="admin-orders">
                            <i class="align-middle" data-feather="activity"></i>
                            <span class="align-middle">Theo dõi đơn hàng</span>
                        </a>
                    </li>
                    <li class="sidebar-item active">
                            <a class="sidebar-link" href="admin-membership">
                                <i class="align-middle" data-feather="activity"></i>
                                <span class="align-middle">Quản lý Membership</span>
                            </a>
                        </li>
                </ul>
            </div>
        </nav>

        <!-- ========== MAIN CONTENT ========== -->
        <div class="main">
            <nav class="navbar navbar-expand navbar-light navbar-bg">
                <a class="sidebar-toggle js-sidebar-toggle">
                    <i class="hamburger align-self-center"></i>
                </a>

                <form class="d-none d-sm-inline-block">
                    <div class="input-group input-group-navbar">
                        <input type="text" class="form-control" placeholder="Tìm kiếm..." aria-label="Search">
                        <button class="btn" type="button">
                            <i class="align-middle" data-feather="search"></i>
                        </button>
                    </div>
                </form>

                <div class="navbar-collapse collapse">
                    <ul class="navbar-nav navbar-align">
                        <li class="nav-item dropdown">
                            <a class="nav-icon dropdown-toggle d-inline-block d-sm-none" href="#" data-bs-toggle="dropdown">
                                <i class="align-middle" data-feather="settings"></i>
                            </a>

                            <a class="nav-link dropdown-toggle d-none d-sm-inline-block" href="#" data-bs-toggle="dropdown">
                                <img src="${not empty sessionScope.user.avatar ? sessionScope.user.avatar : 'https://cdn-icons-png.flaticon.com/512/149/149071.png'}" 
                                    class="avatar img-fluid rounded-circle me-1" alt="Avatar" />
                                <span class="text-dark">${sessionScope.user.fullName}</span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-end">
                                <a class="dropdown-item" href="logout">
                                    <i class="align-middle me-1" data-feather="log-out"></i> Đăng xuất
                                </a>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>

            <main class="content">
                <div class="container-fluid p-0">
                    <div class="row">
                        <div class="col-12">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h1 class="h3 mb-0"><strong>${pageTitle}</strong></h1>
                            </div>
                        </div>
                    </div>

                    <!-- Tab Navigation -->
                    <div class="row">
                        <div class="col-12">
                            <ul class="nav nav-tabs nav-tabs-custom">
                                <li class="nav-item">
                                    <a class="nav-link ${currentType == 'customer' ? 'active' : ''}" 
                                       href="admin-user?type=customer">
                                        <i data-feather="users" style="width: 16px; height: 16px;"></i>
                                        Khách hàng (Customer)
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link ${currentType == 'shopowner' ? 'active' : ''}" 
                                       href="admin-user?type=shopowner">
                                        <i data-feather="shopping-bag" style="width: 16px; height: 16px;"></i>
                                        Chủ cửa hàng (Shop Owner)
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <!-- Statistics -->
                    <div class="row">
                        <div class="col-12">
                            <div class="stat-tiles">
                                <div class="stat-tile">
                                    <div class="stat-tile-value">${fn:length(userList)}</div>
                                    <div class="stat-tile-label">Tổng số tài khoản</div>
                                </div>
                                <div class="stat-tile">
                                    <div class="stat-tile-value" style="color: #10B981;">
                                        <c:set var="activeCount" value="0"/>
                                        <c:forEach items="${userList}" var="u">
                                            <c:if test="${u.status == 'Active'}">
                                                <c:set var="activeCount" value="${activeCount + 1}"/>
                                            </c:if>
                                        </c:forEach>
                                        ${activeCount}
                                    </div>
                                    <div class="stat-tile-label">Đang hoạt động</div>
                                </div>
                                <div class="stat-tile">
                                    <div class="stat-tile-value" style="color: #EF4444;">
                                        <c:set var="inactiveCount" value="0"/>
                                        <c:forEach items="${userList}" var="u">
                                            <c:if test="${u.status == 'Inactive'}">
                                                <c:set var="inactiveCount" value="${inactiveCount + 1}"/>
                                            </c:if>
                                        </c:forEach>
                                        ${inactiveCount}
                                    </div>
                                    <div class="stat-tile-label">Bị khóa</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- User Table -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Danh sách ${currentType == 'customer' ? 'Customer' : 'Shop Owner'}</h5>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Mã ID</th>
                                                    <th>Tài khoản</th>
                                                    <th>Họ và Tên</th>
                                                    <th>Email</th>
                                                    <th>Số điện thoại</th>
                                                    <th>Trạng thái</th>
                                                    <th style="text-align: center;">Hành động</th>
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
                                                                                <i data-feather="check-circle" style="width: 14px; height: 14px;"></i> Active
                                                                            </span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span class="status-badge inactive">
                                                                                <i data-feather="x-circle" style="width: 14px; height: 14px;"></i> Inactive
                                                                            </span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                <td style="text-align: center;">
                                                                    <c:choose>
                                                                        <c:when test="${u.status == 'Active'}">
                                                                            <a href="admin-user?action=toggleStatus&id=${u.id}&status=${u.status}&type=${currentType}" 
                                                                               class="btn btn-sm btn-block-user" 
                                                                               onclick="return confirm('Bạn có chắc chắn muốn KHÓA tài khoản [${u.username}] không?')">
                                                                                <i data-feather="lock" style="width: 14px; height: 14px;"></i> Block
                                                                            </a>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <a href="admin-user?action=toggleStatus&id=${u.id}&status=${u.status}&type=${currentType}" 
                                                                               class="btn btn-sm btn-unblock-user" 
                                                                               onclick="return confirm('Bạn có chắc chắn muốn MỞ KHÓA tài khoản [${u.username}] không?')">
                                                                                <i data-feather="unlock" style="width: 14px; height: 14px;"></i> Unblock
                                                                            </a>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <tr>
                                                            <td colspan="7" style="text-align: center; color: #94a3b8; padding: 3rem 0;">
                                                                <i data-feather="inbox" style="width: 48px; height: 48px; margin-bottom: 0.5rem;"></i>
                                                                <p>Không có tài khoản nào trong danh mục này.</p>
                                                            </td>
                                                        </tr>
                                                    </c:otherwise>
                                                </c:choose>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>

            <footer class="footer">
                <div class="container-fluid">
                    <div class="row text-muted">
                        <div class="col-6 text-start">
                            <p class="mb-0">
                                <a href="#" class="text-muted"><strong>GreenStock Admin Panel</strong></a> &copy; 2026
                            </p>
                        </div>
                        <div class="col-6 text-end">
                            <ul class="list-inline">
                                <li class="list-inline-item">
                                    <a class="text-muted" href="#">Hỗ trợ</a>
                                </li>
                                <li class="list-inline-item">
                                    <a class="text-muted" href="#">Trung tâm trợ giúp</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/app.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Initialize Feather icons
            if (typeof feather !== 'undefined') {
                feather.replace();
            }
        });
    </script>
</body>
</html>


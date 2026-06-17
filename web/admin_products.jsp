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
    <meta name="description" content="Quản lý sản phẩm - GreenStock Admin">
    <meta name="author" content="GreenStock">

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icons/icon-48x48.png" />

    <title>${pageTitle} | Admin</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&amp;display=swap" rel="stylesheet">

    <!-- AdminKit CSS -->
    <link href="${pageContext.request.contextPath}/css/light.css" rel="stylesheet">
    <style>
        /* ---- Product Thumbnail ---- */
        .product-thumb {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
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

        .status-badge.available {
            background: #ECFDF5;
            color: #10B981;
        }

        .status-badge.featured {
            background: #FEF3C7;
            color: #D97706;
        }

        .status-badge.unavailable {
            background: #FEF2F2;
            color: #EF4444;
        }

        /* ---- Action Buttons ---- */
        .btn-block-product {
            background-color: #FEF2F2;
            border-color: #FCA5A5;
            color: #EF4444;
            font-weight: 600;
            font-size: 0.85rem;
            padding: 0.4rem 1rem;
        }

        .btn-block-product:hover {
            background-color: #EF4444;
            border-color: #DC2626;
            color: #fff;
        }

        .btn-unblock-product {
            background-color: #ECFDF5;
            border-color: #6EE7B7;
            color: #10B981;
            font-weight: 600;
            font-size: 0.85rem;
            padding: 0.4rem 1rem;
        }

        .btn-unblock-product:hover {
            background-color: #10B981;
            border-color: #059669;
            color: #fff;
        }

        /* ---- Table Adjustments ---- */
        .table > :not(caption) > * > * {
            padding: 0.85rem 1rem;
            vertical-align: middle;
        }

        .product-id-badge {
            font-weight: 700;
            color: #64748b;
        }

        /* ---- Stat tiles ---- */
        .stat-tiles {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
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

        .price-original {
            text-decoration: line-through;
            color: #94a3b8;
            font-size: 0.82rem;
            margin-right: 5px;
        }

        .price-promo {
            color: #EF4444;
            font-weight: 700;
        }

        .price-normal {
            color: #10B981;
            font-weight: 700;
        }

        @media (max-width: 768px) {
            .stat-tiles {
                grid-template-columns: repeat(2, 1fr);
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
                            <a class="sidebar-user-title dropdown-toggle" href="#"
                                data-bs-toggle="dropdown">
                                ${sessionScope.user.fullName}
                            </a>
                            <div class="dropdown-menu dropdown-menu-start">
                                <a class="dropdown-item" href="profile">
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
                    <li class="sidebar-header">Quản trị</li>

                    <li class="sidebar-item">
                        <a class="sidebar-link" href="admin-user?type=customer">
                            <i class="align-middle" data-feather="users"></i>
                            <span class="align-middle">Quản lý người dùng</span>
                        </a>
                    </li>

                    <li class="sidebar-item active">
                        <a class="sidebar-link" href="admin-products">
                            <i class="align-middle" data-feather="package"></i>
                            <span class="align-middle">Quản lý sản phẩm</span>
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
                                <a class="dropdown-item" href="profile">
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

            <main class="content">
                <div class="container-fluid p-0">
                    <div class="row">
                        <div class="col-12">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h1 class="h3 mb-0"><strong>${pageTitle}</strong></h1>
                            </div>
                        </div>
                    </div>

                    <!-- Statistics -->
                    <div class="row">
                        <div class="col-12">
                            <div class="stat-tiles">
                                <div class="stat-tile">
                                    <div class="stat-tile-value">${fn:length(productList)}</div>
                                    <div class="stat-tile-label">Tổng sản phẩm</div>
                                </div>
                                <div class="stat-tile">
                                    <div class="stat-tile-value" style="color: #10B981;">
                                        <c:set var="availableCount" value="0"/>
                                        <c:forEach items="${productList}" var="p">
                                            <c:if test="${p.status == 'Available'}">
                                                <c:set var="availableCount" value="${availableCount + 1}"/>
                                            </c:if>
                                        </c:forEach>
                                        ${availableCount}
                                    </div>
                                    <div class="stat-tile-label">Đang bán</div>
                                </div>
                                <div class="stat-tile">
                                    <div class="stat-tile-value" style="color: #D97706;">
                                        <c:set var="featuredCount" value="0"/>
                                        <c:forEach items="${productList}" var="p">
                                            <c:if test="${p.status == 'Featured'}">
                                                <c:set var="featuredCount" value="${featuredCount + 1}"/>
                                            </c:if>
                                        </c:forEach>
                                        ${featuredCount}
                                    </div>
                                    <div class="stat-tile-label">Nổi bật</div>
                                </div>
                                <div class="stat-tile">
                                    <div class="stat-tile-value" style="color: #EF4444;">
                                        <c:set var="unavailableCount" value="0"/>
                                        <c:forEach items="${productList}" var="p">
                                            <c:if test="${p.status == 'Unavailable'}">
                                                <c:set var="unavailableCount" value="${unavailableCount + 1}"/>
                                            </c:if>
                                        </c:forEach>
                                        ${unavailableCount}
                                    </div>
                                    <div class="stat-tile-label">Bị khóa</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Product Table -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Danh sách tất cả sản phẩm</h5>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Mã ID</th>
                                                    <th>Hình ảnh</th>
                                                    <th>Tên sản phẩm</th>
                                                    <th>Giá</th>
                                                    <th>Danh mục</th>
                                                    <th>Shop Owner</th>
                                                    <th>Trạng thái</th>
                                                    <th style="text-align: center;">Hành động</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:choose>
                                                    <c:when test="${not empty productList}">
                                                        <c:forEach items="${productList}" var="p">
                                                            <tr>
                                                                <td class="product-id-badge">#${p.id}</td>
                                                                <td>
                                                                    <img src="${p.image}" alt="${p.name}" class="product-thumb"
                                                                         onerror="this.src='https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?auto=format&fit=crop&q=80&w=600'">
                                                                </td>
                                                                <td style="font-weight: 600;">${p.name}</td>
                                                                <td>
                                                                    <c:choose>
                                                                        <c:when test="${p.discountPrice > 0}">
                                                                            <span class="price-original"><fmt:formatNumber value="${p.price}" type="number" maxFractionDigits="0"/>đ</span>
                                                                            <span class="price-promo"><fmt:formatNumber value="${p.discountPrice}" type="number" maxFractionDigits="0"/>đ</span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span class="price-normal"><fmt:formatNumber value="${p.price}" type="number" maxFractionDigits="0"/>đ</span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                <td>${p.category}</td>
                                                                <td>
                                                                    <c:choose>
                                                                        <c:when test="${not empty p.shopOwnerName}">
                                                                            <span style="font-weight: 500; color: #0F172A;">
                                                                                <i data-feather="user" style="width: 14px; height: 14px; color: #10B981;"></i>
                                                                                ${p.shopOwnerName}
                                                                            </span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span style="color: #94a3b8; font-style: italic;">Chưa phân bổ</span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                <td>
                                                                    <c:choose>
                                                                        <c:when test="${p.status == 'Available'}">
                                                                            <span class="status-badge available">
                                                                                <i data-feather="check-circle" style="width: 14px; height: 14px;"></i> Available
                                                                            </span>
                                                                        </c:when>
                                                                        <c:when test="${p.status == 'Featured'}">
                                                                            <span class="status-badge featured">
                                                                                <i data-feather="star" style="width: 14px; height: 14px;"></i> Featured
                                                                            </span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span class="status-badge unavailable">
                                                                                <i data-feather="x-circle" style="width: 14px; height: 14px;"></i> Unavailable
                                                                            </span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                <td style="text-align: center;">
                                                                    <c:choose>
                                                                        <c:when test="${p.status == 'Unavailable'}">
                                                                            <a href="admin-products?action=toggleStatus&id=${p.id}&status=${p.status}" 
                                                                               class="btn btn-sm btn-unblock-product" 
                                                                               onclick="return confirm('Bạn có chắc chắn muốn MỞ KHÓA sản phẩm [${p.name}] không?')">
                                                                                <i data-feather="unlock" style="width: 14px; height: 14px;"></i> Unblock
                                                                            </a>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <a href="admin-products?action=toggleStatus&id=${p.id}&status=${p.status}" 
                                                                               class="btn btn-sm btn-block-product" 
                                                                               onclick="return confirm('Bạn có chắc chắn muốn KHÓA sản phẩm [${p.name}] không?')">
                                                                                <i data-feather="lock" style="width: 14px; height: 14px;"></i> Block
                                                                            </a>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <tr>
                                                            <td colspan="8" style="text-align: center; color: #94a3b8; padding: 3rem 0;">
                                                                <i data-feather="inbox" style="width: 48px; height: 48px; margin-bottom: 0.5rem;"></i>
                                                                <p>Không có sản phẩm nào trong hệ thống.</p>
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

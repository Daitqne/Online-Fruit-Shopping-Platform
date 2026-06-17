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
    <meta name="description" content="Quản lý sản phẩm - GreenStock Shop Owner">
    <meta name="author" content="GreenStock">

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icons/icon-48x48.png" />

    <title>Quản lý sản phẩm | Shop Owner</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&amp;display=swap" rel="stylesheet">

    <!-- AdminKit CSS -->
    <link href="${pageContext.request.contextPath}/css/light.css" rel="stylesheet">
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

        /* ---- Product Thumbnail Style ---- */
        .product-thumb {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
        }

        /* ---- Table Alignments and Adjustments ---- */
        .table > :not(caption) > * > * {
            padding: 0.85rem 1rem;
            vertical-align: middle;
        }

        /* ---- Filter and Search Bar ---- */
        .filter-card {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 1.25rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
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

                    <li class="sidebar-item active">
                        <a class="sidebar-link" href="products-shop-owner">
                            <i class="align-middle" data-feather="list"></i>
                            <span class="align-middle">Sản phẩm</span>
                        </a>
                    </li>

                    <li class="sidebar-item">
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
                        <h1 class="h3 mb-0">Quản lý sản phẩm</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item">
                                    <a href="products-shop-owner">Dashboard</a>
                                </li>
                                <li class="breadcrumb-item active">Sản phẩm</li>
                            </ol>
                        </nav>
                    </div>

                    <!-- Success Alert -->
                    <c:if test="${param.success eq 'true'}">
                        <div class="alert-success-custom">
                            <i data-feather="check-circle" style="width:18px;height:18px;"></i>
                            <span>Thao tác xử lý sản phẩm thành công!</span>
                        </div>
                    </c:if>

                    <!-- Stat Tiles -->
                    <div class="stat-tiles">
                        <div class="stat-tile">
                            <div class="stat-tile-value">${totalProducts}</div>
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

                    <!-- Search and Filter Panel -->
                    <div class="filter-card">
                        <form action="products-shop-owner" method="GET" class="row g-3 align-items-center">
                            <div class="col-12 col-md-5">
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0">
                                        <i data-feather="search" style="width:16px;height:16px;"></i>
                                    </span>
                                    <input type="text" name="search" class="form-control border-start-0 ps-0" 
                                           placeholder="Tìm theo tên sản phẩm..." value="${searchQuery}">
                                </div>
                            </div>
                            <div class="col-12 col-md-3">
                                <select name="category" class="form-select">
                                    <option value="All" ${selectedCategory eq 'All' ? 'selected' : ''}>Tất cả danh mục</option>
                                    <c:forEach var="cat" items="${categories}">
                                        <option value="${cat}" ${selectedCategory eq cat ? 'selected' : ''}>${cat}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-6 col-md-2 d-grid">
                                <button type="submit" class="btn btn-success">
                                    Lọc kết quả
                                </button>
                            </div>
                            <div class="col-6 col-md-2 d-grid">
                                <a href="add-product" class="btn btn-primary">
                                    <i data-feather="plus-circle" class="align-middle me-1"></i> Thêm mới
                                </a>
                            </div>
                        </form>
                    </div>

                    <!-- Products Table Card -->
                    <div class="card">
                        <div class="card-header pb-0">
                            <h5 class="card-title mb-0">Danh sách sản phẩm (${fn:length(products)})</h5>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover table-striped my-0 align-middle">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Hình ảnh</th>
                                            <th>Tên sản phẩm</th>
                                            <th>Danh mục</th>
                                            <th>Giá bán</th>
                                            <th>Đơn vị</th>
                                            <th>Xuất xứ</th>
                                            <th>Trạng thái</th>
                                            <th class="text-center">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${not empty products}">
                                                <c:forEach var="p" items="${products}">
                                                    <tr>
                                                        <td><strong>${p.id}</strong></td>
                                                        <td>
                                                            <img src="${p.image}" class="product-thumb" alt="${p.name}" 
                                                                 onerror="this.src='https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?auto=format&fit=crop&q=80&w=600'">
                                                        </td>
                                                        <td>
                                                            <span class="d-block fw-bold">${p.name}</span>
                                                            <c:if test="${not empty p.description}">
                                                                <small class="text-muted text-truncate d-inline-block" style="max-width: 200px;">
                                                                    ${p.description}
                                                                </small>
                                                            </c:if>
                                                        </td>
                                                        <td><span class="badge bg-secondary">${p.category}</span></td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${p.discountPrice > 0}">
                                                                    <span class="price-original">
                                                                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                                                    </span>
                                                                    <span class="price-promo">
                                                                        <fmt:formatNumber value="${p.discountPrice}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="price-normal">
                                                                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                                                    </span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>${p.unit}</td>
                                                        <td>${p.origin}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${p.status eq 'Featured'}">
                                                                    <span class="badge bg-warning text-dark">Nổi bật</span>
                                                                </c:when>
                                                                <c:when test="${p.status eq 'Available'}">
                                                                    <span class="badge bg-success">Còn hàng</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-danger">${p.status}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td class="text-center">
                                                            <div class="btn-group">
                                                                <a href="edit-product?id=${p.id}" class="btn btn-sm btn-outline-primary" title="Chỉnh sửa">
                                                                    <i data-feather="edit-2" style="width:14px;height:14px;"></i>
                                                                </a>
                                                                <a href="delete-product?id=${p.id}" class="btn btn-sm btn-outline-danger" title="Xóa"
                                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm \'${p.name}\' (ID: ${p.id}) không?');">
                                                                    <i data-feather="trash-2" style="width:14px;height:14px;"></i>
                                                                </a>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="9" class="text-center py-5 text-muted">
                                                        <i data-feather="info" class="mb-2" style="width:32px;height:32px;"></i>
                                                        <p class="mb-0 fw-bold">Không tìm thấy sản phẩm nào phù hợp!</p>
                                                        <a href="products-shop-owner" class="btn btn-sm btn-link mt-2">Đặt lại bộ lọc</a>
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

    <!-- FontAwesome icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <script src="${pageContext.request.contextPath}/js/app.js"></script>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            if (typeof feather !== 'undefined') {
                feather.replace();
            }
        });
    </script>
</body>

</html>
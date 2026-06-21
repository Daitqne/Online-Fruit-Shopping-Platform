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
    <meta name="description" content="Quản lý tồn kho - GreenStock Shop Owner">
    <meta name="author" content="GreenStock">

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icons/icon-48x48.png" />

    <title>Quản lý tồn kho | Shop Owner</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&amp;display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/light.css" rel="stylesheet">
    
    <style>
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
            from { opacity: 0; transform: translateY(-8px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .stat-tiles {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .stat-tile {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 1.5rem;
            text-align: center;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
            transition: box-shadow 0.2s;
        }

        .stat-tile:hover {
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .stat-tile-value {
            font-size: 2.25rem;
            font-weight: 800;
            line-height: 1.1;
        }

        .stat-tile-label {
            font-size: 0.85rem;
            font-weight: 600;
            color: #94a3b8;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin-top: 0.35rem;
        }

        .product-thumb {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
        }

        .table > :not(caption) > * > * {
            padding: 0.85rem 1rem;
            vertical-align: middle;
        }

        .action-form {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .action-input {
            width: 75px !important;
            padding: 0.25rem 0.5rem;
            font-size: 0.85rem;
            text-align: center;
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
                </a>

                <div class="sidebar-user">
                    <div class="d-flex justify-content-center">
                        <div class="flex-shrink-0">
                            <img src="${not empty sessionScope.user.avatar ? sessionScope.user.avatar : 'https://cdn-icons-png.flaticon.com/512/149/149071.png'}"
                                class="avatar img-fluid rounded me-1" alt="Avatar" />
                        </div>
                        <div class="flex-grow-1 ps-2">
                            <a class="sidebar-user-title dropdown-toggle" href="#" data-bs-toggle="dropdown">
                                ${sessionScope.user.fullName}
                            </a>
                            <div class="dropdown-menu dropdown-menu-start">
                                <a class="dropdown-item" href="shop-owner-profile"><i class="align-middle me-1" data-feather="user"></i> Hồ sơ</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="logout"><i class="align-middle me-1" data-feather="log-out"></i> Đăng xuất</a>
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
                        <a class="sidebar-link" href="inventory-shop-owner">
                            <i class="align-middle" data-feather="package"></i>
                            <span class="align-middle">Tồn kho</span>
                        </a>
                    </li>

                    <li class="sidebar-item">
                        <a class="sidebar-link" href="shop-owner-orders">
                            <i class="align-middle" data-feather="shopping-bag"></i>
                            <span class="align-middle">Đơn hàng</span>
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
                            <a class="nav-icon dropdown-toggle" href="#" id="alertsDropdown" data-bs-toggle="dropdown">
                                <div class="position-relative">
                                    <i class="align-middle" data-feather="bell"></i>
                                    <c:if test="${unreadCount > 0}">
                                        <span class="indicator">${unreadCount}</span>
                                    </c:if>
                                </div>
                            </a>
                            <div class="dropdown-menu dropdown-menu-lg dropdown-menu-end py-0" aria-labelledby="alertsDropdown">
                                <div class="dropdown-menu-header">Thông báo (${unreadCount} chưa đọc)</div>
                                <div class="list-group">
                                    <c:choose>
                                        <c:when test="${not empty notifications}">
                                            <c:forEach var="n" items="${notifications}" begin="0" end="4">
                                                <a href="#" class="list-group-item">
                                                    <div class="row g-0 align-items-center">
                                                        <div class="col-2 text-center">
                                                            <c:choose>
                                                                <c:when test="${fn:contains(n.title, 'duyệt')}"><i class="text-success align-middle me-1" data-feather="check-circle"></i></c:when>
                                                                <c:otherwise><i class="text-danger align-middle me-1" data-feather="x-circle"></i></c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <div class="col-10 ps-2">
                                                            <div class="text-dark" style="font-size:0.82rem;font-weight:${n.read ? '400' : '700'}">${n.title}</div>
                                                            <div class="text-muted" style="font-size:0.75rem;">${fn:substring(n.content, 0, 70)}...</div>
                                                        </div>
                                                    </div>
                                                </a>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="text-center text-muted py-3" style="font-size:0.85rem;">Không có thông báo mới</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-icon pe-md-0 dropdown-toggle" href="#" data-bs-toggle="dropdown">
                                <img src="${not empty sessionScope.user.avatar ? sessionScope.user.avatar : 'https://cdn-icons-png.flaticon.com/512/149/149071.png'}"
                                    class="avatar img-fluid rounded" alt="Avatar" />
                            </a>
                            <div class="dropdown-menu dropdown-menu-end">
                                <a class="dropdown-item" href="shop-owner-profile"><i class="align-middle me-1" data-feather="user"></i> Hồ sơ</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="logout"><i class="align-middle me-1" data-feather="log-out"></i> Đăng xuất</a>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- ========== CONTENT ========== -->
            <main class="content">
                <div class="container-fluid p-0">

                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <h1 class="h3 mb-0">Quản lý tồn kho</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item"><a href="products-shop-owner">Dashboard</a></li>
                                <li class="breadcrumb-item active">Tồn kho</li>
                            </ol>
                        </nav>
                    </div>

                    <!-- Success Alert -->
                    <c:if test="${param.success eq 'true'}">
                        <div class="alert-success-custom">
                            <i data-feather="check-circle" style="width:18px;height:18px;"></i>
                            <span>Cập nhật thông tin tồn kho thành công!</span>
                        </div>
                    </c:if>

                    <!-- Stat Tiles -->
                    <div class="stat-tiles">
                        <div class="stat-tile">
                            <div class="stat-tile-value" style="color: #3b7ddd;">${totalProducts}</div>
                            <div class="stat-tile-label">Tổng sản phẩm</div>
                        </div>
                        <div class="stat-tile">
                            <div class="stat-tile-value" style="color: ${lowStockProducts > 0 ? '#dc3545' : '#28a745'};">
                                ${lowStockProducts}
                            </div>
                            <div class="stat-tile-label">Sản phẩm sắp hết hàng</div>
                        </div>
                    </div>

                    <!-- Inventory Table Card -->
                    <div class="card">
                        <div class="card-header pb-0">
                            <h5 class="card-title mb-0">Theo dõi kho hàng (${fn:length(products)})</h5>
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
                                            <th class="text-center">Số lượng tồn</th>
                                            <th class="text-center">Ngưỡng cảnh báo</th>
                                            <th>Tình trạng kho</th>
                                            <th class="text-center" style="width: 230px;">Nhập thêm hàng</th>
                                            <th class="text-center" style="width: 230px;">Cập nhật ngưỡng</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${not empty products}">
                                                <c:forEach var="p" items="${products}">
                                                    <c:set var="isLowStock" value="${p.stockQuantity <= p.lowStockThreshold}" />
                                                    <tr style="${isLowStock ? 'background-color: #fff8f8;' : ''}">
                                                        <td><strong>${p.id}</strong></td>
                                                        <td>
                                                            <img src="${p.image}" class="product-thumb" alt="${p.name}" 
                                                                 onerror="this.src='https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?auto=format&fit=crop&q=80&w=600'">
                                                        </td>
                                                        <td>
                                                            <span class="d-block fw-bold">${p.name}</span>
                                                            <small class="text-muted">Đơn vị: ${p.unit}</small>
                                                        </td>
                                                        <td><span class="badge bg-secondary">${p.category}</span></td>
                                                        <td class="text-center fw-bold text-lg" style="font-size: 1.1rem; color: ${isLowStock ? '#dc3545' : '#1cbb8c'}">
                                                            ${p.stockQuantity}
                                                        </td>
                                                        <td class="text-center fw-bold">${p.lowStockThreshold}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${isLowStock}">
                                                                    <span class="badge bg-danger">
                                                                        <i data-feather="alert-triangle" style="width:12px;height:12px;"></i> Sắp hết hàng
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-success">
                                                                        <i data-feather="check" style="width:12px;height:12px;"></i> An toàn
                                                                    </span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <!-- Nhập thêm hàng -->
                                                        <td>
                                                            <form action="inventory-shop-owner" method="POST" class="action-form">
                                                                <input type="hidden" name="action" value="restock">
                                                                <input type="hidden" name="productId" value="${p.id}">
                                                                <input type="number" name="quantity" class="form-control form-control-sm action-input" 
                                                                       placeholder="+ Số lượng" min="1" required>
                                                                <button type="submit" class="btn btn-sm btn-success">Nhập</button>
                                                            </form>
                                                        </td>
                                                        <!-- Cập nhật ngưỡng cảnh báo -->
                                                        <td>
                                                            <form action="inventory-shop-owner" method="POST" class="action-form">
                                                                <input type="hidden" name="action" value="update-threshold">
                                                                <input type="hidden" name="productId" value="${p.id}">
                                                                <input type="number" name="threshold" class="form-control form-control-sm action-input" 
                                                                       value="${p.lowStockThreshold}" min="0" required>
                                                                <button type="submit" class="btn btn-sm btn-primary">Lưu</button>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="9" class="text-center py-5 text-muted">
                                                        <i data-feather="info" class="mb-2" style="width:32px;height:32px;"></i>
                                                        <p class="mb-0 fw-bold">Không tìm thấy sản phẩm nào trong kho!</p>
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

            <footer class="footer">
                <div class="container-fluid">
                    <div class="row text-muted">
                        <div class="col-6 text-start">
                            <p class="mb-0"><strong>GreenStock</strong> &copy; 2026</p>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    </div>

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

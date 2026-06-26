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
    <meta name="description" content="Quản lý đơn hàng - GreenStock Shop Owner">
    <meta name="author" content="GreenStock">

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icons/icon-48x48.png" />

    <title>Đơn hàng | Shop Owner</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/vendor/light.css" rel="stylesheet">

    <style>
        /* ---------- Alert Styles ---------- */
        .alert-success-custom {
            background: #ECFDF5; border: 1px solid #6EE7B7; color: #065F46;
            padding: 0.9rem 1.25rem; border-radius: 10px;
            display: flex; align-items: center; gap: 0.65rem;
            font-weight: 500; font-size: 0.9rem; margin-bottom: 1.25rem;
            animation: slideDown 0.3s ease;
        }
        .alert-error-custom {
            background: #FEF2F2; border: 1px solid #FCA5A5; color: #991B1B;
            padding: 0.9rem 1.25rem; border-radius: 10px;
            display: flex; align-items: center; gap: 0.65rem;
            font-weight: 500; font-size: 0.9rem; margin-bottom: 1.25rem;
            animation: slideDown 0.3s ease;
        }
        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-8px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        /* ---------- Stat Tiles ---------- */
        .stat-tiles {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        .stat-tile {
            background: #fff; border: 1px solid #e2e8f0; border-radius: 12px;
            padding: 1.25rem; text-align: center;
            box-shadow: 0 1px 4px rgba(0,0,0,.05); transition: box-shadow .2s;
            cursor: pointer; text-decoration: none; color: inherit;
            display: block;
        }
        .stat-tile:hover { box-shadow: 0 4px 12px rgba(0,0,0,.12); color: inherit; text-decoration: none; }
        .stat-tile.active-filter { border-color: #3b7ddd; box-shadow: 0 0 0 3px rgba(59,125,221,.15); }
        .stat-tile-value { font-size: 2rem; font-weight: 800; line-height: 1.1; }
        .stat-tile-label { font-size: 0.78rem; font-weight: 600; color: #94a3b8; text-transform: uppercase; letter-spacing: .05em; margin-top: .35rem; }

        /* ---------- Filter Tab Bar ---------- */
        .filter-bar { display: flex; gap: .5rem; flex-wrap: wrap; margin-bottom: 1.25rem; }
        .filter-btn { 
            padding: .35rem .85rem; border-radius: 20px; font-size: 0.83rem;
            font-weight: 600; border: 1.5px solid #e2e8f0; cursor: pointer;
            text-decoration: none; color: #64748b; background: #fff;
            transition: all .15s;
        }
        .filter-btn:hover, .filter-btn.active { background: #3b7ddd; color: #fff; border-color: #3b7ddd; text-decoration: none; }

        /* ---------- Table ---------- */
        .table > :not(caption) > * > * { padding: .75rem 1rem; vertical-align: middle; }
        .product-thumb {
            width: 40px; height: 40px; object-fit: cover;
            border-radius: 6px; border: 1px solid #e2e8f0;
        }

        /* ---------- Order Status Badges ---------- */
        .badge-pending    { background: #FEF3C7; color: #92400E; }
        .badge-processing { background: #DBEAFE; color: #1E40AF; }
        .badge-shipping   { background: #EDE9FE; color: #4C1D95; }
        .badge-delivered  { background: #D1FAE5; color: #065F46; }
        .badge-cancelled  { background: #FEE2E2; color: #991B1B; }
        .status-badge {
            padding: .28rem .65rem; border-radius: 20px;
            font-size: .76rem; font-weight: 700; display: inline-flex; align-items: center; gap: 4px;
        }

        /* ---------- Action Buttons ---------- */
        .action-btns { display: flex; gap: .4rem; flex-wrap: wrap; }
        .action-btns .btn { padding: .25rem .6rem; font-size: .78rem; }

        /* ---------- Items mini-list inside row ---------- */
        .item-list { list-style: none; padding: 0; margin: 0; }
        .item-list li { display: flex; align-items: center; gap: .5rem; font-size: .82rem; margin-bottom: .25rem; }

        @media (max-width: 768px) { .stat-tiles { grid-template-columns: 1fr 1fr; } }
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
                     style="margin-left:-3px">
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
                        <a class="sidebar-user-title dropdown-toggle" href="#" data-bs-toggle="dropdown">
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

                <li class="sidebar-item">
                    <a class="sidebar-link" href="inventory-shop-owner">
                        <i class="align-middle" data-feather="package"></i>
                        <span class="align-middle">Tồn kho</span>
                    </a>
                </li>

                <li class="sidebar-item active">
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
                                                            <c:when test="${fn:contains(n.title, 'duyet')}"><i class="text-success align-middle" data-feather="check-circle"></i></c:when>
                                                            <c:otherwise><i class="text-danger align-middle" data-feather="x-circle"></i></c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div class="col-10 ps-2">
                                                        <div class="text-dark" style="font-size:.82rem;font-weight:${n.read ? '400' : '700'}">${n.title}</div>
                                                        <div class="text-muted" style="font-size:.75rem;">${fn:substring(n.content, 0, 70)}</div>
                                                    </div>
                                                </div>
                                            </a>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center text-muted py-3" style="font-size:.85rem;">Không có thông báo mới</div>
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

                <!-- Page Header -->
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <h1 class="h3 mb-0">Quản lý đơn hàng</h1>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mb-0">
                            <li class="breadcrumb-item"><a href="products-shop-owner">Dashboard</a></li>
                            <li class="breadcrumb-item active">Đơn hàng</li>
                        </ol>
                    </nav>
                </div>

                <!-- Flash Messages -->
                <c:if test="${not empty successMsg}">
                    <div class="alert-success-custom">
                        <i data-feather="check-circle" style="width:18px;height:18px;"></i>
                        <span>${successMsg}</span>
                    </div>
                </c:if>
                <c:if test="${not empty errorMsg}">
                    <div class="alert-error-custom">
                        <i data-feather="alert-circle" style="width:18px;height:18px;"></i>
                        <span>${errorMsg}</span>
                    </div>
                </c:if>

                <!-- Stat Tiles -->
                <div class="stat-tiles">
                    <a href="shop-owner-orders?status=Pending" class="stat-tile ${filterStatus eq 'Pending' ? 'active-filter' : ''}">
                        <div class="stat-tile-value" style="color:#92400E;">${countPending}</div>
                        <div class="stat-tile-label">Chờ xác nhận</div>
                    </a>
                    <a href="shop-owner-orders?status=Processing" class="stat-tile ${filterStatus eq 'Processing' ? 'active-filter' : ''}">
                        <div class="stat-tile-value" style="color:#1E40AF;">${countProcessing}</div>
                        <div class="stat-tile-label">Đang xử lý</div>
                    </a>
                    <a href="shop-owner-orders?status=Shipping" class="stat-tile ${filterStatus eq 'Shipping' ? 'active-filter' : ''}">
                        <div class="stat-tile-value" style="color:#4C1D95;">${countShipping}</div>
                        <div class="stat-tile-label">Đang giao</div>
                    </a>
                    <a href="shop-owner-orders?status=Delivered" class="stat-tile ${filterStatus eq 'Delivered' ? 'active-filter' : ''}">
                        <div class="stat-tile-value" style="color:#065F46;">${countDelivered}</div>
                        <div class="stat-tile-label">Đã giao</div>
                    </a>
                </div>

                <!-- Filter Tab Bar -->
                <div class="filter-bar">
                    <a href="shop-owner-orders" class="filter-btn ${empty filterStatus or filterStatus eq 'all' ? 'active' : ''}">
                        Tất cả
                    </a>
                    <a href="shop-owner-orders?status=Pending" class="filter-btn ${filterStatus eq 'Pending' ? 'active' : ''}">
                        Chờ xác nhận
                    </a>
                    <a href="shop-owner-orders?status=Processing" class="filter-btn ${filterStatus eq 'Processing' ? 'active' : ''}">
                        Đang xử lý
                    </a>
                    <a href="shop-owner-orders?status=Shipping" class="filter-btn ${filterStatus eq 'Shipping' ? 'active' : ''}">
                        Đang giao
                    </a>
                    <a href="shop-owner-orders?status=Delivered" class="filter-btn ${filterStatus eq 'Delivered' ? 'active' : ''}">
                        Đã giao
                    </a>
                    <a href="shop-owner-orders?status=Cancelled" class="filter-btn ${filterStatus eq 'Cancelled' ? 'active' : ''}">
                        Đã hủy
                    </a>
                </div>

                <!-- Orders Table -->
                <div class="card">
                    <div class="card-header pb-0 d-flex align-items-center justify-content-between">
                        <h5 class="card-title mb-0">
                            Đơn hàng
                            <c:if test="${not empty filterStatus and filterStatus ne 'all'}">
                                — <span class="text-muted" style="font-size:.9rem;">${filterStatus}</span>
                            </c:if>
                            <span class="badge bg-secondary ms-1">${fn:length(orders)}</span>
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover my-0 align-middle">
                                <thead>
                                    <tr>
                                        <th>#ĐH</th>
                                        <th>Khách hàng</th>
                                        <th>Sản phẩm</th>
                                        <th>Tổng tiền</th>
                                        <th>Thanh toán</th>
                                        <th>Trạng thái</th>
                                        <th>Ngày đặt</th>
                                        <th class="text-center">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty orders}">
                                            <c:forEach var="o" items="${orders}">
                                                <tr>
                                                    <!-- Order ID -->
                                                    <td><strong>#${o.saleOrderId}</strong></td>

                                                    <!-- Customer -->
                                                    <td>
                                                        <span class="fw-semibold">${not empty o.customerName ? o.customerName : 'Khách hàng'}</span>
                                                        <br><small class="text-muted">${o.shippingPhone}</small>
                                                    </td>

                                                    <!-- Products in this order (shop owner's only) -->
                                                    <td>
                                                        <ul class="item-list">
                                                            <c:forEach var="item" items="${o.items}">
                                                                <li>
                                                                    <img src="${item.product.image}" class="product-thumb"
                                                                         onerror="this.src='https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?auto=format&fit=crop&q=80&w=200'"
                                                                         alt="${item.product.name}">
                                                                    <span>
                                                                        ${item.product.name}
                                                                        <span class="text-muted">x${item.quantity}</span>
                                                                    </span>
                                                                </li>
                                                            </c:forEach>
                                                        </ul>
                                                    </td>

                                                    <!-- Total -->
                                                    <td>
                                                        <fmt:formatNumber value="${o.totalPayment}" type="number" pattern="#,###"/> đ
                                                    </td>

                                                    <!-- Payment -->
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${o.paymentStatus eq 'Paid'}">
                                                                <span class="badge bg-success">Đã TT</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-warning text-dark">Chưa TT</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <br><small class="text-muted">${o.paymentMethod}</small>
                                                    </td>

                                                    <!-- Status -->
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${o.orderStatus eq 'Pending'}">
                                                                <span class="status-badge badge-pending">
                                                                    <i data-feather="clock" style="width:11px;height:11px;"></i> Chờ xác nhận
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${o.orderStatus eq 'Processing'}">
                                                                <span class="status-badge badge-processing">
                                                                    <i data-feather="refresh-cw" style="width:11px;height:11px;"></i> Đang xử lý
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${o.orderStatus eq 'Shipping'}">
                                                                <span class="status-badge badge-shipping">
                                                                    <i data-feather="truck" style="width:11px;height:11px;"></i> Đang giao
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${o.orderStatus eq 'Delivered'}">
                                                                <span class="status-badge badge-delivered">
                                                                    <i data-feather="check-circle" style="width:11px;height:11px;"></i> Đã giao
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="status-badge badge-cancelled">
                                                                    <i data-feather="x-circle" style="width:11px;height:11px;"></i> ${o.orderStatus}
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>

                                                    <!-- Date -->
                                                    <td>
                                                        <fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                    </td>

                                                    <!-- Actions -->
                                                    <td class="text-center">
                                                        <div class="action-btns justify-content-center">
                                                            <!-- Hóa đơn / Biên lai -->
                                                            <a href="${pageContext.request.contextPath}/orders?action=invoice&id=${o.saleOrderId}" target="_blank" 
                                                                class="btn btn-sm btn-outline-primary" title="Xem hóa đơn">
                                                                 <i data-feather="file-text" style="width:13px;height:13px;"></i> HĐ
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/orders?action=invoice&id=${o.saleOrderId}&download=true" target="_blank" 
                                                                class="btn btn-sm btn-outline-secondary" title="Tải biên lai">
                                                                 <i data-feather="download" style="width:13px;height:13px;"></i> Tải
                                                            </a>

                                                            <c:choose>
                                                                <c:when test="${o.orderStatus eq 'Pending'}">
                                                                    <!-- Confirm order -->
                                                                    <form method="POST" action="shop-owner-orders" style="display:inline;">
                                                                        <input type="hidden" name="action" value="confirm">
                                                                        <input type="hidden" name="orderId" value="${o.saleOrderId}">
                                                                        <input type="hidden" name="filterStatus" value="${filterStatus}">
                                                                        <button type="submit" class="btn btn-sm btn-primary"
                                                                                onclick="return confirm('Xác nhận đơn hàng #${o.saleOrderId}?')">
                                                                            <i data-feather="check" style="width:13px;height:13px;"></i> Xác nhận
                                                                        </button>
                                                                    </form>
                                                                    <!-- Cancel order -->
                                                                    <form method="POST" action="shop-owner-orders" style="display:inline;">
                                                                        <input type="hidden" name="action" value="cancel">
                                                                        <input type="hidden" name="orderId" value="${o.saleOrderId}">
                                                                        <input type="hidden" name="filterStatus" value="${filterStatus}">
                                                                        <button type="submit" class="btn btn-sm btn-danger"
                                                                                onclick="return confirm('Hủy đơn hàng #${o.saleOrderId}?')">
                                                                            <i data-feather="x" style="width:13px;height:13px;"></i> Hủy
                                                                        </button>
                                                                    </form>
                                                                </c:when>
                                                                <c:when test="${o.orderStatus eq 'Processing'}">
                                                                    <!-- Mark as Shipping -->
                                                                    <form method="POST" action="shop-owner-orders" style="display:inline;">
                                                                        <input type="hidden" name="action" value="ship">
                                                                        <input type="hidden" name="orderId" value="${o.saleOrderId}">
                                                                        <input type="hidden" name="filterStatus" value="${filterStatus}">
                                                                        <button type="submit" class="btn btn-sm btn-info text-white"
                                                                                onclick="return confirm('Chuyển sang trạng thái Đang giao?')">
                                                                            <i data-feather="truck" style="width:13px;height:13px;"></i> Giao hàng
                                                                        </button>
                                                                    </form>
                                                                </c:when>
                                                                <c:when test="${o.orderStatus eq 'Shipping'}">
                                                                    <!-- Mark as Delivered -->
                                                                    <form method="POST" action="shop-owner-orders" style="display:inline;">
                                                                        <input type="hidden" name="action" value="delivered">
                                                                        <input type="hidden" name="orderId" value="${o.saleOrderId}">
                                                                        <input type="hidden" name="filterStatus" value="${filterStatus}">
                                                                        <button type="submit" class="btn btn-sm btn-success"
                                                                                onclick="return confirm('Xác nhận đã giao thành công?')">
                                                                            <i data-feather="check-circle" style="width:13px;height:13px;"></i> Đã giao
                                                                        </button>
                                                                    </form>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted" style="font-size:.8rem;">—</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="8" class="text-center py-5 text-muted">
                                                    <i data-feather="shopping-bag" class="mb-2" style="width:36px;height:36px;"></i>
                                                    <p class="mb-0 fw-bold mt-2">Không có đơn hàng nào.</p>
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
        if (typeof feather !== 'undefined') { feather.replace(); }
    });
</script>
</body>
</html>


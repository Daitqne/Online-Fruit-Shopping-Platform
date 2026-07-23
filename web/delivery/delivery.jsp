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
        <title>Giao hàng | Delivery Staff</title>
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icons/icon-48x48.png" />
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="${pageContext.request.contextPath}/css/vendor/light.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/pages/delivery/delivery.css" rel="stylesheet">
    </head>

    <body data-theme="default" data-layout="fluid" data-sidebar-position="left" data-sidebar-layout="default">
        <div class="wrapper">

            <!-- ========== SIDEBAR ========== -->
            <nav id="sidebar" class="sidebar js-sidebar">
                <div class="sidebar-content js-simplebar">
                    <a class="sidebar-brand" href="delivery">
                        <span class="sidebar-brand-text align-middle">
                            Delivery Staff
                        </span>
                        <i class="fa-solid fa-truck-fast text-white ms-2 fs-4 align-middle"></i>
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
                        <li class="sidebar-header">Trang quản lý</li>
                        <li class="sidebar-item active">
                            <a class="sidebar-link" href="delivery">
                                <i class="align-middle" data-feather="truck"></i>
                                <span class="align-middle">Giao hàng & Đơn hàng</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- ========== MAIN ========== -->
            <div class="main">

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
                                                    <a href="${pageContext.request.contextPath}/delivery" class="list-group-item">
                                                        <div class="row g-0 align-items-center">
                                                            <div class="col-2 text-center">
                                                                <i class="text-primary align-middle" data-feather="truck"></i>
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

                        <!-- Page Header -->
                        <div class="d-flex align-items-center justify-content-between mb-4">
                            <div>
                                <h1 class="h3 mb-1 font-weight-bold">Quản lý giao hàng</h1>
                                <p class="text-muted small mb-0">Theo dõi, lọc đơn theo khu vực và quản lý tiến độ giao hàng dễ dàng.</p>
                            </div>
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb mb-0">
                                    <li class="breadcrumb-item"><a href="delivery">Dashboard</a></li>
                                    <li class="breadcrumb-item active">Shipper</li>
                                </ol>
                            </nav>
                        </div>

                        <!-- KPI Summary Cards -->
                        <div class="row mb-4 g-3">
                            <div class="col-6 col-lg-3">
                                <div class="card kpi-card kpi-unassigned h-100">
                                    <div class="card-body p-3 d-flex align-items-center justify-content-between">
                                        <div>
                                            <div class="kpi-title">Đơn chờ nhận</div>
                                            <div class="kpi-value">${totalUnassignedCount}</div>
                                        </div>
                                        <div class="kpi-icon-wrapper">
                                            <i class="fa-solid fa-boxes-packing"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 col-lg-3">
                                <div class="card kpi-card kpi-shipping h-100">
                                    <div class="card-body p-3 d-flex align-items-center justify-content-between">
                                        <div>
                                            <div class="kpi-title">Đơn đang giao</div>
                                            <div class="kpi-value">${myShippingCount}</div>
                                        </div>
                                        <div class="kpi-icon-wrapper">
                                            <i class="fa-solid fa-truck-ramp-box"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 col-lg-3">
                                <div class="card kpi-card kpi-delivered h-100">
                                    <div class="card-body p-3 d-flex align-items-center justify-content-between">
                                        <div>
                                            <div class="kpi-title">Đã hoàn thành</div>
                                            <div class="kpi-value">${completedTodayCount}</div>
                                        </div>
                                        <div class="kpi-icon-wrapper">
                                            <i class="fa-solid fa-circle-check"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 col-lg-3">
                                <div class="card kpi-card kpi-cod h-100">
                                    <div class="card-body p-3 d-flex align-items-center justify-content-between">
                                        <div>
                                            <div class="kpi-title">Tổng COD cần thu</div>
                                            <div class="kpi-value text-danger" style="font-size:1.25rem;">
                                                <fmt:formatNumber value="${totalCodAmount}" pattern="#,##0"/> ₫
                                            </div>
                                        </div>
                                        <div class="kpi-icon-wrapper">
                                            <i class="fa-solid fa-sack-dollar"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Filter Toolbar Card -->
                        <div class="filter-card">
                            <form method="GET" action="delivery" class="row g-3 align-items-center">
                                <div class="col-12 col-md-5">
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-end-0">
                                            <i class="fa-solid fa-magnifying-glass text-muted"></i>
                                        </span>
                                        <input type="text" name="keyword" class="form-control border-start-0" 
                                               placeholder="Tìm khu vực/địa chỉ, mã đơn #, SĐT, tên khách..." 
                                               value="${paramKeyword}">
                                    </div>
                                </div>
                                <div class="col-6 col-md-3">
                                    <select name="paymentMethod" class="form-select">
                                        <option value="">-- Tất cả PTTT --</option>
                                        <option value="COD" <c:if test="${paramPaymentMethod eq 'COD'}">selected</c:if>>Tiền mặt / COD</option>
                                        <option value="VNPAY" <c:if test="${paramPaymentMethod eq 'VNPAY'}">selected</c:if>>Chuyển khoản / VNPAY</option>
                                    </select>
                                </div>
                                <div class="col-6 col-md-2">
                                    <select name="statusFilter" class="form-select">
                                        <option value="">-- Tất cả trạng thái --</option>
                                        <option value="Shipping" <c:if test="${paramStatusFilter eq 'Shipping'}">selected</c:if>>Đang giao</option>
                                        <option value="Delivered" <c:if test="${paramStatusFilter eq 'Delivered'}">selected</c:if>>Đã giao</option>
                                        <option value="Failed" <c:if test="${paramStatusFilter eq 'Failed'}">selected</c:if>>Giao thất bại</option>
                                    </select>
                                </div>
                                <div class="col-12 col-md-2 d-flex gap-2">
                                    <button type="submit" class="btn btn-primary flex-grow-1">
                                        <i class="fa-solid fa-filter me-1"></i> Lọc
                                    </button>
                                    <a href="delivery" class="btn btn-outline-secondary" title="Xóa bộ lọc">
                                        <i class="fa-solid fa-rotate-left"></i>
                                    </a>
                                </div>
                            </form>
                        </div>

                        <!-- Unassigned Deliveries -->
                        <div class="card mb-4 shadow-sm border-0" id="card-unassigned">
                            <div class="card-header bg-white py-3 border-bottom d-flex align-items-center justify-content-between">
                                <h5 class="card-title mb-0 text-dark fw-bold">
                                    <i class="fa-solid fa-clock-rotate-left text-warning me-2"></i> Đơn hàng chờ nhận
                                    <span class="badge bg-warning text-dark ms-2">${unassigned.size()}</span>
                                </h5>
                                <button class="btn btn-sm btn-light border rounded-circle" id="toggleUnassigned" onclick="toggleSection('unassigned')" title="Thu/mở">
                                    <i class="fa-solid fa-chevron-up" id="iconUnassigned"></i>
                                </button>
                            </div>
                            <div id="bodyUnassigned">
                                <div class="table-responsive">
                                    <table class="table table-hover my-0 align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th>#Đơn giao</th>
                                                <th>Khách hàng & SĐT</th>
                                                <th>Địa chỉ giao hàng</th>
                                                <th>Thanh toán</th>
                                                <th>Trạng thái</th>
                                                <th class="text-center">Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbodyUnassigned">
                                            <c:choose>
                                                <c:when test="${not empty unassigned}">
                                                    <c:forEach var="d" items="${unassigned}">
                                                        <tr>
                                                            <td>
                                                                <span class="fw-bold text-primary">#${d.deliveryId}</span>
                                                                <div class="small text-muted">Đơn mua: #${d.orderId}</div>
                                                            </td>
                                                            <td>
                                                                <div class="fw-semibold text-dark">${not empty d.customerName ? d.customerName : 'Khách vãng lai'}</div>
                                                                <c:if test="${not empty d.shippingPhone}">
                                                                    <a href="tel:${d.shippingPhone}" class="small text-decoration-none text-primary">
                                                                        <i class="fa-solid fa-phone me-1"></i>${d.shippingPhone}
                                                                    </a>
                                                                </c:if>
                                                            </td>
                                                            <td style="max-width:280px;">
                                                                <div class="text-truncate" title="${d.shippingAddress}">
                                                                    <i class="fa-solid fa-location-dot text-danger me-1"></i>${d.shippingAddress}
                                                                </div>
                                                                <c:if test="${not empty d.shipperNote}">
                                                                    <div class="small text-muted italic mt-1" style="font-style:italic;">
                                                                        <i class="fa-regular fa-comment-dots me-1"></i>"${d.shipperNote}"
                                                                    </div>
                                                                </c:if>
                                                            </td>
                                                            <td>
                                                                <div class="fw-bold text-dark">
                                                                    <fmt:formatNumber value="${d.totalAmount}" pattern="#,##0"/> ₫
                                                                </div>
                                                                <c:choose>
                                                                    <c:when test="${fn:containsIgnoreCase(d.paymentMethod, 'COD') or fn:containsIgnoreCase(d.paymentMethod, 'tiền mặt')}">
                                                                        <span class="status-badge badge-cod mt-1"><i class="fa-solid fa-money-bill-1"></i> COD (Thu tiền)</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="status-badge badge-prepaid mt-1"><i class="fa-solid fa-circle-check"></i> ${d.paymentMethod}</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td>
                                                                <span class="status-badge badge-pending">
                                                                    <i class="fa-solid fa-hourglass-half me-1"></i> Chờ nhận
                                                                </span>
                                                            </td>
                                                            <td class="text-center">
                                                                <div class="action-btns justify-content-center">
                                                                    <a href="https://www.google.com/maps/search/?api=1&query=${d.shippingAddress}" 
                                                                       target="_blank" class="btn btn-maps" title="Mở bản đồ chỉ đường">
                                                                        <i class="fa-solid fa-map-location-dot"></i> Bản đồ
                                                                    </a>
                                                                    <button type="button" class="btn btn-quickview" onclick="openQuickView(${d.orderId})" title="Xem sản phẩm">
                                                                        <i class="fa-solid fa-eye"></i> Xem món
                                                                    </button>
                                                                    <form method="POST" action="delivery" style="display:inline;">
                                                                        <input type="hidden" name="action" value="claim">
                                                                        <input type="hidden" name="deliveryId" value="${d.deliveryId}">
                                                                        <button type="submit" class="btn btn-primary"
                                                                                onclick="return confirm('Nhận đơn giao hàng #${d.deliveryId}?')">
                                                                            <i class="fa-solid fa-hand-holding-hand me-1"></i> Nhận đơn
                                                                        </button>
                                                                    </form>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr>
                                                        <td colspan="6" class="text-center py-5 text-muted">
                                                            <i class="fa-solid fa-box-open mb-2 text-secondary fs-1 display-6"></i>
                                                            <p class="mb-0 fw-bold mt-2">Không tìm thấy đơn hàng nào đang chờ nhận.</p>
                                                        </td>
                                                    </tr>
                                                </c:otherwise>
                                            </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- Pagination: Đơn chờ nhận -->
                                <div class="d-flex align-items-center justify-content-between px-3 py-2 border-top bg-light" id="paginationUnassigned" style="display:none!important;">
                                    <span class="text-muted small" id="pageInfoUnassigned"></span>
                                    <div class="d-flex gap-2">
                                        <button class="btn btn-sm btn-outline-secondary" id="prevUnassigned" onclick="changePage('unassigned',-1)">
                                            <i class="fa-solid fa-chevron-left"></i> Trước
                                        </button>
                                        <button class="btn btn-sm btn-outline-secondary" id="nextUnassigned" onclick="changePage('unassigned',1)">
                                            Sau <i class="fa-solid fa-chevron-right"></i>
                                        </button>
                                    </div>
                                </div>
                            </div><!-- end bodyUnassigned -->
                        </div>

                        <!-- My Deliveries -->
                        <div class="card shadow-sm border-0" id="card-mydeliveries">
                            <div class="card-header bg-white py-3 border-bottom d-flex align-items-center justify-content-between">
                                <h5 class="card-title mb-0 text-dark fw-bold">
                                    <i class="fa-solid fa-truck-arrow-right text-indigo me-2"></i> Đơn hàng của tôi
                                    <span class="badge bg-indigo text-white ms-2">${myDeliveries.size()}</span>
                                </h5>
                                <button class="btn btn-sm btn-light border rounded-circle" id="toggleMyDeliveries" onclick="toggleSection('mydeliveries')" title="Thu/mở">
                                    <i class="fa-solid fa-chevron-up" id="iconMydeliveries"></i>
                                </button>
                            </div>
                            <div id="bodyMydeliveries">
                                <div class="table-responsive">
                                    <table class="table table-hover my-0 align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th>#Đơn giao</th>
                                                <th>Khách hàng & SĐT</th>
                                                <th>Địa chỉ giao hàng</th>
                                                <th>Thanh toán</th>
                                                <th>Trạng thái</th>
                                                <th class="text-center">Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbodyMydeliveries">
                                            <c:choose>
                                                <c:when test="${not empty myDeliveries}">
                                                    <c:forEach var="d" items="${myDeliveries}">
                                                        <tr>
                                                            <td>
                                                                <span class="fw-bold text-primary">#${d.deliveryId}</span>
                                                                <div class="small text-muted">Đơn mua: #${d.orderId}</div>
                                                                <c:if test="${not empty d.shippedDate}">
                                                                    <div class="small text-muted">
                                                                        <fmt:formatDate value="${d.shippedDate}" pattern="HH:mm dd/MM"/>
                                                                    </div>
                                                                </c:if>
                                                            </td>
                                                            <td>
                                                                <div class="fw-semibold text-dark">${not empty d.customerName ? d.customerName : 'Khách hàng'}</div>
                                                                <c:if test="${not empty d.shippingPhone}">
                                                                    <a href="tel:${d.shippingPhone}" class="small text-decoration-none text-primary fw-bold">
                                                                        <i class="fa-solid fa-phone me-1"></i>${d.shippingPhone}
                                                                    </a>
                                                                </c:if>
                                                            </td>
                                                            <td style="max-width:280px;">
                                                                <div class="text-truncate" title="${d.shippingAddress}">
                                                                    <i class="fa-solid fa-location-dot text-danger me-1"></i>${d.shippingAddress}
                                                                </div>
                                                                <c:if test="${not empty d.shipperNote}">
                                                                    <div class="small text-muted mt-1" style="font-style:italic;">
                                                                        <i class="fa-regular fa-comment-dots me-1"></i>"${d.shipperNote}"
                                                                    </div>
                                                                </c:if>
                                                            </td>
                                                            <td>
                                                                <div class="fw-bold text-dark">
                                                                    <fmt:formatNumber value="${d.totalAmount}" pattern="#,##0"/> ₫
                                                                </div>
                                                                <c:choose>
                                                                    <c:when test="${fn:containsIgnoreCase(d.paymentMethod, 'COD') or fn:containsIgnoreCase(d.paymentMethod, 'tiền mặt')}">
                                                                        <span class="status-badge badge-cod mt-1"><i class="fa-solid fa-money-bill-1"></i> COD</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="status-badge badge-prepaid mt-1"><i class="fa-solid fa-circle-check"></i> ${d.paymentMethod}</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${d.status eq 'Shipping'}">
                                                                        <span class="status-badge badge-shipping">
                                                                            <i class="fa-solid fa-truck-fast me-1"></i> Đang giao
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when test="${d.status eq 'Delivered'}">
                                                                        <span class="status-badge badge-delivered">
                                                                            <i class="fa-solid fa-circle-check me-1"></i> Đã giao
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when test="${d.status eq 'Failed'}">
                                                                        <span class="status-badge badge-failed">
                                                                            <i class="fa-solid fa-circle-xmark me-1"></i> Thất bại
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="status-badge badge-pending">${d.status}</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td class="text-center">
                                                                <div class="action-btns justify-content-center">
                                                                    <a href="https://www.google.com/maps/search/?api=1&query=${d.shippingAddress}" 
                                                                       target="_blank" class="btn btn-maps" title="Chỉ đường Google Maps">
                                                                        <i class="fa-solid fa-map-location-dot"></i> Bản đồ
                                                                    </a>
                                                                    <button type="button" class="btn btn-quickview" onclick="openQuickView(${d.orderId})" title="Xem món hàng">
                                                                        <i class="fa-solid fa-eye"></i> Xem món
                                                                    </button>

                                                                    <c:if test="${d.status eq 'Shipping'}">
                                                                        <form method="POST" action="delivery" style="display:inline;">
                                                                            <input type="hidden" name="action" value="confirm">
                                                                            <input type="hidden" name="deliveryId" value="${d.deliveryId}">
                                                                            <button type="submit" class="btn btn-success"
                                                                                    onclick="return confirm('Xác nhận đã giao đơn hàng #${d.deliveryId} thành công?')">
                                                                                <i class="fa-solid fa-check me-1"></i> Đã giao
                                                                            </button>
                                                                        </form>
                                                                        <button type="button" class="btn btn-report-fail" 
                                                                                onclick="openReportFailModal(${d.deliveryId})" title="Báo không giao được">
                                                                            <i class="fa-solid fa-xmark"></i> Báo lỗi
                                                                        </button>
                                                                    </c:if>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr>
                                                        <td colspan="6" class="text-center py-5 text-muted">
                                                            <i class="fa-solid fa-inbox mb-2 text-secondary fs-1 display-6"></i>
                                                            <p class="mb-0 fw-bold mt-2">Bạn chưa nhận hoặc không có đơn hàng nào khớp tìm kiếm.</p>
                                                        </td>
                                                    </tr>
                                                </c:otherwise>
                                            </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- Pagination: Đơn của tôi -->
                                <div class="d-flex align-items-center justify-content-between px-3 py-2 border-top bg-light" id="paginationMydeliveries" style="display:none!important;">
                                    <span class="text-muted small" id="pageInfoMydeliveries"></span>
                                    <div class="d-flex gap-2">
                                        <button class="btn btn-sm btn-outline-secondary" id="prevMydeliveries" onclick="changePage('mydeliveries',-1)">
                                            <i class="fa-solid fa-chevron-left"></i> Trước
                                        </button>
                                        <button class="btn btn-sm btn-outline-secondary" id="nextMydeliveries" onclick="changePage('mydeliveries',1)">
                                            Sau <i class="fa-solid fa-chevron-right"></i>
                                        </button>
                                    </div>
                                </div>
                            </div><!-- end bodyMydeliveries -->
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

        <!-- Quick View Items Modal -->
        <div class="modal fade" id="quickViewModal" tabindex="-1" aria-labelledby="quickViewModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-light">
                        <h5 class="modal-header-title fw-bold mb-0" id="quickViewModalLabel">
                            <i class="fa-solid fa-basket-shopping text-primary me-2"></i> Chi tiết sản phẩm đơn hàng #<span id="qvOrderId"></span>
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th class="text-center">Số lượng</th>
                                        <th class="text-end">Đơn giá</th>
                                        <th class="text-end">Thành tiền</th>
                                    </tr>
                                </thead>
                                <tbody id="quickViewItemsTable">
                                    <!-- Dynamic rows via JS -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="modal-footer bg-light">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Report Failure Modal -->
        <div class="modal fade" id="reportFailModal" tabindex="-1" aria-labelledby="reportFailModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <form method="POST" action="delivery">
                        <input type="hidden" name="action" value="report_fail">
                        <input type="hidden" name="deliveryId" id="failDeliveryId">
                        
                        <div class="modal-header bg-danger text-white">
                            <h5 class="modal-title fw-bold" id="reportFailModalLabel">
                                <i class="fa-solid fa-triangle-exclamation me-2"></i> Báo giao hàng thất bại
                            </h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p class="text-muted small">Vui lòng chọn hoặc nhập lý do không giao được hàng để gửi thông báo cho chủ shop:</p>
                            
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="radio" name="reason" id="r1" value="Khách hàng không nghe máy / Không liên lạc được" checked>
                                <label class="form-check-label" for="r1">Khách không nghe máy / Không liên lạc được</label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="radio" name="reason" id="r2" value="Sai địa chỉ giao hàng / Không tìm thấy địa chỉ">
                                <label class="form-check-label" for="r2">Sai địa chỉ / Không tìm thấy nhà</label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="radio" name="reason" id="r3" value="Khách đổi ý không nhận hàng / Hủy đơn">
                                <label class="form-check-label" for="r3">Khách hàng đổi ý từ chối nhận</label>
                            </div>
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="radio" name="reason" id="r4" value="Lý do khác">
                                <label class="form-check-label" for="r4">Lý do khác (Nhập chi tiết ở dưới)</label>
                            </div>
                            
                            <div class="mb-3">
                                <textarea name="customReason" class="form-control" placeholder="Ghi chú chi tiết thêm lý do..." rows="2"></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy bỏ</button>
                            <button type="submit" class="btn btn-danger">Xác nhận báo lỗi</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/js/app.js"></script>
        <script>

            function openQuickView(orderId) {
                document.getElementById('qvOrderId').innerText = orderId;
                const tbody = document.getElementById('quickViewItemsTable');
                tbody.innerHTML = '<tr><td colspan="4" class="text-center py-4"><i class="fa-solid fa-spinner fa-spin me-2"></i>Đang tải chi tiết đơn hàng...</td></tr>';
                
                var myModal = new bootstrap.Modal(document.getElementById('quickViewModal'));
                myModal.show();

                fetch('delivery?action=get_items&orderId=' + orderId)
                    .then(response => response.json())
                    .then(data => {
                        if (!data || data.length === 0) {
                            tbody.innerHTML = '<tr><td colspan="4" class="text-center py-4 text-muted">Không tìm thấy chi tiết sản phẩm.</td></tr>';
                            return;
                        }
                        let html = '';
                        let grandTotal = 0;
                        data.forEach(item => {
                            const subtotal = item.quantity * item.unitPrice;
                            grandTotal += subtotal;
                            const imgUrl = item.image ? item.image : '${pageContext.request.contextPath}/img/fruits/default.jpg';
                            html += `
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center gap-2">
                                            <img src="\${imgUrl}" class="item-img-thumb" alt="Product" onerror="this.src='https://cdn-icons-png.flaticon.com/512/1625/1625099.png'">
                                            <div>
                                                <div class="fw-bold text-dark">\${item.productName}</div>
                                                <div class="small text-muted">\${item.weightLabel ? item.weightLabel : ''} \${item.packagingName ? '(' + item.packagingName + ')' : ''}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="text-center fw-bold">\${item.quantity}</td>
                                    <td class="text-end">\${item.unitPrice.toLocaleString('vi-VN')} ₫</td>
                                    <td class="text-end fw-bold text-primary">\${subtotal.toLocaleString('vi-VN')} ₫</td>
                                </tr>
                            `;
                        });
                        html += `
                            <tr class="table-light">
                                <td colspan="3" class="text-end fw-bold">Tổng cộng:</td>
                                <td class="text-end fw-bold fs-6 text-danger">\${grandTotal.toLocaleString('vi-VN')} ₫</td>
                            </tr>
                        `;
                        tbody.innerHTML = html;
                    })
                    .catch(err => {
                        console.error(err);
                        tbody.innerHTML = '<tr><td colspan="4" class="text-center py-4 text-danger"><i class="fa-solid fa-circle-exclamation me-1"></i>Không thể tải danh sách món hàng.</td></tr>';
                    });
            }

            function openReportFailModal(deliveryId) {
                document.getElementById('failDeliveryId').value = deliveryId;
                var myModal = new bootstrap.Modal(document.getElementById('reportFailModal'));
                myModal.show();
            }

            // =========== COLLAPSE / EXPAND ===========
            const sectionState = { unassigned: true, mydeliveries: true };

            function toggleSection(key) {
                const body = document.getElementById('body' + capitalize(key));
                const icon = document.getElementById('icon' + capitalize(key));
                sectionState[key] = !sectionState[key];
                if (sectionState[key]) {
                    body.style.display = '';
                    icon.className = 'fa-solid fa-chevron-up';
                } else {
                    body.style.display = 'none';
                    icon.className = 'fa-solid fa-chevron-down';
                }
            }

            function capitalize(s) {
                return s.charAt(0).toUpperCase() + s.slice(1);
            }

            // =========== PAGINATION ===========
            const PAGE_SIZE = 5;
            const pageState = {};

            function initPagination(key) {
                const tbody = document.getElementById('tbody' + capitalize(key));
                if (!tbody) return;
                const rows = Array.from(tbody.querySelectorAll('tr[data-page-row]'));
                if (rows.length === 0) return; // no data rows

                pageState[key] = { current: 1, total: Math.ceil(rows.length / PAGE_SIZE) };
                const paginationDiv = document.getElementById('pagination' + capitalize(key));
                if (rows.length > PAGE_SIZE) {
                    paginationDiv.style.removeProperty('display');
                }
                renderPage(key);
            }

            function renderPage(key) {
                const tbody = document.getElementById('tbody' + capitalize(key));
                const rows = Array.from(tbody.querySelectorAll('tr[data-page-row]'));
                const state = pageState[key];
                const start = (state.current - 1) * PAGE_SIZE;
                const end   = start + PAGE_SIZE;

                rows.forEach((r, i) => {
                    r.style.display = (i >= start && i < end) ? '' : 'none';
                });

                document.getElementById('pageInfo' + capitalize(key)).textContent =
                    'Trang ' + state.current + ' / ' + state.total + ' (' + rows.length + ' đơn)';
                document.getElementById('prev' + capitalize(key)).disabled = state.current <= 1;
                document.getElementById('next' + capitalize(key)).disabled = state.current >= state.total;
            }

            function changePage(key, delta) {
                const state = pageState[key];
                if (!state) return;
                state.current = Math.min(Math.max(state.current + delta, 1), state.total);
                renderPage(key);
            }

            document.addEventListener('DOMContentLoaded', function () {
                if (typeof feather !== 'undefined') feather.replace();

                // Tag all data rows for pagination
                ['tbodyUnassigned','tbodyMydeliveries'].forEach(function(id) {
                    const tbody = document.getElementById(id);
                    if (!tbody) return;
                    tbody.querySelectorAll('tr').forEach(function(tr) {
                        // Only tag real data rows (not empty-state rows)
                        if (!tr.querySelector('td[colspan]')) {
                            tr.setAttribute('data-page-row', '1');
                        }
                    });
                });

                initPagination('unassigned');
                initPagination('mydeliveries');
            });
        </script>
    </body>
</html>


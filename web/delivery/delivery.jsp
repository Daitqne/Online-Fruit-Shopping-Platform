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
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
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
                            <a class="sidebar-link" href="delivery">
                                <i class="align-middle" data-feather="truck"></i>
                                <span class="align-middle">Giao hàng</span>
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
                                                    <a href="#" class="list-group-item">
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
                        <div class="d-flex align-items-center justify-content-between mb-3">
                            <h1 class="h3 mb-0">Quản lý giao hàng</h1>
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb mb-0">
                                    <li class="breadcrumb-item"><a href="delivery">Dashboard</a></li>
                                    <li class="breadcrumb-item active">Giao hàng</li>
                                </ol>
                            </nav>
                        </div>

                        <!-- Unassigned Deliveries -->
                        <div class="card mb-4">
                            <div class="card-header pb-0">
                                <h5 class="card-title mb-0">
                                    Đơn hàng chờ nhận
                                    <span class="badge bg-secondary ms-1">${unassigned.size()}</span>
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover my-0 align-middle">
                                        <thead>
                                            <tr>
                                                <th>#Giao hàng</th>
                                                <th>#Đơn hàng</th>
                                                <th>Địa chỉ</th>
                                                <th>Trạng thái</th>
                                                <th class="text-center">Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:choose>
                                                <c:when test="${not empty unassigned}">
                                                    <c:forEach var="d" items="${unassigned}">
                                                        <tr>
                                                            <td><strong>#${d.deliveryId}</strong></td>
                                                            <td>#${d.orderId}</td>
                                                            <td>${d.shippingAddress}</td>
                                                            <td>
                                                                <span class="status-badge badge-pending">
                                                                    <i data-feather="clock" style="width:11px;height:11px;"></i> Chờ nhận
                                                                </span>
                                                            </td>
                                                            <td class="text-center">
                                                                <div class="action-btns justify-content-center">
                                                                    <form method="POST" action="delivery" style="display:inline;">
                                                                        <input type="hidden" name="action" value="claim">
                                                                        <input type="hidden" name="deliveryId" value="${d.deliveryId}">
                                                                        <button type="submit" class="btn btn-sm btn-primary"
                                                                                onclick="return confirm('Nhận đơn giao hàng #${d.deliveryId}?')">
                                                                            <i data-feather="package" style="width:13px;height:13px;"></i> Nhận
                                                                        </button>
                                                                    </form>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr>
                                                        <td colspan="5" class="text-center py-5 text-muted">
                                                            <i data-feather="truck" class="mb-2" style="width:36px;height:36px;"></i>
                                                            <p class="mb-0 fw-bold mt-2">Không có đơn hàng nào đang chờ.</p>
                                                        </td>
                                                    </tr>
                                                </c:otherwise>
                                            </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <!-- My Deliveries -->
                        <div class="card">
                            <div class="card-header pb-0">
                                <h5 class="card-title mb-0">
                                    Đơn hàng của tôi
                                    <span class="badge bg-secondary ms-1">${myDeliveries.size()}</span>
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover my-0 align-middle">
                                        <thead>
                                            <tr>
                                                <th>#Giao hàng</th>
                                                <th>#Đơn hàng</th>
                                                <th>Địa chỉ</th>
                                                <th>Ngày nhận</th>
                                                <th>Trạng thái</th>
                                                <th class="text-center">Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:choose>
                                                <c:when test="${not empty myDeliveries}">
                                                    <c:forEach var="d" items="${myDeliveries}">
                                                        <tr>
                                                            <td><strong>#${d.deliveryId}</strong></td>
                                                            <td>#${d.orderId}</td>
                                                            <td>${d.shippingAddress}</td>
                                                            <td>
                                                                <fmt:formatDate value="${d.shippedDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                            </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${d.status eq 'Shipping'}">
                                                                        <span class="status-badge badge-shipping">
                                                                            <i data-feather="truck" style="width:11px;height:11px;"></i> Đang giao
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when test="${d.status eq 'Delivered'}">
                                                                        <span class="status-badge badge-delivered">
                                                                            <i data-feather="check-circle" style="width:11px;height:11px;"></i> Đã giao
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="status-badge badge-pending">${d.status}</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td class="text-center">
                                                                <div class="action-btns justify-content-center">
                                                                    <c:if test="${d.status eq 'Shipping'}">
                                                                        <form method="POST" action="delivery" style="display:inline;">
                                                                            <input type="hidden" name="action" value="confirm">
                                                                            <input type="hidden" name="deliveryId" value="${d.deliveryId}">
                                                                            <button type="submit" class="btn btn-sm btn-success"
                                                                                    onclick="return confirm('Xác nhận đã giao hàng #${d.deliveryId}?')">
                                                                                <i data-feather="check-circle" style="width:13px;height:13px;"></i> Đã giao
                                                                            </button>
                                                                        </form>
                                                                    </c:if>
                                                                    <c:if test="${d.status eq 'Delivered'}">
                                                                        <span class="text-muted" style="font-size:.8rem;">—</span>
                                                                    </c:if>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr>
                                                        <td colspan="6" class="text-center py-5 text-muted">
                                                            <i data-feather="inbox" class="mb-2" style="width:36px;height:36px;"></i>
                                                            <p class="mb-0 fw-bold mt-2">Bạn chưa nhận đơn hàng nào.</p>
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

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
        <meta name="description" content="Theo dõi đơn hàng - GreenStock Admin">
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

            /* ---- Table/List Adjustments ---- */
            .table > :not(caption) > * > * {
                padding: 0.85rem 1rem;
                vertical-align: middle;
            }

            .order-id-badge {
                font-weight: 700;
                color: #64748b;
            }

            .customer-item.active {
                background-color: #E6F4EA !important;
                border-left: 4px solid #10B981;
                color: #059669 !important;
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

                        <li class="sidebar-item">
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
                        <li class="sidebar-item">
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

                    <form action="admin-orders"
                          method="get"
                          class="d-none d-sm-inline-block">

                        <div class="input-group input-group-navbar">

                            <input
                                type="text"
                                class="form-control"
                                name="keyword"
                                value="${keyword}"
                                placeholder="Tìm khách hàng...">

                            <button class="btn btn-success" type="submit">
                                <i data-feather="search"></i>
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

                        <!-- Layout 2 Cột: Danh sách Khách hàng & Chi tiết Đơn hàng -->
                        <div class="row">
                            <!-- Cột Trái: Danh sách khách hàng mua nhiều đơn lỗi/đang theo dõi -->
                            <div class="col-12 col-xl-4">
                                <div class="card">
                                    <div class="card-header">
                                        <h5 class="card-title mb-0">Danh sách Khách hàng</h5>
                                    </div>
                                    <div class="list-group list-group-flush" style="max-height: 650px; overflow-y: auto;">
                                        <c:choose>
                                            <c:when test="${not empty customers}">
                                                <c:forEach items="${customers}" var="c">
                                                    <a href="admin-orders?customerId=${c.userId}" 
                                                       class="list-group-item list-group-item-action customer-item ${c.userId == selectedCustomerId ? 'active' : ''}">
                                                        <div class="d-flex w-100 justify-content-between align-items-center">
                                                            <h6 class="mb-1 fw-bold">${c.fullName}</h6>
                                                            <span class="badge bg-secondary rounded-pill">#${c.userId}</span>
                                                        </div>
                                                        <p class="mb-1 small text-muted">
                                                            <i data-feather="phone" style="width: 12px; height: 12px; vertical-align: middle;"></i> ${c.phone}
                                                        </p>
                                                    </a>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="text-center text-muted py-4">
                                                    <i data-feather="users" style="width: 32px; height: 32px; margin-bottom: 0.5rem;"></i>
                                                    <p class="mb-0">Không có dữ liệu khách hàng.</p>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>

                            <!-- Cột Phải: Lịch sử đơn hàng và chức năng Khóa đơn -->
                            <div class="col-12 col-xl-8">
                                <!-- Hiển thị thông báo kết quả hành động -->
                                <c:if test="${not empty sessionScope.msgSuccess}">
                                    <div class="alert alert-success-custom">
                                        <i data-feather="check-circle" style="width: 16px; height: 16px;"></i>
                                        <span>${sessionScope.msgSuccess}</span>
                                    </div>
                                    <c:remove var="msgSuccess" scope="session"/>
                                </c:if>
                                <c:if test="${not empty sessionScope.msgError}">
                                    <div class="alert alert-danger alert-dismissible" role="alert" style="border-radius: 10px; padding: 0.9rem 1.25rem;">
                                        <div class="alert-message">
                                            <i data-feather="alert-circle" style="width: 16px; height: 16px; margin-right: 0.5rem;"></i>
                                            <span>${sessionScope.msgError}</span>
                                        </div>
                                    </div>
                                    <c:remove var="msgError" scope="session"/>
                                </c:if>

                                <div class="card">
                                    <div class="card-header">
                                        <h5 class="card-title mb-0">Lịch sử Đơn hàng</h5>
                                    </div>
                                    <div class="card-body">
                                        <c:choose>
                                            <c:when test="${empty selectedCustomerId}">
                                                <div class="text-center text-muted py-5">
                                                    <i data-feather="user-check" style="width: 48px; height: 48px; margin-bottom: 0.5rem; color: #94a3b8;"></i>
                                                    <h5>Vui lòng chọn khách hàng</h5>
                                                    <p>Chọn một khách hàng ở danh sách bên trái để theo dõi chi tiết các đơn hàng.</p>
                                                </div>
                                            </c:when>
                                            <c:when test="${not empty orders}">
                                                <c:forEach items="${orders}" var="o">
                                                    <div class="border rounded p-3 mb-4 bg-light shadow-sm">
                                                        <!-- Header Đơn hàng -->
                                                        <div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-3">
                                                            <div>
                                                                <span class="order-id-badge h5">Mã đơn: #${o.saleOrderId}</span>
                                                                <span class="text-muted ms-3 small">
                                                                    <i data-feather="calendar" style="width: 14px; height: 14px; vertical-align: middle;"></i> ${o.orderDate}
                                                                </span>
                                                            </div>
                                                            <div>
                                                                <c:choose>
                                                                    <c:when test="${o.orderStatus == 'Pending'}">
                                                                        <span class="status-badge bg-warning text-dark">Chờ xử lý</span>
                                                                    </c:when>
                                                                    <c:when test="${o.orderStatus == 'Processing'}">
                                                                        <span class="status-badge bg-info text-white">Đang xử lý</span>
                                                                    </c:when>
                                                                    <c:when test="${o.orderStatus == 'Completed'}">
                                                                        <span class="status-badge active">Thành công</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="status-badge inactive">Đã hủy / Khóa</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div>

                                                        <!-- Chi tiết các sản phẩm trong đơn -->
                                                        <div class="table-responsive mb-3">
                                                            <table class="table table-sm table-borderless bg-white rounded">
                                                                <thead>
                                                                    <tr class="table-light text-muted" style="font-size: 0.8rem;">
                                                                        <th>Sản phẩm</th>
                                                                        <th class="text-center">Số lượng</th>
                                                                        <th class="text-end">Đơn giá</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach items="${o.items}" var="item">
                                                                        <tr>
                                                                            <td class="fw-semibold text-dark">
                                                                                ${item.product.name}
                                                                            </td>

                                                                            <td class="text-center">
                                                                                ${item.quantity} ${item.product.unit}
                                                                            </td>

                                                                            <td class="text-end text-secondary">
                                                                                <fmt:formatNumber value="${item.unitPrice}" type="number"/>đ
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </tbody>
                                                            </table>
                                                        </div>

                                                        <!-- Footer Đơn hàng & Nút hành động -->
                                                        <div class="d-flex justify-content-between align-items-center pt-2">
                                                            <div>
                                                                <span class="text-muted small">Tổng thanh toán:</span>
                                                                <strong class="text-danger h5 ms-1">
                                                                    <fmt:formatNumber value="${o.totalPayment}" type="number"/>đ
                                                                </strong>
                                                            </div>

                                                            <!-- Cho phép khóa đơn nếu đơn hàng chưa hoàn thành hoặc chưa hủy -->
                                                            <c:if test="${o.orderStatus eq 'Pending' || o.orderStatus eq 'Processing'}">
                                                                <form action="admin-orders" method="post" class="m-0">
                                                                    <input type="hidden" name="orderId" value="${o.saleOrderId}">
                                                                    <input type="hidden" name="customerId" value="${selectedCustomerId}">
                                                                    <button type="submit" class="btn btn-sm btn-block-user"
                                                                            onclick="return confirm('Bạn có chắc chắn muốn KHÓA đơn hàng này và HOÀN LẠI số lượng kho?')">
                                                                        <i data-feather="lock" style="width: 14px; height: 14px; vertical-align: middle;"></i> Khóa đơn & Hoàn kho
                                                                    </button>
                                                                </form>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="text-center text-muted py-5">
                                                    <i data-feather="inbox" style="width: 48px; height: 48px; margin-bottom: 0.5rem; color: #94a3b8;"></i>
                                                    <p>Khách hàng này hiện chưa có lịch sử đơn hàng nào.</p>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
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
                                                                                document.addEventListener("DOMContentLoaded", function () {
                                                                                    // Khởi tạo Feather Icons
                                                                                    if (typeof feather !== 'undefined') {
                                                                                        feather.replace();
                                                                                    }
                                                                                });
        </script>
    </body>
</html>
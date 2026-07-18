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
        <meta name="description" content="Quản lý khuyến mãi - GreenStock Admin">
        <meta name="author" content="GreenStock">

        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icons/icon-48x48.png" />

        <title>Quản lý chương trình khuyến mãi | Admin</title>

        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&amp;display=swap" rel="stylesheet">

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

            /* ---- Custom Badges & Table Fixes ---- */
            .promo-code-badge {
                font-weight: 700;
                background-color: #10B981;
                color: white;
                padding: 0.25rem 0.6rem;
                border-radius: 4px;
                font-size: 0.85rem;
            }

            .table > :not(caption) > * > * {
                padding: 0.85rem 1rem;
                vertical-align: middle;
            }
        </style>
    </head>

    <body data-theme="default" data-layout="fluid" data-sidebar-position="left" data-sidebar-layout="default">
        <div class="wrapper">

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
                                    <h1 class="h3 mb-0"><strong>Quản lý Chương Trình Khuyến Mãi</strong></h1>
                                </div>
                            </div>
                        </div>

                        <c:if test="${not empty successMessage}">
                            <div class="alert alert-success-custom">
                                <i data-feather="check-circle"></i> ${successMessage}
                            </div>
                        </c:if>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" style="border-radius: 10px; padding: 0.9rem 1.25rem; margin-bottom: 1.25rem; background: #FEF2F2; border: 1px solid #FCA5A5; color: #991B1B; display: flex; align-items: center; gap: 0.65rem; font-weight: 500; font-size: 0.9rem;">
                                <i data-feather="alert-triangle"></i> ${error}
                            </div>
                        </c:if>

                        <div class="row">
                            <div class="col-12 col-md-4">
                                <div class="card">
                                    <div class="card-header">
                                        <h5 class="card-title mb-0">Tạo mã mới</h5>
                                    </div>
                                    <div class="card-body">
                                        <form action="admin-promotions" method="POST">
                                            <input type="hidden" name="action" value="create">

                                            <div class="mb-3">
                                                <label class="form-label">Mã Khuyến Mãi</label>
                                                <input type="text" class="form-control" name="code" placeholder="Ví dụ: FRUIT10" required>
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Loại giảm giá</label>
                                                <select class="form-select" name="discountType">
                                                    <option value="Percentage">Phần trăm (%)</option>
                                                    <option value="Fixed">Tiền cố định</option>
                                                </select>
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Mức giảm</label>
                                                <input type="text" class="form-control" name="discountValue" placeholder="Ví dụ: 10 hoặc 25000" required>
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Đơn tối thiểu áp dụng (VNĐ)</label>
                                                <input type="number" class="form-control" name="minOrderValue" placeholder="Ví dụ: 150000" required>
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Ngày bắt đầu</label>
                                                <input type="date" class="form-control" name="startDate" required>
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Ngày hết hạn</label>
                                                <input type="date" class="form-control" name="endDate" required>
                                            </div>

                                            <button type="submit" class="btn btn-success w-100" style="background-color: #10B981; border-color: #10B981;">
                                                <i data-feather="plus-circle" class="align-middle me-1"></i> Tạo mã mới
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <div class="col-12 col-md-8">
                                <div class="card">
                                    <div class="card-header">
                                        <h5 class="card-title mb-0">Danh sách khuyến mãi hiện tại</h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>Mã</th>
                                                        <th>Loại</th>
                                                        <th>Mức giảm</th>
                                                        <th>Đơn tối thiểu</th>
                                                        <th>Ngày bắt đầu</th>
                                                        <th>Ngày hết hạn</th>
                                                        <th>Thao tác</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:choose>
                                                        <c:when test="${not empty promotionList}">
                                                            <c:forEach items="${promotionList}" var="p">
                                                                <tr>
                                                                    <td><span class="promo-code-badge">${p.promoCode}</span></td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${p.discountType eq 'Percentage' or p.discountType eq 'percentage'}">
                                                                                Phần trăm
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                Tiền cố định
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${p.discountType eq 'Percentage' or p.discountType eq 'percentage'}">
                                                                                <fmt:formatNumber value="${p.discountValue}" type="number" maxFractionDigits="0"/> %
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <fmt:formatNumber value="${p.discountValue}" type="number" maxFractionDigits="0"/> đ
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td><fmt:formatNumber value="${p.minOrderValue}" type="number" maxFractionDigits="0"/> đ</td>
                                                                    <td><fmt:formatDate value="${p.startDate}" pattern="dd/MM/yyyy"/></td>
                                                                    <td><fmt:formatDate value="${p.endDate}" pattern="dd/MM/yyyy"/></td>
                                                                    <td>
                                                                        <a href="admin-promotions?action=delete&id=${p.promoId}"
                                                                           class="btn btn-danger btn-sm"
                                                                           onclick="return confirm('Bạn có chắc muốn xóa voucher này không?')">
                                                                            Xóa
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <tr>
                                                                <td><span class="promo-code-badge" style="background-color: #10B981;">123456</span></td>
                                                                <td>Tiền cố định</td>
                                                                <td>10.000 đ</td>
                                                                <td>15.000 đ</td>
                                                                <td>22/06/2026</td>
                                                                <td>30/06/2026</td>
                                                            </tr>
                                                            <tr>
                                                                <td><span class="promo-code-badge" style="background-color: #10B981;">FRUIT10</span></td>
                                                                <td>Phần trăm</td>
                                                                <td>10 %</td>
                                                                <td>100.000 đ</td>
                                                                <td>01/01/2026</td>
                                                                <td>31/12/2026</td>
                                                            </tr>
                                                            <tr>
                                                                <td><span class="promo-code-badge" style="background-color: #10B981;">FREESHIP</span></td>
                                                                <td>Tiền cố định</td>
                                                                <td>25.000 đ</td>
                                                                <td>150.000 đ</td>
                                                                <td>01/01/2026</td>
                                                                <td>31/12/2026</td>
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
                   document.addEventListener("DOMContentLoaded", function () {
                       // Khởi tạo Feather icons cho các icon render động
                       if (typeof feather !== 'undefined') {
                           feather.replace();
                       }
                   });
        </script>
    </body>
</html>

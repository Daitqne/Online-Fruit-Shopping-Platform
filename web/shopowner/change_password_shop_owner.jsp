<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Đổi mật khẩu - GreenStock Shop Owner">
    <meta name="author" content="GreenStock">

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icons/icon-48x48.png" />

    <title>Đổi mật khẩu | Shop Owner</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&amp;display=swap" rel="stylesheet">

    <!-- AdminKit CSS -->
    <link href="${pageContext.request.contextPath}/css/vendor/light.css" rel="stylesheet">
    <style>
        body {
            opacity: 1 !important;
        }
    </style>
</head>

<body data-theme="default" data-layout="fluid" data-sidebar-position="left" data-sidebar-layout="default">
    <div class="wrapper">

        
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
                        <h1 class="h3 mb-0">Đổi mật khẩu</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item"><a href="shop-owner-profile">Hồ sơ</a></li>
                                <li class="breadcrumb-item active">Đổi mật khẩu</li>
                            </ol>
                        </nav>
                    </div>

                    <div class="row">
                        <div class="col-12 col-md-6 col-xl-5 mx-auto">
                            <div class="card">
                                <div class="card-header pb-0">
                                    <h5 class="card-title mb-0">Thiết lập mật khẩu mới</h5>
                                </div>
                                <div class="card-body">
                                    <!-- Error message banner if any -->
                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger alert-dismissible" role="alert">
                                            <div class="alert-message">
                                                <strong>Lỗi!</strong> ${error}
                                            </div>
                                        </div>
                                    </c:if>

                                    <form action="change-password" method="POST">
                                        <!-- Old Password -->
                                        <div class="mb-3">
                                            <label class="form-label fw-bold" for="oldPassword">Mật khẩu hiện tại <span class="text-danger">*</span></label>
                                            <input type="password" id="oldPassword" name="oldPassword" class="form-control" 
                                                   placeholder="Nhập mật khẩu hiện tại" required autocomplete="current-password">
                                        </div>

                                        <!-- New Password -->
                                        <div class="mb-3">
                                            <label class="form-label fw-bold" for="newPassword">Mật khẩu mới <span class="text-danger">*</span></label>
                                            <input type="password" id="newPassword" name="newPassword" class="form-control" 
                                                   placeholder="Nhập mật khẩu mới" required autocomplete="new-password">
                                        </div>

                                        <!-- Confirm Password -->
                                        <div class="mb-3">
                                            <label class="form-label fw-bold" for="confirmPassword">Xác nhận mật khẩu mới <span class="text-danger">*</span></label>
                                            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" 
                                                   placeholder="Xác nhận lại mật khẩu mới" required autocomplete="new-password">
                                        </div>

                                        <!-- Action Buttons -->
                                        <div class="text-end mt-4">
                                            <a href="shop-owner-profile" class="btn btn-secondary me-2">
                                                <i data-feather="x" class="align-middle me-1"></i> Hủy
                                            </a>
                                            <button type="submit" class="btn btn-success">
                                                <i data-feather="lock" class="align-middle me-1"></i> Đổi mật khẩu
                                            </button>
                                        </div>
                                    </form>
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


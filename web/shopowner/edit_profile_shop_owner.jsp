<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Chỉnh sửa hồ sơ cá nhân - GreenStock Shop Owner">
    <meta name="author" content="GreenStock">

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icons/icon-48x48.png" />

    <title>Chỉnh sửa hồ sơ | Shop Owner</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&amp;display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/vendor/light.css" rel="stylesheet">
    
    <style>
        .profile-hero {
            background: linear-gradient(135deg, #10B981 0%, #059669 50%, #047857 100%);
            border-radius: 12px;
            padding: 2rem;
            color: #fff;
            display: flex;
            align-items: center;
            gap: 2rem;
            margin-bottom: 1.5rem;
            position: relative;
            overflow: hidden;
        }

        .profile-hero::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 300px;
            height: 300px;
            background: rgba(255, 255, 255, 0.06);
            border-radius: 50%;
        }

        .profile-avatar-wrap {
            position: relative;
            flex-shrink: 0;
        }

        .profile-avatar-wrap img {
            width: 110px;
            height: 110px;
            border-radius: 50%;
            border: 4px solid rgba(255, 255, 255, 0.4);
            object-fit: cover;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.25);
        }

        .profile-hero-info h2 {
            font-size: 1.75rem;
            font-weight: 700;
            margin: 0 0 0.3rem;
            color: #fff;
        }

        .profile-hero-info .role-badge {
            display: inline-block;
            background: rgba(255, 255, 255, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: #fff;
            padding: 0.25rem 0.85rem;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 600;
            letter-spacing: 0.05em;
            margin-bottom: 0.4rem;
            text-transform: uppercase;
        }

        .profile-hero-info .member-since {
            font-size: 0.85rem;
            color: rgba(255, 255, 255, 0.75);
            margin: 0;
        }

        .form-section-card {
            background: #fff;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            padding: 2rem;
            margin-bottom: 1.25rem;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
        }

        .form-section-title {
            font-size: 1rem;
            font-weight: 700;
            color: #334155;
            letter-spacing: 0.03em;
            text-transform: uppercase;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 2px solid #f1f5f9;
        }

        .form-section-title i {
            color: #10B981;
        }

        .gender-group {
            display: flex;
            gap: 1.5rem;
            align-items: center;
            margin-top: 0.25rem;
        }

        .gender-option {
            display: flex;
            align-items: center;
            gap: 0.4rem;
            cursor: pointer;
        }

        .gender-option input {
            cursor: pointer;
            accent-color: #10B981;
            width: 18px;
            height: 18px;
        }

        .btn-save-custom {
            background-color: #10B981;
            color: #fff;
            border: none;
            padding: 0.65rem 2rem;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.2s ease;
            box-shadow: 0 4px 10px rgba(16, 185, 129, 0.2);
        }

        .btn-save-custom:hover {
            background-color: #059669;
            transform: translateY(-1px);
            box-shadow: 0 6px 15px rgba(16, 185, 129, 0.3);
        }

        .btn-cancel-custom {
            background-color: #f1f5f9;
            color: #475569;
            border: 1px solid #cbd5e1;
            padding: 0.65rem 2rem;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-cancel-custom:hover {
            background-color: #e2e8f0;
            color: #1e293b;
        }

        .alert-danger-custom {
            background: #FDF2F2;
            border: 1px solid #FDE8E8;
            color: #9B1C1C;
            padding: 1rem 1.25rem;
            border-radius: 10px;
            font-size: 0.9rem;
            margin-bottom: 1.5rem;
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
                                class="avatar img-fluid rounded me-1" id="sidebar-avatar" alt="Avatar" />
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
                            <a class="nav-icon dropdown-toggle" href="#" id="alertsDropdown" data-bs-toggle="dropdown">
                                <div class="position-relative">
                                    <i class="align-middle" data-feather="bell"></i>
                                </div>
                            </a>
                            <div class="dropdown-menu dropdown-menu-lg dropdown-menu-end py-0" aria-labelledby="alertsDropdown">
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
                                    class="avatar img-fluid rounded" id="navbar-avatar" alt="Avatar" />
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
                        <h1 class="h3 mb-0">Chỉnh sửa hồ sơ</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item">
                                    <a href="products-shop-owner">Dashboard</a>
                                </li>
                                <li class="breadcrumb-item">
                                    <a href="shop-owner-profile">Hồ sơ</a>
                                </li>
                                <li class="breadcrumb-item active">Chỉnh sửa</li>
                            </ol>
                        </nav>
                    </div>

                    <!-- Error Alert -->
                    <c:if test="${not empty error}">
                        <div class="alert-danger-custom d-flex align-items-center gap-2">
                            <i data-feather="alert-circle" style="width:20px;height:20px;"></i>
                            <div>${error}</div>
                        </div>
                    </c:if>

                    <!-- Profile Hero Banner -->
                    <div class="profile-hero">
                        <div class="profile-avatar-wrap">
                            <img id="avatar-preview" src="${not empty sessionScope.user.avatar ? sessionScope.user.avatar : 'https://cdn-icons-png.flaticon.com/512/149/149071.png'}"
                                alt="Avatar">
                        </div>

                        <div class="profile-hero-info">
                            <h2>${sessionScope.user.fullName}</h2>
                            <div class="role-badge">Shop Owner</div>
                            <p class="member-since">
                                <i class="fa-regular fa-calendar" style="margin-right:4px;"></i>
                                Thành viên từ 2026 &nbsp;•&nbsp;
                                <i class="fa-solid fa-envelope" style="margin-right:4px;"></i>
                                ${sessionScope.user.email}
                            </p>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12 col-lg-8">
                            <div class="form-section-card">
                                <div class="form-section-title">
                                    <i data-feather="edit-3" style="width:18px;height:18px;"></i>
                                    Thông tin cá nhân &amp; Liên hệ
                                </div>

                                <form action="edit-profile-shop-owner" method="POST">
                                    <div class="row">
                                        <!-- Họ và tên -->
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label" for="fullName">Họ và tên <span class="text-danger">*</span></label>
                                            <input type="text" id="fullName" name="fullName" class="form-control"
                                                value="${not empty inputFullName ? inputFullName : sessionScope.user.fullName}" required minlength="2" maxlength="100">
                                            <div class="form-text text-muted" style="font-size:0.78rem;">Từ 2 đến 100 ký tự (chỉ dùng chữ cái và khoảng trắng)</div>
                                        </div>

                                        <!-- Số điện thoại -->
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label" for="phone">Số điện thoại <span class="text-danger">*</span></label>
                                            <input type="tel" id="phone" name="phone" class="form-control"
                                                value="${not empty inputPhone ? inputPhone : sessionScope.user.phone}" required pattern="0[0-9]{9,10}" maxlength="11">
                                            <div class="form-text text-muted" style="font-size:0.78rem;">10-11 số, bắt đầu bằng số 0</div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <!-- Email -->
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label" for="email">Email <span class="text-danger">*</span></label>
                                            <input type="email" id="email" name="email" class="form-control"
                                                value="${not empty inputEmail ? inputEmail : sessionScope.user.email}" required maxlength="150">
                                        </div>

                                        <!-- Giới tính -->
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Giới tính</label>
                                            <div class="gender-group">
                                                <label class="gender-option">
                                                    <input type="radio" name="gender" value="Nam" 
                                                        ${(not empty inputGender ? inputGender : sessionScope.user.gender) eq 'Nam' ? 'checked' : ''}> Nam
                                                </label>
                                                <label class="gender-option">
                                                    <input type="radio" name="gender" value="Nữ" 
                                                        ${(not empty inputGender ? inputGender : sessionScope.user.gender) eq 'Nữ' ? 'checked' : ''}> Nữ
                                                </label>
                                                <label class="gender-option">
                                                    <input type="radio" name="gender" value="Khác" 
                                                        ${(not empty inputGender ? inputGender : sessionScope.user.gender) eq 'Khác' ? 'checked' : ''}> Khác
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <!-- Ngày sinh -->
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label" for="dob">Ngày sinh</label>
                                            <input type="date" id="dob" name="dob" class="form-control"
                                                value="${not empty inputDob ? inputDob : sessionScope.user.dob}"
                                                max="<%= java.time.LocalDate.now().minusYears(18) %>">
                                            <div class="form-text text-muted" style="font-size:0.78rem;">Phải đủ 18 tuổi trở lên</div>
                                        </div>

                                        <!-- Avatar URL -->
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label" for="avatar">Đường dẫn ảnh đại diện (URL)</label>
                                            <input type="text" id="avatar" name="avatar" class="form-control"
                                                value="${not empty inputAvatar ? inputAvatar : sessionScope.user.avatar}"
                                                oninput="updateAvatarPreview(this.value)" placeholder="https://example.com/avatar.jpg">
                                        </div>
                                    </div>

                                    <!-- Địa chỉ -->
                                    <div class="mb-4">
                                        <label class="form-label" for="address">Địa chỉ liên hệ</label>
                                        <textarea id="address" name="address" class="form-control" rows="3" maxlength="500"
                                            placeholder="Nhập địa chỉ liên hệ/cửa hàng của bạn...">${not empty inputAddress ? inputAddress : sessionScope.user.address}</textarea>
                                        <div class="form-text text-muted" style="font-size:0.78rem;">Tối đa 500 ký tự</div>
                                    </div>

                                    <div class="d-flex gap-2">
                                        <button type="submit" class="btn-save-custom">Lưu thay đổi</button>
                                        <a href="shop-owner-profile" class="btn-cancel-custom">Hủy</a>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <!-- Sidebar Info Guidelines -->
                        <div class="col-12 col-lg-4">
                            <div class="form-section-card">
                                <div class="form-section-title">
                                    <i data-feather="info" style="width:18px;height:18px;"></i>
                                    Hướng dẫn nhập liệu
                                </div>
                                <ul style="padding-left:1.25rem; font-size:0.875rem; color:#64748b; line-height:1.7;">
                                    <li>Các trường đánh dấu <span class="text-danger">*</span> là bắt buộc.</li>
                                    <li>Họ tên phải khớp trên chứng thư cá nhân và không chứa chữ số hay ký tự đặc biệt.</li>
                                    <li>Số điện thoại dùng để liên hệ đặt hàng/nhập kho (bắt buộc đầu số 0, 10-11 ký tự).</li>
                                    <li>Tuổi của chủ cửa hàng phải từ 18 trở lên theo quy định kinh doanh.</li>
                                    <li>Địa chỉ cửa hàng sẽ dùng để lập phiếu biên nhận hàng hóa và chứng từ doanh thu.</li>
                                </ul>
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

    <!-- FontAwesome for profile calendar/envelope icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <script src="${pageContext.request.contextPath}/js/app.js"></script>

    <script>
        function updateAvatarPreview(url) {
            var preview = document.getElementById('avatar-preview');
            if (url && url.trim().length > 0) {
                preview.src = url.trim();
            } else {
                preview.src = 'https://cdn-icons-png.flaticon.com/512/149/149071.png';
            }
        }
        
        document.addEventListener("DOMContentLoaded", function () {
            if (typeof feather !== 'undefined') {
                feather.replace();
            }
        });
    </script>
</body>

</html>

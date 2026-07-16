<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Chỉnh sửa sản phẩm - GreenStock Shop Owner">
    <meta name="author" content="GreenStock">

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icons/icon-48x48.png" />

    <title>Chỉnh sửa sản phẩm | Shop Owner</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&amp;display=swap" rel="stylesheet">

    <!-- AdminKit CSS -->
    <link href="${pageContext.request.contextPath}/css/vendor/light.css" rel="stylesheet">
    <style>
        body {
            opacity: 1 !important;
        }

        .image-preview {
            width: 100%;
            max-height: 200px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
            margin-top: 10px;
            background: #f8fafc;
            display: block;
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
                        <a class="sidebar-link" href="inventory-shop-owner">
                            <i class="align-middle" data-feather="package"></i>
                            <span class="align-middle">Tồn kho</span>
                        </a>
                    </li>

                    <li class="sidebar-item">
                        <a class="sidebar-link" href="import-receipt">
                            <i class="align-middle" data-feather="clipboard"></i>
                            <span class="align-middle">Nhập kho</span>
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
                        <h1 class="h3 mb-0">Chỉnh sửa sản phẩm</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item"><a href="products-shop-owner">Sản phẩm</a></li>
                                <li class="breadcrumb-item active">Chỉnh sửa</li>
                            </ol>
                        </nav>
                    </div>

                    <div class="row">
                        <div class="col-12 col-xl-8 col-xxl-7 mx-auto">
                            <div class="card">
                                <div class="card-header d-flex justify-content-between align-items-center pb-0">
                                    <h5 class="card-title mb-0">Thông tin sản phẩm</h5>
                                    <span class="badge bg-primary">ID: ${product.id}</span>
                                </div>
                                <div class="card-body">
                                    <!-- Error alert if any -->
                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger alert-dismissible" role="alert">
                                            <div class="alert-message">
                                                <strong>Lỗi!</strong> ${error}
                                            </div>
                                        </div>
                                    </c:if>

                                    <form action="edit-product" method="POST">
                                        <!-- Hidden ID field -->
                                        <input type="hidden" name="id" value="${product.id}">

                                        <div class="row g-3">
                                            <!-- Product Name -->
                                            <div class="col-md-6">
                                                <label class="form-label fw-bold" for="name">Tên sản phẩm <span class="text-danger">*</span></label>
                                                <input type="text" id="name" name="name" class="form-control" 
                                                       value="${product.name}" placeholder="Nhập tên sản phẩm" required>
                                            </div>

                                            <!-- Category -->
                                            <div class="col-md-6">
                                                <label class="form-label fw-bold" for="category">Danh mục <span class="text-danger">*</span></label>
                                                <input type="text" id="category" name="category" class="form-control" 
                                                       value="${product.category}" list="categoryList" placeholder="Chọn hoặc tự nhập danh mục" required>
                                                <datalist id="categoryList">
                                                    <c:forEach var="cat" items="${categories}">
                                                        <option value="${cat}"></option>
                                                    </c:forEach>
                                                </datalist>
                                            </div>

                                            <!-- Original Price -->
                                            <div class="col-md-3">
                                                <label class="form-label fw-bold" for="price">Giá gốc (đ / đơn vị)</label>
                                                <input type="number" id="price" name="price" class="form-control" 
                                                       value="${product.price}" placeholder="0" min="0" step="1000">
                                            </div>

                                            <!-- Discount Price -->
                                            <div class="col-md-3">
                                                <label class="form-label fw-bold" for="discountPrice">Giá khuyến mãi (đ)</label>
                                                <input type="number" id="discountPrice" name="discountPrice" class="form-control" 
                                                       value="${product.discountPrice}" placeholder="0" min="0" step="1000">
                                            </div>

                                            <!-- Import Price -->
                                            <div class="col-md-3">
                                                <label class="form-label fw-bold" for="importPrice">Giá nhập (đ)</label>
                                                <input type="number" id="importPrice" name="importPrice" class="form-control" 
                                                       value="${product.importPrice}" placeholder="0" min="0" step="1000">
                                            </div>

                                            <!-- Unit -->
                                            <div class="col-md-3">
                                                <label class="form-label fw-bold" for="unit">Đơn vị tính</label>
                                                <input type="text" id="unit" name="unit" class="form-control" 
                                                       value="${product.unit}" placeholder="Ví dụ: Hộp, Kg">
                                            </div>

                                            <!-- Origin -->
                                            <div class="col-md-6">
                                                <label class="form-label fw-bold" for="origin">Xuất xứ</label>
                                                <input type="text" id="origin" name="origin" class="form-control" 
                                                       value="${product.origin}" placeholder="Ví dụ: Việt Nam, Mỹ">
                                            </div>
                                            <!-- Low Stock Threshold -->
                                            <div class="col-md-6">
                                                <label class="form-label fw-bold" for="lowStockThreshold">Ngưỡng cảnh báo hết hàng <span class="text-danger">*</span></label>
                                                <input type="number" id="lowStockThreshold" name="lowStockThreshold" class="form-control" 
                                                       value="${product.lowStockThreshold}" min="0" placeholder="Ví dụ: 10" required>
                                            </div>

                                            <!-- Import Date -->
                                            <div class="col-md-6">
                                                <label class="form-label fw-bold" for="importDate">Ngày nhập hàng</label>
                                                <input type="date" id="importDate" name="importDate" class="form-control" 
                                                       value="${product.importDate}">
                                            </div>

                                            <!-- Expired Date -->
                                            <div class="col-md-6">
                                                <label class="form-label fw-bold" for="expiredDate">Ngày hết hạn</label>
                                                <input type="date" id="expiredDate" name="expiredDate" class="form-control" 
                                                       value="${product.expiredDate}">
                                            </div>
                                            <!-- Status (read-only info) -->
                                            <div class="col-md-12">
                                                <label class="form-label fw-bold">Trạng thái sau khi lưu</label>
                                                <div class="alert alert-info py-2 mb-0" style="font-size:0.85rem;">
                                                    <i data-feather="info" style="width:14px;height:14px;"></i>
                                                    Sau khi lưu, sản phẩm sẽ tự động chuyển về trạng thái <strong>Chờ duyệt</strong> để Admin xét duyệt lại.
                                                </div>
                                            </div>

                                            <!-- Image URL -->
                                            <div class="col-12">
                                                <label class="form-label fw-bold" for="image">Đường dẫn ảnh sản phẩm</label>
                                                <input type="url" id="imageInput" name="image" class="form-control" 
                                                       value="${product.image}" placeholder="https://..." oninput="updatePreview(this.value)">
                                                <div class="mt-2">
                                                    <small class="text-muted d-block mb-1">Xem trước hình ảnh:</small>
                                                    <img id="imgPreview" class="image-preview" 
                                                         src="${product.image}" 
                                                         alt="Xem trước ảnh"
                                                         onerror="this.src='https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?auto=format&fit=crop&q=80&w=600'">
                                                </div>
                                            </div>

                                            <!-- Description -->
                                            <div class="col-12">
                                                <label class="form-label fw-bold" for="description">Mô tả sản phẩm</label>
                                                <textarea id="description" name="description" class="form-control" rows="4" 
                                                          placeholder="Nhập thông tin mô tả chi tiết sản phẩm...">${product.description}</textarea>
                                            </div>

                                            <!-- Action Buttons -->
                                            <div class="col-12 text-end mt-4">
                                                <a href="products-shop-owner" class="btn btn-secondary me-2">
                                                    <i data-feather="x" class="align-middle me-1"></i> Hủy
                                                </a>
                                                <button type="submit" class="btn btn-primary">
                                                    <i data-feather="save" class="align-middle me-1"></i> Lưu thay đổi
                                                </button>
                                            </div>
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

        function updatePreview(url) {
            const img = document.getElementById('imgPreview');
            img.src = url || 'https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?auto=format&fit=crop&q=80&w=600';
        }
    </script>
</body>

</html>


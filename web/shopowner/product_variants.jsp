<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Quản lý biến thể trọng lượng - GreenStock Shop Owner">
    <meta name="author" content="GreenStock">

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icons/icon-48x48.png" />

    <title>Biến thể trọng lượng | ${product.name}</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&amp;display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/vendor/light.css" rel="stylesheet">
    <style>
        .price-adj-pos {
            color: #28a745;
            font-weight: 600;
        }
        .price-adj-neg {
            color: #dc3545;
            font-weight: 600;
        }
        .price-adj-zero {
            color: #6c757d;
        }
    </style>
</head>

<body data-theme="default" data-layout="fluid" data-sidebar-position="left" data-sidebar-layout="default">
    <div class="wrapper">

        <!-- ========== SIDEBAR ========== -->
        <nav id="sidebar" class="sidebar js-sidebar">
            <div class="sidebar-content js-simplebar">
                <a class="sidebar-brand" href="products-shop-owner">
                    <span class="sidebar-brand-text align-middle">Shop Owner</span>
                </a>
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

            <nav class="navbar navbar-expand navbar-light navbar-bg">
                <a class="sidebar-toggle js-sidebar-toggle">
                    <i class="hamburger align-self-center"></i>
                </a>
            </nav>

            <main class="content">
                <div class="container-fluid p-0">

                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <div>
                            <h1 class="h3 mb-1">Cấu hình biến thể trọng lượng</h1>
                            <h5 class="text-muted mb-0">Sản phẩm: <strong>${product.name}</strong></h5>
                        </div>
                        <a href="products-shop-owner" class="btn btn-secondary">
                            <i data-feather="arrow-left" class="align-middle me-1"></i> Quay lại
                        </a>
                    </div>

                    <div class="row">
                        <!-- List of Variants -->
                        <div class="col-12 col-lg-8">
                            <div class="card">
                                <div class="card-header pb-0">
                                    <h5 class="card-title mb-0">Danh sách biến thể</h5>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover table-striped align-middle">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Nhãn trọng lượng</th>
                                                    <th class="text-end">Chênh lệch giá bán</th>
                                                    <th class="text-center" style="width: 100px;">Hành động</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:choose>
                                                    <c:when test="${not empty variants}">
                                                        <c:forEach var="v" items="${variants}">
                                                            <tr>
                                                                <td><strong>#${v.variantId}</strong></td>
                                                                <td><span class="badge bg-info text-dark" style="font-size: 0.9rem;">${v.weightLabel}</span></td>
                                                                <td class="text-end">
                                                                    <c:choose>
                                                                        <c:when test="${v.priceAdjustment > 0}">
                                                                            <span class="price-adj-pos">
                                                                                +<fmt:formatNumber value="${v.priceAdjustment}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                                                            </span>
                                                                        </c:when>
                                                                        <c:when test="${v.priceAdjustment < 0}">
                                                                            <span class="price-adj-neg">
                                                                                <fmt:formatNumber value="${v.priceAdjustment}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                                                            </span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span class="price-adj-zero">0đ</span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                <td class="text-center">
                                                                    <form action="product-variants" method="POST" onsubmit="return confirm('Bạn có chắc muốn xóa biến thể này?');">
                                                                        <input type="hidden" name="action" value="delete">
                                                                        <input type="hidden" name="productId" value="${product.id}">
                                                                        <input type="hidden" name="variantId" value="${v.variantId}">
                                                                        <button type="submit" class="btn btn-sm btn-outline-danger">
                                                                            <i data-feather="trash-2" style="width: 14px; height: 14px;"></i> Xóa
                                                                        </button>
                                                                    </form>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <tr>
                                                            <td colspan="4" class="text-center py-4 text-muted">
                                                                Chưa có biến thể trọng lượng nào. Sản phẩm sẽ sử dụng trọng lượng mặc định.
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

                        <!-- Add Variant Form -->
                        <div class="col-12 col-lg-4">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Thêm biến thể mới</h5>
                                </div>
                                <div class="card-body">
                                    <form action="product-variants" method="POST">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="productId" value="${product.id}">

                                        <div class="mb-3">
                                            <label class="form-label fw-bold" for="weightLabel">Nhãn trọng lượng <span class="text-danger">*</span></label>
                                            <input type="text" id="weightLabel" name="weightLabel" class="form-control" 
                                                   placeholder="Ví dụ: 500g, 1kg, 2.5kg" required>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label fw-bold" for="priceAdjustment">Chênh lệch giá bán (đ)</label>
                                            <input type="number" id="priceAdjustment" name="priceAdjustment" class="form-control" 
                                                   value="0" placeholder="Ví dụ: 15000 hoặc -5000">
                                            <small class="text-muted">Nhập số dương để cộng thêm vào giá gốc, hoặc số âm để giảm trừ.</small>
                                        </div>

                                        <div class="d-grid mt-4">
                                            <button type="submit" class="btn btn-success">
                                                <i data-feather="plus" class="align-middle me-1"></i> Lưu biến thể
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </main>
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


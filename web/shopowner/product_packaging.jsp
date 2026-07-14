<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Quản lý tùy chọn đóng gói - GreenStock Shop Owner">
    <meta name="author" content="GreenStock">

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icons/icon-48x48.png" />

    <title>Tùy chọn đóng gói | ${product.name}</title>

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
        .suggestion-chip {
            font-size: 0.8rem;
            padding: 0.25rem 0.6rem;
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.2s ease-in-out;
            margin-right: 0.3rem;
            margin-bottom: 0.3rem;
            border: 1px solid #dee2e6;
            background-color: #f8f9fa;
            color: #495057;
            display: inline-block;
            user-select: none;
        }
        .suggestion-chip:hover {
            background-color: #e9ecef;
            border-color: #adb5bd;
            color: #212529;
        }
        .suggestion-chip.active-packaging {
            background-color: #198754;
            border-color: #198754;
            color: #fff;
            box-shadow: 0 2px 4px rgba(25, 135, 84, 0.2);
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
                            <h1 class="h3 mb-1">Cấu hình tùy chọn đóng gói</h1>
                            <h5 class="text-muted mb-0">Sản phẩm: <strong>${product.name}</strong></h5>
                        </div>
                        <a href="products-shop-owner" class="btn btn-secondary">
                            <i data-feather="arrow-left" class="align-middle me-1"></i> Quay lại
                        </a>
                    </div>

                    <div class="row">
                        <!-- List of Packaging Options -->
                        <div class="col-12 col-lg-8">
                            <div class="card">
                                <div class="card-header pb-0">
                                    <h5 class="card-title mb-0">Danh sách tùy chọn đóng gói</h5>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover table-striped align-middle">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Tên đóng gói</th>
                                                    <th class="text-end">Chênh lệch giá bán</th>
                                                    <th class="text-center" style="width: 100px;">Hành động</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:choose>
                                                    <c:when test="${not empty packagings}">
                                                        <c:forEach var="p" items="${packagings}">
                                                            <tr>
                                                                <td><strong>#${p.packagingId}</strong></td>
                                                                <td><span class="badge bg-warning text-dark" style="font-size: 0.9rem;">${p.packagingName}</span></td>
                                                                <td class="text-end">
                                                                    <c:choose>
                                                                        <c:when test="${p.priceAdjustment > 0}">
                                                                            <span class="price-adj-pos">
                                                                                +<fmt:formatNumber value="${p.priceAdjustment}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                                                            </span>
                                                                        </c:when>
                                                                        <c:when test="${p.priceAdjustment < 0}">
                                                                            <span class="price-adj-neg">
                                                                                <fmt:formatNumber value="${p.priceAdjustment}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                                                            </span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span class="price-adj-zero">0đ</span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                <td class="text-center">
                                                                    <form action="product-packaging" method="POST" onsubmit="return confirm('Bạn có chắc muốn xóa tùy chọn đóng gói này?');">
                                                                        <input type="hidden" name="action" value="delete">
                                                                        <input type="hidden" name="productId" value="${product.id}">
                                                                        <input type="hidden" name="packagingId" value="${p.packagingId}">
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
                                                                Chưa có tùy chọn đóng gói nào. Sản phẩm sẽ sử dụng đóng gói mặc định.
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

                        <!-- Add Packaging Option Form -->
                        <div class="col-12 col-lg-4">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Thêm tùy chọn đóng gói</h5>
                                </div>
                                <div class="card-body">
                                    <form action="product-packaging" method="POST">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="productId" value="${product.id}">

                                        <div class="mb-3">
                                            <label class="form-label fw-bold">Chọn quy cách đóng gói <span class="text-danger">*</span></label>
                                            <div class="mb-2">
                                                <label class="form-label text-muted small d-block mb-1">Gợi ý chọn nhanh:</label>
                                                <div class="d-flex flex-wrap">
                                                    <span class="suggestion-chip packaging-chip" onclick="selectPackaging('Hộp quà gỗ')">Hộp quà gỗ</span>
                                                    <span class="suggestion-chip packaging-chip" onclick="selectPackaging('Hộp carton')">Hộp carton</span>
                                                    <span class="suggestion-chip packaging-chip" onclick="selectPackaging('Túi tự hủy')">Túi tự hủy</span>
                                                    <span class="suggestion-chip packaging-chip" onclick="selectPackaging('Hộp nhựa')">Hộp nhựa</span>
                                                    <span class="suggestion-chip packaging-chip" onclick="selectPackaging('Túi nilon')">Túi nilon</span>
                                                </div>
                                            </div>
                                            <select id="packagingSelect" name="packagingName" class="form-select mb-2" onchange="handlePackagingChange(this)" required>
                                                <option value="" disabled selected>-- Chọn đóng gói hoặc "Tự nhập" --</option>
                                                <option value="Hộp quà gỗ">Hộp quà gỗ</option>
                                                <option value="Hộp carton">Hộp carton</option>
                                                <option value="Túi tự hủy">Túi tự hủy</option>
                                                <option value="Hộp nhựa">Hộp nhựa</option>
                                                <option value="Túi nilon">Túi nilon</option>
                                                <option value="custom">Khác (Tự nhập)...</option>
                                            </select>
                                            
                                            <div id="customPackagingDiv" style="display: none;" class="mt-2">
                                                <label class="form-label text-muted small fw-bold" for="packagingName">Nhập quy cách đóng gói khác:</label>
                                                <input type="text" id="packagingName" class="form-control" placeholder="Ví dụ: Hộp thiếc, Hộp tre...">
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label fw-bold" for="priceAdjustment">Chênh lệch giá bán (đ)</label>
                                            <input type="number" id="priceAdjustment" name="priceAdjustment" class="form-control" 
                                                   value="0" placeholder="Ví dụ: 10000 hoặc 25000">
                                            <small class="text-muted">Nhập số dương để cộng thêm vào giá gốc, hoặc số âm để giảm trừ.</small>
                                        </div>

                                        <div class="d-grid mt-4">
                                            <button type="submit" class="btn btn-success">
                                                <i data-feather="plus" class="align-middle me-1"></i> Lưu tùy chọn
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

        function selectPackaging(value) {
            const selectEl = document.getElementById('packagingSelect');
            selectEl.value = value;
            handlePackagingChange(selectEl);
        }

        function handlePackagingChange(selectEl) {
            const customDiv = document.getElementById('customPackagingDiv');
            const customInput = document.getElementById('packagingName');
            
            if (selectEl.value === 'custom') {
                customDiv.style.display = 'block';
                customInput.setAttribute('name', 'packagingName');
                customInput.setAttribute('required', 'true');
                selectEl.removeAttribute('name');
                customInput.focus();
            } else {
                customDiv.style.display = 'none';
                customInput.removeAttribute('name');
                customInput.removeAttribute('required');
                selectEl.setAttribute('name', 'packagingName');
            }
            
            // Sync active visual state for packaging suggestion chips
            document.querySelectorAll('.packaging-chip').forEach(chip => {
                if (chip.textContent.trim() === selectEl.value) {
                    chip.classList.add('active-packaging');
                } else {
                    chip.classList.remove('active-packaging');
                }
            });
        }
    </script>
</body>

</html>


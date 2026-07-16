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
    <meta name="description" content="Nhập kho - GreenStock Shop Owner">
    <meta name="author" content="GreenStock">

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icons/icon-48x48.png" />

    <title>Nhập kho | Shop Owner</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&amp;display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/vendor/light.css" rel="stylesheet">
    
    <style>
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

        .alert-danger-custom {
            background: #FEF2F2;
            border: 1px solid #FCA5A5;
            color: #991B1B;
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
            from { opacity: 0; transform: translateY(-8px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .product-row {
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1rem;
            position: relative;
        }

        .product-row:hover {
            background: #e9ecef;
        }

        .remove-btn {
            position: absolute;
            top: 0.5rem;
            right: 0.5rem;
            background: #dc3545;
            color: white;
            border: none;
            border-radius: 50%;
            width: 28px;
            height: 28px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 1.2rem;
            line-height: 1;
            transition: all 0.2s;
        }

        .remove-btn:hover {
            background: #c82333;
            transform: scale(1.1);
        }

        .add-product-btn {
            border: 2px dashed #3b7ddd;
            background: #f0f4ff;
            color: #3b7ddd;
            padding: 0.75rem;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.2s;
            font-weight: 600;
        }

        .add-product-btn:hover {
            background: #3b7ddd;
            color: white;
        }

        .receipt-history-table {
            font-size: 0.9rem;
        }

        .receipt-badge {
            padding: 0.35rem 0.75rem;
            border-radius: 6px;
            font-weight: 600;
            font-size: 0.8rem;
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
                                <a class="dropdown-item" href="shop-owner-profile"><i class="align-middle me-1" data-feather="user"></i> Hồ sơ</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="logout"><i class="align-middle me-1" data-feather="log-out"></i> Đăng xuất</a>
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
                        <a class="sidebar-link" href="import-receipt">
                            <i class="align-middle" data-feather="clipboard"></i>
                            <span class="align-middle">Nhập kho</span>
                        </a>
                    </li>

                    <li class="sidebar-item">
                        <a class="sidebar-link" href="shop-owner-orders">
                            <i class="align-middle" data-feather="shopping-bag"></i>
                            <span class="align-middle">Đơn hàng</span>
                        </a>
                    </li>

                    <li class="sidebar-item">
                        <a class="sidebar-link" href="shop-owner-revenue">
                            <i class="align-middle" data-feather="trending-up"></i>
                            <span class="align-middle">Báo cáo doanh thu</span>
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
                                                                <c:when test="${fn:contains(n.title, 'duyệt')}"><i class="text-success align-middle me-1" data-feather="check-circle"></i></c:when>
                                                                <c:otherwise><i class="text-danger align-middle me-1" data-feather="x-circle"></i></c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <div class="col-10 ps-2">
                                                            <div class="text-dark" style="font-size:0.82rem;font-weight:${n.read ? '400' : '700'}">${n.title}</div>
                                                            <div class="text-muted" style="font-size:0.75rem;">${fn:substring(n.content, 0, 70)}...</div>
                                                        </div>
                                                    </div>
                                                </a>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="text-center text-muted py-3" style="font-size:0.85rem;">Không có thông báo mới</div>
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

                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <h1 class="h3 mb-0">Phiếu nhập kho</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item"><a href="products-shop-owner">Dashboard</a></li>
                                <li class="breadcrumb-item active">Nhập kho</li>
                            </ol>
                        </nav>
                    </div>

                    <!-- Success/Error Alert -->
                    <c:if test="${not empty successMsg}">
                        <div class="alert-success-custom">
                            <i data-feather="check-circle" style="width:18px;height:18px;"></i>
                            <span>${successMsg}</span>
                        </div>
                    </c:if>
                    <c:if test="${not empty errorMsg}">
                        <div class="alert-danger-custom">
                            <i data-feather="alert-circle" style="width:18px;height:18px;"></i>
                            <span>${errorMsg}</span>
                        </div>
                    </c:if>

                    <div class="row">
                        <!-- Form tạo phiếu nhập -->
                        <div class="col-12 col-lg-7 col-xl-8">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">
                                        <i data-feather="file-plus" style="width:20px;height:20px;"></i>
                                        Tạo phiếu nhập kho mới
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <form action="import-receipt" method="POST" id="importForm">
                                        
                                        <!-- Ghi chú phiếu -->
                                        <div class="mb-3">
                                            <label class="form-label fw-bold">Ghi chú phiếu</label>
                                            <textarea name="note" class="form-control" rows="2" 
                                                placeholder="Ví dụ: Nhập hàng từ nhà cung cấp ABC..."></textarea>
                                        </div>

                                        <!-- Danh sách sản phẩm nhập -->
                                        <div class="mb-3">
                                            <label class="form-label fw-bold">Danh sách sản phẩm nhập kho</label>
                                            <div id="productList">
                                                <!-- Sản phẩm sẽ được thêm vào đây bằng JS -->
                                            </div>
                                            <button type="button" class="btn w-100 add-product-btn" onclick="addProductRow()">
                                                <i data-feather="plus-circle" style="width:18px;height:18px;"></i>
                                                Thêm sản phẩm
                                            </button>
                                        </div>

                                        <div class="d-flex gap-2">
                                            <button type="submit" class="btn btn-success flex-fill">
                                                <i data-feather="save" style="width:18px;height:18px;"></i>
                                                Tạo phiếu nhập kho
                                            </button>
                                            <button type="reset" class="btn btn-secondary" onclick="clearForm()">
                                                <i data-feather="x" style="width:18px;height:18px;"></i>
                                                Hủy
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Lịch sử phiếu nhập -->
                        <div class="col-12 col-lg-5 col-xl-4">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">
                                        <i data-feather="clock" style="width:20px;height:20px;"></i>
                                        Lịch sử nhập kho
                                    </h5>
                                </div>
                                <div class="card-body" style="max-height: 600px; overflow-y: auto;">
                                    <c:choose>
                                        <c:when test="${not empty receipts}">
                                            <c:forEach var="r" items="${receipts}" begin="0" end="9">
                                                <div class="card mb-3 border">
                                                    <div class="card-body p-3">
                                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                                            <div>
                                                                <div class="fw-bold text-primary" style="font-size: 1.1rem;">#${r.receiptId}</div>
                                                                <div class="text-muted" style="font-size: 0.8rem;">
                                                                    <i data-feather="calendar" style="width:12px;height:12px;"></i>
                                                                    <fmt:formatDate value="${r.importDate}" pattern="dd/MM/yyyy HH:mm" />
                                                                </div>
                                                            </div>
                                                            <div class="text-end">
                                                                <c:set var="totalQty" value="0" />
                                                                <c:forEach var="item" items="${r.items}">
                                                                    <c:set var="totalQty" value="${totalQty + item.quantity}" />
                                                                </c:forEach>
                                                                <span class="badge bg-success" style="font-size: 0.9rem;">
                                                                    ${totalQty} đơn vị
                                                                </span>
                                                            </div>
                                                        </div>
                                                        
                                                        <c:if test="${not empty r.note}">
                                                            <div class="text-muted mb-2" style="font-size: 0.8rem; border-left: 3px solid #dee2e6; padding-left: 8px;">
                                                                <i data-feather="file-text" style="width:12px;height:12px;"></i>
                                                                ${fn:substring(r.note, 0, 50)}${fn:length(r.note) > 50 ? '...' : ''}
                                                            </div>
                                                        </c:if>
                                                        
                                                        <button type="button" class="btn btn-sm btn-outline-primary w-100" 
                                                                onclick="viewReceiptDetail(${r.receiptId})">
                                                            <i data-feather="eye" style="width:14px;height:14px;"></i>
                                                            Xem chi tiết
                                                        </button>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="text-center text-muted py-4">
                                                <i data-feather="inbox" style="width:48px;height:48px;opacity:0.3;"></i>
                                                <p class="mt-2 mb-0">Chưa có phiếu nhập kho nào</p>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </main>

            <!-- Modal xem chi tiết phiếu nhập -->
            <div class="modal fade" id="receiptDetailModal" tabindex="-1" aria-labelledby="receiptDetailModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="receiptDetailModalLabel">
                                <i data-feather="file-text" style="width:20px;height:20px;"></i>
                                Chi tiết phiếu nhập #<span id="receiptIdDisplay"></span>
                            </h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div id="receiptDetailContainer">
                                <div class="text-center py-4">
                                    <div class="spinner-border text-primary" role="status">
                                        <span class="visually-hidden">Đang tải...</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        </div>
                    </div>
                </div>
            </div>

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
        // Danh sách sản phẩm từ server
        const products = [
            <c:forEach var="p" items="${products}" varStatus="status">
                {
                    id: ${p.id},
                    name: "${fn:escapeXml(p.name)}",
                    unit: "${p.unit}"
                }${status.last ? '' : ','}
            </c:forEach>
        ];

        let productRowCounter = 0;

        // Thêm một dòng sản phẩm mới
        function addProductRow() {
            productRowCounter++;
            const rowId = 'product-row-' + productRowCounter;
            
            const productOptions = products.map(p => 
                `<option value="\${p.id}">\${p.name} (\${p.unit})</option>`
            ).join('');

            const html = `
                <div class="product-row" id="\${rowId}">
                    <button type="button" class="remove-btn" onclick="removeProductRow('\${rowId}')" title="Xóa">×</button>
                    
                    <div class="row g-2">
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-bold" style="font-size: 0.85rem;">Sản phẩm</label>
                            <select name="productId[]" class="form-select form-select-sm" required>
                                <option value="">-- Chọn sản phẩm --</option>
                                \${productOptions}
                            </select>
                        </div>
                        <div class="col-6 col-md-3">
                            <label class="form-label fw-bold" style="font-size: 0.85rem;">Số lượng</label>
                            <input type="number" name="quantity[]" class="form-control form-control-sm" 
                                   placeholder="Số lượng" min="1" required>
                        </div>
                        <div class="col-6 col-md-3">
                            <label class="form-label fw-bold text-danger" style="font-size: 0.85rem;">
                                Ngày hết hạn <span class="text-danger">*</span>
                            </label>
                            <input type="date" name="expiryDate[]" class="form-control form-control-sm" required>
                        </div>
                    </div>
                </div>
            `;

            document.getElementById('productList').insertAdjacentHTML('beforeend', html);
            feather.replace();
        }

        // Xóa một dòng sản phẩm
        function removeProductRow(rowId) {
            const row = document.getElementById(rowId);
            if (row) {
                row.remove();
            }
        }

        // Reset form
        function clearForm() {
            document.getElementById('productList').innerHTML = '';
            productRowCounter = 0;
        }

        // Xem chi tiết phiếu nhập
        function viewReceiptDetail(receiptId) {
            document.getElementById('receiptIdDisplay').textContent = receiptId;
            
            const modal = new bootstrap.Modal(document.getElementById('receiptDetailModal'));
            modal.show();
            
            fetch('${pageContext.request.contextPath}/api/receipt-detail?receiptId=' + receiptId)
                .then(response => response.json())
                .then(data => {
                    displayReceiptDetail(data);
                })
                .catch(error => {
                    document.getElementById('receiptDetailContainer').innerHTML = 
                        '<div class="alert alert-danger">Không thể tải chi tiết phiếu nhập. Vui lòng thử lại!</div>';
                });
        }

        function displayReceiptDetail(receipt) {
            const container = document.getElementById('receiptDetailContainer');
            
            if (!receipt || !receipt.items) {
                container.innerHTML = '<div class="alert alert-warning">Không tìm thấy thông tin phiếu nhập.</div>';
                return;
            }

            let html = '<div class="mb-3">';
            html += '<p class="mb-1"><strong>Ngày nhập:</strong> ' + formatDateTime(receipt.importDate) + '</p>';
            if (receipt.note) {
                html += '<p class="mb-1"><strong>Ghi chú:</strong> ' + receipt.note + '</p>';
            }
            html += '</div>';

            html += '<table class="table table-hover table-sm">';
            html += '<thead><tr>';
            html += '<th>Sản phẩm</th>';
            html += '<th class="text-center">Số lượng</th>';
            html += '<th class="text-center">Mã lô</th>';
            html += '<th class="text-center">HSD</th>';
            html += '</tr></thead><tbody>';

            receipt.items.forEach(item => {
                html += '<tr>';
                html += '<td>' + item.productName + '</td>';
                html += '<td class="text-center"><strong>' + item.quantity + '</strong></td>';
                html += '<td class="text-center"><code>' + item.batchNumber + '</code></td>';
                html += '<td class="text-center">' + formatDate(item.expiryDate) + '</td>';
                html += '</tr>';
            });

            html += '</tbody></table>';
            container.innerHTML = html;
            
            if (typeof feather !== 'undefined') {
                feather.replace();
            }
        }

        function formatDateTime(dateStr) {
            if (!dateStr) return '-';
            const date = new Date(dateStr);
            const day = String(date.getDate()).padStart(2, '0');
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const year = date.getFullYear();
            const hours = String(date.getHours()).padStart(2, '0');
            const minutes = String(date.getMinutes()).padStart(2, '0');
            return day + '/' + month + '/' + year + ' ' + hours + ':' + minutes;
        }

        function formatDate(dateStr) {
            if (!dateStr) return '-';
            const date = new Date(dateStr);
            const day = String(date.getDate()).padStart(2, '0');
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const year = date.getFullYear();
            return day + '/' + month + '/' + year;
        }

        // Khởi tạo: thêm 1 dòng sản phẩm mặc định
        document.addEventListener('DOMContentLoaded', function() {
            if (typeof feather !== 'undefined') {
                feather.replace();
            }
            addProductRow();
        });

        // Validate trước khi submit
        document.getElementById('importForm').addEventListener('submit', function(e) {
            const productList = document.getElementById('productList');
            if (productList.children.length === 0) {
                e.preventDefault();
                alert('Vui lòng thêm ít nhất một sản phẩm vào phiếu nhập kho!');
            }
        });
    </script>
</body>

</html>

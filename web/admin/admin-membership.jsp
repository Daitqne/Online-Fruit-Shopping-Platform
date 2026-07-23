<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Quản lý Membership</title>
    
    <!-- Google Fonts (Inter) & Bootstrap 5 & FontAwesome 6 & Feather Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <!-- CSS Giao diện chuẩn AdminKit -->
    <style>
        body { font-family: 'Inter', sans-serif; background: #f7f9fa; margin: 0; }
        .wrapper { align-items: stretch; display: flex; width: 100%; min-height: 100vh; }
        
        /* Sidebar AdminKit Style */
        #sidebar { min-width: 260px; max-width: 260px; background: #222e3c; display: flex; flex-direction: column; transition: all .35s ease-in-out; }
        .sidebar-brand { color: #f8f9fa; display: block; font-size: 1.15rem; font-weight: 600; padding: 1.15rem 1.5rem; text-decoration: none; border-bottom: 1px solid rgba(255,255,255,0.05); }
        .sidebar-brand span { font-size: 11px; font-weight: 400; display: block; opacity: 0.5; margin-top: 2px; }
        .sidebar-nav { padding-left: 0; list-style: none; margin-bottom: 0; flex-grow: 1; padding-top: 15px; }
        .sidebar-header { background: transparent; color: #ced4da; font-size: .75rem; padding: 1.5rem 1.5rem .25rem; font-weight: 600; text-transform: uppercase; opacity: 0.4; }
        .sidebar-item a { display: flex; align-items: center; gap: 10px; padding: .625rem 1.625rem; font-weight: 400; color: rgba(233, 236, 239, .5); text-decoration: none; transition: background .1s ease-in-out, color .1s ease-in-out; font-size: 14px; }
        .sidebar-item a:hover { color: #e9ecef; background: rgba(255,255,255,0.03); }
        .sidebar-item i { color: rgba(233, 236, 239, .5); font-size: 14px; width: 16px; }
        .sidebar-item.active a { color: #e9ecef; background: linear-gradient(90deg, rgba(59, 125, 221, .1), rgba(59, 125, 221, .0875) 50%, transparent); border-left: 3px solid #3b7ddd; }
        .sidebar-item.active i { color: #3b7ddd; }
        .sidebar-footer { padding: 1rem 1.5rem; border-top: 1px solid rgba(255,255,255,0.05); }
        .sidebar-footer a { color: rgba(233, 236, 239, .5); text-decoration: none; font-size: 14px; display: flex; align-items: center; gap: 10px; }
        .sidebar-footer a:hover { color: #e9ecef; }

        /* Main Content Style */
        .main { display: flex; flex-direction: column; min-width: 0; width: 100%; background: #f7f9fa; }
        .navbar { background: #fff; border-bottom: 0; box-shadow: 0 0 2rem 0 rgba(33, 37, 41, .03); padding: 0.875rem 1.25rem; }
        .content { padding: 2rem 2rem 1.5rem; flex: 1; }
        
        /* Component Cards & Tables */
        .card { margin-bottom: 24px; box-shadow: 0 0 .875rem 0 rgba(33, 37, 41, .05); border: 1px solid #e2e8f0; background: #fff; border-radius: 5px; }
        .card-header { background: #fff; border-bottom: 1px solid #f1f5f9; padding: 1rem 1.25rem; }
        .card-title { color: #495057; font-size: 0.875rem; font-weight: 600; margin-bottom: 0; }
        
        .table thead th { background-color: #f8fafc; color: #475569; font-size: 13px; font-weight: 600; padding: 12px 16px; border-bottom: 1px solid #e2e8f0; }
        .table tbody td { padding: 12px 16px; font-size: 13.5px; border-bottom: 1px solid #f1f5f9; vertical-align: middle; }
        
        /* Badge Hạng chuẩn tinh tế */
        .rank-badge { padding: 4px 10px; border-radius: 4px; font-size: 11px; font-weight: 600; display: inline-flex; align-items: center; gap: 5px; }
        .rank-badge.Normal { color: #64748b; background-color: #f1f5f9; border: 1px solid #e2e8f0; }
        .rank-badge.Silver { color: #475569; background-color: #e2e8f0; border: 1px solid #cbd5e1; }
        .rank-badge.Gold { color: #d97706; background-color: #fef3c7; border: 1px solid #fde68a; }
        .rank-badge.Diamond { color: #0284c7; background-color: #e0f2fe; border: 1px solid #bae6fd; }
        .rank-badge.None { color: #ef4444; background-color: #fee2e2; border: 1px solid #fecaca; }
        
        .points-col { font-weight: 600; color: #2563eb; }
    </style>
</head>
<body>

    <div class="wrapper">
        <!-- SIDEBAR BÊN TRÁI -->
        <nav id="sidebar">
            <a class="sidebar-brand" href="#">
                <i class="fa-solid fa-leaf text-success me-1"></i> GreenStock
                <span>Admin Dashboard</span>
            </a>
            <ul class="sidebar-nav">
                <li class="sidebar-header">Quản lý chức năng</li>
                <li class="sidebar-item">
                    <a href="admin-user?type=customer"><i class="fa-solid fa-users"></i> <span>Quản lý người dùng</span></a>
                </li>
                <li class="sidebar-item">
                    <a href="admin-productss"><i class="fa-solid fa-box"></i> <span>Quản lý sản phẩm</span></a>
                </li>
                <li class="sidebar-item">
                    <a href="admin-promotions"><i class="fa-solid fa-ticket"></i> <span>Quản lý Voucher</span></a>
                </li>
                <li class="sidebar-item">
                    <a href="admin-orders"><i class="fa-solid fa-clock-rotate-left"></i> <span>Theo dõi đơn hàng</span></a>
                </li>
                <li class="sidebar-item active">
                    <a href="admin-membership"><i class="fa-solid fa-star"></i> <span>Quản lý Membership</span></a>
                </li>
            </ul>
            <div class="sidebar-footer">
                <a href="logout"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
            </div>
        </nav>

        <!-- KHU VỰC HIỂN THỊ CHÍNH -->
        <div class="main">
            <!-- Top Navbar -->
            <nav class="navbar navbar-expand navbar-light navbar-bg justify-content-between">
                <button class="btn btn-sm p-0 border-0" id="sidebar-toggle">
                    <i class="fa-solid fa-bars fs-4 text-secondary"></i>
                </button>
                <div class="navbar-collapse collapse">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle d-none d-sm-inline-block text-dark fw-medium" href="#" data-bs-toggle="dropdown">
                                <i class="fa-solid fa-circle-user text-secondary fs-5 me-1 align-middle"></i> Admin
                            </a>
                            <div class="dropdown-menu dropdown-menu-end">
                                <a class="dropdown-item" href="#"><i class="fa-solid fa-user me-2"></i> Hồ sơ</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item text-danger" href="logout"><i class="fa-solid fa-power-off me-2"></i> Đăng xuất</a>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- NỘI DUNG CHÍNH -->
            <main class="content">
                <div class="container-fluid p-0">
                    <h1 class="h3 mb-1 text-dark fw-bold">Quản lý Membership</h1>
                    <p class="text-muted small mb-4">Quản lý hạng thành viên và điểm tích lũy của khách hàng hệ thống.</p>

                    <!-- Alert thông báo kết quả hành động -->
                    <c:if test="${not empty param.success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-circle-check me-2"></i>
                            <c:if test="${param.success == '1'}">Cập nhật Membership thành công!</c:if>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty param.error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-circle-exclamation me-2"></i>
                            <c:if test="${param.error == '1'}">Cập nhật Membership thất bại!</c:if>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty param.ruleSuccess}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-circle-check me-2"></i> Cập nhật quy định Membership thành công!
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty param.ruleError}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-circle-exclamation me-2"></i> Cập nhật quy định Membership thất bại!
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <!-- Khung lọc & Tìm kiếm -->
                    <div class="card mb-4">
                        <div class="card-body py-3">
                            <form method="GET" action="admin-membership" class="row g-3 align-items-center justify-content-between">
                                <div class="col-12 col-md-6 d-flex gap-2">
                                    <div class="input-group input-group-sm" style="max-width: 280px;">
                                        <span class="input-group-text bg-white border-end-0"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                                        <input type="text" name="searchName" class="form-control border-start-0" value="${searchName}" placeholder="Tìm kiếm theo tên...">
                                    </div>
                                    <select name="tierFilter" class="form-select form-select-sm" style="max-width: 160px;" onchange="this.form.submit()">
                                        <option value="all" ${tierFilter eq 'all' || empty tierFilter ? 'selected' : ''}>Tất cả hạng</option>
                                        <option value="Normal" ${tierFilter eq 'Normal' ? 'selected' : ''}>Normal</option>
                                        <option value="Silver" ${tierFilter eq 'Silver' ? 'selected' : ''}>Silver</option>
                                        <option value="Gold" ${tierFilter eq 'Gold' ? 'selected' : ''}>Gold</option>
                                        <option value="Diamond" ${tierFilter eq 'Diamond' ? 'selected' : ''}>Diamond</option>
                                    </select>
                                </div>
                                
                            </form>
                        </div>
                    </div>

                    <!-- Khung Quy định hạng thành viên -->
                    <div class="card mb-4" style="background-color: #f0fdf4; border: 1px dashed #bbf7d0;">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h6 class="text-success fw-bold m-0" style="font-size: 14px;"><i class="fa-solid fa-sliders me-1"></i> Quy định hạng thành viên</h6>
                                <button type="button" class="btn btn-warning btn-sm fw-medium py-1 px-3" data-bs-toggle="modal" data-bs-target="#editRuleModal">
                                    <i class="fa-solid fa-pen me-1"></i> Sửa cấu hình chung
                                </button>
                            </div>
                            <div class="row g-3 text-start">
                                <div class="col-md-3 border-md-end">
                                    <div class="d-flex align-items-center gap-2">
                                        <i class="fa-solid fa-circle-user text-secondary fs-4"></i>
                                        <div>
                                            <div class="fw-bold text-dark small">Normal</div>
                                            <div class="text-muted" style="font-size: 12px;">0 - ${not empty currentRule ? (currentRule.silverMinPoint - 1) : 99} điểm | Giảm 0%</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 border-md-end">
                                    <div class="d-flex align-items-center gap-2">
                                        <i class="fa-solid fa-award text-muted fs-4"></i>
                                        <div>
                                            <div class="fw-bold text-dark small">Silver</div>
                                            <div class="text-muted" style="font-size: 12px;">${not empty currentRule ? currentRule.silverMinPoint : 100} - ${not empty currentRule ? (currentRule.goldMinPoint - 1) : 499} điểm | Giảm ${not empty currentRule ? currentRule.silverDiscountPercent : 5}%</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 border-md-end">
                                    <div class="d-flex align-items-center gap-2">
                                        <i class="fa-solid fa-crown text-warning fs-4"></i>
                                        <div>
                                            <div class="fw-bold small" style="color: #d97706;">Gold</div>
                                            <div class="text-muted" style="font-size: 12px;">${not empty currentRule ? currentRule.goldMinPoint : 500} - ${not empty currentRule ? (currentRule.diamondMinPoint - 1) : 999} điểm | Giảm ${not empty currentRule ? currentRule.goldDiscountPercent : 10}%</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="d-flex align-items-center gap-2">
                                        <i class="fa-solid fa-gem text-info fs-4"></i>
                                        <div>
                                            <div class="fw-bold small" style="color: #0284c7;">Diamond</div>
                                            <div class="text-muted" style="font-size: 12px;">${not empty currentRule ? currentRule.diamondMinPoint : 1000}+ điểm | Giảm ${not empty currentRule ? currentRule.diamondDiscountPercent : 15}%</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- BẢNG DỮ LIỆU CHÍNH -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-title">Danh sách tài khoản & Điểm tích lũy</h5>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-hover my-0">
                                <thead>
                                    <tr>
                                        <th class="text-center" style="width: 70px;">STT</th>
                                        <th style="width: 110px;">User ID</th>
                                        <th>Họ và tên</th>
                                        <th class="text-center" style="width: 140px;">Điểm hiện tại</th>
                                        <th class="text-center" style="width: 160px;">Hạng hiện tại</th>
                                        <th>Ngày cập nhật</th>
                                        <th class="text-center" style="width: 200px;">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty membershipList}">
                                            <c:forEach items="${membershipList}" var="m" varStatus="status">
                                                <tr>
                                                    <td class="text-center fw-bold text-muted">${status.index + 1}</td>
                                                    <td><span class="text-muted fw-semibold">#${m.userId}</span></td>
                                                    <td class="fw-semibold text-dark">
                                                        <c:choose>
                                                            <c:when test="${not empty m.fullName}">${m.fullName}</c:when>
                                                            <c:otherwise>Khách chưa có tài khoản</c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="text-center points-col">${m.currentPoints}</td>
                                                    <td class="text-center">
                                                        <c:choose>
                                                            <c:when test="${m.currentTier eq 'Normal'}">
                                                                <span class="rank-badge Normal"><i class="fa-solid fa-circle-user"></i> Normal</span>
                                                            </c:when>
                                                            <c:when test="${m.currentTier eq 'Silver'}">
                                                                <span class="rank-badge Silver"><i class="fa-solid fa-award"></i> Silver</span>
                                                            </c:when>
                                                            <c:when test="${m.currentTier eq 'Gold'}">
                                                                <span class="rank-badge Gold"><i class="fa-solid fa-crown"></i> Gold</span>
                                                            </c:when>
                                                            <c:when test="${m.currentTier eq 'Diamond'}">
                                                                <span class="rank-badge Diamond"><i class="fa-solid fa-gem"></i> Diamond</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="rank-badge None">Chưa có</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="text-muted">
                                                        <fmt:formatDate value="${m.tierUpdatedAt}" pattern="dd/MM/yyyy HH:mm"/>
                                                    </td>
                                                    <td class="text-center">
                                                        <c:choose>
                                                            <c:when test="${m.currentPoints > 0 || not empty m.currentTier}">
                                                                <div class="d-flex gap-2 justify-content-center">
                                                                    <button type="button" 
                                                                            class="btn btn-primary btn-sm edit-membership-btn py-1 px-3"
                                                                            data-userid="${m.userId}"
                                                                            data-fullname="${m.fullName != null ? m.fullName : 'Khách chưa có tài khoản'}"
                                                                            data-points="${m.currentPoints}"
                                                                            data-tier="${m.currentTier != null ? m.currentTier : 'Normal'}"
                                                                            data-override="${m.manualOverride}">
                                                                        Sửa
                                                                    </button>
                                                                    <!--<a href="#" class="btn btn-outline-secondary btn-sm py-1 px-2" onclick="alert('Chức năng lịch sử điểm đang được phát triển!')">Lịch sử</a>-->
                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button type="button" 
                                                                        class="btn btn-success btn-sm w-100 edit-membership-btn py-1" 
                                                                        style="font-size: 12px;"
                                                                        data-userid="${m.userId}"
                                                                        data-fullname="${m.fullName != null ? m.fullName : 'Khách chưa có tài khoản'}"
                                                                        data-points="${m.currentPoints}"
                                                                        data-tier="Normal"
                                                                        data-override="${m.manualOverride}">
                                                                    + Cấp Membership
                                                                </button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="7" class="text-center text-muted py-4">
                                                    Không thể tải dữ liệu từ database. Vui lòng kiểm tra lại kết nối hệ thống.
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>

                        <!-- Phân trang chuẩn AdminKit -->
                        <div class="card-footer d-flex justify-content-between align-items-center bg-white border-top-0 py-3">
                            <div class="text-muted small">Hiển thị 1 đến ${membershipList.size()} của ${membershipList.size()} thành viên</div>
                            <nav>
                                <ul class="pagination pagination-sm m-0">
                                    <li class="page-item disabled"><span class="page-link">&laquo;</span></li>
                                    <li class="page-item active"><span class="page-link" style="background-color: #3b7ddd; border-color: #3b7ddd;">1</span></li>
                                    <li class="page-item disabled"><span class="page-link">&raquo;</span></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- MODAL 1: CẬP NHẬT QUY ĐỊNH CHUNG -->
    <div class="modal fade" id="editRuleModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <form action="admin-membership" method="POST" class="modal-content">
                <input type="hidden" name="action" value="updateRule">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold">Cập nhật cấu hình quy định Membership</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                     <div class="mb-3">
                         <label class="form-label fw-semibold">Tỷ lệ quy đổi điểm (Bao nhiêu VNĐ = 1 điểm)</label>
                         <input type="number" class="form-control" name="pointConversionRate" value="${not empty currentRule ? currentRule.pointConversionRate : 10000}">
                     </div>
                     <div class="row g-3 mb-3">
                         <div class="col-md-4">
                             <label class="form-label small fw-semibold">Silver từ (Điểm)</label>
                             <input type="number" class="form-control" name="silverMinPoint" value="${not empty currentRule ? currentRule.silverMinPoint : 100}">
                         </div>
                         <div class="col-md-4">
                             <label class="form-label small fw-semibold">Gold từ (Điểm)</label>
                             <input type="number" class="form-control" name="goldMinPoint" value="${not empty currentRule ? currentRule.goldMinPoint : 500}">
                         </div>
                         <div class="col-md-4">
                             <label class="form-label small fw-semibold">Diamond từ (Điểm)</label>
                             <input type="number" class="form-control" name="diamondMinPoint" value="${not empty currentRule ? currentRule.diamondMinPoint : 1000}">
                         </div>
                     </div>
                     <div class="row g-3">
                         <div class="col-md-4">
                             <label class="form-label small fw-semibold">Giảm giá Silver (%)</label>
                             <input type="number" class="form-control" name="silverDiscountPercent" value="${not empty currentRule ? currentRule.silverDiscountPercent : 5}">
                         </div>
                         <div class="col-md-4">
                             <label class="form-label small fw-semibold">Giảm giá Gold (%)</label>
                             <input type="number" class="form-control" name="goldDiscountPercent" value="${not empty currentRule ? currentRule.goldDiscountPercent : 10}">
                         </div>
                         <div class="col-md-4">
                             <label class="form-label small fw-semibold">Giảm giá Diamond (%)</label>
                             <input type="number" class="form-control" name="diamondDiscountPercent" value="${not empty currentRule ? currentRule.diamondDiscountPercent : 15}">
                         </div>
                     </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary btn-sm px-3" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-success btn-sm px-3">Lưu quy định</button>
                </div>
            </form>
        </div>
    </div>

    <!-- MODAL 2: SỬA MEMBERSHIP CÁ NHÂN -->
    <div class="modal fade" id="editMembershipModal" tabindex="-1" aria-labelledby="editMembershipModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <form action="admin-membership" method="POST" class="modal-content">
                <input type="hidden" name="action" value="updateMembership">
                <input type="hidden" name="editUserId" id="editUserId">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="editMembershipModalLabel">Cập nhật thông tin Membership</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tên khách hàng</label>
                        <input type="text" class="form-control bg-light" id="editFullName" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="editPoints" class="form-label fw-semibold">Điểm tích lũy hiện tại</label>
                        <input type="number" class="form-control" name="editPoints" id="editPoints" min="0" required>
                    </div>
                    <div class="mb-3">
                        <label for="editTier" class="form-label fw-semibold">Hạng thành viên</label>
                        <select class="form-select" name="editTier" id="editTier">
                            <option value="Normal">Normal</option>
                            <option value="Silver">Silver</option>
                            <option value="Gold">Gold</option>
                            <option value="Diamond">Diamond</option>
                        </select>
                    </div>
                    <div class="mb-2 form-check">
                        <input type="checkbox" class="form-check-input" name="editManualOverride" id="editManualOverride">
                        <label class="form-check-label fw-semibold text-danger" for="editManualOverride">Chỉnh sửa thủ công (Không tự động cập nhật hạng theo điểm)</label>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary btn-sm px-3" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary btn-sm px-3">Lưu thay đổi</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Script đồng bộ Modal và Dữ liệu nút bấm -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const editButtons = document.querySelectorAll('.edit-membership-btn');
            const editModal = new bootstrap.Modal(document.getElementById('editMembershipModal'));

            editButtons.forEach(button => {
                button.addEventListener('click', function () {
                    const userId = this.getAttribute('data-userid');
                    const fullName = this.getAttribute('data-fullname');
                    const points = this.getAttribute('data-points');
                    const tier = this.getAttribute('data-tier');
                    const override = this.getAttribute('data-override') === 'true';

                    document.getElementById('editUserId').value = userId;
                    document.getElementById('editFullName').value = fullName;
                    document.getElementById('editPoints').value = points;
                    document.getElementById('editTier').value = tier || 'Normal';
                    document.getElementById('editManualOverride').checked = override;

                    editModal.show();
                });
            });

            // Tự động cập nhật điểm khi đổi Hạng thành viên trong Modal
            const tierMinPoints = {
                'Normal': 0,
                'Silver': ${not empty currentRule ? currentRule.silverMinPoint : 100},
                'Gold': ${not empty currentRule ? currentRule.goldMinPoint : 500},
                'Diamond': ${not empty currentRule ? currentRule.diamondMinPoint : 1000}
            };

            const editTierSelect = document.getElementById('editTier');
            const editPointsInput = document.getElementById('editPoints');
            const editOverrideCheckbox = document.getElementById('editManualOverride');

            if (editTierSelect && editPointsInput) {
                // Khi thay đổi Hạng -> Tự động điền điểm tối thiểu của Hạng đó
                editTierSelect.addEventListener('change', function () {
                    const selectedTier = this.value;
                    if (tierMinPoints.hasOwnProperty(selectedTier)) {
                        editPointsInput.value = tierMinPoints[selectedTier];
                    }
                });

                // Khi thay đổi Điểm -> Tự động cập nhật Hạng tương ứng (nếu không chọn Chỉnh sửa thủ công)
                editPointsInput.addEventListener('input', function () {
                    const pts = parseInt(this.value) || 0;
                    if (editOverrideCheckbox && !editOverrideCheckbox.checked) {
                        if (pts >= tierMinPoints['Diamond']) {
                            editTierSelect.value = 'Diamond';
                        } else if (pts >= tierMinPoints['Gold']) {
                            editTierSelect.value = 'Gold';
                        } else if (pts >= tierMinPoints['Silver']) {
                            editTierSelect.value = 'Silver';
                        } else {
                            editTierSelect.value = 'Normal';
                        }
                    }
                });
            }
            
            // Toggle sidebar (nếu cần xử lý responsive ẩn/hiện menu)
            const toggleBtn = document.getElementById('sidebar-toggle');
            if(toggleBtn) {
                toggleBtn.addEventListener('click', function(){
                    const sidebar = document.getElementById('sidebar');
                    if(sidebar.style.display === 'none') {
                        sidebar.style.display = 'flex';
                    } else {
                        sidebar.style.display = 'none';
                    }
                });
            }
        });
    </script>
</body>
</html>
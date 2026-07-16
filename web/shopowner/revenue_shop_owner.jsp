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
    <meta name="description" content="Báo cáo doanh thu - GreenStock Shop Owner">
    <meta name="author" content="GreenStock">

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icons/icon-48x48.png" />

    <title>Báo cáo doanh thu | Shop Owner</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/vendor/light.css" rel="stylesheet">
    
    <style>
        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 15px;
            padding: 1.5rem;
            color: white;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .stat-card.green { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); }
        .stat-card.orange { background: linear-gradient(135deg, #ee0979 0%, #ff6a00 100%); }
        .stat-card.blue { background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); }
        
        .stat-card h3 { font-size: 0.85rem; font-weight: 600; opacity: 0.9; margin-bottom: 0.5rem; }
        .stat-card .value { font-size: 2rem; font-weight: 800; }
        .stat-card .icon { font-size: 2.5rem; opacity: 0.3; position: absolute; right: 1rem; top: 1rem; }
        
        .filter-panel {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }
        
        .filter-panel label { font-weight: 600; font-size: 0.9rem; color: #64748b; margin-bottom: 0.5rem; }
        .filter-panel .form-control { border-radius: 8px; }
        
        .report-type-tabs {
            display: flex;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }
        
        .report-type-tabs .tab-btn {
            flex: 1;
            padding: 0.6rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            background: white;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.2s;
        }
        
        .report-type-tabs .tab-btn:hover { background: #f8fafc; }
        .report-type-tabs .tab-btn.active { background: #3b7ddd; color: white; border-color: #3b7ddd; }
        
        .chart-container {
            position: relative;
            height: 400px;
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }
        
        .revenue-table {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }
        
        .table thead th {
            background: #f8fafc;
            border-bottom: 2px solid #e2e8f0;
            font-weight: 700;
            color: #475569;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.05em;
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
                    <a class="sidebar-link" href="shop-owner-orders">
                        <i class="align-middle" data-feather="shopping-bag"></i>
                        <span class="align-middle">Đơn hàng</span>
                    </a>
                </li>

                <li class="sidebar-item active">
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
                                                        <i class="text-success align-middle" data-feather="check-circle"></i>
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

                <!-- Page Header -->
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <h1 class="h3 mb-0"><i data-feather="trending-up" class="align-middle me-2"></i>Báo cáo doanh thu</h1>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mb-0">
                            <li class="breadcrumb-item"><a href="products-shop-owner">Dashboard</a></li>
                            <li class="breadcrumb-item active">Báo cáo doanh thu</li>
                        </ol>
                    </nav>
                </div>

                <!-- Filter Panel -->
                <div class="filter-panel">
                    
                    <form method="GET" action="shop-owner-revenue" id="revenueForm" class="row g-3 align-items-end">
                        <input type="hidden" name="type" id="reportType" value="${reportType}">
                        
                        <div class="col-12">
                            <label>Loại báo cáo:</label>
                            <div class="report-type-tabs">
                                <button type="button" onclick="changeReportType('day')" class="tab-btn ${reportType eq 'day' ? 'active' : ''}">
                                    <i data-feather="calendar" style="width:16px;height:16px;"></i> Theo ngày
                                </button>
                                <button type="button" onclick="changeReportType('week')" class="tab-btn ${reportType eq 'week' ? 'active' : ''}">
                                    <i data-feather="calendar" style="width:16px;height:16px;"></i> Theo tuần
                                </button>
                                <button type="button" onclick="changeReportType('month')" class="tab-btn ${reportType eq 'month' ? 'active' : ''}">
                                    <i data-feather="calendar" style="width:16px;height:16px;"></i> Theo tháng
                                </button>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <label for="startDate">Từ ngày:</label>
                            <input type="date" class="form-control" id="startDate" name="startDate" value="${startDate}" required>
                        </div>
                        <div class="col-md-4">
                            <label for="endDate">Đến ngày:</label>
                            <input type="date" class="form-control" id="endDate" name="endDate" value="${endDate}" required>
                        </div>
                        <div class="col-md-4">
                            <button type="submit" class="btn btn-primary w-100">
                                <i data-feather="search" style="width:16px;height:16px;"></i> Xem báo cáo
                            </button>
                        </div>
                    </form>
                </div>

                <!-- Statistics Cards -->
                <div class="row">
                    <div class="col-md-3">
                        <div class="stat-card green position-relative">
                            <h3>TỔNG DOANH THU</h3>
                            <div class="value"><fmt:formatNumber value="${totalRevenue}" type="number" pattern="#,###"/>đ</div>
                            <i class="icon" data-feather="dollar-sign"></i>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-card blue position-relative">
                            <h3>TỔNG ĐƠN HÀNG</h3>
                            <div class="value">${totalOrders}</div>
                            <i class="icon" data-feather="shopping-cart"></i>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-card orange position-relative">
                            <h3>SẢN PHẨM ĐÃ BÁN</h3>
                            <div class="value">${totalProductsSold}</div>
                            <i class="icon" data-feather="package"></i>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-card position-relative">
                            <h3>GIÁ TRỊ ĐƠN TB</h3>
                            <div class="value"><fmt:formatNumber value="${avgOrderValue}" type="number" pattern="#,###"/>đ</div>
                            <i class="icon" data-feather="bar-chart-2"></i>
                        </div>
                    </div>
                </div>

                <!-- Chart -->
                <div class="chart-container">
                    <h5 class="mb-3">Biểu đồ doanh thu</h5>
                    <canvas id="revenueChart"></canvas>
                </div>

                <!-- Revenue Table -->
                <div class="revenue-table">
                    <h5 class="mb-3">Chi tiết doanh thu</h5>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>Thời gian</th>
                                    <th class="text-end">Số đơn hàng</th>
                                    <th class="text-end">Sản phẩm bán</th>
                                    <th class="text-end">Doanh thu</th>
                                    <th class="text-end">Doanh thu ròng</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty revenueData}">
                                        <c:forEach var="row" items="${revenueData}">
                                            <tr>
                                                <td><strong>${row.periodLabel}</strong></td>
                                                <td class="text-end">${row.totalOrders}</td>
                                                <td class="text-end">${row.totalProductsSold}</td>
                                                <td class="text-end"><fmt:formatNumber value="${row.subtotal}" type="number" pattern="#,###"/> đ</td>
                                                <td class="text-end"><strong><fmt:formatNumber value="${row.netRevenue}" type="number" pattern="#,###"/> đ</strong></td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="5" class="text-center text-muted py-4">
                                                <i data-feather="inbox" style="width:48px;height:48px;opacity:0.3;"></i>
                                                <p class="mb-0 mt-2">Không có dữ liệu trong khoảng thời gian này</p>
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </main>
    </div>
</div>

<!-- Scripts -->
<script src="${pageContext.request.contextPath}/js/app.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>

<script>
    // Change report type function with smart date range
    function changeReportType(type) {
        const today = new Date();
        const endDate = today.toISOString().split('T')[0];
        let startDate;
        
        if (type === 'day') {
            // Chỉ hôm nay
            startDate = endDate;
        } else if (type === 'week') {
            // Tuần này (từ thứ 2 đến hôm nay)
            const dayOfWeek = today.getDay(); // 0 = CN, 1 = T2, ..., 6 = T7
            const mondayOffset = dayOfWeek === 0 ? 6 : dayOfWeek - 1; // Nếu CN thì lùi 6 ngày, nếu không thì lùi (dayOfWeek - 1)
            const monday = new Date(today);
            monday.setDate(today.getDate() - mondayOffset);
            startDate = monday.toISOString().split('T')[0];
        } else if (type === 'month') {
            // Tháng này (từ ngày 1 đến hôm nay)
            const firstDayOfMonth = new Date(today.getFullYear(), today.getMonth(), 1);
            startDate = firstDayOfMonth.toISOString().split('T')[0];
        }
        
        // Update form values
        document.getElementById('reportType').value = type;
        document.getElementById('startDate').value = startDate;
        document.getElementById('endDate').value = endDate;
        
        // Submit form
        document.getElementById('revenueForm').submit();
    }
    
    // Revenue Chart
    const ctx = document.getElementById('revenueChart').getContext('2d');
    
    // Prepare data from JSP
    const labels = [];
    const revenueData = [];
    
    <c:forEach var="row" items="${revenueData}">
        labels.push('${row.periodLabel}');
        revenueData.push(${row.netRevenue});
    </c:forEach>
    
    const chart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels.reverse(),
            datasets: [{
                label: 'Doanh thu ròng (đ)',
                data: revenueData.reverse(),
                backgroundColor: 'rgba(59, 125, 221, 0.8)',
                borderColor: 'rgba(59, 125, 221, 1)',
                borderWidth: 2,
                borderRadius: 8
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: true,
                    position: 'top'
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            return 'Doanh thu: ' + context.parsed.y.toLocaleString('vi-VN') + ' đ';
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            return value.toLocaleString('vi-VN') + ' đ';
                        }
                    }
                }
            }
        }
    });
</script>

</body>
</html>

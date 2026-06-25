<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hóa đơn điện tử - GreenStock</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary: #10B981;
            --primary-hover: #059669;
            --dark: #0F172A;
            --light: #F8FAFC;
            --slate-100: #F1F5F9;
            --slate-200: #E2E8F0;
            --slate-300: #CBD5E1;
            --slate-600: #475569;
            --white: #FFFFFF;
            --font-display: 'Outfit', sans-serif;
            --font-body: 'Plus Jakarta Sans', sans-serif;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: var(--font-body);
            background-color: var(--slate-100);
            color: var(--dark);
            line-height: 1.5;
            padding: 2.5rem 1.5rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
        }

        /* --- ACTIONS BAR (NO PRINT) --- */
        .actions-bar {
            width: 100%;
            max-width: 800px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: var(--white);
            padding: 1rem 1.5rem;
            border-radius: 12px;
            box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.05);
            margin-bottom: 1.5rem;
            border: 1px solid var(--slate-200);
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.6rem 1.25rem;
            border-radius: 8px;
            font-family: var(--font-body);
            font-weight: 700;
            font-size: 0.9rem;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-back {
            background-color: transparent;
            color: var(--slate-600);
            border: 1.5px solid var(--slate-300);
        }

        .btn-back:hover {
            background-color: var(--slate-100);
            color: var(--dark);
        }

        .btn-print {
            background-color: var(--primary);
            color: var(--white);
            border: none;
            box-shadow: 0 4px 10px rgba(16, 185, 129, 0.2);
        }

        .btn-print:hover {
            background-color: var(--primary-hover);
        }

        /* --- INVOICE CONTAINER --- */
        .invoice-container {
            width: 100%;
            max-width: 800px;
            background-color: var(--white);
            padding: 3rem;
            border-radius: 16px;
            box-shadow: 0 10px 15px -3px rgb(0 0 0 / 0.05);
            border: 1px solid var(--slate-200);
            display: flex;
            flex-direction: column;
            gap: 2rem;
            position: relative;
        }

        /* --- HEADER SECTION --- */
        .invoice-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            border-bottom: 3px solid var(--primary);
            padding-bottom: 1.5rem;
        }

        .company-info {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .company-logo {
            font-family: var(--font-display);
            font-size: 1.75rem;
            font-weight: 800;
            color: var(--primary);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.25rem;
        }

        .company-logo i {
            color: var(--secondary);
        }

        .company-details {
            font-size: 0.8rem;
            color: var(--slate-600);
            line-height: 1.4;
        }

        .invoice-meta {
            text-align: right;
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .invoice-title {
            font-family: var(--font-display);
            font-size: 2rem;
            font-weight: 800;
            color: var(--dark);
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .invoice-no {
            font-weight: 700;
            color: var(--primary);
            font-size: 1rem;
        }

        .invoice-date {
            font-size: 0.85rem;
            color: var(--slate-600);
        }

        /* --- DETAILS GRID --- */
        .details-grid {
            display: grid;
            grid-template-columns: 1.2fr 1fr;
            gap: 2rem;
            background-color: var(--light);
            border-radius: 12px;
            padding: 1.5rem;
            border: 1px solid var(--slate-200);
        }

        .details-block h3 {
            font-family: var(--font-display);
            font-size: 0.95rem;
            font-weight: 700;
            text-transform: uppercase;
            color: var(--slate-600);
            margin-bottom: 0.75rem;
            border-bottom: 1px solid var(--slate-300);
            padding-bottom: 0.25rem;
            letter-spacing: 0.05em;
        }

        .details-block p {
            font-size: 0.875rem;
            color: var(--dark);
            line-height: 1.6;
        }

        .buyer-name {
            font-weight: 700;
            font-size: 0.95rem !important;
            margin-bottom: 0.2rem;
        }

        /* --- TABLE --- */
        .invoice-table-wrapper {
            margin-top: 0.5rem;
        }

        .invoice-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        .invoice-table th {
            padding: 0.75rem 1rem;
            font-weight: 700;
            color: var(--slate-600);
            border-bottom: 2px solid var(--slate-200);
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .invoice-table td {
            padding: 1rem;
            border-bottom: 1px solid var(--slate-100);
            font-size: 0.9rem;
        }

        .td-price {
            text-align: right;
        }

        .td-qty {
            text-align: center;
        }

        /* --- SUMMARY SECTION --- */
        .summary-section {
            display: flex;
            justify-content: flex-end;
            margin-top: 0.5rem;
        }

        .summary-box {
            width: 320px;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            font-size: 0.9rem;
            color: var(--slate-600);
        }

        .summary-row.total {
            border-top: 2px solid var(--primary);
            padding-top: 0.75rem;
            margin-top: 0.25rem;
            font-weight: 800;
            color: var(--dark);
            font-size: 1.15rem;
        }

        .summary-row.total .total-val {
            color: var(--primary);
            font-family: var(--font-display);
            font-size: 1.25rem;
        }

        /* --- SIGNATURE SECTION --- */
        .signature-section {
            display: flex;
            justify-content: space-between;
            margin-top: 3rem;
            padding: 0 1rem;
        }

        .sig-block {
            text-align: center;
            width: 200px;
        }

        .sig-title {
            font-size: 0.9rem;
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 4rem;
        }

        .sig-name {
            font-size: 0.85rem;
            color: var(--slate-600);
            font-style: italic;
        }

        /* --- FOOTER --- */
        .invoice-footer {
            text-align: center;
            border-top: 1px solid var(--slate-200);
            padding-top: 1.5rem;
            margin-top: 2rem;
            font-size: 0.8rem;
            color: var(--slate-600);
            line-height: 1.5;
        }

        /* --- PRINT MEDIA QUERIES --- */
        @media print {
            body {
                background-color: var(--white);
                padding: 0;
                margin: 0;
            }
            .no-print {
                display: none !important;
            }
            .invoice-container {
                border: none !important;
                box-shadow: none !important;
                padding: 0 !important;
                margin: 0 !important;
                max-width: 100% !important;
                width: 100% !important;
            }
        }
    </style>
</head>
<body>

    <!-- ACTIONS BAR (HIDDEN IN PRINT) -->
    <div class="actions-bar no-print">
        <a href="javascript:window.close();" class="btn btn-back">
            <i class="fa-solid fa-xmark"></i> Đóng cửa sổ
        </a>
        <button type="button" class="btn btn-print" onclick="window.print()">
            <i class="fa-solid fa-print"></i> In hóa đơn / Xuất PDF
        </button>
    </div>

    <!-- INVOICE CONTAINER -->
    <div class="invoice-container">
        
        <!-- HEADER -->
        <div class="invoice-header">
            <div class="company-info">
                <div class="company-logo">
                    <i class="fa-solid fa-leaf"></i> GreenStock
                </div>
                <div class="company-details">
                    <p><strong>CÔNG TY CỔ PHẦN GREENSTOCK VIỆT NAM</strong></p>
                    <p>Địa chỉ: Khu Công Nghệ Cao, Quận 9, TP. Hồ Chí Minh</p>
                    <p>Điện thoại: +84 999 999 999 | Email: contact@greenstock.vn</p>
                    <p>Mã số thuế: 0312345678 | Website: www.greenstock.vn</p>
                </div>
            </div>
            
            <div class="invoice-meta">
                <h1 class="invoice-title">Hóa đơn bán hàng</h1>
                <div class="invoice-no">Mã số ĐH: #GSM-${order.saleOrderId}</div>
                <div class="invoice-date">
                    Ngày lập: <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                </div>
            </div>
        </div>

        <!-- DETAILS GRID -->
        <div class="details-grid">
            <div class="details-block">
                <h3>Thông tin người nhận</h3>
                <!-- Parse full address string formatted in CheckoutController -->
                <!-- fullAddress format: "Label: Name (Phone) - Details" -->
                <c:set var="addrParts" value="${order.shippingAddress}" />
                <p class="buyer-name">Khách hàng: ${order.shippingPhone != null ? order.shippingAddress : 'Khách vãng lai'}</p>
                <c:if test="${not empty order.shipperNote}">
                    <p style="margin-top:0.4rem; font-style: italic; color:var(--slate-600);">
                        * Ghi chú: "${order.shipperNote}"
                    </p>
                </c:if>
            </div>
            <div class="details-block">
                <h3>Thông tin thanh toán</h3>
                <p><strong>Phương thức:</strong> ${order.paymentMethod == 'COD' ? 'Thanh toán COD' : 'Chuyển khoản ngân hàng'}</p>
                <p><strong>Trạng thái:</strong> ${order.paymentStatus == 'Paid' ? 'Đã thanh toán (Paid)' : 'Chờ thanh toán (Pending)'}</p>
                <p><strong>Tiền tệ:</strong> Việt Nam Đồng (VND)</p>
            </div>
        </div>

        <!-- PRODUCTS TABLE -->
        <div class="invoice-table-wrapper">
            <table class="invoice-table">
                <thead>
                    <tr>
                        <th>Sản phẩm</th>
                        <th class="td-price">Đơn giá</th>
                        <th class="td-qty">Số lượng</th>
                        <th class="td-price">Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="totalGoodsPrice" value="0" />
                    <c:forEach items="${order.items}" var="item">
                        <c:set var="itemTotal" value="${item.quantity * item.unitPrice}" />
                        <c:set var="totalGoodsPrice" value="${totalGoodsPrice + itemTotal}" />
                        <tr>
                            <td><strong>${item.product.name}</strong></td>
                            <td class="td-price"><fmt:formatNumber value="${item.unitPrice}" maxFractionDigits="0"/>đ</td>
                            <td class="td-qty">${item.quantity}</td>
                            <td class="td-price"><fmt:formatNumber value="${itemTotal}" maxFractionDigits="0"/>đ</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- BREAKDOWN SUMMARY -->
        <div class="summary-section">
            <div class="summary-box">
                <div class="summary-row">
                    <span>Cộng tiền hàng:</span>
                    <span><fmt:formatNumber value="${totalGoodsPrice}" maxFractionDigits="0"/>đ</span>
                </div>
                <div class="summary-row">
                    <span>Phí vận chuyển:</span>
                    <span>
                        <c:choose>
                            <c:when test="${order.shippingFee > 0}"><fmt:formatNumber value="${order.shippingFee}" maxFractionDigits="0"/>đ</c:when>
                            <c:otherwise>Miễn phí</c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <c:if test="${order.discountAmount > 0}">
                    <div class="summary-row" style="color:var(--primary); font-weight:600;">
                        <span>Khuyến mãi ${not empty order.promoCode ? '('.concat(order.promoCode).concat(')') : ''}:</span>
                        <span>-<fmt:formatNumber value="${order.discountAmount}" maxFractionDigits="0"/>đ</span>
                    </div>
                </c:if>
                <div class="summary-row total">
                    <span>Tổng cộng thanh toán:</span>
                    <span class="total-val"><fmt:formatNumber value="${order.totalPayment}" maxFractionDigits="0"/>đ</span>
                </div>
            </div>
        </div>

        <!-- SIGNATURE AREA -->
        <div class="signature-section">
            <div class="sig-block">
                <div class="sig-title">Người mua hàng</div>
                <div class="sig-name">(Ký, ghi rõ họ tên)</div>
            </div>
            <div class="sig-block">
                <div class="sig-title">Đại diện GreenStock</div>
                <div class="sig-name">(Ký, đóng dấu)</div>
            </div>
        </div>

        <!-- INVOICE FOOTER -->
        <div class="invoice-footer">
            <p>Cảm ơn quý khách đã tin tưởng và mua sắm tại GreenStock!</p>
            <p style="font-size: 0.75rem; color:var(--slate-400); margin-top:0.25rem;">
                Hóa đơn điện tử được khởi tạo tự động từ hệ thống GreenStock. 
                Vui lòng kiểm tra kỹ hàng hóa khi nhận hàng.
            </p>
        </div>
    </div>

    <!-- AUTO PRINT SCRIPT IF REQUESTED -->
    <c:if test="${download}">
        <script>
            window.onload = function() {
                // Wait slightly for layout rendering before popping printing dialog
                setTimeout(function() {
                    window.print();
                }, 300);
            }
        </script>
    </c:if>
</body>
</html>

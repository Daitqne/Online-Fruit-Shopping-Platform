<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử đơn hàng - GreenStock</title>
    
    <%@include file="../common/head.jsp" %>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/customer/orders.css">
</head>
<body>

    <!-- HEADER -->
    <%@include file="../common/header.jsp" %>

    <!-- MAIN LỊCH SỬ ĐƠN HÀNG -->
    <div class="orders-wrapper">
        <div class="orders-header">
            <h1 class="orders-title">
                <i class="fa-solid fa-box-open"></i> Lịch sử đơn hàng
            </h1>
            <p class="orders-subtitle">Quản lý và xem lại tất cả các đơn hàng bạn đã mua tại GreenStock.</p>
        </div>

        <div class="orders-card">
            <c:choose>
                <c:when test="${not empty orders}">
                    <table class="orders-table">
                        <thead>
                            <tr>
                                <th>Mã đơn hàng</th>
                                <th>Ngày đặt</th>
                                <th>Thanh toán</th>
                                <th>Trạng thái</th>
                                <th>Tổng tiền</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${orders}" var="ord">
                                <tr>
                                    <td>
                                        <a href="orders?action=detail&id=${ord.saleOrderId}" class="order-id">
                                            #${ord.saleOrderId}
                                        </a>
                                    </td>
                                    <td class="order-date">
                                        <fmt:formatDate value="${ord.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${ord.paymentStatus == 'Paid'}">
                                                <span class="status-badge pay-paid">
                                                    <i class="fa-solid fa-circle-check"></i> Đã thanh toán
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge pay-pending">
                                                    <i class="fa-solid fa-clock"></i> Chưa thanh toán
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${ord.orderStatus == 'Pending'}">
                                                <span class="status-badge status-pending">
                                                    <i class="fa-solid fa-circle-notch fa-spin"></i> Chờ xử lý
                                                </span>
                                            </c:when>
                                            <c:when test="${ord.orderStatus == 'Processing'}">
                                                <span class="status-badge status-processing">
                                                    <i class="fa-solid fa-gears"></i> Đang xử lý
                                                </span>
                                            </c:when>
                                            <c:when test="${ord.orderStatus == 'Shipping'}">
                                                <span class="status-badge status-shipped">
                                                    <i class="fa-solid fa-truck-fast"></i> Đang giao hàng
                                                </span>
                                            </c:when>
                                            <c:when test="${ord.orderStatus == 'Delivered'}">
                                                <span class="status-badge status-delivered">
                                                    <i class="fa-solid fa-circle-check"></i> Đã giao thành công
                                                </span>
                                            </c:when>
                                            <c:when test="${ord.orderStatus == 'Cancelled'}">
                                                <span class="status-badge status-cancelled">
                                                    <i class="fa-solid fa-circle-xmark"></i> Đã hủy đơn
                                                </span>
                                            </c:when>
                                            <c:when test="${ord.orderStatus == 'Delivery Failed'}">
                                                <span class="status-badge status-failed">
                                                    <i class="fa-solid fa-triangle-exclamation"></i> Giao hàng thất bại
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-pending">
                                                    <i class="fa-solid fa-circle-notch fa-spin"></i> ${ord.orderStatus}
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="order-price">
                                        <fmt:formatNumber value="${ord.totalPayment}" maxFractionDigits="0"/>đ
                                    </td>
                                    <td>
                                        <a href="orders?action=detail&id=${ord.saleOrderId}" class="btn-view-detail">
                                            <i class="fa-solid fa-eye"></i> Xem chi tiết
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                
                <c:otherwise>
                    <!-- Empty Orders State -->
                    <div class="empty-orders">
                        <i class="fa-solid fa-basket-shopping"></i>
                        <h2>Bạn chưa đặt đơn hàng nào!</h2>
                        <p>Hãy bắt đầu mua sắm những trái cây hữu cơ tươi ngon của GreenStock ngay hôm nay.</p>
                        <a href="products" class="btn-shop-now">Mua sắm ngay</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- FOOTER -->
    <%@include file="../common/footer.jsp" %>

</body>
</html>

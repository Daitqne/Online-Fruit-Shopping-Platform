<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng - GreenStock</title>
    
    <%@include file="../common/head.jsp" %>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/customer/order-details.css">
    
    <style>
        /* --- REVIEW MODAL SYSTEM --- */
        .btn-write-review {
            background-color: var(--primary-light);
            color: var(--primary);
            border: 1px solid var(--primary);
            padding: 6px 12px;
            border-radius: 8px;
            font-size: 0.8rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s;
            font-family: var(--font-body);
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .btn-write-review:hover {
            background-color: var(--primary);
            color: var(--white);
            transform: translateY(-1px);
        }

        .reviewed-badge {
            text-align: right;
        }

        /* Modal Overlay */
        .review-modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(15, 23, 42, 0.6);
            backdrop-filter: blur(4px);
            z-index: 2000;
            display: flex;
            align-items: center;
            justify-content: center;
            animation: modalFadeIn 0.3s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes modalFadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Modal Content Box */
        .review-modal-content {
            background: var(--white);
            border-radius: 24px;
            width: 90%;
            max-width: 500px;
            padding: 2rem;
            box-shadow: var(--shadow-xl);
            border: 1px solid var(--slate-200);
            position: relative;
            animation: modalSlideUp 0.3s cubic-bezier(0.16, 1, 0.3, 1);
            text-align: left;
        }

        @keyframes modalSlideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .close-modal {
            position: absolute;
            top: 1rem;
            right: 1.5rem;
            font-size: 1.8rem;
            color: var(--slate-600);
            cursor: pointer;
            transition: color 0.2s;
        }

        .close-modal:hover {
            color: var(--dark);
        }

        .modal-title {
            font-family: var(--font-display);
            font-size: 1.4rem;
            font-weight: 800;
            color: var(--dark);
            margin-bottom: 0.25rem;
        }

        .modal-subtitle {
            color: var(--primary);
            font-weight: 700;
            font-size: 1rem;
            margin-bottom: 1.5rem;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .rating-stars-container {
            margin-bottom: 1.5rem;
        }

        .rating-stars-container label {
            display: block;
            font-weight: 700;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
            color: var(--dark);
        }

        .star-rating {
            display: flex;
            gap: 8px;
            font-size: 1.8rem;
            color: var(--slate-300);
        }

        .star-rating i {
            cursor: pointer;
            transition: color 0.15s, transform 0.15s;
        }

        .star-rating i.active, .star-rating i.hovered {
            color: var(--secondary);
        }

        .star-rating i:hover {
            transform: scale(1.15);
        }

        .comment-container {
            margin-bottom: 1.5rem;
        }

        .comment-container label {
            display: block;
            font-weight: 700;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
            color: var(--dark);
        }

        .comment-container textarea {
            width: 100%;
            border: 1px solid var(--slate-300);
            border-radius: 12px;
            padding: 0.75rem 1rem;
            font-family: var(--font-body);
            font-size: 0.9rem;
            resize: none;
            outline: none;
            transition: border-color 0.2s;
        }

        .comment-container textarea:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.1);
        }

        .view-comment-box {
            background-color: var(--slate-100);
            border: 1px solid var(--slate-200);
            border-radius: 12px;
            padding: 1rem;
            font-size: 0.9rem;
            color: var(--slate-600);
            min-height: 80px;
            line-height: 1.5;
            white-space: pre-wrap;
        }

        .modal-actions {
            display: flex;
            gap: 1rem;
        }

        .btn-modal-cancel {
            flex: 1;
            background: var(--slate-100);
            color: var(--slate-600);
            border: 1px solid var(--slate-300);
            padding: 0.75rem;
            border-radius: 12px;
            font-weight: 700;
            cursor: pointer;
            font-family: var(--font-body);
            transition: all 0.2s;
        }

        .btn-modal-cancel:hover {
            background: var(--slate-200);
            color: var(--dark);
        }

        .btn-modal-submit {
            flex: 1.5;
            background: var(--primary);
            color: var(--white);
            border: none;
            padding: 0.75rem;
            border-radius: 12px;
            font-weight: 700;
            cursor: pointer;
            font-family: var(--font-body);
            transition: all 0.2s;
            box-shadow: 0 4px 10px rgba(16, 185, 129, 0.2);
        }

        .btn-modal-submit:hover {
            background: var(--primary-hover);
            transform: translateY(-1px);
        }
    </style>
</head>
<body>

    <!-- HEADER -->
    <%@include file="../common/header.jsp" %>

    <!-- WRAPPER -->
    <div class="detail-wrapper">
        <div class="detail-header-section">
            <h1 class="detail-title">Đơn hàng #${order.saleOrderId}</h1>
            <a href="orders" class="btn-back-history">
                <i class="fa-solid fa-arrow-left-long"></i> Lịch sử mua hàng
            </a>
        </div>

        <!-- LEFT COLUMN -->
        <div class="detail-left">
            
            <!-- Success/Error Alert -->
            <c:if test="${not empty orderSuccess}">
                <div class="alert alert-success">
                    <i class="fa-solid fa-circle-check"></i> ${orderSuccess}
                </div>
            </c:if>
            <c:if test="${not empty orderError}">
                <div class="alert alert-error">
                    <i class="fa-solid fa-circle-exclamation"></i> ${orderError}
                </div>
            </c:if>

            <!-- TIMELINE TRẠNG THÁI ĐƠN HÀNG (STATUS TRACKING) -->
            <div class="timeline-card">
                <c:choose>
                    <c:when test="${order.orderStatus == 'Cancelled'}">
                        <!-- Hiển thị banner đã hủy -->
                        <div class="cancelled-banner">
                            <i class="fa-solid fa-circle-xmark animate-pulse"></i>
                            <div>
                                <div class="cancelled-title">Đơn hàng này đã bị hủy</div>
                                <div class="cancelled-desc">
                                    Đơn hàng đã được hủy vào lúc hệ thống ghi nhận. Số tiền tạm tính chưa thanh toán và số lượng sản phẩm đã hoàn kho.
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Tiến trình trạng thái (Pending -> Processing -> Shipped -> Delivered) -->
                        <div class="status-timeline">
                            
                            <!-- Tính toán chiều rộng thanh tiến trình xanh dựa theo trạng thái -->
                            <c:set var="progressBarWidth" value="0%" />
                            <c:choose>
                                <c:when test="${order.orderStatus == 'Pending'}"><c:set var="progressBarWidth" value="0%" /></c:when>
                                <c:when test="${order.orderStatus == 'Processing'}"><c:set var="progressBarWidth" value="33.3%" /></c:when>
                                <c:when test="${order.orderStatus == 'Shipped'}"><c:set var="progressBarWidth" value="66.6%" /></c:when>
                                <c:when test="${order.orderStatus == 'Delivered'}"><c:set var="progressBarWidth" value="100%" /></c:when>
                            </c:choose>

                            <div class="timeline-progress-bar" style="width: ${progressBarWidth};"></div>
                            
                            <!-- Bước 1: Pending -->
                            <div class="timeline-step ${order.orderStatus == 'Pending' ? 'active' : ''} ${order.orderStatus != 'Pending' ? 'completed' : ''}">
                                <div class="step-icon"><i class="fa-solid fa-clock"></i></div>
                                <div class="step-label">Chờ xử lý</div>
                            </div>
                            
                            <!-- Bước 2: Processing -->
                            <div class="timeline-step ${order.orderStatus == 'Processing' ? 'active' : ''} ${(order.orderStatus == 'Shipped' || order.orderStatus == 'Delivered') ? 'completed' : ''}">
                                <div class="step-icon"><i class="fa-solid fa-gears"></i></div>
                                <div class="step-label">Đang xử lý</div>
                            </div>
                            
                            <!-- Bước 3: Shipped -->
                            <div class="timeline-step ${order.orderStatus == 'Shipped' ? 'active' : ''} ${order.orderStatus == 'Delivered' ? 'completed' : ''}">
                                <div class="step-icon"><i class="fa-solid fa-truck-fast"></i></div>
                                <div class="step-label">Đang giao</div>
                            </div>
                            
                            <!-- Bước 4: Delivered -->
                            <div class="timeline-step ${order.orderStatus == 'Delivered' ? 'active' : ''}">
                                <div class="step-icon"><i class="fa-solid fa-circle-check"></i></div>
                                <div class="step-label">Hoàn thành</div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- THÔNG TIN GIAO HÀNG & THANH TOÁN -->
            <div class="info-card">
                <h2 class="info-title"><i class="fa-solid fa-location-dot"></i> Thông tin giao nhận & Thanh toán</h2>
                <div class="info-grid">
                    <div class="info-block">
                        <h4>Địa chỉ nhận hàng</h4>
                        <p style="font-weight: 500; font-size: 0.95rem; color: var(--slate-600); line-height: 1.5; margin-top: 0.25rem;">
                            ${order.shippingAddress}
                        </p>
                    </div>
                    <div class="info-grid" style="grid-template-columns: 1fr; gap: 0.75rem;">
                        <div class="info-block">
                            <h4>Phương thức thanh toán</h4>
                            <p>
                                <c:choose>
                                    <c:when test="${order.paymentMethod == 'COD'}">Thanh toán khi nhận hàng (COD)</c:when>
                                    <c:when test="${order.paymentMethod == 'Bank Transfer'}">Chuyển khoản ngân hàng</c:when>
                                    <c:when test="${order.paymentMethod == 'VNPAY'}">Cổng thanh toán VNPAY</c:when>
                                    <c:otherwise>${order.paymentMethod}</c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div class="info-block">
                            <h4>Trạng thái thanh toán</h4>
                            <p style="display:flex; align-items:center; gap: 0.4rem; font-size: 0.9rem;">
                                <c:choose>
                                    <c:when test="${order.paymentStatus == 'Paid'}">
                                        <span class="status-badge pay-paid" style="padding: 0.2rem 0.5rem;"><i class="fa-solid fa-circle-check"></i> Đã thanh toán</span>
                                    </c:when>
                                    <c:when test="${order.paymentStatus == 'Failed'}">
                                        <span class="status-badge pay-failed" style="padding: 0.2rem 0.5rem; background-color: #FEF2F2; color: #EF4444; border: 1px solid #FCA5A5; border-radius: 6px; font-weight: 600;"><i class="fa-solid fa-circle-xmark"></i> Thanh toán thất bại</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge pay-pending" style="padding: 0.2rem 0.5rem;"><i class="fa-solid fa-clock"></i> Chưa thanh toán</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Hiển thị VietQR thanh toán nếu chọn Chuyển khoản ngân hàng và chưa thanh toán -->
                <fmt:formatNumber value="${order.totalPayment}" pattern="#" var="formattedAmount"/>
                <c:if test="${order.paymentMethod == 'Bank Transfer' && order.paymentStatus != 'Paid'}">
                    <div style="margin-top: 1.5rem; padding: 1.25rem; border: 1px dashed var(--primary); border-radius: 16px; background-color: var(--primary-light); display: flex; flex-direction: column; align-items: center; text-align: center;">
                        <h4 style="font-family: var(--font-display); font-size: 1.1rem; font-weight: 700; color: var(--primary-hover); margin-bottom: 0.5rem;">
                            <i class="fa-solid fa-qrcode"></i> Quét VietQR thanh toán nhanh
                        </h4>
                        <p style="font-size: 0.8rem; color: var(--slate-600); margin-bottom: 0.75rem; max-width: 450px; line-height: 1.4;">
                            Quét mã này bằng ứng dụng ngân hàng để chuyển khoản thanh toán tự động điền sẵn thông tin.
                        </p>
                        <img src="https://img.vietqr.io/image/vietcombank-1234567890-compact.png?amount=${formattedAmount}&addInfo=GS${order.saleOrderId}&accountName=CONG%20TY%20CO%20PHAN%20GREENSTOCK%20VIET%20NAM" 
                             alt="VietQR Code" 
                             style="max-width: 180px; border-radius: 10px; box-shadow: var(--shadow-md); border: 1px solid var(--slate-200); background-color: white; padding: 4px; margin-bottom: 0.5rem;">
                        <div style="font-size: 0.85rem; font-weight: 700; color: var(--dark);">
                            Số tiền: <span style="color:#DC2626;"><fmt:formatNumber value="${order.totalPayment}" maxFractionDigits="0"/>đ</span>
                        </div>
                        <div style="font-size: 0.85rem; font-weight: 700; color: var(--dark);">
                            Nội dung: <span style="color:var(--primary-hover);">GS${order.saleOrderId}</span>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${not empty order.shipperNote}">
                    <div class="info-block" style="margin-top: 1.5rem; border-top: 1px solid var(--slate-100); padding-top: 1rem;">
                        <h4>Ghi chú đơn hàng</h4>
                        <p style="font-weight: 500; color: var(--slate-600); font-style: italic;">"${order.shipperNote}"</p>
                    </div>
                </c:if>
            </div>

            <!-- CHI TIẾT SẢN PHẨM MUA -->
            <div class="info-card">
                <h2 class="info-title"><i class="fa-solid fa-basket-shopping"></i> Danh sách mặt hàng</h2>
                <div>
                    <c:forEach items="${order.items}" var="item">
                        <div class="item-row">
                            <img src="${not empty item.product.image ? item.product.image : 'https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?auto=format&fit=crop&q=80&w=600'}" 
                                 alt="${item.product.name}" class="item-img">
                            <div class="item-main">
                                <div class="item-name">${item.product.name}</div>
                                <c:if test="${not empty item.weightLabel || not empty item.packagingName}">
                                    <div style="font-size: 0.8rem; color: var(--slate-600); margin-top: 0.25rem;">
                                        <c:if test="${not empty item.weightLabel}">
                                            <span style="background: var(--slate-200); padding: 0.15rem 0.4rem; border-radius: 4px; margin-right: 4px; font-weight: 600;">
                                                Trọng lượng: ${item.weightLabel}
                                            </span>
                                        </c:if>
                                        <c:if test="${not empty item.packagingName}">
                                            <span style="background: var(--slate-200); padding: 0.15rem 0.4rem; border-radius: 4px; font-weight: 600;">
                                                Đóng gói: ${item.packagingName}
                                            </span>
                                        </c:if>
                                    </div>
                                </c:if>
                                <div class="item-meta">Số lượng: ${item.quantity} x <fmt:formatNumber value="${item.unitPrice}" maxFractionDigits="0"/>đ</div>
                            </div>
                            <div class="item-price" style="text-align: right; display: flex; flex-direction: column; align-items: flex-end; gap: 0.5rem; min-width: 140px;">
                                <div style="font-weight: 700; color: var(--dark);">
                                    <fmt:formatNumber value="${item.quantity * item.unitPrice}" maxFractionDigits="0"/>đ
                                </div>
                                <c:if test="${order.orderStatus == 'Delivered'}">
                                    <div class="review-action-container" data-product-id="${item.productId}" data-product-name="${item.product.name}">
                                        <c:choose>
                                            <c:when test="${reviewedProductIds.contains(item.productId)}">
                                                <div class="reviewed-badge">
                                                    <div class="stars-display" style="color: var(--secondary); font-size: 0.85rem; margin-bottom: 2px;">
                                                        <c:forEach begin="1" end="${productReviews[item.productId].rating}">
                                                            <i class="fa-solid fa-star"></i>
                                                        </c:forEach>
                                                        <c:forEach begin="${productReviews[item.productId].rating + 1}" end="5">
                                                            <i class="fa-regular fa-star"></i>
                                                        </c:forEach>
                                                    </div>
                                                    <span style="font-size: 0.75rem; color: var(--primary); font-weight: bold; cursor: pointer; text-decoration: underline;" onclick="viewMyReview('${item.productId}', this)">Xem đánh giá</span>
                                                    <!-- Hidden data for JavaScript -->
                                                    <span class="hidden-review-rating" style="display:none;">${productReviews[item.productId].rating}</span>
                                                    <span class="hidden-review-comment" style="display:none;"><c:out value="${productReviews[item.productId].comment}" /></span>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <button type="button" class="btn-write-review" onclick="openReviewModal('${item.productId}', this)">
                                                    <i class="fa-regular fa-star-half-stroke"></i> Viết đánh giá
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <!-- RIGHT COLUMN (ORDER SUMMARY SIDEBAR) -->
        <div class="detail-right">
            <div class="sidebar-card">
                <h3 class="summary-title">Tóm tắt thanh toán</h3>
                
                <!-- Tính toán tạm tính từ các mặt hàng -->
                <c:set var="subTotal" value="0" />
                <c:forEach items="${order.items}" var="item">
                    <c:set var="subTotal" value="${subTotal + (item.quantity * item.unitPrice)}" />
                </c:forEach>

                <div class="price-row">
                    <span>Tổng tiền hàng</span>
                    <span><fmt:formatNumber value="${subTotal}" maxFractionDigits="0"/>đ</span>
                </div>
                <div class="price-row">
                    <span>Phí vận chuyển</span>
                    <span>
                        <c:choose>
                            <c:when test="${order.shippingFee > 0}"><fmt:formatNumber value="${order.shippingFee}" maxFractionDigits="0"/>đ</c:when>
                            <c:otherwise>Miễn phí</c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <c:if test="${order.discountAmount > 0}">
                    <div class="price-row" style="color: var(--primary); font-weight: 600;">
                        <span>Khuyến mãi giảm giá ${not empty order.promoCode ? '('.concat(order.promoCode).concat(')') : ''}</span>
                        <span>-<fmt:formatNumber value="${order.discountAmount}" maxFractionDigits="0"/>đ</span>
                    </div>
                </c:if>
                <div class="price-row total">
                    <span>Tổng thanh toán</span>
                    <span class="total-val"><fmt:formatNumber value="${order.totalPayment}" maxFractionDigits="0"/>đ</span>
                </div>

                <!-- INVOICE & RECEIPT BUTTONS -->
                <a href="${pageContext.request.contextPath}/orders?action=invoice&id=${order.saleOrderId}" target="_blank" class="btn-cancel-order" style="background-color: var(--primary-light); color: var(--primary-hover); border-color: var(--primary); margin-top: 1.5rem; text-decoration: none;">
                    <i class="fa-solid fa-file-invoice"></i> Xem hóa đơn điện tử
                </a>
                <a href="${pageContext.request.contextPath}/orders?action=invoice&id=${order.saleOrderId}&download=true" target="_blank" class="btn-cancel-order" style="background-color: var(--slate-100); color: var(--dark); border-color: var(--slate-300); margin-top: 0.5rem; text-decoration: none;">
                    <i class="fa-solid fa-download"></i> Tải biên lai (PDF)
                </a>

                <!-- NÚT HỦY ĐƠN HÀNG (CHỈ KHI TRẠNG THÁI LÀ PENDING) -->
                <c:if test="${order.orderStatus == 'Pending'}">
                    <button type="button" class="btn-cancel-order" onclick="confirmCancelOrder(${order.saleOrderId})" style="margin-top: 0.5rem;">
                        <i class="fa-solid fa-circle-xmark"></i> Hủy đơn hàng này
                    </button>
                </c:if>

                <!-- CÁC NÚT THANH TOÁN LẠI & THAY ĐỔI PHƯƠNG THỨC (CHỈ KHI CHƯA THANH TOÁN VÀ ĐƠN HÀNG CHỜ XỬ LÝ) -->
                <c:if test="${order.orderStatus == 'Pending' && order.paymentStatus != 'Paid'}">
                    <!-- Nút Thanh toán lại qua VNPAY -->
                    <c:if test="${order.paymentMethod == 'VNPAY'}">
                        <a href="${pageContext.request.contextPath}/checkout?action=repay&orderId=${order.saleOrderId}" class="btn-cancel-order" style="background-color: #2563EB; color: white; border-color: #2563EB; margin-top: 0.5rem; text-decoration: none; display: flex; justify-content: center; align-items: center; gap: 0.5rem;">
                            <i class="fa-solid fa-credit-card"></i> Thanh toán lại qua VNPAY
                        </a>
                    </c:if>
                    
                    <!-- Nút Đổi sang thanh toán COD -->
                    <c:if test="${order.paymentMethod == 'VNPAY' || order.paymentMethod == 'Bank Transfer'}">
                        <a href="javascript:void(0);" onclick="confirmChangeToCOD(${order.saleOrderId})" class="btn-cancel-order" style="background-color: #F59E0B; color: white; border-color: #F59E0B; margin-top: 0.5rem; text-decoration: none; display: flex; justify-content: center; align-items: center; gap: 0.5rem;">
                            <i class="fa-solid fa-hand-holding-dollar"></i> Đổi sang thanh toán COD
                        </a>
                    </c:if>
                </c:if>
            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <%@include file="../common/footer.jsp" %>

    <!-- REVIEW MODAL -->
    <div id="reviewModal" class="review-modal" style="display: none;">
        <div class="review-modal-content">
            <span class="close-modal" onclick="closeReviewModal()">&times;</span>
            <h3 class="modal-title">Đánh giá sản phẩm</h3>
            <p class="modal-subtitle" id="modal-product-name">Tên sản phẩm</p>
            
            <form id="reviewForm" onsubmit="submitReview(event)">
                <input type="hidden" id="review-product-id" name="productId">
                
                <div class="rating-stars-container">
                    <label>Đánh giá số sao:</label>
                    <div class="star-rating" id="star-rating-selector">
                        <i class="fa-regular fa-star star-btn" data-value="1"></i>
                        <i class="fa-regular fa-star star-btn" data-value="2"></i>
                        <i class="fa-regular fa-star star-btn" data-value="3"></i>
                        <i class="fa-regular fa-star star-btn" data-value="4"></i>
                        <i class="fa-regular fa-star star-btn" data-value="5"></i>
                    </div>
                    <input type="hidden" id="selected-rating" name="rating" value="5">
                </div>
                
                <div class="comment-container">
                    <label for="review-comment">Nhận xét của bạn (Không bắt buộc):</label>
                    <textarea id="review-comment" name="comment" rows="4" placeholder="Chia sẻ trải nghiệm của bạn về độ tươi ngon, đóng gói và dịch vụ giao nhận trái cây..."></textarea>
                </div>
                
                <div class="modal-actions">
                    <button type="button" class="btn-modal-cancel" onclick="closeReviewModal()">Hủy bỏ</button>
                    <button type="submit" class="btn-modal-submit" id="submit-review-btn">Gửi đánh giá</button>
                </div>
            </form>
        </div>
    </div>

    <!-- VIEW REVIEW MODAL -->
    <div id="viewReviewModal" class="review-modal" style="display: none;">
        <div class="review-modal-content">
            <span class="close-modal" onclick="closeViewReviewModal()">&times;</span>
            <h3 class="modal-title">Đánh giá của bạn</h3>
            <p class="modal-subtitle" id="view-modal-product-name">Tên sản phẩm</p>
            
            <div class="rating-stars-container" style="margin-bottom: 1.25rem;">
                <div class="star-rating" id="view-star-rating" style="color: var(--secondary); pointer-events: none;">
                    <!-- Stars will be injected dynamically -->
                </div>
            </div>
            
            <div class="comment-container">
                <label>Nhận xét đã gửi:</label>
                <div class="view-comment-box" id="view-comment-text">
                    Nội dung nhận xét...
                </div>
            </div>
            
            <div class="modal-actions">
                <button type="button" class="btn-modal-cancel" onclick="closeViewReviewModal()" style="width: 100%;">Đóng</button>
            </div>
        </div>
    </div>

    <!-- CONFIRMATION & REVIEW SCRIPTS -->
    <script>
        function confirmCancelOrder(orderId) {
            if (confirm("Bạn có chắc chắn muốn hủy đơn hàng #" + orderId + " không?\nLưu ý: Thao tác này không thể hoàn tác và số lượng sản phẩm sẽ được hoàn trả lại vào kho hàng.")) {
                window.location.href = "${pageContext.request.contextPath}/orders?action=cancel&id=" + orderId;
            }
        }
        
        function confirmChangeToCOD(orderId) {
            if (confirm("Bạn có chắc chắn muốn chuyển đổi phương thức thanh toán của đơn hàng #" + orderId + " sang COD (Thanh toán khi nhận hàng) không?")) {
                window.location.href = "${pageContext.request.contextPath}/orders?action=changeToCOD&id=" + orderId;
            }
        }

        // --- REVIEW MODAL CODE ---
        const stars = document.querySelectorAll("#star-rating-selector .star-btn");
        const ratingInput = document.getElementById("selected-rating");

        stars.forEach(star => {
            star.addEventListener("click", function() {
                const val = parseInt(this.getAttribute("data-value"));
                ratingInput.value = val;
                highlightStars(val);
            });

            star.addEventListener("mouseover", function() {
                const val = parseInt(this.getAttribute("data-value"));
                highlightStars(val, true);
            });

            star.addEventListener("mouseout", function() {
                const currentVal = parseInt(ratingInput.value);
                highlightStars(currentVal);
            });
        });

        function highlightStars(val, isHover = false) {
            stars.forEach(s => {
                const sVal = parseInt(s.getAttribute("data-value"));
                if (sVal <= val) {
                    s.classList.add("active");
                    s.className = "fa-solid fa-star star-btn active";
                } else {
                    s.classList.remove("active");
                    s.className = "fa-regular fa-star star-btn";
                }
            });
        }

        // Modal Controls
        const reviewModal = document.getElementById("reviewModal");
        const viewReviewModal = document.getElementById("viewReviewModal");

        function openReviewModal(productId, buttonElement) {
            const row = buttonElement.closest('.item-row');
            const productName = row.querySelector('.item-name').innerText;
            
            document.getElementById("review-product-id").value = productId;
            document.getElementById("modal-product-name").innerText = productName;
            document.getElementById("review-comment").value = "";
            ratingInput.value = 5;
            highlightStars(5);
            reviewModal.style.display = "flex";
        }

        function closeReviewModal() {
            reviewModal.style.display = "none";
        }

        function openViewReviewModal(productName, rating, comment) {
            document.getElementById("view-modal-product-name").innerText = productName;
            const starContainer = document.getElementById("view-star-rating");
            let starsHtml = "";
            for (let i = 1; i <= 5; i++) {
                if (i <= rating) {
                    starsHtml += '<i class="fa-solid fa-star"></i> ';
                } else {
                    starsHtml += '<i class="fa-regular fa-star"></i> ';
                }
            }
            starContainer.innerHTML = starsHtml;
            document.getElementById("view-comment-text").innerText = comment ? comment : "(Không có nhận xét)";
            viewReviewModal.style.display = "flex";
        }

        function closeViewReviewModal() {
            viewReviewModal.style.display = "none";
        }

        function viewMyReview(productId, spanElement) {
            const row = spanElement.closest('.item-row');
            const productName = row.querySelector('.item-name').innerText;
            const rating = parseInt(row.querySelector('.hidden-review-rating').innerText);
            const comment = row.querySelector('.hidden-review-comment').innerText;
            openViewReviewModal(productName, rating, comment);
        }

        // Submitting Review via AJAX
        function submitReview(e) {
            e.preventDefault();
            const productId = document.getElementById("review-product-id").value;
            const rating = ratingInput.value;
            const comment = document.getElementById("review-comment").value;
            const btn = document.getElementById("submit-review-btn");
            const contextPath = "${pageContext.request.contextPath}";

            btn.disabled = true;
            btn.innerText = "Đang gửi...";

            fetch(contextPath + "/customer/submit-review", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: "productId=" + productId + "&rating=" + rating + "&comment=" + encodeURIComponent(comment)
            })
            .then(response => response.json())
            .then(data => {
                btn.disabled = false;
                btn.innerText = "Gửi đánh giá";
                
                if (data.success) {
                    closeReviewModal();
                    alert("Đánh giá sản phẩm thành công!");

                    // Dynamically update the review-action-container to reviewed state
                    const container = document.querySelector(`.review-action-container[data-product-id="${productId}"]`);
                    if (container) {
                        let starsDisplayHtml = "";
                        for (let i = 1; i <= 5; i++) {
                            if (i <= rating) {
                                starsDisplayHtml += '<i class="fa-solid fa-star text-warning"></i>';
                            } else {
                                starsDisplayHtml += '<i class="fa-regular fa-star"></i>';
                            }
                        }

                        container.innerHTML = `
                            <div class="reviewed-badge">
                                <div class="stars-display" style="color: var(--secondary); font-size: 0.85rem; margin-bottom: 2px;">
                                    \${starsDisplayHtml}
                                </div>
                                <span style="font-size: 0.75rem; color: var(--primary); font-weight: bold; cursor: pointer; text-decoration: underline;" onclick="viewMyReview('\${productId}', this)">Xem đánh giá</span>
                                <span class="hidden-review-rating" style="display:none;">\${rating}</span>
                                <span class="hidden-review-comment" style="display:none;">\${comment}</span>
                            </div>
                        `;
                    }
                } else {
                    alert(data.message || "Có lỗi xảy ra khi gửi đánh giá.");
                }
            })
            .catch(err => {
                btn.disabled = false;
                btn.innerText = "Gửi đánh giá";
                console.error("Lỗi gửi đánh giá:", err);
                alert("Không thể gửi đánh giá. Vui lòng thử lại sau.");
            });
        }
    </script>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông báo của tôi - GreenStock</title>
    
    <%@include file="../common/head.jsp" %>
</head>
<body>

    <!-- HEADER -->
    <%@include file="../common/header.jsp" %>

    <!-- MAIN NOTIFICATIONS WRAPPER -->
    <div class="noti-page-wrapper">
        <div class="noti-page-header">
            <h1 class="noti-page-title">
                <i class="fa-solid fa-bell"></i> Thông báo của tôi
            </h1>
            <c:if test="${unreadCount > 0}">
                <button class="btn-mark-all-read" id="page-mark-all-read-btn" style="font-size: 0.95rem; font-weight: 700;">
                    <i class="fa-solid fa-check-double"></i> Đánh dấu tất cả đã đọc
                </button>
            </c:if>
        </div>

        <!-- Filter Tabs -->
        <div class="noti-filters">
            <button class="filter-btn active" data-filter="all">Tất cả</button>
            <button class="filter-btn" data-filter="unread">Chưa đọc</button>
            <button class="filter-btn" data-filter="read">Đã đọc</button>
        </div>

        <div class="noti-card-list" id="page-noti-list">
            <c:choose>
                <c:when test="${not empty notifications}">
                    <c:forEach items="${notifications}" var="noti">
                        <div class="noti-card-item ${noti.read ? 'read' : 'unread'}" data-id="${noti.notificationId}" data-read="${noti.read}">
                            <div class="noti-icon-wrapper">
                                <i class="fa-solid fa-bell"></i>
                            </div>
                            <div class="noti-content">
                                <span class="noti-title">${noti.title}</span>
                                <span class="noti-desc">${noti.content}</span>
                                <span class="noti-time">
                                    <i class="fa-regular fa-clock"></i> 
                                    <fmt:formatDate value="${noti.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                </span>
                            </div>
                            <div class="noti-card-actions">
                                <c:if test="${!noti.read}">
                                    <button class="btn-read-single btn-mark-read-page" data-id="${noti.notificationId}">Đánh dấu đã đọc</button>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <!-- Empty Notifications State -->
                    <div class="noti-card-empty">
                        <i class="fa-solid fa-bell-slash"></i>
                        <h3>Bạn không có thông báo nào!</h3>
                        <p>Thông tin về đơn hàng, vận chuyển, ưu đãi của bạn sẽ xuất hiện tại đây.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- FOOTER -->
    <%@include file="../common/footer.jsp" %>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const filterButtons = document.querySelectorAll(".filter-btn");
            const notiItems = document.querySelectorAll(".noti-card-item");
            const markAllReadBtn = document.getElementById("page-mark-all-read-btn");
            const notiListContainer = document.getElementById("page-noti-list");
            const contextPath = "${pageContext.request.contextPath}";

            // Dynamically assign icons based on title/content text to avoid JSTL EL Method call limitations
            notiItems.forEach(item => {
                const titleEl = item.querySelector(".noti-title");
                if (!titleEl) return;
                const titleText = titleEl.innerText;
                const titleUpper = titleText.toUpperCase();
                const iconWrapper = item.querySelector(".noti-icon-wrapper");
                const icon = iconWrapper.querySelector("i");

                if (titleUpper.includes("THÀNH CÔNG") || titleUpper.includes("HOÀN TẤT") || titleUpper.includes("THANH TOÁN")) {
                    icon.className = "fa-solid fa-circle-check";
                } else if (titleUpper.includes("THẤT BẠI") || titleUpper.includes("HỦY")) {
                    icon.className = "fa-solid fa-circle-xmark";
                    iconWrapper.classList.add("warning");
                } else if (titleUpper.includes("ĐANG GIAO") || titleUpper.includes("VẬN CHUYỂN") || titleUpper.includes("SHIPPING")) {
                    icon.className = "fa-solid fa-truck-fast";
                    iconWrapper.classList.add("info");
                } else if (titleUpper.includes("ĐỔI") || titleUpper.includes("CẬP NHẬT")) {
                    icon.className = "fa-solid fa-arrows-rotate";
                    iconWrapper.classList.add("info");
                }
            });

            // Filter functionality
            filterButtons.forEach(btn => {
                btn.addEventListener("click", function() {
                    filterButtons.forEach(b => b.classList.remove("active"));
                    this.classList.add("active");

                    const filter = this.getAttribute("data-filter");
                    let visibleCount = 0;

                    notiItems.forEach(item => {
                        const isRead = item.getAttribute("data-read") === "true";
                        if (filter === "all") {
                            item.style.display = "flex";
                            visibleCount++;
                        } else if (filter === "unread" && !isRead) {
                            item.style.display = "flex";
                            visibleCount++;
                        } else if (filter === "read" && isRead) {
                            item.style.display = "flex";
                            visibleCount++;
                        } else {
                            item.style.display = "none";
                        }
                    });

                    // Check if list is empty after filter
                    const existingEmpty = notiListContainer.querySelector(".noti-card-empty");
                    if (visibleCount === 0) {
                        if (!existingEmpty) {
                            const emptyDiv = document.createElement("div");
                            emptyDiv.className = "noti-card-empty temp-empty";
                            emptyDiv.innerHTML = `
                                <i class="fa-solid fa-bell-slash"></i>
                                <h3>Không có thông báo phù hợp!</h3>
                                <p>Không có thông báo nào trong bộ lọc này.</p>
                            `;
                            notiListContainer.appendChild(emptyDiv);
                        } else {
                            existingEmpty.style.display = "block";
                        }
                    } else {
                        if (existingEmpty) {
                            if (existingEmpty.classList.contains("temp-empty")) {
                                existingEmpty.remove();
                            } else {
                                existingEmpty.style.display = "none";
                            }
                        }
                    }
                });
            });

            // Mark single as read on page
            document.querySelectorAll(".btn-mark-read-page").forEach(btn => {
                btn.addEventListener("click", function(e) {
                    e.stopPropagation();
                    const id = this.getAttribute("data-id");
                    const cardItem = this.closest(".noti-card-item");

                    fetch(contextPath + "/customer/notifications?action=read&id=" + id, {
                        method: "POST"
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            cardItem.classList.remove("unread");
                            cardItem.classList.add("read");
                            cardItem.setAttribute("data-read", "true");
                            this.remove(); // Remove button
                            
                            // Refresh header badge
                            if (window.refreshBadgeOnly) {
                                window.refreshBadgeOnly();
                            }
                        }
                    })
                    .catch(err => console.error("Lỗi:", err));
                });
            });

            // Mark all as read on page
            if (markAllReadBtn) {
                markAllReadBtn.addEventListener("click", function() {
                    fetch(contextPath + "/customer/notifications?action=read-all", {
                        method: "POST"
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            notiItems.forEach(item => {
                                item.classList.remove("unread");
                                item.classList.add("read");
                                item.setAttribute("data-read", "true");
                                const btn = item.querySelector(".btn-mark-read-page");
                                if (btn) btn.remove();
                            });
                            markAllReadBtn.remove();
                            
                            // Refresh header badge
                            if (window.refreshBadgeOnly) {
                                window.refreshBadgeOnly();
                            }
                        }
                    })
                    .catch(err => console.error("Lỗi:", err));
                });
            }

            // Click item to view details (redirect to order details)
            notiItems.forEach(item => {
                item.addEventListener("click", function(e) {
                    if (e.target.classList.contains("btn-mark-read-page")) return;
                    const isRead = this.getAttribute("data-read") === "true";
                    const id = this.getAttribute("data-id");
                    
                    if (!isRead) {
                        fetch(contextPath + "/customer/notifications?action=read&id=" + id, {
                            method: "POST"
                        });
                    }
                    
                    const contentText = this.querySelector(".noti-desc").innerText;
                    const titleText = this.querySelector(".noti-title").innerText;
                    const match = contentText.match(/#(\d+)/) || titleText.match(/#(\d+)/);
                    let url = contextPath + "/orders";
                    if (match && match[1]) {
                        url = contextPath + "/orders?action=detail&id=" + match[1];
                    }
                    
                    window.location.href = url;
                });
            });
        });
    </script>
</body>
</html>

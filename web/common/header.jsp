<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/customer/notifications.css">

<style>
    /* --- LOGIN BUTTON --- */
    .btn-login {
        background-color: var(--primary) !important;
        color: var(--white) !important;
        text-decoration: none !important;
        padding: 0.6rem 1.4rem !important;
        border-radius: 50px !important;
        font-weight: 600 !important;
        display: flex !important;
        align-items: center !important;
        gap: 0.5rem !important;
        transition: all 0.3s ease !important;
        font-size: 0.95rem !important;
    }

    .btn-login:hover {
        background-color: var(--primary-hover) !important;
        color: var(--white) !important;
        transform: translateY(-2px) !important;
        box-shadow: 0 4px 12px rgba(16, 185, 129, 0.25) !important;
    }
</style>

<header>
    <div class="nav-container">
        <a href="${pageContext.request.contextPath}/home" class="logo">
            <i class="fa-solid fa-leaf"></i> GreenStock
        </a>

        <ul class="nav-menu">
            <li><a href="${pageContext.request.contextPath}/home" class="nav-link">Trang chủ</a></li>
            <li><a href="${pageContext.request.contextPath}/products" class="nav-link">Sản phẩm</a></li>
            <li><a href="${pageContext.request.contextPath}/customer/about.jsp" class="nav-link">Giới thiệu</a></li>
            <li><a href="${pageContext.request.contextPath}/customer/contact.jsp" class="nav-link">Liên hệ</a></li>
        </ul>
        
        <div class="nav-actions">
            <!-- Search Toggle Button (chỉ hiển thị icon) -->
            <div class="header-search-wrapper">
                <button class="header-search-toggle" id="search-toggle-btn" title="Tìm kiếm">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </button>
            </div>
            
            <a href="${pageContext.request.contextPath}/cart" style="color: var(--slate-600); font-size: 1.25rem; position: relative; text-decoration: none;">
                <i class="fa-solid fa-cart-shopping"></i>
                <span class="cart-badge" style="position: absolute; top: -8px; right: -10px; background: var(--secondary); color: var(--white); border-radius: 50%; font-size: 0.7rem; width: 18px; height: 18px; display: flex; align-items: center; justify-content: center; font-weight: 700;">
                    ${sessionScope.cartCount != null ? sessionScope.cartCount : 0}
                </span>
            </a>

            <c:if test="${not empty sessionScope.user}">
                <!-- NOTIFICATION BELL & DROPDOWN -->
                <div class="notification-wrapper">
                    <button class="notification-toggle" id="noti-toggle-btn" title="Thông báo">
                        <i class="fa-solid fa-bell"></i>
                        <span class="notification-badge" id="noti-badge" style="display: none;">0</span>
                    </button>
                    <div class="notification-dropdown" id="noti-dropdown">
                        <div class="noti-header">
                            <h3>Thông báo</h3>
                            <button class="btn-mark-all-read" id="noti-mark-all-read-btn">Đọc tất cả</button>
                        </div>
                        <div class="noti-list" id="noti-list-container">
                            <div class="noti-empty">
                                <i class="fa-solid fa-bell-slash"></i>
                                <p>Không có thông báo mới nào</p>
                            </div>
                        </div>
                        <div class="noti-footer">
                            <a href="${pageContext.request.contextPath}/customer/notifications">Xem tất cả thông báo <i class="fa-solid fa-arrow-right"></i></a>
                        </div>
                    </div>
                </div>
            </c:if>
            
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <div class="user-menu">
                        <button class="user-menu-btn">
                            <i class="fa-solid fa-circle-user"></i>
                            Xin chào, ${sessionScope.user.fullName}
                            <i class="fa-solid fa-chevron-down" style="font-size:0.75rem;"></i>
                        </button>
                        <div class="user-dropdown">
                            <a href="${pageContext.request.contextPath}/profile"><i class="fa-solid fa-user"></i> Tài khoản</a>
                            <a href="${pageContext.request.contextPath}/orders"><i class="fa-solid fa-bag-shopping"></i> Đơn hàng</a>
                            <a href="${pageContext.request.contextPath}/logout" class="logout"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn-login">
                        <i class="fa-solid fa-user"></i> Đăng nhập
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>

<script>
document.addEventListener("DOMContentLoaded", function() {
    const notiToggle = document.getElementById("noti-toggle-btn");
    const notiDropdown = document.getElementById("noti-dropdown");
    const notiBadge = document.getElementById("noti-badge");
    const notiListContainer = document.getElementById("noti-list-container");
    const markAllReadBtn = document.getElementById("noti-mark-all-read-btn");
    const contextPath = "${pageContext.request.contextPath}";

    if (!notiToggle) return; // User not logged in

    // Toggle dropdown
    notiToggle.addEventListener("click", function(e) {
        e.stopPropagation();
        notiDropdown.classList.toggle("active");
        if (notiDropdown.classList.contains("active")) {
            loadNotifications();
        }
    });

    // Close dropdown on click outside
    document.addEventListener("click", function(e) {
        if (!notiDropdown.contains(e.target) && !notiToggle.contains(e.target)) {
            notiDropdown.classList.remove("active");
        }
    });

    // Load notifications from API
    function loadNotifications() {
        fetch(contextPath + "/customer/notifications?ajax=true&view=dropdown", {
            headers: {
                "X-Requested-With": "XMLHttpRequest"
            }
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                updateBadge(data.unreadCount);
                renderDropdownList(data.notifications);
            }
        })
        .catch(err => console.error("Lỗi tải thông báo:", err));
    }

    // Update unread count badge
    function updateBadge(count) {
        if (count > 0) {
            notiBadge.innerText = count;
            notiBadge.style.display = "flex";
        } else {
            notiBadge.style.display = "none";
        }
    }

    // Render dropdown list
    function renderDropdownList(notifications) {
        if (!notifications || notifications.length === 0) {
            notiListContainer.innerHTML = `
                <div class="noti-empty">
                    <i class="fa-solid fa-bell-slash"></i>
                    <p>Không có thông báo mới nào</p>
                </div>
            `;
            return;
        }

        let html = "";
        notifications.forEach(n => {
            let iconClass = "fa-bell";
            let typeColor = ""; // default primary
            
            // Choose icon based on notification title/content
            const titleUpper = n.title.toUpperCase();
            if (titleUpper.includes("THÀNH CÔNG") || titleUpper.includes("HOÀN TẤT") || titleUpper.includes("ĐÃ GIAO")) {
                iconClass = "fa-circle-check";
            } else if (titleUpper.includes("THẤT BẠI") || titleUpper.includes("HỦY")) {
                iconClass = "fa-circle-xmark";
                typeColor = "warning";
            } else if (titleUpper.includes("ĐANG GIAO") || titleUpper.includes("VẬN CHUYỂN") || titleUpper.includes("SHIPPING")) {
                iconClass = "fa-truck-fast";
                typeColor = "info";
            } else if (titleUpper.includes("ĐỔI") || titleUpper.includes("CẬP NHẬT")) {
                iconClass = "fa-arrows-rotate";
                typeColor = "info";
            }

            // Extract order ID if exists
            let targetUrl = contextPath + "/orders";
            const orderIdMatch = n.content.match(/#(\d+)/) || n.title.match(/#(\d+)/);
            if (orderIdMatch && orderIdMatch[1]) {
                targetUrl = contextPath + "/orders?action=detail&id=" + orderIdMatch[1];
            }

            html += `
                <div class="noti-item \${n.isRead ? '' : 'unread'}" data-id="\${n.id}" data-url="\${targetUrl}">
                    <div class="noti-icon-wrapper \${typeColor}">
                        <i class="fa-solid \${iconClass}"></i>
                    </div>
                    <div class="noti-content">
                        <span class="noti-title">\${n.title}</span>
                        <span class="noti-desc">\${n.content}</span>
                        <span class="noti-time"><i class="fa-regular fa-clock"></i> \${n.friendlyTime}</span>
                    </div>
                </div>
            `;
        });
        notiListContainer.innerHTML = html;

        // Add click events to items to mark as read
        document.querySelectorAll(".noti-dropdown .noti-item").forEach(item => {
            item.addEventListener("click", function(e) {
                const id = this.getAttribute("data-id");
                const isUnread = this.classList.contains("unread");
                const url = this.getAttribute("data-url");
                
                if (isUnread) {
                    markAsRead(id, this);
                }
                
                // Redirect to order details
                window.location.href = url;
            });
        });
    }

    // Mark single notification as read
    function markAsRead(id, element) {
        fetch(contextPath + "/customer/notifications?action=read&id=" + id, {
            method: "POST"
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                element.classList.remove("unread");
                // Refresh badge count
                refreshBadgeOnly();
            }
        })
        .catch(err => console.error("Lỗi cập nhật đọc thông báo:", err));
    }

    // Mark all as read
    markAllReadBtn.addEventListener("click", function(e) {
        e.stopPropagation();
        fetch(contextPath + "/customer/notifications?action=read-all", {
            method: "POST"
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                document.querySelectorAll(".noti-dropdown .noti-item").forEach(item => {
                    item.classList.remove("unread");
                });
                updateBadge(0);
            }
        })
        .catch(err => console.error("Lỗi đánh dấu đọc tất cả:", err));
    });

    // Helper to refresh badge only without opening dropdown
    function refreshBadgeOnly() {
        fetch(contextPath + "/customer/notifications?ajax=true&view=dropdown", {
            headers: {
                "X-Requested-With": "XMLHttpRequest"
            }
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                updateBadge(data.unreadCount);
            }
        })
        .catch(err => console.error("Lỗi tải badge thông báo:", err));
    }

    // Poll for new notifications every 60 seconds
    refreshBadgeOnly();
    setInterval(refreshBadgeOnly, 60000);
});
</script>


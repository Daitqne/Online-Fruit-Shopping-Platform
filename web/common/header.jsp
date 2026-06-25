<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- Tự động nạp thông tin hạng thành viên (Membership) vào session khi người dùng đăng nhập --%>
<c:if test="${not empty sessionScope.user && empty sessionScope.membership}">
    <%
        model.Authen currUser = (model.Authen) session.getAttribute("user");
        if (currUser != null) {
            dal.MembershipDAO mDAO = new dal.MembershipDAO();
            model.Membership mShip = mDAO.getMembershipByUserId(currUser.getId());
            session.setAttribute("membership", mShip);
        }
    %>
</c:if>
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
                    <div class="user-menu" style="position: relative;">
                        <button class="user-menu-btn">
                            <i class="fa-solid fa-circle-user"></i>
                            Xin chào, ${sessionScope.user.fullName}
                            <%-- Hiển thị huy hiệu (Badge) hạng thành viên --%>
                            <c:if test="${not empty sessionScope.membership}">
                                <span class="member-badge ${sessionScope.membership.currentTier.toLowerCase()}" id="memberBadgeBtn" title="Xem tiến trình thăng hạng">
                                    ${sessionScope.membership.currentTier}
                                </span>
                            </c:if>
                            <i class="fa-solid fa-chevron-down" style="font-size:0.75rem;"></i>
                        </button>

                        <%-- Popover chứa thanh tiến độ tích lũy điểm --%>
                        <c:if test="${not empty sessionScope.membership}">
                            <c:set var="m" value="${sessionScope.membership}"/>
                            <c:set var="currentPoints" value="${m.currentPoints}"/>
                            
                            <%-- Xác định mốc điểm để tính % tiến độ --%>
                            <c:choose>
                                <c:when test="${m.currentTier == 'Normal'}">
                                    <c:set var="tierName" value="Normal"/>
                                    <c:set var="nextTier" value="Silver"/>
                                    <c:set var="minPoints" value="0"/>
                                    <c:set var="maxPoints" value="${m.silverMinPoint}"/>
                                </c:when>
                                <c:when test="${m.currentTier == 'Silver'}">
                                    <c:set var="tierName" value="Silver"/>
                                    <c:set var="nextTier" value="Gold"/>
                                    <c:set var="minPoints" value="${m.silverMinPoint}"/>
                                    <c:set var="maxPoints" value="${m.goldMinPoint}"/>
                                </c:when>
                                <c:when test="${m.currentTier == 'Gold'}">
                                    <c:set var="tierName" value="Gold"/>
                                    <c:set var="nextTier" value="Diamond"/>
                                    <c:set var="minPoints" value="${m.goldMinPoint}"/>
                                    <c:set var="maxPoints" value="${m.diamondMinPoint}"/>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="tierName" value="Diamond"/>
                                    <c:set var="nextTier" value=""/>
                                    <c:set var="minPoints" value="${m.diamondMinPoint}"/>
                                    <c:set var="maxPoints" value="${m.diamondMinPoint}"/>
                                </c:otherwise>
                            </c:choose>
                            
                            <%-- Tính tỷ lệ phần trăm thanh tiến độ --%>
                            <c:choose>
                                <c:when test="${tierName == 'Diamond'}">
                                    <c:set var="percent" value="100"/>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="range" value="${maxPoints - minPoints}"/>
                                    <c:set var="progress" value="${currentPoints - minPoints}"/>
                                    <c:set var="percent" value="${(progress * 100) / (range > 0 ? range : 1)}"/>
                                    <c:if test="${percent < 0}"><c:set var="percent" value="0"/></c:if>
                                    <c:if test="${percent > 100}"><c:set var="percent" value="100"/></c:if>
                                </c:otherwise>
                            </c:choose>
                            
                            <%-- Số điểm cần đạt hạng tiếp theo --%>
                            <c:set var="pointsNeeded" value="${maxPoints - currentPoints}"/>
                            
                            <div class="member-popover" id="memberPopover">
                                <div class="popover-header">
                                    Hạng thành viên: <strong class="tier-${tierName.toLowerCase()}">${tierName}</strong>
                                </div>
                                <div class="popover-points">
                                    Điểm hiện tại: <strong>${currentPoints}</strong> điểm
                                </div>
                                
                                <c:choose>
                                    <c:when test="${tierName == 'Diamond'}">
                                        <div class="popover-progress-container">
                                            <div class="popover-progress-bar diamond" style="width: 100%;"></div>
                                        </div>
                                        <div class="popover-footer" style="color: var(--secondary); font-weight: 600;">
                                            <i class="fa-solid fa-crown"></i> Bạn đã đạt hạng cao nhất!
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="popover-progress-container">
                                            <div class="popover-progress-bar ${tierName.toLowerCase()}" style="width: ${percent}%;"></div>
                                        </div>
                                        <div class="popover-footer">
                                            Cần tích thêm <strong>${pointsNeeded}</strong> điểm để lên hạng <strong>${nextTier}</strong>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:if>

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

            <%-- Style CSS cho Huy hiệu và Popover thanh tiến độ --%>
            <style>
                .member-badge {
                    margin-left: 8px;
                    padding: 2px 8px;
                    font-size: 0.72rem;
                    border-radius: 50px;
                    cursor: pointer;
                    display: inline-block;
                    font-weight: 700;
                    text-transform: uppercase;
                    vertical-align: middle;
                    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                    transition: transform 0.2s ease;
                }
                .member-badge:hover {
                    transform: scale(1.05);
                }
                .member-badge.normal {
                    background: #94a3b8;
                    color: #ffffff;
                }
                .member-badge.silver {
                    background: linear-gradient(135deg, #cbd5e1 0%, #94a3b8 100%);
                    color: #1e293b;
                    border: 1px solid #cbd5e1;
                }
                .member-badge.gold {
                    background: linear-gradient(135deg, #fef08a 0%, #ca8a04 100%);
                    color: #713f12;
                    border: 1px solid #fef08a;
                    box-shadow: 0 0 8px rgba(234, 179, 8, 0.3);
                }
                .member-badge.diamond {
                    background: linear-gradient(135deg, #c084fc 0%, #7c3aed 100%);
                    color: #ffffff;
                    border: 1px solid #c084fc;
                    box-shadow: 0 0 8px rgba(124, 58, 237, 0.3);
                }

                .member-popover {
                    position: absolute;
                    right: 0;
                    top: calc(100% + 12px);
                    background: rgba(255, 255, 255, 0.98);
                    border: 1px solid #e2e8f0;
                    border-radius: 12px;
                    padding: 16px;
                    width: 280px;
                    box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.05);
                    z-index: 1000;
                    display: none;
                    text-align: left;
                    font-family: inherit;
                    color: #1e293b;
                }
                .member-popover::before {
                    content: '';
                    position: absolute;
                    top: -6px;
                    right: 35px;
                    width: 12px;
                    height: 12px;
                    background: #ffffff;
                    border-left: 1px solid #e2e8f0;
                    border-top: 1px solid #e2e8f0;
                    transform: rotate(45deg);
                }
                .member-popover.show {
                    display: block;
                    animation: slideDown 0.2s ease-out forwards;
                }

                @keyframes slideDown {
                    from { opacity: 0; transform: translateY(-8px); }
                    to { opacity: 1; transform: translateY(0); }
                }

                .popover-header {
                    font-size: 0.88rem;
                    font-weight: 600;
                    margin-bottom: 6px;
                    border-bottom: 1px solid #f1f5f9;
                    padding-bottom: 6px;
                }
                .popover-header strong {
                    text-transform: uppercase;
                }
                .popover-header strong.tier-silver { color: #475569; }
                .popover-header strong.tier-gold { color: #b45309; }
                .popover-header strong.tier-diamond { color: #6d28d9; }

                .popover-points {
                    font-size: 0.82rem;
                    color: #475569;
                    margin-bottom: 10px;
                }

                .popover-progress-container {
                    background: #e2e8f0;
                    height: 10px;
                    border-radius: 6px;
                    overflow: hidden;
                    margin-bottom: 8px;
                }
                .popover-progress-bar {
                    height: 100%;
                    border-radius: 6px;
                    transition: width 0.4s ease;
                }
                .popover-progress-bar.normal { background: #94a3b8; }
                .popover-progress-bar.silver { background: linear-gradient(90deg, #94a3b8, #cbd5e1); }
                .popover-progress-bar.gold { background: linear-gradient(90deg, #ca8a04, #fef08a); }
                .popover-progress-bar.diamond { background: linear-gradient(90deg, #7c3aed, #c084fc); }

                .popover-footer {
                    font-size: 0.78rem;
                    color: #64748b;
                    margin-top: 4px;
                    line-height: 1.3;
                }
            </style>

            <%-- JS Bật/Tắt Popover khi click vào Badge --%>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const badgeBtn = document.getElementById('memberBadgeBtn');
                    const popover = document.getElementById('memberPopover');

                    if (badgeBtn && popover) {
                        // Click vào Badge: Bật/Tắt Popover
                        badgeBtn.addEventListener('click', function (e) {
                            e.preventDefault();
                            e.stopPropagation();
                            popover.classList.toggle('show');
                        });

                        // Click bên trong Popover: Không ẩn
                        popover.addEventListener('click', function (e) {
                            e.stopPropagation();
                        });

                        // Click ra ngoài: Tự động ẩn Popover
                        document.addEventListener('click', function () {
                            popover.classList.remove('show');
                        });
                    }
                });
            </script>
        </div>
    </div>
</header>

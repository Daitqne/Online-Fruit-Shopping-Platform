<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer>
    <div class="footer-container">
        <div class="footer-column">
            <a href="${pageContext.request.contextPath}/home" class="footer-logo" style="text-decoration: none;">
                <i class="fa-solid fa-leaf"></i> GreenStock
            </a>
            <p class="footer-desc">Đơn vị tiên phong cung cấp trái cây tươi hữu cơ, mang đến bữa ăn an toàn và dinh dưỡng cho mọi gia đình Việt.</p>
            <div class="social-links">
                <a href="#" class="social-link"><i class="fa-brands fa-facebook-f"></i></a>
                <a href="#" class="social-link"><i class="fa-brands fa-instagram"></i></a>
                <a href="#" class="social-link"><i class="fa-brands fa-tiktok"></i></a>
                <a href="#" class="social-link"><i class="fa-brands fa-youtube"></i></a>
            </div>
        </div>

        <div class="footer-column">
            <h3>Về chúng tôi</h3>
            <ul class="footer-links">
                <li><a href="${pageContext.request.contextPath}/customer/about.jsp">Giới thiệu công ty</a></li>
                <li><a href="#">Hệ thống cửa hàng</a></li>
                <li><a href="#">Tuyển dụng</a></li>
                <li><a href="#">Tin tức & Sự kiện</a></li>
            </ul>
        </div>

        <div class="footer-column">
            <h3>Chính sách mua bán</h3>
            <ul class="footer-links">
                <li><a href="#">Chính sách giao nhận</a></li>
                <li><a href="#">Chính sách đổi trả hàng</a></li>
                <li><a href="#">Chính sách bảo mật</a></li>
                <li><a href="#">Hướng dẫn thanh toán</a></li>
            </ul>
        </div>

        <div class="footer-column">
            <h3>Liên hệ & Hỗ trợ</h3>
            <ul class="contact-info">
                <li>
                    <i class="fa-solid fa-location-dot"></i>
                    <span>Khu Công nghệ cao Hòa Lạc, Thạch Thất, Hà Nội, Việt Nam</span>
                </li>
                <li>
                    <i class="fa-solid fa-phone"></i>
                    <span>Hotline: 1900 8198</span>
                </li>
                <li>
                    <i class="fa-solid fa-envelope"></i>
                    <span>support@greenstock.vn</span>
                </li>
            </ul>
        </div>
    </div>

    <div class="footer-bottom">
        <p>&copy; 2026 GreenStock. All rights reserved. Designed with ❤️ for healthy living.</p>
        <div style="display: flex; gap: 1.5rem;">
            <a href="#" style="color: var(--slate-300); text-decoration: none;">Điều khoản sử dụng</a>
            <a href="#" style="color: var(--slate-300); text-decoration: none;">Bảo mật thông tin</a>
        </div>
    </div>
</footer>

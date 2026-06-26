<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Search Autocomplete JS -->
<script>window.contextPath = "${pageContext.request.contextPath}";</script>
<script src="${pageContext.request.contextPath}/js/search-autocomplete.js"></script>

<!-- Search Overlay Backdrop -->
<div class="header-search-overlay" id="search-overlay"></div>

<!-- Search Bar (mở ra khi click icon) -->
<div class="header-search-bar" id="header-search-bar">
    <form action="${pageContext.request.contextPath}/products" method="GET" style="position:relative;flex-grow:1;">
        <i class="fa-solid fa-magnifying-glass"></i>
        <input type="text" name="search" class="header-search-input" id="header-search-input"
               placeholder="Tìm kiếm trái cây... (nhấn Enter để tìm)" autocomplete="off">
        <div class="search-suggestions-dropdown" id="header-search-suggestions"></div>
    </form>
    <button class="header-search-close" id="search-close-btn" title="Đóng">
        <i class="fa-solid fa-xmark"></i>
    </button>
</div>

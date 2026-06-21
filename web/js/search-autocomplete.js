// --- SEARCH TOGGLE + AUTOCOMPLETE SUGGESTIONS FOR HEADER ---
document.addEventListener('DOMContentLoaded', function() {
    const toggleBtn   = document.getElementById('search-toggle-btn');
    const searchBar   = document.getElementById('header-search-bar');
    const overlay     = document.getElementById('search-overlay');
    const closeBtn    = document.getElementById('search-close-btn');
    const searchInput = document.getElementById('header-search-input');
    const dropdown    = document.getElementById('header-search-suggestions');

    if (!toggleBtn || !searchBar) return;

    // --- Mở search bar ---
    function openSearch() {
        searchBar.classList.add('active');
        overlay.classList.add('active');
        // Tự động focus vào ô nhập sau khi animation chạy xong
        setTimeout(function() { searchInput.focus(); }, 50);
    }

    // --- Đóng search bar ---
    function closeSearch() {
        searchBar.classList.remove('active');
        overlay.classList.remove('active');
        dropdown.style.display = 'none';
        dropdown.innerHTML = '';
        searchInput.value = '';
    }

    toggleBtn.addEventListener('click', openSearch);
    if (closeBtn) closeBtn.addEventListener('click', closeSearch);
    // Click overlay để đóng
    if (overlay) overlay.addEventListener('click', closeSearch);

    if (!searchInput || !dropdown) return;

    let debounceTimer;

    function formatVND(value) {
        return new Intl.NumberFormat('vi-VN').format(value) + 'đ';
    }

    searchInput.addEventListener('input', function() {
        clearTimeout(debounceTimer);
        var query = searchInput.value.trim();

        if (query.length === 0) {
            dropdown.innerHTML = '';
            dropdown.style.display = 'none';
            return;
        }

        var ctx = window.contextPath || '';

        debounceTimer = setTimeout(function() {
            fetch(ctx + '/api/search-suggestions?q=' + encodeURIComponent(query))
                .then(function(response) { return response.json(); })
                .then(function(products) {
                    dropdown.innerHTML = '';
                    if (products.length === 0) {
                        dropdown.innerHTML = '<div class="search-suggestion-no-result">Không tìm thấy sản phẩm phù hợp</div>';
                        dropdown.style.display = 'block';
                        return;
                    }

                    products.forEach(function(p) {
                        var item = document.createElement('a');
                        item.className = 'search-suggestion-item';
                        item.href = ctx + '/product-detail?id=' + p.id;

                        var hasDiscount = p.discountPrice > 0;
                        var displayPrice = hasDiscount ? p.discountPrice : p.price;

                        var priceHtml = '<span class="search-suggestion-price">' + formatVND(displayPrice) + '/' + p.unit + '</span>';
                        if (hasDiscount) {
                            priceHtml += '<span class="search-suggestion-old-price">' + formatVND(p.price) + '</span>';
                        }

                        item.innerHTML =
                            '<img src="' + p.image + '" class="search-suggestion-img" alt="' + p.name + '" onerror="this.src=\'https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?auto=format&fit=crop&q=80&w=600\'">' +
                            '<div class="search-suggestion-info">' +
                                '<span class="search-suggestion-name">' + p.name + '</span>' +
                                '<div class="search-suggestion-price-wrapper">' + priceHtml + '</div>' +
                            '</div>';
                        dropdown.appendChild(item);
                    });

                    dropdown.style.display = 'block';
                })
                .catch(function(err) {
                    console.error('Lỗi khi tải gợi ý:', err);
                });
        }, 300);
    });

    // Nhấn Escape để đóng
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') closeSearch();
    });
});

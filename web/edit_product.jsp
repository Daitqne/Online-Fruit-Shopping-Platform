<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa sản phẩm - GreenStock</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary: #10B981;
            --primary-hover: #059669;
            --primary-light: #E6F4EA;
            --secondary: #F59E0B;
            --dark: #0F172A;
            --light: #F8FAFC;
            --slate-200: #E2E8F0;
            --slate-300: #CBD5E1;
            --slate-400: #94A3B8;
            --slate-600: #475569;
            --white: #FFFFFF;
            --shadow-lg: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
            --font-display: 'Outfit', sans-serif;
            --font-body: 'Plus Jakarta Sans', sans-serif;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: var(--font-body);
            background: linear-gradient(135deg, #E6F4EA 0%, #FFFFFF 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 3rem 1rem;
        }
        .form-card {
            background: rgba(255, 255, 255, 0.92);
            backdrop-filter: blur(16px);
            width: 100%;
            max-width: 620px;
            border-radius: 24px;
            padding: 3rem;
            box-shadow: var(--shadow-lg);
            border: 1px solid rgba(255,255,255,0.8);
            position: relative;
        }
        .back-link {
            position: absolute;
            top: 1.5rem; left: 1.5rem;
            text-decoration: none;
            color: var(--slate-600);
            font-size: 0.9rem; font-weight: 600;
            display: flex; align-items: center; gap: 0.4rem;
            transition: color 0.2s;
        }
        .back-link:hover { color: var(--primary); }
        .header-title {
            text-align: center;
            margin-bottom: 2.5rem;
            margin-top: 1rem;
        }
        .header-title h1 {
            font-family: var(--font-display);
            font-size: 2rem; font-weight: 800;
            color: var(--secondary);
            display: inline-flex; align-items: center; gap: 0.5rem;
        }
        .header-title p { color: var(--slate-600); font-size: 0.95rem; margin-top: 0.5rem; }

        .badge-id {
            display: inline-flex; align-items: center; gap: 0.4rem;
            background: var(--primary-light); color: var(--primary-hover);
            padding: 0.3rem 0.8rem; border-radius: 50px;
            font-size: 0.82rem; font-weight: 700;
            margin-bottom: 1.5rem;
        }

        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; }
        .form-group { margin-bottom: 0; }
        .form-group.full-width { grid-column: span 2; }
        .form-group label {
            display: block; font-size: 0.9rem; font-weight: 700;
            margin-bottom: 0.5rem; color: var(--slate-600);
        }
        .form-group label span.required { color: #EF4444; margin-left: 0.2rem; }
        .form-group label span.optional { color: var(--slate-400); font-size: 0.8rem; font-weight: 500; margin-left: 0.3rem; }
        .input-wrapper { position: relative; display: flex; align-items: center; }
        .input-wrapper i { position: absolute; left: 1rem; color: var(--slate-400); transition: color 0.2s; }
        .form-control {
            width: 100%; padding: 0.8rem 1rem 0.8rem 2.5rem;
            border-radius: 12px; border: 1px solid var(--slate-300);
            background-color: var(--light);
            font-family: var(--font-body); font-size: 0.95rem;
            outline: none; transition: all 0.25s;
        }
        .form-control:focus {
            border-color: var(--secondary);
            background-color: var(--white);
            box-shadow: 0 0 0 4px rgba(245, 158, 11, 0.15);
        }
        textarea.form-control { padding: 0.8rem 1rem; min-height: 100px; resize: vertical; }
        .helper-text { display: block; font-size: 0.8rem; color: var(--slate-400); margin-top: 0.4rem; }
        .image-preview {
            width: 100%; height: 160px; object-fit: cover;
            border-radius: 12px; border: 1px solid var(--slate-200);
            margin-top: 0.75rem; display: block;
            background: var(--light);
        }
        .checkbox-group {
            display: flex; align-items: center; gap: 0.5rem;
            margin-top: 0.5rem; cursor: pointer;
            color: var(--slate-600); font-weight: 600; font-size: 0.95rem;
        }
        .checkbox-group input { accent-color: var(--secondary); width: 18px; height: 18px; cursor: pointer; }
        .btn-row {
            grid-column: span 2;
            display: flex; gap: 1rem; margin-top: 1rem;
        }
        .btn-submit {
            flex: 1;
            background-color: var(--secondary); color: var(--white);
            border: none; padding: 0.9rem;
            border-radius: 12px;
            font-family: var(--font-body); font-size: 1.05rem; font-weight: 700;
            cursor: pointer; transition: all 0.3s;
            box-shadow: 0 4px 10px rgba(245,158,11,0.2);
            display: flex; justify-content: center; align-items: center; gap: 0.5rem;
        }
        .btn-submit:hover {
            background-color: #D97706;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(245,158,11,0.3);
        }
        .btn-cancel {
            flex: 0.45;
            background-color: var(--light); color: var(--slate-600);
            border: 1px solid var(--slate-300); padding: 0.9rem;
            border-radius: 12px;
            font-family: var(--font-body); font-size: 1rem; font-weight: 600;
            cursor: pointer; text-decoration: none;
            display: flex; justify-content: center; align-items: center; gap: 0.4rem;
            transition: all 0.3s;
        }
        .btn-cancel:hover { background-color: var(--slate-200); color: var(--dark); }
        .error-message {
            background-color: #FEE2E2; border: 1px solid #FCA5A5; color: #DC2626;
            padding: 0.75rem; border-radius: 10px;
            font-size: 0.85rem; margin-bottom: 1.5rem;
            display: flex; align-items: center; gap: 0.5rem;
            grid-column: span 2;
        }
        @media (max-width: 580px) {
            .form-grid { grid-template-columns: 1fr; }
            .form-group.full-width, .btn-row, .error-message { grid-column: span 1; }
            .btn-row { flex-direction: column; }
            .btn-cancel { flex: 1; }
            .form-card { padding: 2rem 1.5rem; }
        }
    </style>
</head>
<body>
<div class="form-card">
    <a href="products" class="back-link"><i class="fa-solid fa-arrow-left"></i> Cửa hàng</a>

    <div class="header-title">
        <h1><i class="fa-solid fa-pen-to-square"></i> Chỉnh sửa sản phẩm</h1>
        <p>Cập nhật thông tin sản phẩm và lưu vào cơ sở dữ liệu.</p>
    </div>

    <c:if test="${product != null}">
        <div style="text-align:center; margin-bottom: 1.5rem;">
            <span class="badge-id"><i class="fa-solid fa-fingerprint"></i> ID: ${product.id}</span>
        </div>
    </c:if>

    <form action="edit-product" method="POST">
        <div class="form-grid">

            <%-- Error banner --%>
            <% if (request.getAttribute("error") != null) { %>
                <div class="error-message" style="grid-column: span 2;">
                    <i class="fa-solid fa-circle-exclamation"></i>
                    <span><%= request.getAttribute("error") %></span>
                </div>
            <% } %>

            <%-- Hidden id --%>
            <input type="hidden" name="id" value="${product.id}">

            <%-- Name --%>
            <div class="form-group full-width">
                <label for="name">Tên sản phẩm <span class="required">*</span></label>
                <div class="input-wrapper">
                    <input type="text" id="name" name="name" class="form-control"
                           placeholder="Nhập tên sản phẩm" value="${product.name}" required>
                    <i class="fa-solid fa-tag"></i>
                </div>
            </div>

            <%-- Price --%>
            <div class="form-group">
                <label for="price">Giá (VNĐ) <span class="optional">(Tùy chọn)</span></label>
                <div class="input-wrapper">
                    <input type="number" id="price" name="price" class="form-control"
                           placeholder="0" min="0" step="1000" value="${product.price}">
                    <i class="fa-solid fa-coins"></i>
                </div>
            </div>

            <%-- Category --%>
            <div class="form-group">
                <label for="category">Danh mục <span class="optional">(Tùy chọn)</span></label>
                <div class="input-wrapper">
                    <input type="text" id="category" name="category" class="form-control"
                           placeholder="Ví dụ: Trái cây nhập khẩu" value="${product.category}">
                    <i class="fa-solid fa-folder-open"></i>
                </div>
            </div>

            <%-- Image URL --%>
            <div class="form-group full-width">
                <label for="image">Đường dẫn ảnh <span class="optional">(Tùy chọn)</span></label>
                <div class="input-wrapper">
                    <input type="url" id="imageInput" name="image" class="form-control"
                           placeholder="https://..." value="${product.image}"
                           oninput="updatePreview(this.value)">
                    <i class="fa-solid fa-image"></i>
                </div>
                <span class="helper-text">Để trống → tự động dùng ảnh mặc định của cửa hàng.</span>
                <img id="imgPreview" class="image-preview"
                     src="${product.image}" alt="Xem trước ảnh"
                     onerror="this.src='https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?auto=format&fit=crop&q=80&w=600'">
            </div>

            <%-- Description --%>
            <div class="form-group full-width">
                <label for="description">Mô tả <span class="optional">(Tùy chọn)</span></label>
                <textarea id="description" name="description" class="form-control"
                          placeholder="Mô tả sản phẩm...">${product.description}</textarea>
            </div>

            <%-- Featured --%>
            <div class="form-group full-width">
                <label class="checkbox-group">
                    <input type="checkbox" name="isFeatured" ${product.featured ? 'checked' : ''}>
                    Hiển thị là sản phẩm nổi bật ở Trang chủ
                </label>
            </div>

            <%-- Buttons --%>
            <div class="btn-row">
                <button type="submit" class="btn-submit">
                    Lưu thay đổi <i class="fa-solid fa-floppy-disk"></i>
                </button>
                <a href="products" class="btn-cancel">
                    <i class="fa-solid fa-xmark"></i> Hủy
                </a>
            </div>

        </div>
    </form>
</div>

<script>
    function updatePreview(url) {
        const img = document.getElementById('imgPreview');
        img.src = url || 'https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?auto=format&fit=crop&q=80&w=600';
    }
</script>
</body>
</html>

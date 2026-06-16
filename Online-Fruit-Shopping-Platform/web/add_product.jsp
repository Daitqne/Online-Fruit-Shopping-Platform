<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm sản phẩm mới - GreenStock</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- FontAwesome Icons -->
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

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: var(--font-body);
            background: linear-gradient(135deg, #E6F4EA 0%, #FFFFFF 100%);
            color: var(--dark);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 3rem 1rem;
        }

        .form-card {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            width: 100%;
            max-width: 600px;
            border-radius: 24px;
            padding: 3rem;
            box-shadow: var(--shadow-lg);
            border: 1px solid rgba(255, 255, 255, 0.8);
            position: relative;
        }

        .back-link {
            position: absolute;
            top: 1.5rem;
            left: 1.5rem;
            text-decoration: none;
            color: var(--slate-600);
            font-size: 0.9rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.4rem;
            transition: color 0.2s ease;
        }

        .back-link:hover {
            color: var(--primary);
        }

        .header-title {
            text-align: center;
            margin-bottom: 2.5rem;
            margin-top: 1rem;
        }

        .header-title h1 {
            font-family: var(--font-display);
            font-size: 2.2rem;
            font-weight: 800;
            color: var(--primary);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .header-title i {
            color: var(--secondary);
        }

        .header-title p {
            color: var(--slate-600);
            font-size: 0.95rem;
            margin-top: 0.5rem;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group.full-width {
            grid-column: span 2;
        }

        .form-group label {
            display: block;
            font-size: 0.9rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: var(--slate-600);
        }

        .form-group label span.required {
            color: #EF4444;
            margin-left: 0.2rem;
        }

        .form-group label span.optional {
            color: var(--slate-400);
            font-size: 0.8rem;
            font-weight: 500;
            margin-left: 0.3rem;
        }

        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-wrapper i {
            position: absolute;
            left: 1rem;
            color: var(--slate-400);
            transition: color 0.2s ease;
        }

        .form-control {
            width: 100%;
            padding: 0.8rem 1rem 0.8rem 2.5rem;
            border-radius: 12px;
            border: 1px solid var(--slate-300);
            background-color: var(--light);
            font-family: var(--font-body);
            font-size: 0.95rem;
            outline: none;
            transition: all 0.25s ease;
        }

        .form-control:focus {
            border-color: var(--primary);
            background-color: var(--white);
            box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.15);
        }

        .form-control:focus + i {
            color: var(--primary);
        }

        textarea.form-control {
            padding: 0.8rem 1rem;
            min-height: 100px;
            resize: vertical;
        }

        .helper-text {
            display: block;
            font-size: 0.8rem;
            color: var(--slate-400);
            margin-top: 0.4rem;
        }

        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-top: 0.5rem;
            cursor: pointer;
            color: var(--slate-600);
            font-weight: 600;
            font-size: 0.95rem;
        }

        .checkbox-group input {
            accent-color: var(--primary);
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        .btn-submit {
            grid-column: span 2;
            background-color: var(--primary);
            color: var(--white);
            border: none;
            padding: 0.9rem;
            border-radius: 12px;
            font-family: var(--font-body);
            font-size: 1.05rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(16, 185, 129, 0.2);
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 0.5rem;
            margin-top: 1rem;
        }

        .btn-submit:hover {
            background-color: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(16, 185, 129, 0.3);
        }

        /* Error notification */
        .error-message {
            background-color: #FEE2E2;
            border: 1px solid #FCA5A5;
            color: #DC2626;
            padding: 0.75rem;
            border-radius: 10px;
            font-size: 0.85rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        @media (max-width: 580px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
            .form-group.full-width, .btn-submit {
                grid-column: span 1;
            }
            .form-card {
                padding: 2rem 1.5rem;
            }
        }
    </style>
</head>
<body>

    <div class="form-card">
        <!-- Back Button -->
        <a href="products" class="back-link">
            <i class="fa-solid fa-arrow-left"></i> Cửa hàng
        </a>

        <!-- Header -->
        <div class="header-title">
            <h1><i class="fa-solid fa-basket-shopping"></i> GreenStock</h1>
            <p>Tạo sản phẩm trái cây tươi sạch mới lưu vào cơ sở dữ liệu.</p>
        </div>

        <!-- Error Notification Banner if any -->
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message">
                <i class="fa-solid fa-circle-exclamation"></i>
                <span><%= request.getAttribute("error") %></span>
            </div>
        <% } %>

        <!-- Product Creation Form -->
        <form action="add-product" method="POST">
            <div class="form-grid">
                
                <!-- Product Name (Mandatory) -->
                <div class="form-group full-width">
                    <label for="name">Tên sản phẩm <span class="required">*</span></label>
                    <div class="input-wrapper">
                        <input type="text" id="name" name="name" class="form-control" placeholder="Nhập tên sản phẩm (ví dụ: Cherry Mỹ chín mọng)" required>
                        <i class="fa-solid fa-tag"></i>
                    </div>
                </div>

                <!-- Product Price (Optional, has defaults) -->
                <div class="form-group">
                    <label for="price">Giá sản phẩm <span class="optional">(Tùy chọn)</span></label>
                    <div class="input-wrapper">
                        <input type="number" id="price" name="price" class="form-control" placeholder="0" min="0" step="1000">
                        <i class="fa-solid fa-coins"></i>
                    </div>
                    <span class="helper-text">Đơn vị: VNĐ. Mặc định là 0đ.</span>
                </div>

                <!-- Product Category (Optional, has defaults) -->
                <div class="form-group">
                    <label for="category">Danh mục <span class="optional">(Tùy chọn)</span></label>
                    <div class="input-wrapper">
                        <input type="text" id="category" name="category" class="form-control" placeholder="Ví dụ: Trái cây nhập khẩu">
                        <i class="fa-solid fa-folder-open"></i>
                    </div>
                    <span class="helper-text">Mặc định: Trái cây khác</span>
                </div>

                <!-- Product Image URL (Optional, has fallback) -->
                <div class="form-group full-width">
                    <label for="image">Đường dẫn ảnh sản phẩm <span class="optional">(Tùy chọn)</span></label>
                    <div class="input-wrapper">
                        <input type="url" id="image" name="image" class="form-control" placeholder="https://unsplash.com/... (định dạng URL ảnh trực tiếp)">
                        <i class="fa-solid fa-image"></i>
                    </div>
                    <span class="helper-text">Để trống sẽ tự động hiển thị ảnh giỏ trái cây tươi sạch mặc định cực đẹp của cửa hàng.</span>
                </div>

                <!-- Product Description (Optional) -->
                <div class="form-group full-width">
                    <label for="description">Mô tả sản phẩm <span class="optional">(Tùy chọn)</span></label>
                    <textarea id="description" name="description" class="form-control" placeholder="Mô tả độ tươi ngon, xuất xứ, tác dụng sức khỏe của sản phẩm..."></textarea>
                </div>

                <!-- Featured Checkbox (Optional) -->
                <div class="form-group full-width">
                    <label class="checkbox-group">
                        <input type="checkbox" name="isFeatured" checked> Đánh dấu là sản phẩm nổi bật hiển thị ở Trang chủ
                    </label>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn-submit">
                    Lưu sản phẩm <i class="fa-solid fa-cloud-arrow-up"></i>
                </button>
                
            </div>
        </form>
    </div>

</body>
</html>

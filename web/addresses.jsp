<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Địa chỉ giao hàng - GreenStock</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            :root {
                --primary: #10B981; --primary-hover: #059669; --primary-light: #E6F4EA;
                --secondary: #F59E0B; --dark: #0F172A; --light: #F8FAFC;
                --slate-200: #E2E8F0; --slate-300: #CBD5E1; --slate-400: #94A3B8;
                --slate-600: #475569; --white: #FFFFFF;
                --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
                --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1);
                --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1);
                --font-display: 'Outfit', sans-serif;
                --font-body: 'Plus Jakarta Sans', sans-serif;
            }
            * { margin: 0; padding: 0; box-sizing: border-box; }
            body { font-family: var(--font-body); background: var(--light); color: var(--dark); }

            /* HEADER */
            header {
                position: fixed; top: 0; left: 0; right: 0; z-index: 1000;
                background: rgba(255,255,255,0.85); backdrop-filter: blur(16px);
                border-bottom: 1px solid rgba(226,232,240,0.8);
            }
            .nav-container {
                max-width: 1200px; margin: 0 auto; padding: 1rem 2rem;
                display: flex; justify-content: space-between; align-items: center;
            }
            .logo {
                font-family: var(--font-display); font-size: 1.6rem; font-weight: 800;
                color: var(--primary); text-decoration: none; display: flex; align-items: center; gap: 0.5rem;
            }
            .logo i { color: var(--secondary); }
            .nav-menu { display: flex; list-style: none; gap: 2rem; align-items: center; }
            .nav-link { text-decoration: none; color: var(--slate-600); font-weight: 600; transition: color 0.2s; }
            .nav-link:hover { color: var(--primary); }
            .user-menu { position: relative; display: flex; align-items: center; }
            .user-menu-btn {
                background: var(--primary-light); color: var(--primary); border: none;
                padding: 0.6rem 1.2rem; border-radius: 50px; font-weight: 600;
                cursor: pointer; display: flex; align-items: center; gap: 0.5rem;
                font-family: var(--font-body); transition: all 0.3s;
            }
            .user-menu-btn:hover { background: var(--primary); color: var(--white); }
            .user-dropdown {
                display: none; position: absolute; top: 100%; right: 0;
                background: var(--white); border-radius: 14px; box-shadow: var(--shadow-lg);
                border: 1px solid rgba(226,232,240,0.8); min-width: 180px; overflow: hidden; z-index: 1001;
            }
            .user-menu:hover .user-dropdown { display: block; }
            .user-dropdown a {
                display: flex; align-items: center; gap: 0.6rem; padding: 0.75rem 1.2rem;
                color: var(--dark); text-decoration: none; font-size: 0.9rem; transition: background 0.2s;
            }
            .user-dropdown a:hover { background: var(--primary-light); color: var(--primary); }
            .user-dropdown a.logout { color: #EF4444; border-top: 1px solid rgba(226,232,240,0.8); }
            .user-dropdown a.logout:hover { background: #FEF2F2; color: #DC2626; }
            .btn-login {
                background: var(--primary); color: var(--white); text-decoration: none;
                padding: 0.6rem 1.4rem; border-radius: 50px; font-weight: 600;
                display: flex; align-items: center; gap: 0.5rem;
            }

            /* MAIN LAYOUT */
            .page-wrapper {
                max-width: 900px; margin: 0 auto; padding: 100px 1.5rem 4rem;
                position: relative;
                z-index: 1;
            }

            .page-header {
                display: flex; justify-content: space-between; align-items: center;
                margin-bottom: 1.5rem;
            }
            .page-header h1 {
                font-family: var(--font-display); font-size: 1.6rem; font-weight: 800;
                display: flex; align-items: center; gap: 0.6rem;
            }
            .page-header h1 i { color: var(--primary); }
            .back-link {
                color: var(--slate-600); text-decoration: none; font-size: 0.9rem;
                display: flex; align-items: center; gap: 0.4rem; transition: color 0.2s;
            }
            .back-link:hover { color: var(--primary); }

            /* ALERTS */
            .alert {
                padding: 0.9rem 1.2rem; border-radius: 12px; margin-bottom: 1.2rem;
                display: flex; align-items: center; gap: 0.6rem; font-size: 0.9rem; font-weight: 500;
            }
            .alert-success { background: #DEF7EC; border: 1px solid #31C48D; color: #03543F; }
            .alert-error   { background: #FEF2F2; border: 1px solid #FECACA; color: #991B1B; }

            /* ADDRESS LIST */
            .address-list { display: flex; flex-direction: column; gap: 1rem; margin-bottom: 2rem; }

            .address-card {
                background: var(--white); border-radius: 16px; padding: 1.2rem 1.5rem;
                border: 2px solid var(--slate-200); display: flex;
                justify-content: space-between; align-items: flex-start;
                transition: border-color 0.2s;
            }
            .address-card.is-default { border-color: var(--primary); }

            .address-card-left { display: flex; flex-direction: column; gap: 0.4rem; }

            .address-label {
                display: flex; align-items: center; gap: 0.5rem;
                font-weight: 700; font-size: 0.95rem;
            }
            .badge-default {
                background: var(--primary-light); color: var(--primary);
                font-size: 0.7rem; font-weight: 700; padding: 0.15rem 0.6rem;
                border-radius: 50px; border: 1px solid var(--primary);
            }
            .address-receiver { font-size: 0.9rem; color: var(--dark); font-weight: 500; }
            .address-phone    { font-size: 0.85rem; color: var(--slate-600); }
            .address-details  { font-size: 0.85rem; color: var(--slate-600); max-width: 500px; }

            .address-card-actions { display: flex; gap: 0.5rem; flex-shrink: 0; margin-left: 1rem; }

            .btn-sm {
                padding: 0.4rem 0.9rem; border-radius: 8px; font-size: 0.8rem;
                font-weight: 600; text-decoration: none; border: none; cursor: pointer;
                display: flex; align-items: center; gap: 0.3rem; transition: all 0.2s;
                font-family: var(--font-body);
            }
            .btn-edit-sm  { background: #EFF6FF; color: #3B82F6; border: 1px solid #BFDBFE; }
            .btn-edit-sm:hover  { background: #3B82F6; color: var(--white); }
            .btn-delete-sm { background: #FEF2F2; color: #EF4444; border: 1px solid #FECACA; }
            .btn-delete-sm:hover { background: #EF4444; color: var(--white); }
            .btn-default-sm { background: var(--light); color: var(--slate-600); border: 1px solid var(--slate-300); }
            .btn-default-sm:hover { background: var(--primary-light); color: var(--primary); border-color: var(--primary); }

            .empty-state {
                text-align: center; padding: 3rem; background: var(--white);
                border-radius: 16px; border: 2px dashed var(--slate-300); color: var(--slate-400);
            }
            .empty-state i { font-size: 2.5rem; margin-bottom: 0.8rem; display: block; }

            /* FORM CARD */
            .form-card {
                background: var(--white); border-radius: 16px; padding: 1.5rem;
                border: 1px solid var(--slate-200); box-shadow: var(--shadow-sm);
            }
            .form-card h2 {
                font-family: var(--font-display); font-size: 1.1rem; font-weight: 700;
                margin-bottom: 1.2rem; display: flex; align-items: center; gap: 0.5rem;
                padding-bottom: 0.8rem; border-bottom: 1px solid var(--slate-200);
            }
            .form-card h2 i { color: var(--primary); }

            .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; }
            .form-group { display: flex; flex-direction: column; gap: 0.4rem; }
            .form-group.full-width { grid-column: span 2; }
            .form-group label { font-size: 0.82rem; font-weight: 600; color: var(--slate-600); }
            .form-group input, .form-group select {
                padding: 0.65rem 1rem; border-radius: 10px; border: 1px solid var(--slate-300);
                font-family: var(--font-body); font-size: 0.9rem; outline: none; transition: all 0.2s;
            }
            .form-group input:focus, .form-group select:focus {
                border-color: var(--primary); box-shadow: 0 0 0 3px rgba(16,185,129,0.1);
            }

            .checkbox-row {
                display: flex; align-items: center; gap: 0.6rem;
                font-size: 0.9rem; font-weight: 500; cursor: pointer;
                grid-column: span 2;
            }
            .checkbox-row input[type="checkbox"] { width: 16px; height: 16px; accent-color: var(--primary); }

            .form-actions { display: flex; gap: 0.75rem; margin-top: 1.2rem; justify-content: flex-end; }

            .btn-primary {
                background: var(--primary); color: var(--white); border: none;
                padding: 0.65rem 1.5rem; border-radius: 10px; font-weight: 600;
                font-size: 0.9rem; cursor: pointer; font-family: var(--font-body);
                display: flex; align-items: center; gap: 0.4rem; transition: all 0.2s;
            }
            .btn-primary:hover { background: var(--primary-hover); }
            .btn-cancel {
                background: var(--light); color: var(--slate-600); border: 1px solid var(--slate-300);
                padding: 0.65rem 1.5rem; border-radius: 10px; font-weight: 600;
                font-size: 0.9rem; text-decoration: none; display: flex; align-items: center; gap: 0.4rem;
                transition: all 0.2s;
            }
            .btn-cancel:hover { background: var(--slate-200); }

            /* ADD NEW BUTTON */
            .btn-add-new {
                display: inline-flex; align-items: center; gap: 0.5rem;
                background: var(--primary); color: var(--white); border: none;
                padding: 0.65rem 1.4rem; border-radius: 10px; font-weight: 600;
                font-size: 0.9rem; cursor: pointer; text-decoration: none;
                font-family: var(--font-body); transition: all 0.2s;
            }
            .btn-add-new:hover { background: var(--primary-hover); }

            @media (max-width: 600px) {
                .form-grid { grid-template-columns: 1fr; }
                .form-group.full-width { grid-column: span 1; }
                .checkbox-row { grid-column: span 1; }
                .address-card { flex-direction: column; gap: 1rem; }
                .address-card-actions { margin-left: 0; }
            }
        </style>
    </head>
    <body>

        <!-- HEADER -->
        <header>
            <div class="nav-container">
                <a href="home" class="logo">
                    <i class="fa-solid fa-leaf"></i> GreenStock
                </a>
                <div>
                    <a href="profile" class="btn-login">
                        <i class="fa-solid fa-arrow-left"></i> Quay lại hồ sơ
                    </a>
                </div>
            </div>
        </header>

        <div class="page-wrapper">

            <!-- PAGE HEADER -->
            <div class="page-header">
                <h1><i class="fa-solid fa-location-dot"></i> Địa chỉ giao hàng</h1>
            </div>

            <!-- ALERTS -->
            <c:if test="${param.success eq 'added'}">
                <div class="alert alert-success"><i class="fa-solid fa-circle-check"></i> Thêm địa chỉ thành công!</div>
            </c:if>
            <c:if test="${param.success eq 'updated'}">
                <div class="alert alert-success"><i class="fa-solid fa-circle-check"></i> Cập nhật địa chỉ thành công!</div>
            </c:if>
            <c:if test="${param.success eq 'deleted'}">
                <div class="alert alert-success"><i class="fa-solid fa-circle-check"></i> Đã xóa địa chỉ!</div>
            </c:if>
            <c:if test="${param.success eq 'default'}">
                <div class="alert alert-success"><i class="fa-solid fa-circle-check"></i> Đã đặt làm địa chỉ mặc định!</div>
            </c:if>
            <c:if test="${param.success eq 'error'}">
                <div class="alert alert-error"><i class="fa-solid fa-circle-xmark"></i> Có lỗi xảy ra, vui lòng thử lại!</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fa-solid fa-circle-xmark"></i> 
                    <div>${error}</div>
                </div>
            </c:if>

            <!-- DANH SÁCH ĐỊA CHỈ -->
            <div class="address-list">
                <c:choose>
                    <c:when test="${not empty addresses}">
                        <c:forEach var="addr" items="${addresses}">
                            <div class="address-card ${addr['default'] ? 'is-default' : ''}">
                                <div class="address-card-left">
                                    <div class="address-label">
                                        <i class="fa-solid fa-location-dot" style="color: var(--primary);"></i>
                                        ${addr.label}
                                        <c:if test="${addr['default']}">
                                            <span class="badge-default">Mặc định</span>
                                        </c:if>
                                    </div>
                                    <div class="address-receiver"><i class="fa-solid fa-user" style="width:14px;color:var(--slate-400);"></i> ${addr.receiverName}</div>
                                    <div class="address-phone"><i class="fa-solid fa-phone" style="width:14px;color:var(--slate-400);"></i> ${addr.receiverPhone}</div>
                                    <div class="address-details"><i class="fa-solid fa-map-pin" style="width:14px;color:var(--slate-400);"></i> ${addr.addressDetails}</div>
                                </div>
                                <div class="address-card-actions">
                                    <c:if test="${!addr['default']}">
                                        <a href="address?action=setDefault&id=${addr.addressId}" class="btn-sm btn-default-sm" title="Đặt mặc định">
                                            <i class="fa-solid fa-star"></i> Mặc định
                                        </a>
                                    </c:if>
                                    <a href="address?action=edit&id=${addr.addressId}" class="btn-sm btn-edit-sm">
                                        <i class="fa-solid fa-pen"></i> Sửa
                                    </a>
                                    <a href="address?action=delete&id=${addr.addressId}"
                                       class="btn-sm btn-delete-sm"
                                       onclick="return confirm('Bạn có chắc muốn xóa địa chỉ này không?')">
                                        <i class="fa-solid fa-trash"></i> Xóa
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fa-solid fa-location-dot"></i>
                            <p>Bạn chưa có địa chỉ giao hàng nào.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- FORM THÊM / SỬA ĐỊA CHỈ -->
            <div class="form-card">
                <h2>
                    <i class="fa-solid fa-${not empty editAddress ? 'pen' : 'plus'}"></i>
                    ${not empty editAddress ? 'Chỉnh sửa địa chỉ' : 'Thêm địa chỉ mới'}
                </h2>

                <form action="address" method="POST">
                    <input type="hidden" name="action" value="${not empty editAddress ? 'edit' : 'add'}">
                    <c:if test="${not empty editAddress}">
                        <input type="hidden" name="addressId" value="${editAddress.addressId}">
                    </c:if>

                    <div class="form-grid">
                        <div class="form-group">
                            <label>Nhãn địa chỉ <span style="color:#EF4444;">*</span></label>
                            <input type="text" name="label" placeholder="VD: Nhà riêng, Văn phòng..."
                                   value="${not empty editAddress ? editAddress.label : (not empty inputLabel ? inputLabel : '')}" 
                                   required maxlength="50">
                        </div>
                        <div class="form-group">
                            <label>Người nhận <span style="color:#EF4444;">*</span></label>
                            <input type="text" name="receiverName" placeholder="Họ và tên người nhận"
                                   value="${not empty editAddress ? editAddress.receiverName : (not empty inputReceiverName ? inputReceiverName : '')}" 
                                   required maxlength="150">
                        </div>
                        <div class="form-group">
                            <label>Số điện thoại <span style="color:#EF4444;">*</span></label>
                            <input type="tel" name="receiverPhone" placeholder="VD: 0912345678" pattern="0[0-9]{9,10}"
                                   value="${not empty editAddress ? editAddress.receiverPhone : (not empty inputReceiverPhone ? inputReceiverPhone : '')}" 
                                   required maxlength="20">
                            <small style="color: #64748b; font-size: 0.8rem; margin-top: 0.25rem; display: block;">
                                <i class="fa-solid fa-circle-info"></i> Số điện thoại 10-11 số, bắt đầu bằng 0
                            </small>
                        </div>
                        <div class="form-group full-width">
                            <label>Địa chỉ chi tiết <span style="color:#EF4444;">*</span></label>
                            <input type="text" name="addressDetails" placeholder="Số nhà, đường, phường/xã, quận/huyện, tỉnh/thành phố"
                                   value="${not empty editAddress ? editAddress.addressDetails : (not empty inputAddressDetails ? inputAddressDetails : '')}" 
                                   required minlength="10" maxlength="500">
                            <small style="color: #64748b; font-size: 0.8rem; margin-top: 0.25rem; display: block;">
                                <i class="fa-solid fa-circle-info"></i> Tối thiểu 10 ký tự, tối đa 500 ký tự
                            </small>
                        </div>
                        <label class="checkbox-row">
                        <input type="checkbox" name="isDefault" ${(not empty editAddress && editAddress['default']) || (not empty inputIsDefault && inputIsDefault) ? 'checked' : ''}>
                            Đặt làm địa chỉ mặc định
                        </label>
                    </div>

                    <div class="form-actions">
                        <c:if test="${not empty editAddress}">
                            <a href="address" class="btn-cancel"><i class="fa-solid fa-xmark"></i> Hủy</a>
                        </c:if>
                        <button type="submit" class="btn-primary">
                            <i class="fa-solid fa-${not empty editAddress ? 'floppy-disk' : 'plus'}"></i>
                            ${not empty editAddress ? 'Lưu thay đổi' : 'Thêm địa chỉ'}
                        </button>
                    </div>
                </form>
            </div>

        </div>

    </body>
</html>

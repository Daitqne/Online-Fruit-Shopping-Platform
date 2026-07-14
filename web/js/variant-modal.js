// Global function to open the variant selection modal
function openVariantModal(productId, productName, image, unit, basePrice, discountPrice, weightVariants, packagingOptions, onConfirm) {
    // Remove existing modal if any
    const existing = document.getElementById('variantSelectionModal');
    if (existing) existing.remove();

    // Create modal element
    const modal = document.createElement('div');
    modal.id = 'variantSelectionModal';
    modal.style = `
        position: fixed; top: 0; left: 0; width: 100%; height: 100%;
        background: rgba(15, 23, 42, 0.6); backdrop-filter: blur(4px);
        display: flex; justify-content: center; align-items: center; z-index: 99999;
        font-family: 'Plus Jakarta Sans', sans-serif;
    `;

    // Modal Content box
    const modalContent = document.createElement('div');
    modalContent.style = `
        background: #fff; width: 90%; max-width: 480px; padding: 1.5rem;
        border-radius: 16px; box-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.1);
        position: relative; animation: slideUp 0.3s ease;
    `;

    // Style keyframe
    const style = document.createElement('style');
    style.innerHTML = `
        @keyframes slideUp {
            from { transform: translateY(20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        .modal-pill {
            background: #F1F5F9; border: 2px solid transparent; padding: 0.5rem 1rem;
            border-radius: 50px; font-weight: 600; cursor: pointer; transition: all 0.2s;
            display: inline-flex; align-items: center; gap: 0.25rem; font-size: 0.85rem;
            user-select: none;
        }
        .modal-pill.active {
            border-color: #10B981; background: #E6F4EA; color: #10B981;
        }
        .modal-btn {
            width: 100%; padding: 0.75rem; border-radius: 8px; font-weight: 700;
            border: none; cursor: pointer; transition: all 0.2s;
        }
        .modal-btn-confirm { background: #10B981; color: #fff; }
        .modal-btn-confirm:hover { background: #059669; }
        .modal-qty-btn {
            width: 32px; height: 32px; border-radius: 50%; border: 1px solid #CBD5E1;
            background: #fff; font-weight: bold; cursor: pointer; display: flex;
            align-items: center; justify-content: center; transition: all 0.2s;
            user-select: none;
        }
        .modal-qty-btn:hover { background: #F1F5F9; }
    `;
    document.head.appendChild(style);

    // Initial variables
    const initialPrice = discountPrice > 0 && discountPrice < basePrice ? discountPrice : basePrice;
    let selectedWeightAdjustment = 0;
    let selectedPackagingAdjustment = 0;
    let selectedWeightId = null;
    let selectedPackagingId = null;
    let qty = 1;
    let selectedWeightLabel = weightVariants && weightVariants.length > 0 ? weightVariants[0].weightLabel : '';

    const unitLower = unit ? unit.toLowerCase().trim() : '';
    const isKg = (unitLower === 'kg' || unitLower === 'kilogam' || unitLower === 'kí' || unitLower === 'ky');

    function parseWeightToKg(label) {
        if (!label) return 1.0;
        label = label.toLowerCase().trim().replace(',', '.');
        
        let gMatch = label.match(/^([0-9.]+)\s*(g|gr|gram|grams)$/);
        if (gMatch) {
            return parseFloat(gMatch[1]) / 1000.0;
        }
        
        let kgMatch = label.match(/^([0-9.]+)\s*(kg|kilo|kilogam|ký|ky)$/);
        if (kgMatch) {
            return parseFloat(kgMatch[1]);
        }
        
        let numMatch = label.match(/^([0-9.]+)/);
        if (numMatch) {
            let val = parseFloat(numMatch[1]);
            if (val >= 50) {
                return val / 1000.0;
            } else {
                return val;
            }
        }
        return 1.0;
    }

    // Helper to calculate price
    function getPrice() {
        const multiplier = isKg ? parseWeightToKg(selectedWeightLabel) : 1.0;
        return ((initialPrice * multiplier) + selectedWeightAdjustment + selectedPackagingAdjustment) * qty;
    }

    function formatPrice(val) {
        return val.toLocaleString('vi-VN') + 'đ';
    }

    function updateModalPrice() {
        modalContent.querySelector('.modal-price-display').innerText = formatPrice(getPrice());
    }

    // Build the inner HTML
    let html = `
        <button type="button" class="modal-close-btn" style="position: absolute; top: 1rem; right: 1rem; border: none; background: none; font-size: 1.25rem; cursor: pointer; color: #64748B;">&times;</button>
        <div style="display: flex; gap: 1rem; margin-bottom: 1.25rem;">
            <img src="${image}" style="width: 80px; height: 80px; object-fit: cover; border-radius: 8px;" onerror="this.src='https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?auto=format&amp;fit=crop&amp;q=80&amp;w=200'">
            <div>
                <h4 style="font-size: 1.1rem; font-weight: 700; color: #0F172A; margin-bottom: 0.25rem;">${productName}</h4>
                <div style="font-size: 0.85rem; color: #64748B; margin-bottom: 0.5rem;">Đơn vị: ${unit}</div>
                <div class="modal-price-display" style="font-size: 1.2rem; font-weight: 800; color: #10B981;">${formatPrice(getPrice())}</div>
            </div>
        </div>
    `;

    // Weight variants selection
    if (weightVariants && weightVariants.length > 0) {
        // Set first weight variant as active
        selectedWeightId = weightVariants[0].variantId;
        selectedWeightAdjustment = weightVariants[0].priceAdjustment;
        
        html += `
            <div style="margin-bottom: 1rem;">
                <label style="display: block; font-size: 0.85rem; font-weight: 700; color: #334155; margin-bottom: 0.5rem;">Trọng lượng:</label>
                <div class="weight-pills-container" style="display: flex; flex-wrap: wrap; gap: 0.5rem;">
        `;
        weightVariants.forEach((v, index) => {
            const adjText = v.priceAdjustment !== 0 ? ` (${v.priceAdjustment > 0 ? '+' : ''}${formatPrice(v.priceAdjustment)})` : '';
            html += `
                <div class="modal-pill weight-pill ${index === 0 ? 'active' : ''}" data-id="${v.variantId}" data-adjustment="${v.priceAdjustment}" data-label="${v.weightLabel}">
                    ${v.weightLabel}${adjText}
                </div>
            `;
        });
        html += `
                </div>
            </div>
        `;
    }

    // Packaging options selection
    if (packagingOptions && packagingOptions.length > 0) {
        html += `
            <div style="margin-bottom: 1rem;">
                <label style="display: block; font-size: 0.85rem; font-weight: 700; color: #334155; margin-bottom: 0.5rem;">Đóng gói:</label>
                <div class="packaging-pills-container" style="display: flex; flex-wrap: wrap; gap: 0.5rem;">
                    <div class="modal-pill packaging-pill active" data-id="" data-adjustment="0">Mặc định</div>
        `;
        packagingOptions.forEach(k => {
            const adjText = k.priceAdjustment !== 0 ? ` (${k.priceAdjustment > 0 ? '+' : ''}${formatPrice(k.priceAdjustment)})` : '';
            html += `
                <div class="modal-pill packaging-pill" data-id="${k.packagingId}" data-adjustment="${k.priceAdjustment}">
                    ${k.packagingName}${adjText}
                </div>
            `;
        });
        html += `
                </div>
            </div>
        `;
    }

    // Quantity selector
    html += `
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; border-top: 1px solid #E2E8F0; padding-top: 1rem;">
            <label style="font-size: 0.85rem; font-weight: 700; color: #334155;">Số lượng:</label>
            <div style="display: flex; align-items: center; gap: 0.75rem;">
                <button type="button" class="modal-qty-btn qty-dec">−</button>
                <span class="modal-qty-val" style="font-weight: bold; font-size: 1rem; width: 24px; text-align: center;">1</span>
                <button type="button" class="modal-qty-btn qty-inc">+</button>
            </div>
        </div>
        <button type="button" class="modal-btn modal-btn-confirm">Xác nhận thêm vào giỏ</button>
    `;

    modalContent.innerHTML = html;
    modal.appendChild(modalContent);
    document.body.appendChild(modal);

    // Event listeners
    const closeBtn = modalContent.querySelector('.modal-close-btn');
    closeBtn.onclick = () => modal.remove();

    // Click outside to close
    modal.onclick = (e) => {
        if (e.target === modal) modal.remove();
    };

    // Weight pills click
    modalContent.querySelectorAll('.weight-pill').forEach(pill => {
        pill.onclick = () => {
            modalContent.querySelectorAll('.weight-pill').forEach(p => p.classList.remove('active'));
            pill.classList.add('active');
            selectedWeightId = parseInt(pill.getAttribute('data-id'));
            selectedWeightAdjustment = parseFloat(pill.getAttribute('data-adjustment'));
            selectedWeightLabel = pill.getAttribute('data-label') || '';
            updateModalPrice();
        };
    });

    // Packaging pills click
    modalContent.querySelectorAll('.packaging-pill').forEach(pill => {
        pill.onclick = () => {
            modalContent.querySelectorAll('.packaging-pill').forEach(p => p.classList.remove('active'));
            pill.classList.add('active');
            const idVal = pill.getAttribute('data-id');
            selectedPackagingId = idVal ? parseInt(idVal) : null;
            selectedPackagingAdjustment = parseFloat(pill.getAttribute('data-adjustment'));
            updateModalPrice();
        };
    });

    // Qty decrease
    modalContent.querySelector('.qty-dec').onclick = () => {
        if (qty > 1) {
            qty--;
            modalContent.querySelector('.modal-qty-val').innerText = qty;
            updateModalPrice();
        }
    };

    // Qty increase
    modalContent.querySelector('.qty-inc').onclick = () => {
        qty++;
        modalContent.querySelector('.modal-qty-val').innerText = qty;
        updateModalPrice();
    };

    // Confirm button click
    modalContent.querySelector('.modal-btn-confirm').onclick = () => {
        onConfirm(qty, selectedWeightId, selectedPackagingId);
        modal.remove();
    };
}

package model;

import java.sql.Date;

/**
 * Chi tiết từng dòng sản phẩm trong phiếu nhập kho.
 */
public class ImportReceiptItem {
    private int itemId;
    private int receiptId;
    private int productId;
    private int quantity;
    private Date manufactureDate; // Ngày sản xuất (tùy chọn)
    private Date expiryDate;      // Ngày hết hạn (bắt buộc)
    private String batchNumber;   // Mã lô tự động sinh

    // Join field — thông tin sản phẩm để hiển thị
    private Product product;

    public ImportReceiptItem() {}

    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }

    public int getReceiptId() { return receiptId; }
    public void setReceiptId(int receiptId) { this.receiptId = receiptId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public Date getManufactureDate() { return manufactureDate; }
    public void setManufactureDate(Date manufactureDate) { this.manufactureDate = manufactureDate; }

    public Date getExpiryDate() { return expiryDate; }
    public void setExpiryDate(Date expiryDate) { this.expiryDate = expiryDate; }

    public String getBatchNumber() { return batchNumber; }
    public void setBatchNumber(String batchNumber) { this.batchNumber = batchNumber; }

    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }

    @Override
    public String toString() {
        return "ImportReceiptItem{productId=" + productId + ", qty=" + quantity
                + ", expiry=" + expiryDate + ", batch=" + batchNumber + "}";
    }
}

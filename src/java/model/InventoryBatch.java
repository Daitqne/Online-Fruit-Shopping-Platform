package model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * Model cho bảng Inventory_Batch - quản lý tồn kho theo lô với FEFO.
 */
public class InventoryBatch {
    private int batchId;
    private int productId;
    private int receiptItemId;
    private String batchNumber;
    private int quantityIn;        // Số lượng nhập ban đầu
    private int quantityRemain;    // Số lượng còn lại
    private Date manufactureDate;
    private Date expiryDate;
    private Timestamp createdAt;
    
    // Join field
    private Product product;

    public InventoryBatch() {}

    public int getBatchId() {
        return batchId;
    }

    public void setBatchId(int batchId) {
        this.batchId = batchId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getReceiptItemId() {
        return receiptItemId;
    }

    public void setReceiptItemId(int receiptItemId) {
        this.receiptItemId = receiptItemId;
    }

    public String getBatchNumber() {
        return batchNumber;
    }

    public void setBatchNumber(String batchNumber) {
        this.batchNumber = batchNumber;
    }

    public int getQuantityIn() {
        return quantityIn;
    }

    public void setQuantityIn(int quantityIn) {
        this.quantityIn = quantityIn;
    }

    public int getQuantityRemain() {
        return quantityRemain;
    }

    public void setQuantityRemain(int quantityRemain) {
        this.quantityRemain = quantityRemain;
    }

    public Date getManufactureDate() {
        return manufactureDate;
    }

    public void setManufactureDate(Date manufactureDate) {
        this.manufactureDate = manufactureDate;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
    
    /**
     * Kiểm tra lô đã hết hạn chưa.
     */
    public boolean isExpired() {
        if (expiryDate == null) return false;
        return expiryDate.before(new Date(System.currentTimeMillis()));
    }
    
    /**
     * Kiểm tra lô sắp hết hạn (< 7 ngày).
     */
    public boolean isExpiringSoon() {
        if (expiryDate == null) return false;
        long now = System.currentTimeMillis();
        long expiryTime = expiryDate.getTime();
        long daysRemaining = (expiryTime - now) / (1000 * 60 * 60 * 24);
        return daysRemaining > 0 && daysRemaining <= 7;
    }

    @Override
    public String toString() {
        return "InventoryBatch{" +
                "batchId=" + batchId +
                ", productId=" + productId +
                ", batchNumber='" + batchNumber + '\'' +
                ", quantityIn=" + quantityIn +
                ", quantityRemain=" + quantityRemain +
                ", expiryDate=" + expiryDate +
                '}';
    }
}

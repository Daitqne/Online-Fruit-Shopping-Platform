package model;

import java.sql.Date;

public class ImportOrderItem {
    private int importItemId;
    private int importOrderId;
    private int productId;
    private int quantity;
    private double importPrice;
    private Date expiredDate;
    
    // Join field
    private Product product;

    public ImportOrderItem() {
    }

    public ImportOrderItem(int importItemId, int importOrderId, int productId, int quantity, double importPrice, Date expiredDate) {
        this.importItemId = importItemId;
        this.importOrderId = importOrderId;
        this.productId = productId;
        this.quantity = quantity;
        this.importPrice = importPrice;
        this.expiredDate = expiredDate;
    }

    public int getImportItemId() {
        return importItemId;
    }

    public void setImportItemId(int importItemId) {
        this.importItemId = importItemId;
    }

    public int getImportOrderId() {
        return importOrderId;
    }

    public void setImportOrderId(int importOrderId) {
        this.importOrderId = importOrderId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getImportPrice() {
        return importPrice;
    }

    public void setImportPrice(double importPrice) {
        this.importPrice = importPrice;
    }

    public Date getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(Date expiredDate) {
        this.expiredDate = expiredDate;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @Override
    public String toString() {
        return "ImportOrderItem{" +
                "importItemId=" + importItemId +
                ", importOrderId=" + importOrderId +
                ", productId=" + productId +
                ", quantity=" + quantity +
                ", importPrice=" + importPrice +
                ", expiredDate=" + expiredDate +
                '}';
    }
}

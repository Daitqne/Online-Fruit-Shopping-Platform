package model;

public class SaleOrderItem {
    private int saleItemId;
    private int saleOrderId;
    private int productId;
    private int quantity;
    private double unitPrice;
    
    // Join field
    private Product product;

    public SaleOrderItem() {
    }

    public SaleOrderItem(int saleItemId, int saleOrderId, int productId, int quantity, double unitPrice) {
        this.saleItemId = saleItemId;
        this.saleOrderId = saleOrderId;
        this.productId = productId;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    public int getSaleItemId() {
        return saleItemId;
    }

    public void setSaleItemId(int saleItemId) {
        this.saleItemId = saleItemId;
    }

    public int getSaleOrderId() {
        return saleOrderId;
    }

    public void setSaleOrderId(int saleOrderId) {
        this.saleOrderId = saleOrderId;
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

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @Override
    public String toString() {
        return "SaleOrderItem{" +
                "saleItemId=" + saleItemId +
                ", saleOrderId=" + saleOrderId +
                ", productId=" + productId +
                ", quantity=" + quantity +
                ", unitPrice=" + unitPrice +
                '}';
    }
}

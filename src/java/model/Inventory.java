package model;

import java.sql.Timestamp;

public class Inventory {
    private int inventoryId;
    private int productId;
    private int quantity;
    private Timestamp lastUpdated;

    public Inventory() {
    }

    public Inventory(int inventoryId, int productId, int quantity, Timestamp lastUpdated) {
        this.inventoryId = inventoryId;
        this.productId = productId;
        this.quantity = quantity;
        this.lastUpdated = lastUpdated;
    }

    public int getInventoryId() {
        return inventoryId;
    }

    public void setInventoryId(int inventoryId) {
        this.inventoryId = inventoryId;
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

    public Timestamp getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(Timestamp lastUpdated) {
        this.lastUpdated = lastUpdated;
    }

    @Override
    public String toString() {
        return "Inventory{" +
                "inventoryId=" + inventoryId +
                ", productId=" + productId +
                ", quantity=" + quantity +
                ", lastUpdated=" + lastUpdated +
                '}';
    }
}

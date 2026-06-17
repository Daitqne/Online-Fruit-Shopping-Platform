package model;

import java.sql.Timestamp;

public class ProductImage {
    private int imageId;
    private int productId;
    private String imageUrl;
    private Timestamp createdAt;

    public ProductImage() {
    }

    public ProductImage(int imageId, int productId, String imageUrl, Timestamp createdAt) {
        this.imageId = imageId;
        this.productId = productId;
        this.imageUrl = imageUrl;
        this.createdAt = createdAt;
    }

    public int getImageId() {
        return imageId;
    }

    public void setImageId(int imageId) {
        this.imageId = imageId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "ProductImage{" +
                "imageId=" + imageId +
                ", productId=" + productId +
                ", imageUrl='" + imageUrl + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}

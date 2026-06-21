package model;

/**
 * Model class representing a packaging option of a product.
 */
public class PackagingOption {
    private int packagingId;
    private int productId;
    private String packagingName;
    private double priceAdjustment;

    public PackagingOption() {
    }

    public PackagingOption(int packagingId, int productId, String packagingName, double priceAdjustment) {
        this.packagingId = packagingId;
        this.productId = productId;
        this.packagingName = packagingName;
        this.priceAdjustment = priceAdjustment;
    }

    public int getPackagingId() {
        return packagingId;
    }

    public void setPackagingId(int packagingId) {
        this.packagingId = packagingId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getPackagingName() {
        return packagingName;
    }

    public void setPackagingName(String packagingName) {
        this.packagingName = packagingName;
    }

    public double getPriceAdjustment() {
        return priceAdjustment;
    }

    public void setPriceAdjustment(double priceAdjustment) {
        this.priceAdjustment = priceAdjustment;
    }

    @Override
    public String toString() {
        return "PackagingOption{" +
                "packagingId=" + packagingId +
                ", productId=" + productId +
                ", packagingName='" + packagingName + '\'' +
                ", priceAdjustment=" + priceAdjustment +
                '}';
    }
}

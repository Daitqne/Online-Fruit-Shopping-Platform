package model;

/**
 * Model class representing a weight variant of a product.
 */
public class WeightVariant {
    private int variantId;
    private int productId;
    private String weightLabel;
    private double priceAdjustment;

    public WeightVariant() {
    }

    public WeightVariant(int variantId, int productId, String weightLabel, double priceAdjustment) {
        this.variantId = variantId;
        this.productId = productId;
        this.weightLabel = weightLabel;
        this.priceAdjustment = priceAdjustment;
    }

    public int getVariantId() {
        return variantId;
    }

    public void setVariantId(int variantId) {
        this.variantId = variantId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getWeightLabel() {
        return weightLabel;
    }

    public void setWeightLabel(String weightLabel) {
        this.weightLabel = weightLabel;
    }

    public double getPriceAdjustment() {
        return priceAdjustment;
    }

    public void setPriceAdjustment(double priceAdjustment) {
        this.priceAdjustment = priceAdjustment;
    }

    @Override
    public String toString() {
        return "WeightVariant{" +
                "variantId=" + variantId +
                ", productId=" + productId +
                ", weightLabel='" + weightLabel + '\'' +
                ", priceAdjustment=" + priceAdjustment +
                '}';
    }
}

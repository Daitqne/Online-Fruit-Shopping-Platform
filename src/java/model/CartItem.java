package model;

public class CartItem {
    private int cartItemId;
    private int cartId;
    private int productId;
    private int quantity;
    private Integer variantId;
    private Integer packagingId;
    
    // Joint fields for convenient display in JSP
    private Product product;
    private String weightLabel;
    private double variantPriceAdjustment;
    private String packagingName;
    private double packagingPriceAdjustment;

    public CartItem() {
    }

    public CartItem(int cartItemId, int cartId, int productId, int quantity) {
        this.cartItemId = cartItemId;
        this.cartId = cartId;
        this.productId = productId;
        this.quantity = quantity;
    }

    public int getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(int cartItemId) {
        this.cartItemId = cartItemId;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
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

    public Integer getVariantId() {
        return variantId;
    }

    public void setVariantId(Integer variantId) {
        this.variantId = variantId;
    }

    public Integer getPackagingId() {
        return packagingId;
    }

    public void setPackagingId(Integer packagingId) {
        this.packagingId = packagingId;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public String getWeightLabel() {
        return weightLabel;
    }

    public void setWeightLabel(String weightLabel) {
        this.weightLabel = weightLabel;
    }

    public double getVariantPriceAdjustment() {
        return variantPriceAdjustment;
    }

    public void setVariantPriceAdjustment(double variantPriceAdjustment) {
        this.variantPriceAdjustment = variantPriceAdjustment;
    }

    public String getPackagingName() {
        return packagingName;
    }

    public void setPackagingName(String packagingName) {
        this.packagingName = packagingName;
    }

    public double getPackagingPriceAdjustment() {
        return packagingPriceAdjustment;
    }

    public void setPackagingPriceAdjustment(double packagingPriceAdjustment) {
        this.packagingPriceAdjustment = packagingPriceAdjustment;
    }

    public double getEffectiveUnitPrice() {
        if (product == null) return 0;
        return product.getEffectivePrice() + variantPriceAdjustment + packagingPriceAdjustment;
    }

    @Override
    public String toString() {
        return "CartItem{" +
                "cartItemId=" + cartItemId +
                ", cartId=" + cartId +
                ", productId=" + productId +
                ", quantity=" + quantity +
                ", variantId=" + variantId +
                ", packagingId=" + packagingId +
                '}';
    }
}

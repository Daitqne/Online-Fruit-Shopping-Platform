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

    public double getWeightMultiplier() {
        if (weightLabel == null) return 1.0;
        if (product == null || product.getUnit() == null) return 1.0;
        String unit = product.getUnit().toLowerCase().trim();
        if (!unit.equals("kg") && !unit.equals("kilogam") && !unit.equals("kí") && !unit.equals("ky")) {
            return 1.0;
        }
        
        String label = weightLabel.toLowerCase().trim().replace(',', '.');
        
        // Match g/gr/gram
        java.util.regex.Pattern gPattern = java.util.regex.Pattern.compile("^([0-9.]+)\\s*(g|gr|gram|grams)$");
        java.util.regex.Matcher gMatcher = gPattern.matcher(label);
        if (gMatcher.matches()) {
            try {
                return Double.parseDouble(gMatcher.group(1)) / 1000.0;
            } catch (NumberFormatException e) {
                // Ignore
            }
        }
        
        // Match kg/kilo/kilogam/ký/ky
        java.util.regex.Pattern kgPattern = java.util.regex.Pattern.compile("^([0-9.]+)\\s*(kg|kilo|kilogam|ký|ky)$");
        java.util.regex.Matcher kgMatcher = kgPattern.matcher(label);
        if (kgMatcher.matches()) {
            try {
                return Double.parseDouble(kgMatcher.group(1));
            } catch (NumberFormatException e) {
                // Ignore
            }
        }
        
        // Fallback: search for first number in string
        java.util.regex.Pattern numPattern = java.util.regex.Pattern.compile("^([0-9.]+)");
        java.util.regex.Matcher numMatcher = numPattern.matcher(label);
        if (numMatcher.find()) {
            try {
                double val = Double.parseDouble(numMatcher.group(1));
                if (val >= 50.0) {
                    return val / 1000.0;
                } else {
                    return val;
                }
            } catch (NumberFormatException e) {
                // Ignore
            }
        }
        
        return 1.0;
    }

    public double getOriginalUnitPrice() {
        if (product == null) return 0;
        double multiplier = getWeightMultiplier();
        return (product.getPrice() * multiplier) + variantPriceAdjustment + packagingPriceAdjustment;
    }

    public double getEffectiveUnitPrice() {
        if (product == null) return 0;
        double multiplier = getWeightMultiplier();
        return (product.getEffectivePrice() * multiplier) + variantPriceAdjustment + packagingPriceAdjustment;
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

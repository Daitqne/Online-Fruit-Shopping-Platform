package model;

/**
 * Product Entity Class representing fruit products, updated for GreenStockDB.
 */
public class Product {
    private int id;
    private String name;
    private double price;
    private double discountPrice;
    private String unit;
    private String origin;
    private String status;
    private String image;
    private String description;
    private String category;
    private int categoryId;
    private boolean isFeatured;

    public Product() {
    }

    public Product(int id, String name, double price, String image, String description, String category, boolean isFeatured) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.image = image;
        this.description = description;
        this.category = category;
        this.isFeatured = isFeatured;
        this.status = isFeatured ? "Featured" : "Available";
    }

    public Product(int id, String name, double price, double discountPrice, String unit, String origin, String status, String image, String description, String category) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.discountPrice = discountPrice;
        this.unit = unit;
        this.origin = origin;
        this.status = status;
        this.image = image;
        this.description = description;
        this.category = category;
        this.isFeatured = "Featured".equalsIgnoreCase(status);
    }

    public Product(int id, String name, double price, double discountPrice, String unit, String origin, String status, String image, String description, String category, int categoryId) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.discountPrice = discountPrice;
        this.unit = unit;
        this.origin = origin;
        this.status = status;
        this.image = image;
        this.description = description;
        this.category = category;
        this.categoryId = categoryId;
        this.isFeatured = "Featured".equalsIgnoreCase(status);
    }

    public Product(int id, String name, double price, String image, String description, String category, boolean isFeatured, int categoryId, double discountPrice, String unit, String origin, String status) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.image = image;
        this.description = description;
        this.category = category;
        this.isFeatured = isFeatured;
        this.categoryId = categoryId;
        this.discountPrice = discountPrice;
        this.unit = unit;
        this.origin = origin;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getDiscountPrice() {
        return discountPrice;
    }

    public void setDiscountPrice(double discountPrice) {
        this.discountPrice = discountPrice;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
        this.isFeatured = "Featured".equalsIgnoreCase(status);
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public boolean isFeatured() {
        return "Featured".equalsIgnoreCase(status) || isFeatured;
    }

    public void setFeatured(boolean isFeatured) {
        this.isFeatured = isFeatured;
        if (isFeatured) {
            this.status = "Featured";
        } else if (this.status == null || "Featured".equalsIgnoreCase(this.status)) {
            this.status = "Available";
        }
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", discountPrice=" + discountPrice +
                ", unit='" + unit + '\'' +
                ", origin='" + origin + '\'' +
                ", status='" + status + '\'' +
                ", image='" + image + '\'' +
                ", category='" + category + '\'' +
                ", isFeatured=" + isFeatured() +
                ", categoryId=" + categoryId +
                '}';
    }
}

package model;

/**
 * Product Entity Class representing fruit/vegetable products.
 */
public class Product {
    private int id;
    private String name;
    private double price;
    private double discountPrice;
    private String image;
    private String description;
    private String category;
    private String unit;
    private String origin;
    private String status;

    public Product() {
    }

    public Product(int id, String name, double price, double discountPrice,
                   String image, String description, String category,
                   String unit, String origin, String status) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.discountPrice = discountPrice;
        this.image = image;
        this.description = description;
        this.category = category;
        this.unit = unit;
        this.origin = origin;
        this.status = status;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public double getDiscountPrice() { return discountPrice; }
    public void setDiscountPrice(double discountPrice) { this.discountPrice = discountPrice; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }

    public String getOrigin() { return origin; }
    public void setOrigin(String origin) { this.origin = origin; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    // Helper: tra ve gia hien thi (gia khuyen mai neu co, nguoc lai gia goc)
    public double getDisplayPrice() {
        return (discountPrice > 0) ? discountPrice : price;
    }

    // Tuong thich nguoc voi code cu (isFeatured)
    public boolean isFeatured() {
        return "Available".equalsIgnoreCase(status);
    }

    @Override
    public String toString() {
        return "Product{id=" + id + ", name='" + name + "', price=" + price
                + ", category='" + category + "', status='" + status + "'}";
    }
}

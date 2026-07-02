package model;

public class OrderProductDetail {
    private int productId;
    private String productName;
    private String productImage;
    private String unit; // Thêm đơn vị tính (kg, hộp, túi...)
    private int quantity;
    private double unitPrice;

    public OrderProductDetail() {}

    public OrderProductDetail(int productId, String productName, String productImage, String unit, int quantity, double unitPrice) {
        this.productId = productId;
        this.productName = productName;
        this.productImage = productImage;
        this.unit = unit;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    // Các hàm getter/setter hiện tại của bạn...

    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }

    // Thêm hàm này để xử lý hiển thị tổng tiền từng món bên JSP cho nhàn
    public double getTotalPrice() { 
        return this.quantity * this.unitPrice; 
    }
}
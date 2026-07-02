package model;

import java.sql.Timestamp;
import java.util.List;

public class AdminSaleOrder {
    private int saleOrderId;
    private Timestamp orderDate;
    private String orderStatus;
    private String paymentMethod;
    private String paymentStatus;
    private double totalPayment;
    
    // 🌟 ĐỔI SANG DÙNG SaleOrderItem TẠI ĐÂY
    private List<SaleOrderItem> items; 

    public AdminSaleOrder() {}

    public int getSaleOrderId() { return saleOrderId; }
    public void setSaleOrderId(int saleOrderId) { this.saleOrderId = saleOrderId; }

    public Timestamp getOrderDate() { return orderDate; }
    public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }

    public String getOrderStatus() { return orderStatus; }
    public void setOrderStatus(String orderStatus) { this.orderStatus = orderStatus; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    public double getTotalPayment() { return totalPayment; }
    public void setTotalPayment(double totalPayment) { this.totalPayment = totalPayment; }

    // 🌟 CẬP NHẬT LẠI GETTER/SETTER CHO SaleOrderItem
    public List<SaleOrderItem> getItems() { return items; }
    public void setItems(List<SaleOrderItem> items) { this.items = items; }
}
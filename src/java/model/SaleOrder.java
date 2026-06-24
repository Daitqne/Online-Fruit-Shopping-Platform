package model;

import java.sql.Timestamp;
import java.util.List;

public class SaleOrder {
    private int saleOrderId;
    private Timestamp orderDate;
    private int createdBy;
    private String orderStatus;
    private String paymentMethod;
    private String paymentStatus;
    private String shippingAddress;
    private String shippingPhone;
    private Integer shipperId; // Can be null
    private Timestamp shippedDate; // Can be null
    private Timestamp deliveredDate; // Can be null
    private String shipperNote;
    
    private List<SaleOrderItem> items;
    
    // New fields for promotion/pricing
    private double discountAmount;
    private String promoCode;
    private double shippingFee;
    private double totalPayment;

    // Join / display field (not stored in DB)
    private String customerName;

    public SaleOrder() {
    }

    public SaleOrder(int saleOrderId, Timestamp orderDate, int createdBy, String orderStatus, String paymentMethod, String paymentStatus, String shippingAddress, String shippingPhone, Integer shipperId, Timestamp shippedDate, Timestamp deliveredDate, String shipperNote) {
        this.saleOrderId = saleOrderId;
        this.orderDate = orderDate;
        this.createdBy = createdBy;
        this.orderStatus = orderStatus;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.shippingAddress = shippingAddress;
        this.shippingPhone = shippingPhone;
        this.shipperId = shipperId;
        this.shippedDate = shippedDate;
        this.deliveredDate = deliveredDate;
        this.shipperNote = shipperNote;
    }

    public int getSaleOrderId() {
        return saleOrderId;
    }

    public void setSaleOrderId(int saleOrderId) {
        this.saleOrderId = saleOrderId;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public String getShippingPhone() {
        return shippingPhone;
    }

    public void setShippingPhone(String shippingPhone) {
        this.shippingPhone = shippingPhone;
    }

    public Integer getShipperId() {
        return shipperId;
    }

    public void setShipperId(Integer shipperId) {
        this.shipperId = shipperId;
    }

    public Timestamp getShippedDate() {
        return shippedDate;
    }

    public void setShippedDate(Timestamp shippedDate) {
        this.shippedDate = shippedDate;
    }

    public Timestamp getDeliveredDate() {
        return deliveredDate;
    }

    public void setDeliveredDate(Timestamp deliveredDate) {
        this.deliveredDate = deliveredDate;
    }

    public String getShipperNote() {
        return shipperNote;
    }

    public void setShipperNote(String shipperNote) {
        this.shipperNote = shipperNote;
    }

    public List<SaleOrderItem> getItems() {
        return items;
    }

    public void setItems(List<SaleOrderItem> items) {
        this.items = items;
    }

    public double getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(double discountAmount) {
        this.discountAmount = discountAmount;
    }

    public String getPromoCode() {
        return promoCode;
    }

    public void setPromoCode(String promoCode) {
        this.promoCode = promoCode;
    }

    public double getShippingFee() {
        return shippingFee;
    }

    public void setShippingFee(double shippingFee) {
        this.shippingFee = shippingFee;
    }

    public double getTotalPayment() {
        return totalPayment;
    }

    public void setTotalPayment(double totalPayment) {
        this.totalPayment = totalPayment;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    @Override
    public String toString() {
        return "SaleOrder{" +
                "saleOrderId=" + saleOrderId +
                ", orderDate=" + orderDate +
                ", createdBy=" + createdBy +
                ", orderStatus='" + orderStatus + '\'' +
                ", paymentMethod='" + paymentMethod + '\'' +
                ", paymentStatus='" + paymentStatus + '\'' +
                ", itemsCount=" + (items != null ? items.size() : 0) +
                '}';
    }
}

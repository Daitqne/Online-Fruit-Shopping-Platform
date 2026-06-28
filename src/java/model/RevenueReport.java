package model;

import java.sql.Date;

/**
 * Revenue Report Model - Used for displaying revenue statistics
 * This is a DTO (Data Transfer Object), not a database entity
 */
public class RevenueReport {
    private Date reportDate;           // Ngày/Tuần/Tháng báo cáo
    private String periodLabel;        // Label hiển thị (VD: "Tuần 1", "01/2024")
    private int totalOrders;           // Tổng số đơn hàng
    private int totalProductsSold;     // Tổng số sản phẩm đã bán
    private double subtotal;           // Tổng tiền hàng (chưa trừ giảm giá)
    private double totalDiscount;      // Tổng giảm giá
    private double totalShippingFee;   // Tổng phí ship
    private double totalPayment;       // Tổng thanh toán
    private double netRevenue;         // Doanh thu ròng

    public RevenueReport() {
    }

    public RevenueReport(Date reportDate, String periodLabel, int totalOrders, 
                        int totalProductsSold, double subtotal, double totalDiscount, 
                        double totalShippingFee, double totalPayment, double netRevenue) {
        this.reportDate = reportDate;
        this.periodLabel = periodLabel;
        this.totalOrders = totalOrders;
        this.totalProductsSold = totalProductsSold;
        this.subtotal = subtotal;
        this.totalDiscount = totalDiscount;
        this.totalShippingFee = totalShippingFee;
        this.totalPayment = totalPayment;
        this.netRevenue = netRevenue;
    }

    public Date getReportDate() {
        return reportDate;
    }

    public void setReportDate(Date reportDate) {
        this.reportDate = reportDate;
    }

    public String getPeriodLabel() {
        return periodLabel;
    }

    public void setPeriodLabel(String periodLabel) {
        this.periodLabel = periodLabel;
    }

    public int getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }

    public int getTotalProductsSold() {
        return totalProductsSold;
    }

    public void setTotalProductsSold(int totalProductsSold) {
        this.totalProductsSold = totalProductsSold;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public double getTotalDiscount() {
        return totalDiscount;
    }

    public void setTotalDiscount(double totalDiscount) {
        this.totalDiscount = totalDiscount;
    }

    public double getTotalShippingFee() {
        return totalShippingFee;
    }

    public void setTotalShippingFee(double totalShippingFee) {
        this.totalShippingFee = totalShippingFee;
    }

    public double getTotalPayment() {
        return totalPayment;
    }

    public void setTotalPayment(double totalPayment) {
        this.totalPayment = totalPayment;
    }

    public double getNetRevenue() {
        return netRevenue;
    }

    public void setNetRevenue(double netRevenue) {
        this.netRevenue = netRevenue;
    }

    @Override
    public String toString() {
        return "RevenueReport{" +
                "reportDate=" + reportDate +
                ", periodLabel='" + periodLabel + '\'' +
                ", totalOrders=" + totalOrders +
                ", totalProductsSold=" + totalProductsSold +
                ", subtotal=" + subtotal +
                ", totalDiscount=" + totalDiscount +
                ", netRevenue=" + netRevenue +
                '}';
    }
}

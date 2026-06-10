package model;

import java.sql.Timestamp;

public class Promotion {
    private int promoId;
    private String promoCode;
    private double discountValue;
    private String discountType; // "Percentage" or "Fixed"
    private Timestamp startDate;
    private Timestamp endDate;
    private double minOrderValue;

    public Promotion() {
    }

    public Promotion(int promoId, String promoCode, double discountValue, String discountType, Timestamp startDate, Timestamp endDate, double minOrderValue) {
        this.promoId = promoId;
        this.promoCode = promoCode;
        this.discountValue = discountValue;
        this.discountType = discountType;
        this.startDate = startDate;
        this.endDate = endDate;
        this.minOrderValue = minOrderValue;
    }

    public int getPromoId() {
        return promoId;
    }

    public void setPromoId(int promoId) {
        this.promoId = promoId;
    }

    public String getPromoCode() {
        return promoCode;
    }

    public void setPromoCode(String promoCode) {
        this.promoCode = promoCode;
    }

    public double getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(double discountValue) {
        this.discountValue = discountValue;
    }

    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }

    public Timestamp getStartDate() {
        return startDate;
    }

    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    public Timestamp getEndDate() {
        return endDate;
    }

    public void setEndDate(Timestamp endDate) {
        this.endDate = endDate;
    }

    public double getMinOrderValue() {
        return minOrderValue;
    }

    public void setMinOrderValue(double minOrderValue) {
        this.minOrderValue = minOrderValue;
    }

    @Override
    public String toString() {
        return "Promotion{" +
                "promoId=" + promoId +
                ", promoCode='" + promoCode + '\'' +
                ", discountValue=" + discountValue +
                ", discountType='" + discountType + '\'' +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", minOrderValue=" + minOrderValue +
                '}';
    }
}

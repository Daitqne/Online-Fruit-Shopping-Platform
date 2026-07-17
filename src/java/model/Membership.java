package model;

import java.sql.Timestamp;

public class Membership {

    private int membershipId;
    private int userId;

    private int currentPoints;
    private String currentTier;

    private int pointConversionRate;

    private int silverMinPoint;
    private int silverDiscountPercent;

    private int goldMinPoint;
    private int goldDiscountPercent;

    private int diamondMinPoint;
    private int diamondDiscountPercent;

    private boolean manualOverride;

    private Timestamp tierUpdatedAt;

    // THUỘC TÍNH LIÊN KẾT ĐỂ HIỂN THỊ HỌ TÊN
    private String fullName;

    // Constructor rỗng
    public Membership() {
    }

    // Constructor đầy đủ
    public Membership(
            int membershipId,
            int userId,
            int currentPoints,
            String currentTier,
            int pointConversionRate,
            int silverMinPoint,
            int silverDiscountPercent,
            int goldMinPoint,
            int goldDiscountPercent,
            int diamondMinPoint,
            int diamondDiscountPercent,
            boolean manualOverride,
            Timestamp tierUpdatedAt,
            String fullName) {

        this.membershipId = membershipId;
        this.userId = userId;
        this.currentPoints = currentPoints;
        this.currentTier = currentTier;
        this.pointConversionRate = pointConversionRate;
        this.silverMinPoint = silverMinPoint;
        this.silverDiscountPercent = silverDiscountPercent;
        this.goldMinPoint = goldMinPoint;
        this.goldDiscountPercent = goldDiscountPercent;
        this.diamondMinPoint = diamondMinPoint;
        this.diamondDiscountPercent = diamondDiscountPercent;
        this.manualOverride = manualOverride;
        this.tierUpdatedAt = tierUpdatedAt;
        this.fullName = fullName;
    }

    public int getMembershipId() {
        return membershipId;
    }

    public void setMembershipId(int membershipId) {
        this.membershipId = membershipId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCurrentPoints() {
        return currentPoints;
    }

    public void setCurrentPoints(int currentPoints) {
        this.currentPoints = currentPoints;
    }

    public String getCurrentTier() {
        return currentTier;
    }

    public void setCurrentTier(String currentTier) {
        this.currentTier = currentTier;
    }

    public int getPointConversionRate() {
        return pointConversionRate;
    }

    public void setPointConversionRate(int pointConversionRate) {
        this.pointConversionRate = pointConversionRate;
    }

    public int getSilverMinPoint() {
        return silverMinPoint;
    }

    public void setSilverMinPoint(int silverMinPoint) {
        this.silverMinPoint = silverMinPoint;
    }

    public int getSilverDiscountPercent() {
        return silverDiscountPercent;
    }

    public void setSilverDiscountPercent(int silverDiscountPercent) {
        this.silverDiscountPercent = silverDiscountPercent;
    }

    public int getGoldMinPoint() {
        return goldMinPoint;
    }

    public void setGoldMinPoint(int goldMinPoint) {
        this.goldMinPoint = goldMinPoint;
    }

    public int getGoldDiscountPercent() {
        return goldDiscountPercent;
    }

    public void setGoldDiscountPercent(int goldDiscountPercent) {
        this.goldDiscountPercent = goldDiscountPercent;
    }

    public int getDiamondMinPoint() {
        return diamondMinPoint;
    }

    public void setDiamondMinPoint(int diamondMinPoint) {
        this.diamondMinPoint = diamondMinPoint;
    }

    public int getDiamondDiscountPercent() {
        return diamondDiscountPercent;
    }

    public void setDiamondDiscountPercent(int diamondDiscountPercent) {
        this.diamondDiscountPercent = diamondDiscountPercent;
    }

    public boolean isManualOverride() {
        return manualOverride;
    }

    public void setManualOverride(boolean manualOverride) {
        this.manualOverride = manualOverride;
    }

    public Timestamp getTierUpdatedAt() {
        return tierUpdatedAt;
    }

    public void setTierUpdatedAt(Timestamp tierUpdatedAt) {
        this.tierUpdatedAt = tierUpdatedAt;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    @Override
    public String toString() {
        return "Membership{" +
                "membershipId=" + membershipId +
                ", userId=" + userId +
                ", currentPoints=" + currentPoints +
                ", currentTier='" + currentTier + '\'' +
                ", pointConversionRate=" + pointConversionRate +
                ", silverMinPoint=" + silverMinPoint +
                ", silverDiscountPercent=" + silverDiscountPercent +
                ", goldMinPoint=" + goldMinPoint +
                ", goldDiscountPercent=" + goldDiscountPercent +
                ", diamondMinPoint=" + diamondMinPoint +
                ", diamondDiscountPercent=" + diamondDiscountPercent +
                ", manualOverride=" + manualOverride +
                ", tierUpdatedAt=" + tierUpdatedAt +
                ", fullName='" + fullName + '\'' +
                '}';
    }
}
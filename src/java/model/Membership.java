package model;

import java.sql.Timestamp;

public class Membership {

    private int membershipId;
    private int userId;
    private int currentPoints;
    private int tierId;
    private boolean manualOverride;
    private Timestamp tierUpdatedAt;

    // THUỘC TÍNH LIÊN KẾT
    private String fullName;          // Họ tên khách hàng từ bảng UserInfo
    private MembershipTier tierInfo;  // Thông tin Hạng thành viên liên kết từ bảng MembershipTier

    // Constructor rỗng
    public Membership() {
    }

    // Constructor cơ bản
    public Membership(int membershipId, int userId, int currentPoints, int tierId, boolean manualOverride, Timestamp tierUpdatedAt, String fullName, MembershipTier tierInfo) {
        this.membershipId = membershipId;
        this.userId = userId;
        this.currentPoints = currentPoints;
        this.tierId = tierId;
        this.manualOverride = manualOverride;
        this.tierUpdatedAt = tierUpdatedAt;
        this.fullName = fullName;
        this.tierInfo = tierInfo;
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

    public int getTierId() {
        return tierId;
    }

    public void setTierId(int tierId) {
        this.tierId = tierId;
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

    public MembershipTier getTierInfo() {
        return tierInfo;
    }

    public void setTierInfo(MembershipTier tierInfo) {
        this.tierInfo = tierInfo;
    }

    // =========================================================================
    // HÀM TIỆN ÍCH / BACKWARD COMPATIBILITY
    // =========================================================================
    public String getCurrentTier() {
        return (tierInfo != null && tierInfo.getTierName() != null) ? tierInfo.getTierName() : "Normal";
    }

    public int getPointConversionRate() {
        return (tierInfo != null && tierInfo.getPointConversionRate() > 0) ? tierInfo.getPointConversionRate() : 10000;
    }

    public int getDiscountPercent() {
        return (tierInfo != null) ? tierInfo.getDiscountPercent() : 0;
    }

    @Override
    public String toString() {
        return "Membership{" +
                "membershipId=" + membershipId +
                ", userId=" + userId +
                ", currentPoints=" + currentPoints +
                ", tierId=" + tierId +
                ", manualOverride=" + manualOverride +
                ", tierUpdatedAt=" + tierUpdatedAt +
                ", fullName='" + fullName + '\'' +
                ", tierInfo=" + tierInfo +
                '}';
    }
}
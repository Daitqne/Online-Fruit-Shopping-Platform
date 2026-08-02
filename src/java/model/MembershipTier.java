package model;

public class MembershipTier {

    private int tierId;
    private String tierName;
    private int minPoints;
    private int discountPercent;
    private int pointConversionRate;

    public MembershipTier() {
    }

    public MembershipTier(int tierId, String tierName, int minPoints, int discountPercent, int pointConversionRate) {
        this.tierId = tierId;
        this.tierName = tierName;
        this.minPoints = minPoints;
        this.discountPercent = discountPercent;
        this.pointConversionRate = pointConversionRate;
    }

    public int getTierId() {
        return tierId;
    }

    public void setTierId(int tierId) {
        this.tierId = tierId;
    }

    public String getTierName() {
        return tierName;
    }

    public void setTierName(String tierName) {
        this.tierName = tierName;
    }

    public int getMinPoints() {
        return minPoints;
    }

    public void setMinPoints(int minPoints) {
        this.minPoints = minPoints;
    }

    public int getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(int discountPercent) {
        this.discountPercent = discountPercent;
    }

    public int getPointConversionRate() {
        return pointConversionRate;
    }

    public void setPointConversionRate(int pointConversionRate) {
        this.pointConversionRate = pointConversionRate;
    }

    @Override
    public String toString() {
        return "MembershipTier{" +
                "tierId=" + tierId +
                ", tierName='" + tierName + '\'' +
                ", minPoints=" + minPoints +
                ", discountPercent=" + discountPercent +
                ", pointConversionRate=" + pointConversionRate +
                '}';
    }
}

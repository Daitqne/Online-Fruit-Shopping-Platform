package model;

public class CustomerAddress {
    private int addressId;
    private int userId;
    private String label;
    private String receiverName;
    private String receiverPhone;
    private String addressDetails;
    private boolean isDefault;

    public CustomerAddress() {
    }

    public CustomerAddress(int addressId, int userId, String label, String receiverName, String receiverPhone, String addressDetails, boolean isDefault) {
        this.addressId = addressId;
        this.userId = userId;
        this.label = label;
        this.receiverName = receiverName;
        this.receiverPhone = receiverPhone;
        this.addressDetails = addressDetails;
        this.isDefault = isDefault;
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }

    public String getAddressDetails() {
        return addressDetails;
    }

    public void setAddressDetails(String addressDetails) {
        this.addressDetails = addressDetails;
    }

    public boolean isDefault() {
        return isDefault;
    }

    public void setDefault(boolean isDefault) {
        this.isDefault = isDefault;
    }

    @Override
    public String toString() {
        return "CustomerAddress{" +
                "addressId=" + addressId +
                ", userId=" + userId +
                ", label='" + label + '\'' +
                ", receiverName='" + receiverName + '\'' +
                ", receiverPhone='" + receiverPhone + '\'' +
                ", addressDetails='" + addressDetails + '\'' +
                ", isDefault=" + isDefault +
                '}';
    }
}

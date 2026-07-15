package model;

import java.sql.Timestamp;
import java.util.List;

/**
 * Phiếu nhập kho — đại diện cho một lần nhập hàng của shop owner.
 */
public class ImportReceipt {
    private int receiptId;
    private Timestamp importDate;
    private int createdBy;
    private String note;
    private List<ImportReceiptItem> items;

    public ImportReceipt() {}

    public ImportReceipt(int receiptId, Timestamp importDate, int createdBy, String note) {
        this.receiptId = receiptId;
        this.importDate = importDate;
        this.createdBy = createdBy;
        this.note = note;
    }

    public int getReceiptId() { return receiptId; }
    public void setReceiptId(int receiptId) { this.receiptId = receiptId; }

    public Timestamp getImportDate() { return importDate; }
    public void setImportDate(Timestamp importDate) { this.importDate = importDate; }

    public int getCreatedBy() { return createdBy; }
    public void setCreatedBy(int createdBy) { this.createdBy = createdBy; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public List<ImportReceiptItem> getItems() { return items; }
    public void setItems(List<ImportReceiptItem> items) { this.items = items; }

    @Override
    public String toString() {
        return "ImportReceipt{receiptId=" + receiptId + ", importDate=" + importDate
                + ", createdBy=" + createdBy + ", items=" + (items != null ? items.size() : 0) + "}";
    }
}

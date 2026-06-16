package model;

import java.sql.Timestamp;
import java.util.List;

public class ImportOrder {
    private int importOrderId;
    private Timestamp importDate;
    private int createdBy;
    private String note;
    
    private List<ImportOrderItem> items;

    public ImportOrder() {
    }

    public ImportOrder(int importOrderId, Timestamp importDate, int createdBy, String note) {
        this.importOrderId = importOrderId;
        this.importDate = importDate;
        this.createdBy = createdBy;
        this.note = note;
    }

    public int getImportOrderId() {
        return importOrderId;
    }

    public void setImportOrderId(int importOrderId) {
        this.importOrderId = importOrderId;
    }

    public Timestamp getImportDate() {
        return importDate;
    }

    public void setImportDate(Timestamp importDate) {
        this.importDate = importDate;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public List<ImportOrderItem> getItems() {
        return items;
    }

    public void setItems(List<ImportOrderItem> items) {
        this.items = items;
    }

    @Override
    public String toString() {
        return "ImportOrder{" +
                "importOrderId=" + importOrderId +
                ", importDate=" + importDate +
                ", createdBy=" + createdBy +
                ", note='" + note + '\'' +
                ", itemsCount=" + (items != null ? items.size() : 0) +
                '}';
    }
}

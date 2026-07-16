package dal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.ImportReceipt;
import model.ImportReceiptItem;
import model.Product;

/**
 * DAO cho Phiếu Nhập Kho theo lô (Import_Receipt + Import_Receipt_Item + Inventory_Batch).
 * Tự động tạo bảng nếu chưa tồn tại khi khởi tạo.
 */
public class ImportReceiptDAO extends DBContext {

    public ImportReceiptDAO() {
        super();
        ensureTablesExist();
    }

    /**
     * Tạo các bảng cần thiết nếu chưa có trong DB.
     */
    private void ensureTablesExist() {
        String[] ddls = {
            // Bảng phiếu nhập kho
            "IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='Import_Receipt') " +
            "CREATE TABLE Import_Receipt (" +
            "  receipt_id    INT IDENTITY(1,1) PRIMARY KEY, " +
            "  import_date   DATETIME NOT NULL DEFAULT GETDATE(), " +
            "  created_by    INT NOT NULL, " +
            "  note          NVARCHAR(500) NULL" +
            ")",

            // Bảng chi tiết từng dòng trong phiếu
            "IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='Import_Receipt_Item') " +
            "CREATE TABLE Import_Receipt_Item (" +
            "  item_id          INT IDENTITY(1,1) PRIMARY KEY, " +
            "  receipt_id       INT NOT NULL, " +
            "  product_id       INT NOT NULL, " +
            "  quantity         INT NOT NULL, " +
            "  manufacture_date DATE NULL, " +
            "  expiry_date      DATE NOT NULL, " +
            "  batch_number     VARCHAR(50) NOT NULL" +
            ")",

            // Bảng tồn kho theo lô (FEFO)
            "IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='Inventory_Batch') " +
            "CREATE TABLE Inventory_Batch (" +
            "  batch_id         INT IDENTITY(1,1) PRIMARY KEY, " +
            "  product_id       INT NOT NULL, " +
            "  receipt_item_id  INT NOT NULL, " +
            "  batch_number     VARCHAR(50) NOT NULL, " +
            "  quantity_in      INT NOT NULL, " +
            "  quantity_remain  INT NOT NULL, " +
            "  manufacture_date DATE NULL, " +
            "  expiry_date      DATE NOT NULL, " +
            "  created_at       DATETIME NOT NULL DEFAULT GETDATE()" +
            ")"
        };
        for (String ddl : ddls) {
            try (PreparedStatement ps = getConnection().prepareStatement(ddl)) {
                ps.executeUpdate();
            } catch (SQLException e) {
                Logger.getLogger(ImportReceiptDAO.class.getName()).log(Level.WARNING, "DDL error (ignored): " + e.getMessage());
            }
        }
    }

    /**
     * Tạo phiếu nhập kho — bao gồm:
     * 1. Insert Import_Receipt
     * 2. Insert từng Import_Receipt_Item
     * 3. UPDATE Inventory (cộng số lượng)
     * 4. INSERT Inventory_Batch (tạo lô mới)
     *
     * Toàn bộ trong một transaction.
     */
    public boolean createReceipt(ImportReceipt receipt) {
        String sqlReceipt = "INSERT INTO Import_Receipt (import_date, created_by, note) VALUES (?, ?, ?)";
        String sqlItem    = "INSERT INTO Import_Receipt_Item (receipt_id, product_id, quantity, manufacture_date, expiry_date, batch_number) VALUES (?, ?, ?, ?, ?, ?)";
        String sqlUpdInv  = "UPDATE Inventory SET quantity = quantity + ?, last_updated = GETDATE() WHERE product_id = ?";
        String sqlInsInv  = "INSERT INTO Inventory (product_id, quantity, last_updated) VALUES (?, ?, GETDATE())";
        String sqlBatch   = "INSERT INTO Inventory_Batch (product_id, receipt_item_id, batch_number, quantity_in, quantity_remain, manufacture_date, expiry_date) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try {
            getConnection().setAutoCommit(false);

            // 1. Insert phiếu nhập
            int receiptId;
            try (PreparedStatement ps = getConnection().prepareStatement(sqlReceipt, Statement.RETURN_GENERATED_KEYS)) {
                ps.setTimestamp(1, receipt.getImportDate() != null ? receipt.getImportDate() : new Timestamp(System.currentTimeMillis()));
                ps.setInt(2, receipt.getCreatedBy());
                ps.setNString(3, receipt.getNote());
                ps.executeUpdate();
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (!rs.next()) throw new SQLException("Không lấy được receipt_id");
                    receiptId = rs.getInt(1);
                    receipt.setReceiptId(receiptId);
                }
            }

            // 2. Insert từng dòng sản phẩm
            for (ImportReceiptItem item : receipt.getItems()) {
                // Sinh mã lô: [TÊN_SP_VIẾT_TẮT]-[YYYYMMDD]-[receiptId]
                String batchNo = generateBatchNumber(item.getProductId(), receiptId);
                item.setBatchNumber(batchNo);

                int itemId;
                try (PreparedStatement ps = getConnection().prepareStatement(sqlItem, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setInt(1, receiptId);
                    ps.setInt(2, item.getProductId());
                    ps.setInt(3, item.getQuantity());
                    if (item.getManufactureDate() != null) {
                        ps.setDate(4, item.getManufactureDate());
                    } else {
                        ps.setNull(4, java.sql.Types.DATE);
                    }
                    ps.setDate(5, item.getExpiryDate());
                    ps.setString(6, batchNo);
                    ps.executeUpdate();
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (!rs.next()) throw new SQLException("Không lấy được item_id");
                        itemId = rs.getInt(1);
                        item.setItemId(itemId);
                    }
                }

                // 3. Cộng số lượng vào Inventory (upsert)
                try (PreparedStatement psUpd = getConnection().prepareStatement(sqlUpdInv)) {
                    psUpd.setInt(1, item.getQuantity());
                    psUpd.setInt(2, item.getProductId());
                    int rows = psUpd.executeUpdate();
                    if (rows == 0) {
                        // Chưa có record trong Inventory → insert mới
                        try (PreparedStatement psIns = getConnection().prepareStatement(sqlInsInv)) {
                            psIns.setInt(1, item.getProductId());
                            psIns.setInt(2, item.getQuantity());
                            psIns.executeUpdate();
                        }
                    }
                }

                // 4. Tạo lô trong Inventory_Batch
                try (PreparedStatement ps = getConnection().prepareStatement(sqlBatch)) {
                    ps.setInt(1, item.getProductId());
                    ps.setInt(2, itemId);
                    ps.setString(3, batchNo);
                    ps.setInt(4, item.getQuantity());
                    ps.setInt(5, item.getQuantity()); // quantity_remain = quantity_in ban đầu
                    if (item.getManufactureDate() != null) {
                        ps.setDate(6, item.getManufactureDate());
                    } else {
                        ps.setNull(6, java.sql.Types.DATE);
                    }
                    ps.setDate(7, item.getExpiryDate());
                    ps.executeUpdate();
                }
            }

            getConnection().commit();
            return true;

        } catch (SQLException ex) {
            try { getConnection().rollback(); } catch (SQLException ignored) {}
            Logger.getLogger(ImportReceiptDAO.class.getName()).log(Level.SEVERE, "createReceipt failed", ex);
        } finally {
            try { getConnection().setAutoCommit(true); } catch (SQLException ignored) {}
        }
        return false;
    }

    /**
     * Lấy danh sách phiếu nhập của một shop owner, kèm số dòng sản phẩm.
     */
    public List<ImportReceipt> getReceiptsByShopOwner(int shopOwnerId) {
        List<ImportReceipt> list = new ArrayList<>();
        String sql =
            "SELECT ir.receipt_id, ir.import_date, ir.created_by, ir.note, " +
            "       COUNT(iri.item_id) AS item_count, " +
            "       SUM(iri.quantity)  AS total_qty " +
            "FROM Import_Receipt ir " +
            "LEFT JOIN Import_Receipt_Item iri ON ir.receipt_id = iri.receipt_id " +
            "WHERE ir.created_by = ? " +
            "GROUP BY ir.receipt_id, ir.import_date, ir.created_by, ir.note " +
            "ORDER BY ir.import_date DESC";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, shopOwnerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ImportReceipt r = new ImportReceipt();
                    r.setReceiptId(rs.getInt("receipt_id"));
                    r.setImportDate(rs.getTimestamp("import_date"));
                    r.setCreatedBy(rs.getInt("created_by"));
                    r.setNote(rs.getString("note"));
                    // Dùng item list tạm để truyền thêm thông tin
                    List<ImportReceiptItem> tmp = new ArrayList<>();
                    int cnt = rs.getInt("item_count");
                    for (int i = 0; i < cnt; i++) {
                        ImportReceiptItem dummy = new ImportReceiptItem();
                        dummy.setQuantity(rs.getInt("total_qty") / (cnt > 0 ? cnt : 1));
                        tmp.add(dummy);
                    }
                    r.setItems(tmp);
                    list.add(r);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ImportReceiptDAO.class.getName()).log(Level.SEVERE, "getReceiptsByShopOwner failed", ex);
        }
        return list;
    }

    /**
     * Lấy chi tiết một phiếu nhập kèm danh sách sản phẩm.
     */
    public ImportReceipt getReceiptDetail(int receiptId) {
        String sqlR = "SELECT receipt_id, import_date, created_by, note FROM Import_Receipt WHERE receipt_id = ?";
        String sqlI = "SELECT iri.item_id, iri.receipt_id, iri.product_id, iri.quantity, " +
                      "       iri.manufacture_date, iri.expiry_date, iri.batch_number, " +
                      "       p.product_name " +
                      "FROM Import_Receipt_Item iri " +
                      "JOIN Product p ON iri.product_id = p.product_id " +
                      "WHERE iri.receipt_id = ? ORDER BY iri.item_id";
        try (PreparedStatement ps = getConnection().prepareStatement(sqlR)) {
            ps.setInt(1, receiptId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ImportReceipt r = new ImportReceipt();
                    r.setReceiptId(rs.getInt("receipt_id"));
                    r.setImportDate(rs.getTimestamp("import_date"));
                    r.setCreatedBy(rs.getInt("created_by"));
                    r.setNote(rs.getString("note"));

                    List<ImportReceiptItem> items = new ArrayList<>();
                    try (PreparedStatement ps2 = getConnection().prepareStatement(sqlI)) {
                        ps2.setInt(1, receiptId);
                        try (ResultSet rs2 = ps2.executeQuery()) {
                            while (rs2.next()) {
                                ImportReceiptItem it = new ImportReceiptItem();
                                it.setItemId(rs2.getInt("item_id"));
                                it.setReceiptId(rs2.getInt("receipt_id"));
                                it.setProductId(rs2.getInt("product_id"));
                                it.setQuantity(rs2.getInt("quantity"));
                                it.setManufactureDate(rs2.getDate("manufacture_date"));
                                it.setExpiryDate(rs2.getDate("expiry_date"));
                                it.setBatchNumber(rs2.getString("batch_number"));
                                Product p = new Product();
                                p.setId(rs2.getInt("product_id"));
                                p.setName(rs2.getNString("product_name"));
                                it.setProduct(p);
                                items.add(it);
                            }
                        }
                    }
                    r.setItems(items);
                    return r;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ImportReceiptDAO.class.getName()).log(Level.SEVERE, "getReceiptDetail failed", ex);
        }
        return null;
    }

    /**
     * Lấy danh sách lô tồn kho của một sản phẩm, sắp xếp theo FEFO (hết hạn trước bán trước).
     */
    public List<model.InventoryBatch> getBatchesByProduct(int productId) {
        List<model.InventoryBatch> batches = new ArrayList<>();
        String sql = "SELECT batch_id, product_id, receipt_item_id, batch_number, " +
                     "       quantity_in, quantity_remain, manufacture_date, expiry_date, created_at " +
                     "FROM Inventory_Batch " +
                     "WHERE product_id = ? AND quantity_remain > 0 " +
                     "ORDER BY expiry_date ASC";
        
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    model.InventoryBatch batch = new model.InventoryBatch();
                    batch.setBatchId(rs.getInt("batch_id"));
                    batch.setProductId(rs.getInt("product_id"));
                    batch.setReceiptItemId(rs.getInt("receipt_item_id"));
                    batch.setBatchNumber(rs.getString("batch_number"));
                    batch.setQuantityIn(rs.getInt("quantity_in"));
                    batch.setQuantityRemain(rs.getInt("quantity_remain"));
                    batch.setManufactureDate(rs.getDate("manufacture_date"));
                    batch.setExpiryDate(rs.getDate("expiry_date"));
                    batch.setCreatedAt(rs.getTimestamp("created_at"));
                    batches.add(batch);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ImportReceiptDAO.class.getName()).log(Level.SEVERE, "getBatchesByProduct failed", ex);
        }
        return batches;
    }
    
    /**
     * Lấy danh sách lô của shop owner (tất cả sản phẩm thuộc shop owner đó).
     */
    public List<model.InventoryBatch> getBatchesByShopOwner(int shopOwnerId) {
        List<model.InventoryBatch> batches = new ArrayList<>();
        String sql = "SELECT ib.batch_id, ib.product_id, ib.receipt_item_id, ib.batch_number, " +
                     "       ib.quantity_in, ib.quantity_remain, ib.manufacture_date, ib.expiry_date, ib.created_at, " +
                     "       p.product_name " +
                     "FROM Inventory_Batch ib " +
                     "JOIN Product p ON ib.product_id = p.product_id " +
                     "WHERE p.shop_owner_id = ? AND ib.quantity_remain > 0 " +
                     "ORDER BY ib.expiry_date ASC";
        
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, shopOwnerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    model.InventoryBatch batch = new model.InventoryBatch();
                    batch.setBatchId(rs.getInt("batch_id"));
                    batch.setProductId(rs.getInt("product_id"));
                    batch.setReceiptItemId(rs.getInt("receipt_item_id"));
                    batch.setBatchNumber(rs.getString("batch_number"));
                    batch.setQuantityIn(rs.getInt("quantity_in"));
                    batch.setQuantityRemain(rs.getInt("quantity_remain"));
                    batch.setManufactureDate(rs.getDate("manufacture_date"));
                    batch.setExpiryDate(rs.getDate("expiry_date"));
                    batch.setCreatedAt(rs.getTimestamp("created_at"));
                    
                    Product p = new Product();
                    p.setId(rs.getInt("product_id"));
                    p.setName(rs.getNString("product_name"));
                    batch.setProduct(p);
                    
                    batches.add(batch);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ImportReceiptDAO.class.getName()).log(Level.SEVERE, "getBatchesByShopOwner failed", ex);
        }
        return batches;
    }
    
    /**
     * Xóa một lô hết hạn và trừ số lượng trong Inventory.
     */
    public boolean removeExpiredBatch(int batchId, int shopOwnerId) {
        String checkSql = "SELECT ib.product_id, ib.quantity_remain, p.shop_owner_id " +
                          "FROM Inventory_Batch ib " +
                          "JOIN Product p ON ib.product_id = p.product_id " +
                          "WHERE ib.batch_id = ?";
        String deleteBatchSql = "DELETE FROM Inventory_Batch WHERE batch_id = ?";
        String updateInventorySql = "UPDATE Inventory SET quantity = quantity - ? WHERE product_id = ?";
        
        try {
            getConnection().setAutoCommit(false);
            
            int productId = 0;
            int qtyRemain = 0;
            
            // Check ownership and get info
            try (PreparedStatement ps = getConnection().prepareStatement(checkSql)) {
                ps.setInt(1, batchId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        int ownerIdFromDB = rs.getInt("shop_owner_id");
                        if (ownerIdFromDB != shopOwnerId) {
                            getConnection().rollback();
                            return false; // Not owned by this shop owner
                        }
                        productId = rs.getInt("product_id");
                        qtyRemain = rs.getInt("quantity_remain");
                    } else {
                        getConnection().rollback();
                        return false;
                    }
                }
            }
            
            // Delete batch
            try (PreparedStatement ps = getConnection().prepareStatement(deleteBatchSql)) {
                ps.setInt(1, batchId);
                ps.executeUpdate();
            }
            
            // Update inventory
            try (PreparedStatement ps = getConnection().prepareStatement(updateInventorySql)) {
                ps.setInt(1, qtyRemain);
                ps.setInt(2, productId);
                ps.executeUpdate();
            }
            
            getConnection().commit();
            return true;
            
        } catch (SQLException ex) {
            try { getConnection().rollback(); } catch (SQLException ignored) {}
            Logger.getLogger(ImportReceiptDAO.class.getName()).log(Level.SEVERE, "removeExpiredBatch failed", ex);
        } finally {
            try { getConnection().setAutoCommit(true); } catch (SQLException ignored) {}
        }
        return false;
    }

    /**
     * Sinh mã lô: P{productId}-{YYYYMMDD}-R{receiptId}
     * Ví dụ: P12-20260712-R5
     */
    private String generateBatchNumber(int productId, int receiptId) {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMdd");
        String dateStr = sdf.format(new java.util.Date());
        return "P" + productId + "-" + dateStr + "-R" + receiptId;
    }
}

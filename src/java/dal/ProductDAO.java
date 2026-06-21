package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;

/**
 * Product Data Access Object containing queries for the Product table.
 */
public class ProductDAO extends DBContext {

    private static final String DEFAULT_IMAGE = "https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?auto=format&fit=crop&q=80&w=600";
    private static final String DEFAULT_CATEGORY = "Trái Cây Nội Địa";
    private static final String DEFAULT_STATUS = "Available";
    private static final String FEATURED_STATUS = "Featured";

    public List<Product> getTop8FeaturedProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT TOP 8 p.product_id, p.product_name, p.price, p.discount_price, p.unit, p.origin, p.status, p.description, c.category_name, pi.image_url, p.shop_owner_id, p.low_stock_threshold, i.quantity AS stock_quantity " +
                     "FROM Product p " +
                     "LEFT JOIN Product_Category c ON p.category_id = c.category_id " +
                     "LEFT JOIN Inventory i ON p.product_id = i.product_id " +
                     "LEFT JOIN (" +
                     "    SELECT product_id, image_url FROM (" +
                     "        SELECT product_id, image_url, ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY created_at DESC, image_id DESC) AS rn " +
                     "        FROM Product_Image" +
                     "    ) t WHERE rn = 1" +
                     ") pi ON pi.product_id = p.product_id " +
                     "WHERE p.status = ? " +
                     "ORDER BY p.product_id DESC";

        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setNString(1, FEATURED_STATUS);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    products.add(mapRowToProduct(rs));
                }
            }
        } catch (SQLException ex) {
            System.err.println("[ProductDAO Error] Failed to retrieve featured products!");
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return products;
    }

    public List<Product> getFilteredProducts(String search, String category,
                                              Double minPrice, Double maxPrice,
                                              String availability) {
        return getFilteredProducts(search, category, minPrice, maxPrice, availability, null);
    }

    public List<Product> getFilteredProducts(String search, String category,
                                              Double minPrice, Double maxPrice,
                                              String availability, Integer shopOwnerId) {
        List<Product> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT p.product_id, p.product_name, p.price, p.discount_price, p.unit, p.origin, p.status, p.description, c.category_name, pi.image_url, p.shop_owner_id, p.low_stock_threshold, i.quantity AS stock_quantity " +
                                              "FROM Product p " +
                                              "LEFT JOIN Product_Category c ON p.category_id = c.category_id " +
                                              "LEFT JOIN Inventory i ON p.product_id = i.product_id " +
                                              "LEFT JOIN (" +
                                              "    SELECT product_id, image_url FROM (" +
                                              "        SELECT product_id, image_url, ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY created_at DESC, image_id DESC) AS rn " +
                                              "        FROM Product_Image" +
                                              "    ) t WHERE rn = 1" +
                                              ") pi ON pi.product_id = p.product_id " +
                                              "WHERE 1=1 ");

        boolean hasSearch       = (search != null && !search.trim().isEmpty());
        boolean hasCategory     = (category != null && !category.trim().isEmpty() && !category.equalsIgnoreCase("All"));
        boolean hasMinPrice     = (minPrice != null && minPrice > 0);
        boolean hasMaxPrice     = (maxPrice != null && maxPrice > 0);
        boolean hasAvailability = (availability != null && !availability.trim().isEmpty() && !availability.equalsIgnoreCase("All"));

        if (hasSearch)       sql.append("AND p.product_name LIKE ? ");
        if (hasCategory)     sql.append("AND c.category_name = ? ");
        if (hasMinPrice)     sql.append("AND p.price >= ? ");
        if (hasMaxPrice)     sql.append("AND p.price <= ? ");
        if (hasAvailability) sql.append("AND p.status = ? ");
        
        if (shopOwnerId != null) {
            sql.append("AND p.shop_owner_id = ? ");
        } else {
            // Khách hàng: Chỉ xem sản phẩm đã duyệt
            sql.append("AND p.status IN ('Approved', 'Available', 'Featured') ");
        }
        
        sql.append("ORDER BY p.product_id DESC");

        try (PreparedStatement st = getConnection().prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (hasSearch)       st.setNString(paramIndex++, "%" + search.trim() + "%");
            if (hasCategory)     st.setNString(paramIndex++, category.trim());
            if (hasMinPrice)     st.setDouble(paramIndex++, minPrice);
            if (hasMaxPrice)     st.setDouble(paramIndex++, maxPrice);
            if (hasAvailability) st.setNString(paramIndex++, availability.trim());
            if (shopOwnerId != null) {
                st.setInt(paramIndex++, shopOwnerId);
            }
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    products.add(mapRowToProduct(rs));
                }
            }
        } catch (SQLException ex) {
            System.err.println("[ProductDAO Error] Failed to retrieve filtered products!");
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return products;
    }

    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT DISTINCT category_name FROM Product_Category ORDER BY category_name";

        try (PreparedStatement st = getConnection().prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                categories.add(rs.getNString("category_name"));
            }
        } catch (SQLException ex) {
            System.err.println("[ProductDAO Error] Failed to retrieve categories!");
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return categories;
    }

    public boolean addProduct(Product p) {
        String sqlProduct = "INSERT INTO Product (product_name, category_id, price, discount_price, unit, origin, status, description, shop_owner_id, low_stock_threshold) " +
                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            int categoryId = getCategoryIdOrCreate(p.getCategory());
            if (p.getImage() == null || p.getImage().trim().isEmpty()) {
                p.setImage(DEFAULT_IMAGE);
            }
            if (p.getCategory() == null || p.getCategory().trim().isEmpty()) {
                p.setCategory(DEFAULT_CATEGORY);
                categoryId = getCategoryIdOrCreate(DEFAULT_CATEGORY);
            }
            String status = p.getStatus() != null ? p.getStatus() : (p.isFeatured() ? FEATURED_STATUS : DEFAULT_STATUS);

            getConnection().setAutoCommit(false);
            
            // 1. Insert product
            try (PreparedStatement stProduct = getConnection().prepareStatement(sqlProduct, Statement.RETURN_GENERATED_KEYS)) {
                stProduct.setNString(1, p.getName());
                stProduct.setInt(2, categoryId);
                stProduct.setDouble(3, p.getPrice());
                stProduct.setDouble(4, p.getDiscountPrice());
                stProduct.setNString(5, p.getUnit() != null ? p.getUnit() : "kg");
                stProduct.setNString(6, p.getOrigin() != null ? p.getOrigin() : "Vietnam");
                stProduct.setNString(7, status);
                stProduct.setNString(8, p.getDescription());
                if (p.getShopOwnerId() > 0) {
                    stProduct.setInt(9, p.getShopOwnerId());
                } else {
                    stProduct.setNull(9, java.sql.Types.INTEGER);
                }
                stProduct.setInt(10, p.getLowStockThreshold() > 0 ? p.getLowStockThreshold() : 10);

                int rowsAffected = stProduct.executeUpdate();
                if (rowsAffected > 0) {
                    int productId = 0;
                    try (ResultSet generatedKeys = stProduct.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            productId = generatedKeys.getInt(1);
                        }
                    }
                    
                    if (productId > 0) {
                        // 2. Save image url
                        saveProductImage(productId, p.getImage());
                        
                        // 3. Initialize inventory (use initial stock or default 100)
                        String sqlInv = "INSERT INTO Inventory (product_id, quantity, last_updated) VALUES (?, ?, GETDATE())";
                        try (PreparedStatement stInv = getConnection().prepareStatement(sqlInv)) {
                            stInv.setInt(1, productId);
                            stInv.setInt(2, p.getStockQuantity() >= 0 ? p.getStockQuantity() : 100);
                            stInv.executeUpdate();
                        }
                        
                        getConnection().commit();
                        getConnection().setAutoCommit(true);
                        return true;
                    }
                }
            }
            getConnection().rollback();
            getConnection().setAutoCommit(true);
        } catch (SQLException ex) {
            try {
                getConnection().rollback();
                getConnection().setAutoCommit(true);
            } catch (SQLException rollbackEx) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, rollbackEx);
            }
            System.err.println("[ProductDAO Error] Failed to insert new product!");
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public Product getProductById(int id) {
        String sql = "SELECT p.product_id, p.product_name, p.price, p.discount_price, p.unit, p.origin, p.status, p.description, c.category_name, pi.image_url, p.shop_owner_id, p.low_stock_threshold, i.quantity AS stock_quantity " +
                     "FROM Product p " +
                     "LEFT JOIN Product_Category c ON p.category_id = c.category_id " +
                     "LEFT JOIN Inventory i ON p.product_id = i.product_id " +
                     "LEFT JOIN (" +
                     "    SELECT product_id, image_url FROM (" +
                     "        SELECT product_id, image_url, ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY created_at DESC, image_id DESC) AS rn " +
                     "        FROM Product_Image" +
                     "    ) t WHERE rn = 1" +
                     ") pi ON pi.product_id = p.product_id " +
                     "WHERE p.product_id = ?";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return mapRowToProduct(rs);
                }
            }
        } catch (SQLException ex) {
            System.err.println("[ProductDAO Error] Failed to retrieve product by ID!");
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean updateProduct(Product p) {
        String sql = "UPDATE Product SET product_name=?, category_id=?, price=?, discount_price=?, unit=?, origin=?, status=?, description=?, low_stock_threshold=? " +
                     "WHERE product_id=?";

        try {
            int categoryId = getCategoryIdOrCreate(p.getCategory());
            if (p.getImage() == null || p.getImage().trim().isEmpty()) {
                p.setImage(DEFAULT_IMAGE);
            }
            String status = p.getStatus() != null ? p.getStatus() : (p.isFeatured() ? FEATURED_STATUS : DEFAULT_STATUS);

            getConnection().setAutoCommit(false);
            try (PreparedStatement st = getConnection().prepareStatement(sql)) {
                st.setNString(1, p.getName());
                st.setInt(2, categoryId);
                st.setDouble(3, p.getPrice());
                st.setDouble(4, p.getDiscountPrice());
                st.setNString(5, p.getUnit());
                st.setNString(6, p.getOrigin());
                st.setNString(7, status);
                st.setNString(8, p.getDescription());
                st.setInt(9, p.getLowStockThreshold() > 0 ? p.getLowStockThreshold() : 10);
                st.setInt(10, p.getId());

                int rowsAffected = st.executeUpdate();
                if (rowsAffected > 0) {
                    saveProductImage(p.getId(), p.getImage());
                    getConnection().commit();
                    getConnection().setAutoCommit(true);
                    return true;
                }
            }
            getConnection().rollback();
            getConnection().setAutoCommit(true);
        } catch (SQLException ex) {
            try {
                getConnection().rollback();
                getConnection().setAutoCommit(true);
            } catch (SQLException rollbackEx) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, rollbackEx);
            }
            System.err.println("[ProductDAO Error] Failed to update product!");
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean deleteProduct(int id) {
        String sqlDelInv = "DELETE FROM Inventory WHERE product_id = ?";
        String sqlDelImg = "DELETE FROM Product_Image WHERE product_id = ?";
        String sqlDelProd = "DELETE FROM Product WHERE product_id = ?";

        try {
            getConnection().setAutoCommit(false);

            try (PreparedStatement stDelInv = getConnection().prepareStatement(sqlDelInv);
                 PreparedStatement stDelImg = getConnection().prepareStatement(sqlDelImg);
                 PreparedStatement stDelProd = getConnection().prepareStatement(sqlDelProd)) {

                stDelInv.setInt(1, id);
                stDelInv.executeUpdate();

                stDelImg.setInt(1, id);
                stDelImg.executeUpdate();

                stDelProd.setInt(1, id);
                int rowsAffected = stDelProd.executeUpdate();

                if (rowsAffected > 0) {
                    getConnection().commit();
                    getConnection().setAutoCommit(true);
                    return true;
                }
            }
            getConnection().rollback();
            getConnection().setAutoCommit(true);
        } catch (SQLException ex) {
            try {
                getConnection().rollback();
                getConnection().setAutoCommit(true);
            } catch (SQLException rollbackEx) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, rollbackEx);
            }
            System.err.println("[ProductDAO Error] Failed to delete product!");
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    private int getCategoryIdOrCreate(String categoryName) throws SQLException {
        if (categoryName == null || categoryName.trim().isEmpty()) {
            categoryName = DEFAULT_CATEGORY;
        }

        String selectSql = "SELECT category_id FROM Product_Category WHERE category_name = ?";
        try (PreparedStatement st = getConnection().prepareStatement(selectSql)) {
            st.setNString(1, categoryName.trim());
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("category_id");
                }
            }
        }

        String insertSql = "INSERT INTO Product_Category (category_name) VALUES (?)";
        try (PreparedStatement st = getConnection().prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
            st.setNString(1, categoryName.trim());
            st.executeUpdate();
            try (ResultSet rs = st.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return -1;
    }

    private void saveProductImage(int productId, String imageUrl) throws SQLException {
        if (imageUrl == null || imageUrl.trim().isEmpty()) {
            imageUrl = DEFAULT_IMAGE;
        }

        String selectSql = "SELECT TOP 1 image_id FROM Product_Image WHERE product_id = ? ORDER BY created_at DESC, image_id DESC";
        try (PreparedStatement st = getConnection().prepareStatement(selectSql)) {
            st.setInt(1, productId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    int imageId = rs.getInt("image_id");
                    String updateSql = "UPDATE Product_Image SET image_url = ?, created_at = GETDATE() WHERE image_id = ?";
                    try (PreparedStatement updateStmt = getConnection().prepareStatement(updateSql)) {
                        updateStmt.setString(1, imageUrl);
                        updateStmt.setInt(2, imageId);
                        updateStmt.executeUpdate();
                    }
                    return;
                }
            }
        }

        String insertSql = "INSERT INTO Product_Image (product_id, image_url, created_at) VALUES (?, ?, GETDATE())";
        try (PreparedStatement st = getConnection().prepareStatement(insertSql)) {
            st.setInt(1, productId);
            st.setString(2, imageUrl);
            st.executeUpdate();
        }
    }

    private Product mapRowToProduct(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("product_id"));
        p.setName(rs.getNString("product_name"));
        p.setPrice(rs.getDouble("price"));
        p.setDiscountPrice(rs.getDouble("discount_price"));
        p.setUnit(rs.getNString("unit"));
        p.setOrigin(rs.getNString("origin"));
        p.setStatus(rs.getNString("status") != null ? rs.getNString("status") : DEFAULT_STATUS);
        p.setImage(rs.getString("image_url") != null ? rs.getString("image_url") : DEFAULT_IMAGE);
        p.setDescription(rs.getNString("description"));
        p.setCategory(rs.getNString("category_name") != null ? rs.getNString("category_name") : DEFAULT_CATEGORY);
        p.setShopOwnerId(rs.getInt("shop_owner_id"));
        
        try {
            p.setStockQuantity(rs.getInt("stock_quantity"));
        } catch (SQLException e) {
            // column not joined, default to 0
        }
        try {
            p.setLowStockThreshold(rs.getInt("low_stock_threshold"));
        } catch (SQLException e) {
            // column not selected, default to 10
            p.setLowStockThreshold(10);
        }
        return p;
    }

    public boolean updateStock(int productId, int quantity) {
        String sqlUpdate = "UPDATE Inventory SET quantity = ?, last_updated = GETDATE() WHERE product_id = ?";
        String sqlInsert = "INSERT INTO Inventory (product_id, quantity, last_updated) VALUES (?, ?, GETDATE())";
        try {
            try (PreparedStatement stUpdate = getConnection().prepareStatement(sqlUpdate)) {
                stUpdate.setInt(1, quantity);
                stUpdate.setInt(2, productId);
                int rowsUpdated = stUpdate.executeUpdate();
                if (rowsUpdated > 0) {
                    return true;
                }
            }
            
            // If the row doesn't exist in Inventory, insert it
            try (PreparedStatement stInsert = getConnection().prepareStatement(sqlInsert)) {
                stInsert.setInt(1, productId);
                stInsert.setInt(2, quantity);
                return stInsert.executeUpdate() > 0;
            }
        } catch (SQLException ex) {
            System.err.println("[ProductDAO Error] Failed to update stock!");
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean updateLowStockThreshold(int productId, int threshold) {
        String sql = "UPDATE Product SET low_stock_threshold = ? WHERE product_id = ?";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, threshold);
            st.setInt(2, productId);
            return st.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.err.println("[ProductDAO Error] Failed to update low stock threshold!");
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static void main(String[] args) {
        ProductDAO dao = new ProductDAO();
        List<Product> list = dao.getFilteredProducts("Cam", "All", null, null, "All");
        System.out.println("Search 'Cam' in 'All': " + list.size());
        for (Product p : list) {
            System.out.println(p);
        }
    }
}

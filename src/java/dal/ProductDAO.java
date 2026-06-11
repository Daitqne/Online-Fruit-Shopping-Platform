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
 * Fully synchronized with GreenStockDB schema.
 */
public class ProductDAO extends DBContext {

    /**
     * Helper to get category_id by category_name, or create it if not exists.
     */
    private int getOrCreateCategoryId(String categoryName) {
        String selectSql = "SELECT category_id FROM Product_Category WHERE category_name = ?";
        try (PreparedStatement st = getConnection().prepareStatement(selectSql)) {
            st.setString(1, categoryName.trim());
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("category_id");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        String insertSql = "INSERT INTO Product_Category (category_name) VALUES (?)";
        try (PreparedStatement st = getConnection().prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
            st.setString(1, categoryName.trim());
            st.executeUpdate();
            try (ResultSet rs = st.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 1; // Fallback default category ID
    }

    /**
     * Retrieves the top 8 featured (latest available) products from the database.
     * @return List of Product objects
     */
    public List<Product> getTop8FeaturedProducts() {
        List<Product> products = new ArrayList<>();
        String sql = """
            SELECT TOP 8 p.product_id AS id, p.product_name AS name, p.price, p.discount_price,
                         p.unit, p.origin, p.status, p.description, c.category_name AS category,
                         (SELECT TOP 1 image_url FROM Product_Image WHERE product_id = p.product_id ORDER BY image_id ASC) AS image
            FROM Product p
            LEFT JOIN Product_Category c ON p.category_id = c.category_id
            WHERE p.status = 'Available'
            ORDER BY p.product_id DESC
        """;
        
        try (PreparedStatement st = getConnection().prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getNString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setImage(rs.getString("image"));
                p.setDescription(rs.getNString("description"));
                p.setCategory(rs.getNString("category"));
                p.setFeatured(true);
                
                // Additional database fields
                p.setDiscountPrice(rs.getDouble("discount_price"));
                p.setUnit(rs.getString("unit"));
                p.setOrigin(rs.getString("origin"));
                p.setStatus(rs.getString("status"));
                
                products.add(p);
            }
        } catch (SQLException ex) {
            System.err.println("[ProductDAO Error] Failed to retrieve featured products!");
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return products;
    }

    /**
     * Retrieves products filtered dynamically by search query and category.
     * @param search Search keyword for name
     * @param category Category name ("All" or null to fetch all)
     * @return List of matching Product objects
     */
    public List<Product> getFilteredProducts(String search, String category) {
        List<Product> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder("""
            SELECT p.product_id AS id, p.product_name AS name, p.price, p.discount_price,
                   p.unit, p.origin, p.status, p.description, c.category_name AS category,
                   (SELECT TOP 1 image_url FROM Product_Image WHERE product_id = p.product_id ORDER BY image_id ASC) AS image
            FROM Product p
            LEFT JOIN Product_Category c ON p.category_id = c.category_id
            WHERE p.status = 'Available' 
        """);
        
        boolean hasSearch = (search != null && !search.trim().isEmpty());
        boolean hasCategory = (category != null && !category.trim().isEmpty() && !category.equalsIgnoreCase("All"));
        
        if (hasSearch) {
            sql.append("AND p.product_name LIKE ? ");
        }
        if (hasCategory) {
            sql.append("AND c.category_name = ? ");
        }
        sql.append("ORDER BY p.product_id DESC");
        
        try (PreparedStatement st = getConnection().prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (hasSearch) {
                st.setNString(paramIndex++, "%" + search.trim() + "%");
            }
            if (hasCategory) {
                st.setNString(paramIndex++, category.trim());
            }
            
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getNString("name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setImage(rs.getString("image"));
                    p.setDescription(rs.getNString("description"));
                    p.setCategory(rs.getNString("category"));
                    p.setFeatured(true);
                    
                    p.setDiscountPrice(rs.getDouble("discount_price"));
                    p.setUnit(rs.getString("unit"));
                    p.setOrigin(rs.getString("origin"));
                    p.setStatus(rs.getString("status"));
                    
                    products.add(p);
                }
            }
        } catch (SQLException ex) {
            System.err.println("[ProductDAO Error] Failed to retrieve filtered products!");
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return products;
    }

    /**
     * Retrieves all unique product categories.
     * @return List of category names
     */
    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT category_name FROM Product_Category ORDER BY category_name";
        
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

    /**
     * Adds a new product and its image to the database.
     * @param p Product object to insert
     * @return true if insertion succeeds, false otherwise
     */
    public boolean addProduct(Product p) {
        int categoryId = getOrCreateCategoryId(p.getCategory());
        
        String sqlProduct = """
            INSERT INTO Product (product_name, category_id, price, discount_price, unit, origin, status, description)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """;
        
        try {
            getConnection().setAutoCommit(false);
            
            // 1. Insert product
            PreparedStatement stProduct = getConnection().prepareStatement(sqlProduct, Statement.RETURN_GENERATED_KEYS);
            stProduct.setString(1, p.getName());
            stProduct.setInt(2, categoryId);
            stProduct.setDouble(3, p.getPrice());
            stProduct.setDouble(4, p.getDiscountPrice());
            stProduct.setString(5, p.getUnit() != null ? p.getUnit() : "kg");
            stProduct.setString(6, p.getOrigin() != null ? p.getOrigin() : "Vietnam");
            stProduct.setString(7, p.getStatus() != null ? p.getStatus() : "Available");
            stProduct.setString(8, p.getDescription());
            
            stProduct.executeUpdate();
            
            // Get generated product_id
            int productId = 0;
            try (ResultSet rs = stProduct.getGeneratedKeys()) {
                if (rs.next()) {
                    productId = rs.getInt(1);
                }
            }
            
            if (productId == 0) {
                getConnection().rollback();
                getConnection().setAutoCommit(true);
                return false;
            }
            
            // 2. Insert image
            if (p.getImage() != null && !p.getImage().trim().isEmpty()) {
                String sqlImage = "INSERT INTO Product_Image (product_id, image_url) VALUES (?, ?)";
                PreparedStatement stImage = getConnection().prepareStatement(sqlImage);
                stImage.setInt(1, productId);
                stImage.setString(2, p.getImage().trim());
                stImage.executeUpdate();
            }
            
            // 3. Initialize inventory
            String sqlInv = "INSERT INTO Inventory (product_id, quantity, last_updated) VALUES (?, ?, GETDATE())";
            PreparedStatement stInv = getConnection().prepareStatement(sqlInv);
            stInv.setInt(1, productId);
            stInv.setInt(2, 100); // Default inventory stock is 100
            stInv.executeUpdate();
            
            getConnection().commit();
            getConnection().setAutoCommit(true);
            return true;
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

    /**
     * Retrieves a single product by its ID.
     * @param id Product ID
     * @return Product object, or null if not found
     */
    public Product getProductById(int id) {
        String sql = """
            SELECT p.product_id AS id, p.product_name AS name, p.price, p.discount_price,
                   p.unit, p.origin, p.status, p.description, c.category_name AS category, c.category_id,
                   (SELECT TOP 1 image_url FROM Product_Image WHERE product_id = p.product_id ORDER BY image_id ASC) AS image
            FROM Product p
            LEFT JOIN Product_Category c ON p.category_id = c.category_id
            WHERE p.product_id = ?
        """;
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getNString("name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setImage(rs.getString("image"));
                    p.setDescription(rs.getNString("description"));
                    p.setCategory(rs.getNString("category"));
                    p.setFeatured(true);
                    
                    p.setCategoryId(rs.getInt("category_id"));
                    p.setDiscountPrice(rs.getDouble("discount_price"));
                    p.setUnit(rs.getString("unit"));
                    p.setOrigin(rs.getString("origin"));
                    p.setStatus(rs.getString("status"));
                    return p;
                }
            }
        } catch (SQLException ex) {
            System.err.println("[ProductDAO Error] Failed to retrieve product by ID!");
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * Updates an existing product in the database.
     * @param p Product object with updated data (must have valid id)
     * @return true if update succeeds, false otherwise
     */
    public boolean updateProduct(Product p) {
        int categoryId = getOrCreateCategoryId(p.getCategory());
        
        String sqlProduct = """
            UPDATE Product 
            SET product_name=?, category_id=?, price=?, discount_price=?, unit=?, origin=?, status=?, description=? 
            WHERE product_id=?
        """;
        
        try {
            getConnection().setAutoCommit(false);
            
            // 1. Update product details
            PreparedStatement stProduct = getConnection().prepareStatement(sqlProduct);
            stProduct.setString(1, p.getName());
            stProduct.setInt(2, categoryId);
            stProduct.setDouble(3, p.getPrice());
            stProduct.setDouble(4, p.getDiscountPrice());
            stProduct.setString(5, p.getUnit());
            stProduct.setString(6, p.getOrigin());
            stProduct.setString(7, p.getStatus());
            stProduct.setString(8, p.getDescription());
            stProduct.setInt(9, p.getId());
            
            stProduct.executeUpdate();
            
            // 2. Update image url (delete all old ones, insert the new one)
            String sqlDelImg = "DELETE FROM Product_Image WHERE product_id = ?";
            PreparedStatement stDelImg = getConnection().prepareStatement(sqlDelImg);
            stDelImg.setInt(1, p.getId());
            stDelImg.executeUpdate();
            
            if (p.getImage() != null && !p.getImage().trim().isEmpty()) {
                String sqlInsImg = "INSERT INTO Product_Image (product_id, image_url) VALUES (?, ?)";
                PreparedStatement stInsImg = getConnection().prepareStatement(sqlInsImg);
                stInsImg.setInt(1, p.getId());
                stInsImg.setString(2, p.getImage().trim());
                stInsImg.executeUpdate();
            }
            
            getConnection().commit();
            getConnection().setAutoCommit(true);
            return true;
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

    /**
     * Deletes a product from the database by its ID.
     * @param id Product ID to delete
     * @return true if deletion succeeds, false otherwise
     */
    public boolean deleteProduct(int id) {
        // Must delete dependent records because of foreign key constraints
        String sqlDelInv = "DELETE FROM Inventory WHERE product_id = ?";
        String sqlDelImg = "DELETE FROM Product_Image WHERE product_id = ?";
        String sqlDelProd = "DELETE FROM Product WHERE product_id = ?";
        
        try {
            getConnection().setAutoCommit(false);
            
            // Delete inventory
            PreparedStatement stDelInv = getConnection().prepareStatement(sqlDelInv);
            stDelInv.setInt(1, id);
            stDelInv.executeUpdate();
            
            // Delete image records
            PreparedStatement stDelImg = getConnection().prepareStatement(sqlDelImg);
            stDelImg.setInt(1, id);
            stDelImg.executeUpdate();
            
            // Delete product
            PreparedStatement stDelProd = getConnection().prepareStatement(sqlDelProd);
            stDelProd.setInt(1, id);
            int rowsAffected = stDelProd.executeUpdate();
            
            getConnection().commit();
            getConnection().setAutoCommit(true);
            return rowsAffected > 0;
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
}

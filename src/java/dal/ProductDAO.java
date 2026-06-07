package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;

/**
 * Product Data Access Object containing queries for the Products table.
 */
public class ProductDAO extends DBContext {

    /**
     * Retrieves the top 8 featured products from the database.
     * @return List of Product objects
     */
    public List<Product> getTop8FeaturedProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT TOP 8 id, name, price, image, description, category, isFeatured " +
                     "FROM Products " +
                     "WHERE isFeatured = 1 " +
                     "ORDER BY id DESC";
        
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
                p.setFeatured(rs.getBoolean("isFeatured"));
                
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
        StringBuilder sql = new StringBuilder("SELECT id, name, price, image, description, category, isFeatured " +
                                              "FROM Products WHERE 1=1 ");
        
        boolean hasSearch = (search != null && !search.trim().isEmpty());
        boolean hasCategory = (category != null && !category.trim().isEmpty() && !category.equalsIgnoreCase("All"));
        
        if (hasSearch) {
            sql.append("AND name LIKE ? ");
        }
        if (hasCategory) {
            sql.append("AND category = ? ");
        }
        sql.append("ORDER BY id DESC");
        
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
                    p.setFeatured(rs.getBoolean("isFeatured"));
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
        String sql = "SELECT DISTINCT category FROM Products WHERE category IS NOT NULL";
        
        try (PreparedStatement st = getConnection().prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            
            while (rs.next()) {
                categories.add(rs.getNString("category"));
            }
        } catch (SQLException ex) {
            System.err.println("[ProductDAO Error] Failed to retrieve categories!");
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return categories;
    }

    /**
     * Adds a new product to the database.
     * @param p Product object to insert
     * @return true if insertion succeeds, false otherwise
     */
    public boolean addProduct(Product p) {
        String sql = "INSERT INTO Products (name, price, image, description, category, isFeatured) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setNString(1, p.getName());
            st.setDouble(2, p.getPrice());
            st.setString(3, p.getImage());
            st.setNString(4, p.getDescription());
            st.setNString(5, p.getCategory());
            st.setBoolean(6, p.isFeatured());
            
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
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
        String sql = "SELECT id, name, price, image, description, category, isFeatured " +
                     "FROM Products WHERE id = ?";
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
                    p.setFeatured(rs.getBoolean("isFeatured"));
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
        String sql = "UPDATE Products SET name=?, price=?, image=?, description=?, category=?, isFeatured=? " +
                     "WHERE id=?";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setNString(1, p.getName());
            st.setDouble(2, p.getPrice());
            st.setString(3, p.getImage());
            st.setNString(4, p.getDescription());
            st.setNString(5, p.getCategory());
            st.setBoolean(6, p.isFeatured());
            st.setInt(7, p.getId());

            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
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
        String sql = "DELETE FROM Products WHERE id = ?";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, id);
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            System.err.println("[ProductDAO Error] Failed to delete product!");
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     * Test main to verify Product retrieval.
     */
    public static void main(String[] args) {
        ProductDAO dao = new ProductDAO();
        List<Product> list = dao.getFilteredProducts("Cam", "All");
        System.out.println("Search 'Cam' in 'All': " + list.size());
        for (Product p : list) {
            System.out.println(p);
        }
    }
}

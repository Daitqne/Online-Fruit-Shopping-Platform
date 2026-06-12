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
 * Product Data Access Object - mapping to actual DB schema:
 *   Product (product_id, product_name, category_id, price, discount_price, unit, origin, status, description)
 *   Product_Category (category_id, category_name)
 *   Product_Image (image_id, product_id, image_url, created_at)
 */
public class ProductDAO extends DBContext {

    // =====================================================
    // HELPER: map ResultSet -> Product object
    // =====================================================
    private Product mapRow(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("product_id"));
        p.setName(rs.getNString("product_name"));
        p.setPrice(rs.getDouble("price"));
        p.setDiscountPrice(rs.getDouble("discount_price"));
        p.setDescription(rs.getNString("description"));
        p.setUnit(rs.getNString("unit"));
        p.setOrigin(rs.getNString("origin"));
        p.setStatus(rs.getNString("status"));
        // category_name tu JOIN
        try { p.setCategory(rs.getNString("category_name")); } catch (SQLException e) { p.setCategory(""); }
        // image_url tu JOIN (lay anh dau tien)
        try { p.setImage(rs.getString("image_url")); } catch (SQLException e) { p.setImage(""); }
        return p;
    }

    // =====================================================
    // BASE QUERY (JOIN Category + Image dau tien)
    // =====================================================
    private static final String BASE_SELECT =
        "SELECT p.product_id, p.product_name, p.category_id, p.price, p.discount_price, " +
        "       p.unit, p.origin, p.status, p.description, " +
        "       c.category_name, " +
        "       (SELECT TOP 1 image_url FROM Product_Image pi WHERE pi.product_id = p.product_id ORDER BY pi.image_id) AS image_url " +
        "FROM Product p " +
        "LEFT JOIN Product_Category c ON p.category_id = c.category_id ";

    // =====================================================
    // LAY TAT CA SAN PHAM (cho trang quan ly)
    // =====================================================
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = BASE_SELECT + "ORDER BY p.product_id DESC";

        try (PreparedStatement st = getConnection().prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                products.add(mapRow(rs));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return products;
    }

    // =====================================================
    // LAY TOP 8 SAN PHAM NOI BAT (cho trang chu)
    // => Lay 8 san pham dau tien co status = 'Available'
    // =====================================================
    public List<Product> getTop8FeaturedProducts() {
        List<Product> products = new ArrayList<>();
        String sql = BASE_SELECT +
            "WHERE p.status = 'Available' " +
            "ORDER BY p.product_id DESC " +
            "OFFSET 0 ROWS FETCH NEXT 8 ROWS ONLY";

        try (PreparedStatement st = getConnection().prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                products.add(mapRow(rs));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return products;
    }

    // =====================================================
    // LAY SAN PHAM CO LOC (search + category)
    // =====================================================
    public List<Product> getFilteredProducts(String search, String category) {
        List<Product> products = new ArrayList<>();

        StringBuilder sql = new StringBuilder(BASE_SELECT + "WHERE 1=1 ");

        boolean hasSearch   = (search   != null && !search.trim().isEmpty());
        boolean hasCategory = (category != null && !category.trim().isEmpty()
                               && !category.equalsIgnoreCase("All"));

        if (hasSearch)   sql.append("AND (p.product_name LIKE ? OR p.description LIKE ?) ");
        if (hasCategory) sql.append("AND c.category_name = ? ");
        sql.append("ORDER BY p.product_id DESC");

        try (PreparedStatement st = getConnection().prepareStatement(sql.toString())) {
            int idx = 1;
            if (hasSearch) {
                st.setNString(idx++, "%" + search.trim() + "%");
                st.setNString(idx++, "%" + search.trim() + "%");
            }
            if (hasCategory) {
                st.setNString(idx++, category.trim());
            }

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    products.add(mapRow(rs));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return products;
    }

    // =====================================================
    // LAY TAT CA DANH MUC
    // =====================================================
    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT category_name FROM Product_Category ORDER BY category_name";

        try (PreparedStatement st = getConnection().prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                categories.add(rs.getNString("category_name"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return categories;
    }

    // =====================================================
    // LAY SAN PHAM THEO ID
    // =====================================================
    public Product getProductById(int id) {
        String sql = BASE_SELECT + "WHERE p.product_id = ?";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // =====================================================
    // THEM SAN PHAM MOI
    // =====================================================
    public boolean addProduct(Product p) {
        // Lay category_id tu ten danh muc
        int categoryId = getCategoryId(p.getCategory());

        String sql = "INSERT INTO Product (product_name, category_id, price, discount_price, unit, origin, status, description) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement st = getConnection().prepareStatement(sql,
                PreparedStatement.RETURN_GENERATED_KEYS)) {
            st.setNString(1, p.getName());
            st.setInt(2, categoryId);
            st.setDouble(3, p.getPrice());
            st.setDouble(4, p.getDiscountPrice());
            st.setNString(5, p.getUnit() != null ? p.getUnit() : "kg");
            st.setNString(6, p.getOrigin() != null ? p.getOrigin() : "");
            st.setNString(7, p.getStatus() != null ? p.getStatus() : "Available");
            st.setNString(8, p.getDescription());

            int rows = st.executeUpdate();
            if (rows > 0 && p.getImage() != null && !p.getImage().trim().isEmpty()) {
                ResultSet keys = st.getGeneratedKeys();
                if (keys.next()) {
                    int newId = keys.getInt(1);
                    insertProductImage(newId, p.getImage());
                }
            }
            return rows > 0;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // =====================================================
    // CAP NHAT SAN PHAM
    // =====================================================
    public boolean updateProduct(Product p) {
        int categoryId = getCategoryId(p.getCategory());

        String sql = "UPDATE Product SET product_name=?, category_id=?, price=?, " +
                     "discount_price=?, unit=?, origin=?, status=?, description=? " +
                     "WHERE product_id=?";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setNString(1, p.getName());
            st.setInt(2, categoryId);
            st.setDouble(3, p.getPrice());
            st.setDouble(4, p.getDiscountPrice());
            st.setNString(5, p.getUnit() != null ? p.getUnit() : "kg");
            st.setNString(6, p.getOrigin() != null ? p.getOrigin() : "");
            st.setNString(7, p.getStatus() != null ? p.getStatus() : "Available");
            st.setNString(8, p.getDescription());
            st.setInt(9, p.getId());

            int rows = st.executeUpdate();
            // Cap nhat anh neu co
            if (rows > 0 && p.getImage() != null && !p.getImage().trim().isEmpty()) {
                updateProductImage(p.getId(), p.getImage());
            }
            return rows > 0;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // =====================================================
    // XOA SAN PHAM
    // =====================================================
    public boolean deleteProduct(int id) {
        // Xoa anh truoc
        String sqlImg = "DELETE FROM Product_Image WHERE product_id = ?";
        try (PreparedStatement st = getConnection().prepareStatement(sqlImg)) {
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        String sql = "DELETE FROM Product WHERE product_id = ?";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, id);
            return st.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // =====================================================
    // HELPER: lay category_id tu category_name
    // =====================================================
    private int getCategoryId(String categoryName) {
        if (categoryName == null || categoryName.trim().isEmpty()) return 1;
        String sql = "SELECT category_id FROM Product_Category WHERE category_name = ?";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setNString(1, categoryName.trim());
            ResultSet rs = st.executeQuery();
            if (rs.next()) return rs.getInt("category_id");
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 1; // mac dinh category dau tien
    }

    // =====================================================
    // HELPER: them anh san pham
    // =====================================================
    private void insertProductImage(int productId, String imageUrl) {
        String sql = "INSERT INTO Product_Image (product_id, image_url) VALUES (?, ?)";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, productId);
            st.setString(2, imageUrl);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // =====================================================
    // HELPER: cap nhat anh san pham (xoa cu, them moi)
    // =====================================================
    private void updateProductImage(int productId, String imageUrl) {
        String sqlDel = "DELETE FROM Product_Image WHERE product_id = ?";
        try (PreparedStatement st = getConnection().prepareStatement(sqlDel)) {
            st.setInt(1, productId);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        insertProductImage(productId, imageUrl);
    }

    // =====================================================
    // TEST MAIN
    // =====================================================
    public static void main(String[] args) {
        ProductDAO dao = new ProductDAO();

        System.out.println("=== Test getAllCategories ===");
        for (String cat : dao.getAllCategories()) {
            System.out.println(" - " + cat);
        }

        System.out.println("\n=== Test getTop8FeaturedProducts ===");
        for (Product p : dao.getTop8FeaturedProducts()) {
            System.out.println(" - " + p);
        }

        System.out.println("\n=== Test getFilteredProducts('Apple', 'All') ===");
        for (Product p : dao.getFilteredProducts("Apple", "All")) {
            System.out.println(" - " + p);
        }
    }
}

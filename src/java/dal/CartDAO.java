package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Cart;
import model.CartItem;
import model.Product;

public class CartDAO extends DBContext {

    public CartDAO() {
        checkAndAddColumns();
    }

    private void checkAndAddColumns() {
        String[] cols = {
            "ALTER TABLE Cart_Item ADD variant_id INT NULL",
            "ALTER TABLE Cart_Item ADD packaging_id INT NULL"
        };
        for (String sql : cols) {
            try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
                ps.executeUpdate();
            } catch (SQLException e) {
                // Column probably already exists
            }
        }
    }

    /**
     * Gets the Cart for a user, or creates one if it doesn't exist.
     */
    public Cart getCartByUserId(int userId) {
        String selectSql = "SELECT cart_id, user_id, created_at FROM Cart WHERE user_id = ?";
        try (PreparedStatement st = getConnection().prepareStatement(selectSql)) {
            st.setInt(1, userId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    Cart cart = new Cart();
                    cart.setCartId(rs.getInt("cart_id"));
                    cart.setUserId(rs.getInt("user_id"));
                    cart.setCreatedAt(rs.getTimestamp("created_at"));
                    return cart;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Create new cart if it doesn't exist
        String insertSql = "INSERT INTO Cart (user_id, created_at) VALUES (?, GETDATE())";
        try (PreparedStatement st = getConnection().prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
            st.setInt(1, userId);
            st.executeUpdate();
            try (ResultSet rs = st.getGeneratedKeys()) {
                if (rs.next()) {
                    Cart cart = new Cart();
                    cart.setCartId(rs.getInt(1));
                    cart.setUserId(userId);
                    return cart;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * Retrieves all CartItems within a given cart, loading their associated Product details.
     */
    public List<CartItem> getCartItems(int cartId) {
        List<CartItem> items = new ArrayList<>();
        String sql = """
            SELECT ci.cart_item_id, ci.cart_id, ci.product_id, ci.quantity, ci.variant_id, ci.packaging_id,
                   p.product_name AS name, p.price, p.discount_price, p.description,
                   c.category_name AS category,
                   v.weight_label, v.price_adjustment AS variant_price_adjustment,
                   k.packaging_name, k.price_adjustment AS packaging_price_adjustment,
                   (SELECT TOP 1 image_url FROM Product_Image WHERE product_id = p.product_id ORDER BY image_id ASC) AS image
            FROM Cart_Item ci
            JOIN Product p ON ci.product_id = p.product_id
            LEFT JOIN Product_Category c ON p.category_id = c.category_id
            LEFT JOIN Product_Weight_Variant v ON ci.variant_id = v.variant_id
            LEFT JOIN Product_Packaging k ON ci.packaging_id = k.packaging_id
            WHERE ci.cart_id = ?
            ORDER BY ci.cart_item_id DESC
        """;

        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, cartId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem();
                    item.setCartItemId(rs.getInt("cart_item_id"));
                    item.setCartId(rs.getInt("cart_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));

                    int vId = rs.getInt("variant_id");
                    if (!rs.wasNull()) {
                        item.setVariantId(vId);
                        item.setWeightLabel(rs.getNString("weight_label"));
                        item.setVariantPriceAdjustment(rs.getDouble("variant_price_adjustment"));
                    } else {
                        item.setVariantId(null);
                        item.setWeightLabel(null);
                        item.setVariantPriceAdjustment(0);
                    }

                    int kId = rs.getInt("packaging_id");
                    if (!rs.wasNull()) {
                        item.setPackagingId(kId);
                        item.setPackagingName(rs.getNString("packaging_name"));
                        item.setPackagingPriceAdjustment(rs.getDouble("packaging_price_adjustment"));
                    } else {
                        item.setPackagingId(null);
                        item.setPackagingName(null);
                        item.setPackagingPriceAdjustment(0);
                    }

                    Product p = new Product();
                    p.setId(rs.getInt("product_id"));
                    p.setName(rs.getNString("name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setDiscountPrice(rs.getDouble("discount_price"));
                    p.setDescription(rs.getNString("description"));
                    p.setCategory(rs.getNString("category"));
                    p.setImage(rs.getString("image"));
                    item.setProduct(p);

                    items.add(item);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return items;
    }

    /**
     * Adds an item to the cart. If it already exists, increases its quantity.
     */
    public boolean addOrUpdateCartItem(int cartId, int productId, int quantity, Integer variantId, Integer packagingId) {
        String selectSql = "SELECT cart_item_id, quantity FROM Cart_Item WHERE cart_id = ? AND product_id = ? " +
                           "AND (variant_id = ? OR (variant_id IS NULL AND ? IS NULL)) " +
                           "AND (packaging_id = ? OR (packaging_id IS NULL AND ? IS NULL))";
        try (PreparedStatement selectSt = getConnection().prepareStatement(selectSql)) {
            selectSt.setInt(1, cartId);
            selectSt.setInt(2, productId);
            if (variantId != null) {
                selectSt.setInt(3, variantId);
                selectSt.setInt(4, variantId);
            } else {
                selectSt.setNull(3, java.sql.Types.INTEGER);
                selectSt.setNull(4, java.sql.Types.INTEGER);
            }
            if (packagingId != null) {
                selectSt.setInt(5, packagingId);
                selectSt.setInt(6, packagingId);
            } else {
                selectSt.setNull(5, java.sql.Types.INTEGER);
                selectSt.setNull(6, java.sql.Types.INTEGER);
            }
            
            try (ResultSet rs = selectSt.executeQuery()) {
                if (rs.next()) {
                    int cartItemId = rs.getInt("cart_item_id");
                    int oldQty = rs.getInt("quantity");
                    int newQty = oldQty + quantity;
                    if (newQty <= 0) {
                        return deleteCartItem(cartItemId);
                    }
                    String updateSql = "UPDATE Cart_Item SET quantity = ? WHERE cart_item_id = ?";
                    try (PreparedStatement updateSt = getConnection().prepareStatement(updateSql)) {
                        updateSt.setInt(1, newQty);
                        updateSt.setInt(2, cartItemId);
                        return updateSt.executeUpdate() > 0;
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Insert new item
        if (quantity <= 0) return false;
        String insertSql = "INSERT INTO Cart_Item (cart_id, product_id, quantity, variant_id, packaging_id) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement insertSt = getConnection().prepareStatement(insertSql)) {
            insertSt.setInt(1, cartId);
            insertSt.setInt(2, productId);
            insertSt.setInt(3, quantity);
            if (variantId != null) {
                insertSt.setInt(4, variantId);
            } else {
                insertSt.setNull(4, java.sql.Types.INTEGER);
            }
            if (packagingId != null) {
                insertSt.setInt(5, packagingId);
            } else {
                insertSt.setNull(5, java.sql.Types.INTEGER);
            }
            return insertSt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     * Directly updates a cart item's quantity.
     */
    public boolean updateCartItemQuantity(int cartItemId, int quantity) {
        if (quantity <= 0) {
            return deleteCartItem(cartItemId);
        }
        String sql = "UPDATE Cart_Item SET quantity = ? WHERE cart_item_id = ?";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, quantity);
            st.setInt(2, cartItemId);
            return st.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     * Deletes a cart item.
     */
    public boolean deleteCartItem(int cartItemId) {
        String sql = "DELETE FROM Cart_Item WHERE cart_item_id = ?";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, cartItemId);
            return st.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     * Counts the total number of items in the cart (sum of quantities).
     */
    public int getCartItemsCount(int cartId) {
        String sql = "SELECT SUM(quantity) AS total FROM Cart_Item WHERE cart_id = ?";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, cartId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    /**
     * Clears all items in the cart.
     */
    public boolean clearCart(int cartId) {
        String sql = "DELETE FROM Cart_Item WHERE cart_id = ?";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, cartId);
            return st.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}

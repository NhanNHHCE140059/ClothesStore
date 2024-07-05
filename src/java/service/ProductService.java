package service;

import db.DBContext;
import helper.ProductStatus;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;

/**
 *
 * @author Huenh
 */
public class ProductService {

    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DBContext dbcontext = new DBContext();

    public void updateProduct(String pro_name, double pro_price, String des, String image, int cat_id, int pro_id) {
        String updateProductQuery = "UPDATE Products "
                + "SET pro_name = ?, "
                + "    pro_price = ?, "
                + "    description = ?, "
                + "    imageURL = ?, "
                + "    cat_id = ? "
                + "WHERE pro_id = ?;";

        String updateCartQuery = "UPDATE c "
                + "SET c.pro_price = p.pro_price, "
                + "    c.Total_price = p.pro_price * c.pro_quantity "
                + "FROM Carts c "
                + "INNER JOIN ProductVariants pv ON c.variant_id = pv.variant_id "
                + "INNER JOIN Products p ON pv.pro_id = p.pro_id "
                + "WHERE p.pro_id = ?;";

        try {
            connection = dbcontext.getConnection();

            // Update Produc
            ps = connection.prepareStatement(updateProductQuery);
            ps.setString(1, pro_name);
            ps.setDouble(2, pro_price);
            ps.setString(3, des);
            ps.setString(4, image);
            ps.setInt(5, cat_id);
            ps.setInt(6, pro_id);
            ps.executeUpdate();
            ps.close();

            // Update Cart
            ps = connection.prepareStatement(updateCartQuery);
            ps.setInt(1, pro_id);
            ps.executeUpdate();
            ps.close();

        } catch (Exception e) {
            System.out.println("loiloiloi");
            e.printStackTrace();
        }
    }

    public Product GetProById(int id) {
        Product pro = null;
        String sql = "select * from Products where pro_id=?";
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                pro = new Product(
                        rs.getInt("pro_id"),
                        rs.getString("pro_name"),
                        rs.getDouble("pro_price"),
                        rs.getString("imageURL"),
                        rs.getString("description"),
                        rs.getInt("cat_id"),
                        ProductStatus.values()[rs.getInt("status_product")]
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception e) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, e);
        }

        return pro;
    }

    public List<Product> getRandom9Product() {
        List<Product> list9 = new ArrayList<>();
        String query = "SELECT TOP 9 *\n"
                + "FROM products\n"
                + "ORDER BY NEWID();";
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
             while (rs.next()) {
                list9.add(new Product(rs.getInt("pro_id"),
                        rs.getString("pro_name"),
                        rs.getDouble("pro_price"),
                        rs.getString("imageURL"),
                        rs.getString("description"),
                        rs.getInt("cat_id"),
                        ProductStatus.values()[rs.getInt("status_product")]));
            }
        } catch (Exception e) {
        }
        return list9;
    }

    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM Products";

        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt("pro_id"),
                        rs.getString("pro_name"),
                        rs.getDouble("pro_price"),
                        rs.getString("imageURL"),
                        rs.getString("description"),
                        rs.getInt("cat_id"),
                        ProductStatus.values()[rs.getInt("status_product")]));
            }
        } catch (Exception e) {
            System.out.println("An error occurred while fetching products: " + e.getMessage());
        }
        return list;
    }

    public boolean addProduct(String pro_name, double pro_price, String imageURL, String description, int cat_id, ProductStatus status_product) {

        try {

            String sql = "INSERT INTO Products (pro_name, pro_price, imageURL, description, cat_id, status_product) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, pro_name);
            ps.setDouble(2, pro_price);
            ps.setString(3, imageURL);
            ps.setString(4, description);
            ps.setInt(5, cat_id);
            ps.setInt(6, status_product.ordinal());

            ps.executeUpdate();

            System.out.println("Sản phẩm đã được thêm vào cơ sở dữ liệu!");

        } catch (SQLException e) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, e);
            return false;
        } catch (Exception e) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, e);
            return false;
        }
        return true;
    }

    public List<Product> searchByName(String txtSearch) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM Products WHERE pro_name LIKE ? AND status_product = 0";

        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, "%" + txtSearch + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("pro_id"),
                        rs.getString("pro_name"),
                        rs.getDouble("pro_price"),
                        rs.getString("imageURL"),
                        rs.getString("description"),
                        rs.getInt("cat_id"),
                        ProductStatus.values()[rs.getInt("status_product")]
                ));
            }
        } catch (SQLException e) {
            System.out.println("loi roi ban oi");
        } catch (Exception e) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, e);
        }
        return list;
    }

    public void hiddenProduct(int pro_id, int status) {
        String query = "UPDATE Products SET status_product = ? WHERE pro_id = ?";

        try {
            Connection connection = dbcontext.getConnection();
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, status);
            ps.setInt(2, pro_id);
            ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (Exception e) {
            System.out.println("Error while updating product status");
            e.printStackTrace();
        }
    }

    public void createProduct(String pro_name, double pro_price, String description, String imageURL, int cat_id, int status) {
        String query = "INSERT INTO Products (pro_name, pro_price, description, imageURL, cat_id, status_product) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try {
            Connection connection = dbcontext.getConnection();
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, pro_name);
            ps.setDouble(2, pro_price);
            ps.setString(3, description);
            ps.setString(4, imageURL);
            ps.setInt(5, cat_id);
            ps.setInt(6, status);
            ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (Exception e) {
            System.out.println("Error while creating product");
            e.printStackTrace();
        }
    }

    public List<Product> getAllProductsShop() {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM Products where status_product = 0";

        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt("pro_id"),
                        rs.getString("pro_name"),
                        rs.getDouble("pro_price"),
                        rs.getString("imageURL"),
                        rs.getString("description"),
                        rs.getInt("cat_id"),
                        ProductStatus.values()[rs.getInt("status_product")]));
            }
        } catch (Exception e) {
            System.out.println("An error occurred while fetching products: " + e.getMessage());
        }
        return list;
    }
}

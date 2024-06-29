package service;

import db.DBContext;
import helper.ProductStatus;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Cart;
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
        String query = "SELECT * FROM Products WHERE pro_name LIKE ?";

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

   public static void main(String[] args) {
    ProductService productService = new ProductService();
   }
}

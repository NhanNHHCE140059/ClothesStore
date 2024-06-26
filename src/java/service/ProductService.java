package service;

import db.DBContext;
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
                pro = new Product(rs.getInt("pro_id"),
                        rs.getString("pro_name"), rs.getDouble("pro_price"), rs.getString("imageURL"),
                        rs.getString("description"), rs.getString("cat_name"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception e) {
        }

        return pro;
    }

    public boolean addProduct(int id_account, int productID, String proname, int quantity, double price) {
        // Thực hiện kết nối đến cơ sở dữ liệu
        try {
            try {
                connection = dbcontext.getConnection();
            } catch (Exception ex) {
                Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, ex);
            }
            String sql = "INSERT INTO Carts (acc_id, pro_id, pro_name, pro_quantity, pro_price) "
                    + "VALUES (?, ?, ?, ?, ?)";

            ps = connection.prepareStatement(sql);

            ps.setInt(1, id_account);
            ps.setInt(2, productID);
            ps.setString(3, proname);
            ps.setInt(4, quantity);
            ps.setDouble(5, price);

            ps.executeUpdate();

            System.out.println("Sản phẩm đã được thêm vào giỏ hàng!");

        } catch (SQLException e) {
            if (e.getSQLState().equals("S0001")) {
                System.out.println("Qua so Luong");
                return false;
            }
        } catch (Exception e) {
            System.out.println("error");
            return false;
        }
        return true;
    }

    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String query = "select * from Products";

        try {
            connection = new DBContext().getConnection();
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3),
                        rs.getString(4), rs.getString(5), rs.getString(6)));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Product> searchByName(String txtSearch) {
        List<Product> list = new ArrayList<>();
        String query = "select * from Products where pro_name like ?";

        try {
            connection = new DBContext().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, "%" + txtSearch + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3),
                        rs.getString(4), rs.getString(5), rs.getString(6)));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public static void main(String[] args) {
        
    }
}

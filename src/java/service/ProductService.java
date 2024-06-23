package service;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
    public static void main(String[] args) {
        ProductService ps = new ProductService();
        if ( ps.addProduct(2, 3, "Watch", 1,100)) {
            System.out.println("Khong co van de");
        }else {
            System.out.println("Xu li jsp");
        }
    }
}

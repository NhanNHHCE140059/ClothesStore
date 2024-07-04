
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Cart;
import model.CartInfo;

public class CartService {

    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DBContext dbcontext = new DBContext();

    public LinkedList<Cart> GetListCartByAccID(int acc_id) {
        LinkedList<Cart> list = new LinkedList<>();
        String sql = "Select * from Carts where acc_id=?";
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, acc_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Cart(
                        rs.getInt("cart_id"),
                        rs.getInt("acc_id"),
                        rs.getInt("variant_id"),
                        rs.getInt("pro_quantity"),
                        rs.getDouble("pro_price"),
                        rs.getDouble("Total_price")
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {

        }
        return list;
    }

    public int AddCart(int acc_id, int variant_id, int pro_quantity, double pro_price, double Total_price) {
        int count = 0;
        String sql = "INSERT INTO Carts (acc_id, variant_id, pro_quantity, pro_price, Total_price) VALUES (?, ?, ?, ?, ?)";
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, acc_id);
            ps.setInt(2, variant_id);
            ps.setInt(3, pro_quantity);
            ps.setDouble(4, pro_price);
            ps.setDouble(5, Total_price);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CartService.class.getName()).log(Level.SEVERE, null, ex);
            if ("52000".equals(ex.getSQLState())) {
                count = -1;
            }
        } catch (Exception ex) {
            Logger.getLogger(CartService.class.getName()).log(Level.SEVERE, null, ex);
        }

        return count;
    }

    public int DeleteCart(int cart_id) {
        int count = 0;
        String sql = "Delete from Carts where cart_id=?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, cart_id);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CartService.class.getName()).log(Level.SEVERE, null, ex);
        }

        return count;

    }

    public int UpdateQuan(int pro_quantity, double Total_price, int cart_id, int variant_id) {
        int count = 0;
        String sql = "UPDATE Carts SET pro_quantity=?, Total_price=? WHERE cart_id=? AND variant_id=?";
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, pro_quantity);
            ps.setDouble(2, Total_price);
            ps.setInt(3, cart_id);
            ps.setInt(4, variant_id);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CartService.class.getName()).log(Level.SEVERE, null, ex);
            if ("52000".equals(ex.getSQLState())) {
                count = -1;
            }
        } catch (Exception ex) {
            Logger.getLogger(CartService.class.getName()).log(Level.SEVERE, null, ex);
        }

        return count;
    }

    public Cart GetCartById(int cart_id) {
        Cart c = null;
        String sql = "SELECT * FROM Carts WHERE cart_id=?";
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, cart_id);
            rs = ps.executeQuery();
            if (rs.next()) {
                c = new Cart(rs.getInt("cart_id"), rs.getInt("acc_id"),
                        rs.getInt("variant_id"), rs.getInt("pro_quantity"),
                        rs.getDouble("pro_price"), rs.getDouble("Total_price"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(CartService.class.getName()).log(Level.SEVERE, null, ex);
        }

        return c;
    }

    public LinkedList<CartInfo> GetTop5CartByAccID(int acc_id, int indexpage) {
        LinkedList<CartInfo> list = new LinkedList<>();
        String sql = "WITH x AS ("
                + "  SELECT ROW_NUMBER() OVER (ORDER BY c.cart_id ASC) AS r, "
                + "         c.cart_id, c.variant_id, c.pro_quantity, c.pro_price, c.Total_price, "
                + "         pc.color_name, pv.size_id, p.pro_name, p.imageURL "
                + "  FROM Carts c "
                + "  JOIN ProductVariants pv ON c.variant_id = pv.variant_id "
                + "  JOIN ProductColors pc ON pv.color_id = pc.color_id "
                + "  JOIN Products p ON pv.pro_id = p.pro_id "
                + "  WHERE c.acc_id = ? "
                + ") "
                + "SELECT * FROM x WHERE r BETWEEN ? * 5 - 4 AND ? * 5";
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, acc_id);
            ps.setInt(2, indexpage);
            ps.setInt(3, indexpage);
            rs = ps.executeQuery();
            while (rs.next()) {
                CartInfo cartInfo = new CartInfo(
                        rs.getInt("cart_id"),
                        rs.getInt("variant_id"),
                        rs.getInt("pro_quantity"),
                        rs.getDouble("pro_price"),
                        rs.getDouble("Total_price"),
                        rs.getString("color_name"),
                        rs.getInt("size_id"),
                        rs.getString("pro_name"),
                        rs.getString("imageURL")
                );
                list.add(cartInfo);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(CartService.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(CartService.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return list;
    }

    public int CountPageCart(int acc_id) {
        int count = 0;
        String query = "select count(*) from Carts where acc_id=?";
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, acc_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {

        }
        return count;
    }

    public static void main(String[] args) {
        CartService dao = new CartService();
        
    }
}

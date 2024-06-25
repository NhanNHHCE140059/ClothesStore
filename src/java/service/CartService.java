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
                list.add(new Cart(rs.getInt("cart_id"), rs.getInt("acc_id"),
                        rs.getInt("pro_id"), rs.getString("pro_name"), rs.getInt("pro_quantity"), rs.getDouble("pro_price"), rs.getDouble("Total_price")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {

        }
        return list;
    }

    public int AddCart(int acc_id, int pro_id, String pro_name, int pro_quantity, double pro_price, double Total_price) {
        int count = 0;
        String sql = "Insert into Carts values(?,?,?,?,?,?)";
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, acc_id);
            ps.setInt(2, pro_id);
            ps.setString(3, pro_name);
            ps.setInt(4, pro_quantity);
            ps.setDouble(5, pro_price);
            ps.setDouble(6, Total_price);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CartService.class.getName()).log(Level.SEVERE, null, ex);
            if ("52000".equals(ex.getSQLState())) {
                count = -1;
                return count;

            }
        } catch (Exception ex) {

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

    public int UpdateQuan(int pro_quantity, double Total_price, int cart_id, int pro_id) {
        int count = 0;
        String sql = "Update Carts set pro_quantity=?, Total_price=? where cart_id=? and pro_id=?";
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, pro_quantity);
            ps.setDouble(2, Total_price);
            ps.setInt(3, cart_id);
            ps.setInt(4, pro_id);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CartService.class.getName()).log(Level.SEVERE, null, ex);
            if ("52000".equals(ex.getSQLState())) {
                count = -1;
                return count;

            }
        } catch (Exception ex) {

        }

        return count;
    }

    public Cart GetCartById(int cart_id) {
        Cart c = null;
        String sql = "Select * from Carts where cart_id=?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, cart_id);
            rs = ps.executeQuery();
            if (rs.next()) {
                c = new Cart(rs.getInt("cart_id"), rs.getInt("acc_id"),
                        rs.getInt("pro_id"), rs.getString("pro_name"), rs.getInt("pro_quantity"), rs.getDouble("pro_price"), rs.getDouble("Total_price"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, ex);
        }

        return c;
    }

    public LinkedList<Cart> GetTop5CartByAccID(int acc_id, int indexpage) {
        LinkedList<Cart> list = new LinkedList<>();
        String sql = "with x as (select ROW_NUMBER() over (order by cart_id asc) as r\n"
                + "                    ,* from Carts where acc_id=? )\n"
                + "                    select * from x where r between ?*5-4 and ?*5";
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, acc_id);
            ps.setInt(2, indexpage);
            ps.setInt(3, indexpage);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Cart(rs.getInt("cart_id"), rs.getInt("acc_id"),
                        rs.getInt("pro_id"), rs.getString("pro_name"), rs.getInt("pro_quantity"), rs.getDouble("pro_price"), rs.getDouble("Total_price")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {

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

        try {
            LinkedList<Cart> cart = dao.GetListCartByAccID(1);
            for (Cart c : cart) {
                System.out.println(c.getTotal_price());
            }
        } catch (Exception e) {

            e.printStackTrace();
        }

    }
}

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
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.ProductColor;

/**
 *
 * @author My Computer
 */
public class ProductColorService {

    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DBContext dbcontext = new DBContext();

    public ProductColor getProductByName(String name) {
        ProductColor prdColor = new ProductColor();
        try {
            String query = "Select * form ProductColors where color_name = ?";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, name);
            rs = ps.executeQuery();
            while (rs.next()) {
                prdColor = new ProductColor(rs.getInt(1), rs.getString(2));
            }
        } catch (Exception e) {
        }
        return prdColor;
    }

    public ProductColor getProductColorByID(int ID) {
        ProductColor proColor = null;
        String query = "Select * from ProductColors where color_id= ?";
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, ID);
            rs = ps.executeQuery();
            while (rs.next()) {
                proColor = new ProductColor(
                        rs.getInt(1),
                        rs.getString(2));
            }
        } catch (Exception e) {
        }
        return proColor;
    }
    public ProductColor GetProColorByID(int id) {
        ProductColor pro = null;
        String sql = "select * from ProductColors where color_id =?";
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                pro = new ProductColor(
                        rs.getInt("color_id"),
                        rs.getString("color_name")
                );

            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception e) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, e);
        }

        return pro;
    }

    public ProductColor GetProColorByName(String color_name) {
        ProductColor pro = null;
        String sql = "select * from ProductColors where color_name =?";
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, color_name);
            rs = ps.executeQuery();
            if (rs.next()) {
                pro = new ProductColor(
                        rs.getInt("color_id"),
                        rs.getString("color_name")
                );

            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception e) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, e);
        }

        return pro;
    }

    public List<ProductColor> getALLProductColor() {
        List<ProductColor> list = new ArrayList<>();
        String sql = "Select * from ProductColors";
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new ProductColor(
                        rs.getInt("color_id"),
                        rs.getString("color_name")
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public boolean addNewColor(String color_name) {
        boolean isAdded = false;
        String sql = "INSERT INTO ProductColors (color_name) VALUES (?)";
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, color_name);
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                isAdded = true;
            }
        } catch (Exception e) {

        }
        return isAdded;
    }
}

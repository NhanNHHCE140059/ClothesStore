/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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

    public static void main(String[] args) {
        ProductColorService ps = new ProductColorService();
        ps.getProductColorByID(1);
        System.out.println(ps.getProductColorByID(2));
    }
}

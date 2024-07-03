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
    
}

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
    
    
    public ProductColor getProductByName (String name) {
        ProductColor prdColor = new ProductColor();
        try {
            String query = "Select * form ProductColors where color_name = ?";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1,name);
            rs = ps.executeQuery();
            while (rs.next()){
                prdColor = new ProductColor (rs.getInt(1),rs.getString(2));               
            }
        } catch (Exception e) {
        }
        return prdColor;
    }
}

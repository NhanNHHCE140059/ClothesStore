/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.ProductSize;

/**
 *
 * @author HP
 */
public class ProductSizeService {

    Connection connection = null;
    DBContext dbcontext = new DBContext();

    public List<ProductSize> selectAllProductSizes() {
        String sql = "SELECT * FROM ProductSizes;";
        List<ProductSize> productSizes = new ArrayList<>();
        try {
            connection = dbcontext.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                int size_id = rs.getInt("size_id");
                String size_name = rs.getString("size_name");
                productSizes.add(new ProductSize(size_id, size_name));
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return productSizes;
    }
}

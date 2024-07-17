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
import model.ProductImage;

/**
 *
 * @author My Computer
 */
public class ProductImageService {

    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DBContext dbcontext = new DBContext();

    public List<ProductImage> getImageByID(int id) {
        List<ProductImage> listImg = new ArrayList<>();
        try {
            String query = "Select * from ProductImages where pro_id = ?";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                listImg.add(new ProductImage(rs.getInt(1), rs.getInt(2), rs.getString(3)));
            }
        } catch (Exception e) {
        }
        return listImg;
    }
    
    public ProductImage getImageID(int id) {
        ProductImage img = new ProductImage();
        try {
            String query = "Select * from ProductImages where image_id = ?";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                img = new ProductImage(rs.getInt(1), rs.getInt(2), rs.getString(3));
            }
        } catch (Exception e) {
        }
        return img;
    }

    public void addProductImage(int productId, String imageURL) {
        String query = "INSERT INTO ProductImages (pro_id, imageURL) VALUES (?, ?)";

        try {
            Connection connection = dbcontext.getConnection();
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, productId);
            ps.setString(2, imageURL);
            ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (Exception e) {
            System.out.println("Error while adding product image");
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {

    }
}

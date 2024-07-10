/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import db.DBContext;
import helper.ProductStatus;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Favorite;
import model.Product;

/**
 *
 * @author My Computer
 */
public class FavoriteService {

    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DBContext dbcontext = new DBContext();

    public List<Favorite> getAllFavoriteByAccID(int acc_id) {
        List<Favorite> allListF = new ArrayList<>();
        try {
            String query = "Select * from Favorites where acc_id=?";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, acc_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                allListF.add(new Favorite(rs.getInt(1), rs.getInt(2), rs.getInt(3)));
            }
        } catch (Exception e) {
        }
        return allListF;
    }

    public List<Product> getAllProducts(int acc_id) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT \n"
                + "    p.[pro_id],\n"
                + "    p.[pro_name],\n"
                + "    p.[pro_price],\n"
                + "    p.[imageURL],\n"
                + "    p.[description],\n"
                + "    p.[cat_id],\n"
                + "    p.[status_product]\n"
                + "FROM \n"
                + "    [ClothesStore].[dbo].[Favorites] f\n"
                + "JOIN \n"
                + "    [ClothesStore].[dbo].[Products] p ON f.[pro_id] = p.[pro_id]\n"
                + "WHERE \n"
                + "    f.[acc_id] = ?; -- Replace @acc_id with the specific account ID";

        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, acc_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt("pro_id"),
                        rs.getString("pro_name"),
                        rs.getDouble("pro_price"),
                        rs.getString("imageURL"),
                        rs.getString("description"),
                        rs.getInt("cat_id"),
                        ProductStatus.values()[rs.getInt("status_product")]));
            }
        } catch (Exception e) {
            System.out.println("An error occurred while fetching products: " + e.getMessage());
        }
        return list;
    }

    public void insertFavorite(int acc_id, int pro_id) {
        try {
            String query = "INSERT INTO Favorites (acc_id, pro_id) VALUES (?, ?)";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, acc_id);
            ps.setInt(2, pro_id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(); // Optional: log the error for debugging
        } finally {
            // Optional: close resources to avoid memory leaks
            try {
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public void deleteAllFavoriteByAccID(int acc_id) {
        try {
            String query = "DELETE FROM Favorites WHERE acc_id=?";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, acc_id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(); // Optional: log the error for debugging
        } finally {
            // Optional: close resources to avoid memory leaks
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
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}

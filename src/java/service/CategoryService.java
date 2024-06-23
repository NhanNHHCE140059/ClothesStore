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
import model.Category;
import helper.CategoryType;

/**
 *
 * @author My Computer
 */
public class CategoryService {

    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DBContext dbcontext = new DBContext();

    public boolean createCategory(String category) {
        boolean result = false;
        try {
            String query = "INSERT INTO categories VALUES (?)";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, category);
            result = ps.execute();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL error occurred while fetching account.");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("An unexpected error occurred.");
        }
        return result;
    }

    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        try {
            String query = "SELECT * FROM categories";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("cat_id");
                CategoryType name = CategoryType.valueOf(rs.getString("cat_name"));
                categories.add(new Category(id, name));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL error occurred while fetching categories.");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("An unexpected error occurred.");
        }
        return categories;
    }
}

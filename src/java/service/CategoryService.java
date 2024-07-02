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
import model.Category;

/**
 *
 * @author My Computer
 */
public class CategoryService {

    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DBContext dbcontext = new DBContext();

    public Category getNameCateByIDCate(int id_cate) {
        Category category = null;
        try {
            String query = "Select * from Categories where cat_id=?";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, id_cate);
            rs = ps.executeQuery();
            while (rs.next()) {
                category = new Category(rs.getInt(1), rs.getString(2));
            }
        } catch (Exception e) {
        }
        return category;
    }

    public boolean addNewCategory(String cat_name) {
        boolean isAdded = false;
        try {
            String query = "INSERT INTO Categories (cat_name) VALUES (?)";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, cat_name);
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                isAdded = true;
            }
        } catch (Exception e) {

        }
        return isAdded;
    }

    public List<Category> getAllCate() {
        List<Category> list = new ArrayList<>();
        try {
            String query = "Select * from Categories";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Category(rs.getInt(1), rs.getString(2)));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public static void main(String[] args) {
        CategoryService cate = new CategoryService();
    }
}

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

    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String query = "SELECT * FROM Categories";
        try {
            Connection conn = dbcontext.getConnection();
            PreparedStatement st = conn.prepareStatement(query);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int cat_id = rs.getInt("cat_id");
                String cat_name = rs.getString("cat_name");
                Category category = new Category(cat_id, cat_name);
                categories.add(category);
            }
        } catch (Exception e) {
            System.out.println("Error fetching categories: " + e);
        }
        return categories;
    }

    public Category getCategory(int id) {
        Category category = null;
        String query = "SELECT * FROM Categories WHERE cat_id = ?";
        try {
            Connection conn = dbcontext.getConnection();
            PreparedStatement st = conn.prepareStatement(query);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                String cat_name = rs.getString("cat_name");
                category = new Category(id, cat_name);
            }
        } catch (Exception e) {
            System.out.println("Error fetching category: " + e);
        }
        return category;
    }

    public void insertCategory(Category category) {
        String query = "INSERT INTO Categories (cat_name) VALUES (?)";
        try {
            Connection conn = dbcontext.getConnection();
            PreparedStatement st = conn.prepareStatement(query);
            st.setString(1, category.getCat_name());
            st.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error inserting category: " + e);
        }
    }

    public void updateCategory(Category category) {
        String query = "UPDATE Categories SET cat_name = ? WHERE cat_id = ?";
        try {
            Connection conn = dbcontext.getConnection();
            PreparedStatement st = conn.prepareStatement(query);
            st.setString(1, category.getCat_name());
            st.setInt(2, category.getCat_id());
            st.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error updating category: " + e);
        }
    }

    public void deleteCategory(int id) {
        String query = "DELETE FROM Categories WHERE cat_id = ?";
        try {
            Connection conn = dbcontext.getConnection();
            PreparedStatement st = conn.prepareStatement(query);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error deleting category: " + e);
        }
    }

    public static void main(String[] args) {
        CategoryService cate = new CategoryService();

    }
}

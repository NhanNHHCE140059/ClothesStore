/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
        Category category = new Category();
        try {
            String query = "Select * from Categories where cat_id=?";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1,id_cate);
            while (rs.next()){
                category = new Category(rs.getInt(1),rs.getString(2));
            }
        } catch (Exception e) {
        }
        return category;
    }
    public static void main(String[] args) {
        CategoryService cate = new CategoryService();
    
    }
}

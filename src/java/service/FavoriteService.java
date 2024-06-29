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
import model.Favorite;

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
            String query = "Select * from Favorites by acc_id=?";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, acc_id);
            while (rs.next()) {
                allListF.add(new Favorite(rs.getInt(1), rs.getInt(2), rs.getInt(3)));
            }
        } catch (Exception e) {
        }
        return allListF;
    }

}

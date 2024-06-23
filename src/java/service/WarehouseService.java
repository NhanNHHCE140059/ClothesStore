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
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Warehouse;

/**
 *
 * @author My Computer
 */
public class WarehouseService {

    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DBContext dbcontext = new DBContext();

    public Warehouse GetProByIdInWareHouse(int id) {
        Warehouse ware = null;
        String sql = "select * from Warehouses where pro_id=?";
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                ware = new Warehouse(rs.getInt("ware_id"),
                        rs.getInt("bill_id"), rs.getInt("pro_id"), rs.getDate("import_date"),
                        rs.getInt("inventory_number"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception e) {
        }

        return ware;
    }
}

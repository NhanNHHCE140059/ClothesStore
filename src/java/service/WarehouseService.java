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

    public int countTotalProductInWareHouseByID(int pro_id) {
        int total = 0;
        try {
            String query = "SELECT w. inventory_number\n"
                    + "FROM warehouses w\n"
                    + "JOIN [dbo].[ProductVariants] v ON w.variant_id = v.variant_id\n"
                    + "WHERE v.pro_id = ?";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, pro_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                total += rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return total;
    }

    public Warehouse GetProByIdInWareHouse(int id) {
        Warehouse ware = null;
        String sql = "select * from Warehouses where variant_id=?";
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                ware = new Warehouse(
                        rs.getInt("ware_id"),
                        rs.getInt("bill_id"),
                        rs.getInt("variant_id"),
                        rs.getDate("import_date"),
                        rs.getInt("inventory_number")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception e) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, e);
        }

        return ware;
    }
}

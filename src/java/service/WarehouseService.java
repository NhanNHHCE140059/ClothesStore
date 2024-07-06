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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;
import model.Warehouse;
import model.WarehouseProduct;

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

    public List<WarehouseProduct> getAllWarehouse() {
        List<WarehouseProduct> wh = new ArrayList<>();
        String sql = "SELECT w.*, pv.pro_id, p.pro_name, p.pro_price, c.color_name, s.size_name, pi.imageURL\n"
                + "FROM Warehouses w\n"
                + "JOIN ProductVariants pv ON w.variant_id = pv.variant_id\n"
                + "JOIN Products p ON pv.pro_id = p.pro_id\n"
                + "JOIN ProductColors c ON pv.color_id = c.color_id\n"
                + "JOIN ProductSizes s ON pv.size_id = s.size_id\n"
                + "JOIN ProductImages pi ON pv.image_id = pi.image_id";
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                wh.add(new WarehouseProduct(
                        rs.getInt("ware_id"),
                        rs.getInt("bill_id"),
                        rs.getInt("variant_id"),
                        rs.getInt("pro_id"),
                        rs.getString("pro_name"),
                        rs.getDouble("pro_price"),
                        rs.getDate("import_date"),
                        rs.getInt("inventory_number"),
                        rs.getString("color_name"),
                        rs.getString("size_name"),
                        rs.getString("imageURL")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return wh;
    }

    public List search(String text) {
        List<WarehouseProduct> wplist = new ArrayList<>();
        String query = "SELECT w.*, pv.pro_id, p.pro_name, p.pro_price, c.color_name, s.size_name, pi.imageURL\n"
                + "FROM Warehouses w\n"
                + "JOIN ProductVariants pv ON w.variant_id = pv.variant_id\n"
                + "JOIN Products p ON pv.pro_id = p.pro_id\n"
                + "JOIN ProductColors c ON pv.color_id = c.color_id\n"
                + "JOIN ProductSizes s ON pv.size_id = s.size_id\n"
                + "JOIN ProductImages pi ON pv.image_id = pi.image_id where p.pro_name like ?";
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, "%" + text + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                wplist.add(new WarehouseProduct(
                        rs.getInt("ware_id"),
                        rs.getInt("bill_id"),
                        rs.getInt("variant_id"),
                        rs.getInt("pro_id"),
                        rs.getString("pro_name"),
                        rs.getDouble("pro_price"),
                        rs.getDate("import_date"),
                        rs.getInt("inventory_number"),
                        rs.getString("color_name"),
                        rs.getString("size_name"),
                        rs.getString("imageURL")
                ));
            }

        } catch (Exception ex) {
            Logger.getLogger(WarehouseService.class.getName()).log(Level.SEVERE, null, ex);
        }

        return wplist;
    }

    public static void main(String[] args) {
        WarehouseService service = new WarehouseService();
        List<WarehouseProduct> warehouseProducts = service.search("Summer");
        // In ra danh sách sản phẩm trong kho
        for (WarehouseProduct wp : warehouseProducts) {
            System.out.println(wp);
        }
    }
}

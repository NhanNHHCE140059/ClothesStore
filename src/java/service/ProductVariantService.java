/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import db.DBContext;
import helper.ProductSizeType;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.function.Function;
import model.ProductsVariant;

/**
 *
 * @author My Computer
 */
public class ProductVariantService {

    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DBContext dbcontext = new DBContext();

    public Map<String, Set<String>> getVariantsByProductId(int productId) {
        Map<String, Set<String>> variants = new HashMap<>();
        Set<String> uniqueColors = new HashSet<>();
        String query = "SELECT ps.size_name, pc.color_name\n"
                + "FROM ProductVariants pv\n"
                + "JOIN [dbo].[ProductSizes] ps ON pv.size_id = ps.size_id\n"
                + "JOIN [dbo].[ProductColors] pc ON pv.color_id = pc.color_id\n"
                + "WHERE pv.pro_id = ?";

        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, productId);
            rs = ps.executeQuery();
            while (rs.next()) {
                String size = rs.getString("size_name");
                String color = rs.getString("color_name");
                variants.computeIfAbsent(size, new Function<String, Set<String>>() {
                    @Override
                    public Set<String> apply(String k) {
                        return new HashSet<>();
                    }
                }).add(color);

                uniqueColors.add(color);
            }

        } catch (Exception e) {
            System.out.println("loiroibanoi@@@");
        }

        variants.put("ALL_COLORS", uniqueColors);
        return variants;
    }

    public ProductsVariant getPVbyColorAndSize(int pro_id, String size_name, String color_name) {
        ProductsVariant pv = null;
        try {
            String query = "SELECT pv.*\n"
                    + "FROM ProductVariants pv\n"
                    + "JOIN ProductSizes ps ON pv.size_id = ps.size_id\n"
                    + "JOIN ProductColors pc ON pv.color_id = pc.color_id\n"
                    + "WHERE pv.pro_id = ? AND ps.size_name = ? AND pc.color_name = ?;";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, pro_id);
            ps.setString(2, size_name);
            ps.setString(3, color_name);
            rs = ps.executeQuery();
            while (rs.next()) {
                pv = new ProductsVariant(rs.getInt(1), rs.getInt(2), ProductSizeType.values()[rs.getInt(3)], rs.getInt(4), rs.getInt(5));
            }
        } catch (Exception e) {
        }
        return pv;
    }

    public Map<String, Integer> getProductVariantByProIDAndSizeID(int pro_id, int size_id) {
        Map<String, Integer> colorQuantityMap = new HashMap<>();
        try {
            String query = "SELECT pc.color_name, w.inventory_number "
                    + "FROM ProductVariants pv "
                    + "JOIN ProductColors pc ON pv.color_id = pc.color_id "
                    + "JOIN Warehouses w ON pv.variant_id = w.variant_id "
                    + "WHERE pv.pro_id = ? AND pv.size_id = ?";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, pro_id);
            ps.setInt(2, size_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                String colorName = rs.getString("color_name");
                int quantity = rs.getInt("inventory_number");
                colorQuantityMap.put(colorName, quantity);
            }
        } catch (Exception e) {
            System.out.println("Error");
        }
        return colorQuantityMap;
    }

    public Set<String> getSizesByProIDAndColorName(int pro_id, String color_name) {
        Set<String> sizes = new HashSet<>();
        try {
            String query = "SELECT DISTINCT pv.size_id "
                    + "FROM ProductVariants pv "
                    + "JOIN ProductColors pc ON pv.color_id = pc.color_id "
                    + "WHERE pv.pro_id = ? AND pc.color_name = ?";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, pro_id);
            ps.setString(2, color_name);
            rs = ps.executeQuery();
            while (rs.next()) {
                String size_id = ProductSizeType.values()[rs.getInt("size_id")].name();
                sizes.add(size_id);
            }
        } catch (Exception e) {
            System.out.println(" loi roi ");
        }
        return sizes;
    }

    public int getQuantityBySizeAndProductID(int pro_id, String size_name) {
        int quantity = 0;
        try {
            String query = "SELECT SUM(w.inventory_number) AS total_quantity\n"
                    + "FROM ProductVariants pv\n"
                    + "JOIN Warehouses w ON pv.variant_id = w.variant_id\n"
                    + "WHERE pv.pro_id = ? AND pv.size_id = ?\n"
                    + "GROUP BY pv.size_id;";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, pro_id);
            ProductSizeType sizeEnum = ProductSizeType.valueOf(size_name);
            int size_name_ordinal = sizeEnum.ordinal();
            ps.setInt(2, size_name_ordinal);
            rs = ps.executeQuery();
            while (rs.next()) {
                quantity = rs.getInt(1);
            }

        } catch (Exception e) {
        }
        return quantity;
    }

    public static void main(String[] args) {
        ProductVariantService pv = new ProductVariantService();
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
            ps.setInt(1,productId);
            rs = ps.executeQuery();
            while (rs.next()) {
                String size = rs.getString("size_name");
                String color = rs.getString("color_name");

                variants.computeIfAbsent(size, k -> new HashSet<>()).add(color);
                uniqueColors.add(color);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        variants.put("ALL_COLORS", uniqueColors); // Add all unique colors under a special key
        return variants;
    }

    public static void main(String[] args) {
        ProductVariantService service = new ProductVariantService();
        int productId = 1; 
        Map<String, Set<String>> variants = service.getVariantsByProductId(productId);
        for (Map.Entry<String, Set<String>> entry : variants.entrySet()) {
            String size = entry.getKey();
            Set<String> colors = entry.getValue();
            System.out.println("Size: " + size);
            for (String color : colors) {
                System.out.println("  Color: " + color);
            }
        }
    }
}

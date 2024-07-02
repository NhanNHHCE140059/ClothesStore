/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import db.DBContext;
import helper.ProductSizeType;
import helper.ProductStatus;
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
import model.Product;
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
    
    public List<ProductsVariant> getAllProducts() {
        List<ProductsVariant> list = new ArrayList<>();
        String query = "SELECT * FROM ProductVariants";

        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new ProductsVariant(rs.getInt("variant_id"),
                        rs.getInt("pro_id"),
                        ProductSizeType.values()[rs.getInt("size_id")],
                        rs.getInt("color_id"),
                        rs.getInt("image_id"))
                );
            }
        } catch (Exception e) {
            System.out.println("An error occurred while fetching products: " + e.getMessage());
        }
        return list;
    }
    
    // Xu li phan trang cho order da ship ( for feedbackManager) 
    // Dem so luong trang can xu li 
    public int countPageforProduct() {
        int countPage = 0;
        try {
            String query = "select count(*) from ProductVariants";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                countPage = rs.getInt(1);
            }

        } catch (Exception e) {
        }
        return countPage;
    }
    
    public List<ProductsVariant> getTop5Pro(int indexPage) {
        List<ProductsVariant> listTop5ProVar = new ArrayList<>();
        try {
            String query = "with x as (select ROW_NUMBER() over (order by variant_id desc) as r \n"
                    + ", * from ProductVariants)\n"
                    + "select * from x where r between ?*5-4 and ?*5";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, indexPage);
            ps.setInt(2, indexPage);
            rs = ps.executeQuery();
            while (rs.next()) {
                listTop5ProVar.add(new ProductsVariant(rs.getInt("variant_id"),
                        rs.getInt("pro_id"),
                        ProductSizeType.values()[rs.getInt("size_id")],
                        rs.getInt("color_id"),
                        rs.getInt("image_id"))
                );
            }
            return listTop5ProVar;
        } catch (Exception e) {
        }
        return null;
    }

    public static void main(String[] args) {
        ProductVariantService service = new ProductVariantService();
        int productId = 1; // Thay đổi ID sản phẩm theo yêu cầu của bạn
        Map<String, Set<String>> variants = service.getVariantsByProductId(productId);
        for (Map.Entry<String, Set<String>> entry : variants.entrySet()) {
            String size = entry.getKey();
            Set<String> colors = entry.getValue();
            System.out.println(size);
            for (String color : colors) {
                System.out.println(color);
            }
        }
    }
}

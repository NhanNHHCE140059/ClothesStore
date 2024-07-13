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
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.function.Function;
import model.ProductVariantInfo;
import model.Product;
import model.ProductVariantInfomation;
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

    public List<ProductVariantInfo> searchByName(String name) {
        List<ProductVariantInfo> listAll = new ArrayList<>();
        try {
            String query = "SELECT \n"
                    + "    pv.variant_id,\n"
                    + "    p.pro_id,\n"
                    + "    p.pro_name,\n"
                    + "    p.pro_price,\n"
                    + "    pc.color_id,\n"
                    + "    pc.color_name,\n"
                    + "    ps.size_id,\n"
                    + "    pi.imageURL,\n"
                    + "    c.cat_id,\n"
                    + "    c.cat_name\n"
                    + "FROM \n"
                    + "    ProductVariants pv\n"
                    + "JOIN \n"
                    + "    Products p ON pv.pro_id = p.pro_id\n"
                    + "JOIN \n"
                    + "    ProductColors pc ON pv.color_id = pc.color_id\n"
                    + "JOIN \n"
                    + "    ProductSizes ps ON pv.size_id = ps.size_id\n"
                    + "JOIN \n"
                    + "    ProductImages pi ON pv.image_id = pi.image_id\n"
                    + "JOIN\n"
                    + "    Categories c ON p.cat_id = c.cat_id\n"
                    + "WHERE pro_name LIKE ?";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, "%" + name + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                listAll.add(
                        new ProductVariantInfo(
                                rs.getInt(1),
                                rs.getInt(2),
                                rs.getString(3),
                                rs.getDouble(4),
                                rs.getInt(5),
                                rs.getString(6),
                                ProductSizeType.values()[rs.getInt(7)],
                                rs.getString(8),
                                rs.getInt(9),
                                rs.getString(10)
                        )
                );
            }
        } catch (Exception e) {
        }
        return listAll;
    }

    public List<ProductVariantInfo> getAllVariantInfo() {
        List<ProductVariantInfo> listAll = new ArrayList<>();
        try {
            String query = "SELECT \n"
                    + "    pv.variant_id,\n"
                    + "    p.pro_id,\n"
                    + "    p.pro_name,\n"
                    + "    p.pro_price,\n"
                    + "    pc.color_id,\n"
                    + "    pc.color_name,\n"
                    + "    ps.size_id,\n"
                    + "    pi.imageURL,\n"
                    + "    c.cat_id,\n"
                    + "    c.cat_name\n"
                    + "FROM \n"
                    + "    ProductVariants pv\n"
                    + "JOIN \n"
                    + "    Products p ON pv.pro_id = p.pro_id\n"
                    + "JOIN \n"
                    + "    ProductColors pc ON pv.color_id = pc.color_id\n"
                    + "JOIN \n"
                    + "    ProductSizes ps ON pv.size_id = ps.size_id\n"
                    + "JOIN \n"
                    + "    ProductImages pi ON pv.image_id = pi.image_id\n"
                    + "JOIN\n"
                    + "    Categories c ON p.cat_id = c.cat_id;";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                listAll.add(
                        new ProductVariantInfo(
                                rs.getInt(1),
                                rs.getInt(2),
                                rs.getString(3),
                                rs.getDouble(4),
                                rs.getInt(5),
                                rs.getString(6),
                                ProductSizeType.values()[rs.getInt(7)],
                                rs.getString(8),
                                rs.getInt(9),
                                rs.getString(10)
                        )
                );
            }
        } catch (Exception e) {
        }
        return listAll;
    }

    public ProductsVariant getVariantByID(int variant_id) {
        ProductsVariant productV = null;
        String query = "Select * from ProductVariants where variant_id=?";
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, variant_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                productV = new ProductsVariant(
                        rs.getInt(1),
                        rs.getInt(2),
                        ProductSizeType.values()[rs.getInt(3)],
                        rs.getInt(4),
                        rs.getInt(5)
                );
            }
        } catch (Exception e) {

        }
        return productV;
    }

    public List<ProductVariantInfomation> searchProductVariants(String sizeName, String categoryName, String colorName, String productName) {
        List<ProductVariantInfomation> productVariants = new ArrayList<>();

        StringBuilder query = new StringBuilder("SELECT pv.variant_id, p.pro_id, p.pro_name, p.pro_price, c.cat_name, ps.size_name, p.description, pc.color_name, pi.imageURL "
                + "FROM ProductVariants pv "
                + "JOIN Products p ON pv.pro_id = p.pro_id "
                + "JOIN Categories c ON p.cat_id = c.cat_id "
                + "JOIN ProductSizes ps ON pv.size_id = ps.size_id "
                + "JOIN ProductColors pc ON pv.color_id = pc.color_id "
                + "JOIN ProductImages pi ON pv.image_id = pi.image_id "
                + "WHERE 1=1 ");

        if (sizeName != null && !sizeName.isEmpty()) {
            query.append("AND ps.size_name LIKE ? ");
        }
        if (categoryName != null && !categoryName.isEmpty()) {
            query.append("AND c.cat_name LIKE ? ");
        }
        if (colorName != null && !colorName.isEmpty()) {
            query.append("AND pc.color_name LIKE ? ");
        }
        if (productName != null && !productName.isEmpty()) {
            query.append("AND p.pro_name LIKE ? ");
        }

        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query.toString());
            int index = 1;
            if (sizeName != null && !sizeName.isEmpty()) {
                ps.setString(index++, "%" + sizeName + "%");
            }
            if (categoryName != null && !categoryName.isEmpty()) {
                ps.setString(index++, "%" + categoryName + "%");
            }
            if (colorName != null && !colorName.isEmpty()) {
                ps.setString(index++, "%" + colorName + "%");
            }
            if (productName != null && !productName.isEmpty()) {
                ps.setString(index++, "%" + productName + "%");
            }
            rs = ps.executeQuery();
            {
                while (rs.next()) {
                    productVariants.add(new ProductVariantInfomation(
                            rs.getInt("variant_id"),
                            rs.getInt("pro_id"),
                            rs.getString("pro_name"),
                            rs.getDouble("pro_price"),
                            rs.getString("cat_name"),
                            ProductSizeType.valueOf(rs.getString("size_name")),
                            rs.getString("description"),
                            rs.getString("color_name"),
                            rs.getString("imageURL")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return productVariants;
    }

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

                new Runnable() {
                    @Override
                    public void run() {
                        variants.computeIfAbsent(size, k -> new HashSet<>()).add(color);
                    }
                }.run();
                uniqueColors.add(color);
            }

        } catch (Exception e) {
            System.out.println("loiroibanoi@@@");
        }

        variants.put("ALL_COLORS", uniqueColors);
        return variants;
    }

    public int addProductImage(int proId, String imageUrl) {
        String query = "INSERT INTO ProductImages (pro_id, imageURL) VALUES (?, ?)";
        int imageId = -1;

        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, proId);
            ps.setString(2, imageUrl);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    imageId = rs.getInt(1); // Giả sử khóa chính là kiểu int
                }
            }
        } catch (Exception e) {
            System.out.println("An error occurred while adding new product image: " + e.getMessage());
        }
        return imageId;
    }

    public boolean addNewVariant(int proId, int sizeId, int colorId, int imageId) {
        String query = "INSERT INTO ProductVariants (pro_id, size_id, color_id,image_id) VALUES (?, ?, ?,?)";
        boolean isAdded = false;

        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, proId);
            ps.setInt(2, sizeId);
            ps.setInt(3, colorId);
            ps.setInt(4, imageId);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                isAdded = true;
            }
        } catch (Exception e) {
            System.out.println("An error occurred while adding new product variant: " + e.getMessage());
        }
        return isAdded;
    }

    public List<ProductsVariant> getAllProductVariantsByPro_id(int pro_id) {
        List<ProductsVariant> list = new ArrayList<>();
        String query = "SELECT * FROM ProductVariants Where pro_id=?";

        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, pro_id);
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

    public List<ProductsVariant> getProductVariantsByProNameAndSizeName(String proName, String sizeName) {
        List<ProductsVariant> list = new ArrayList<>();
        String query = "SELECT pv.* FROM Products p "
                + "JOIN ProductVariants pv ON p.pro_id = pv.pro_id "
                + "JOIN ProductSizes ps ON pv.size_id = ps.size_id "
                + "WHERE p.pro_name = ? AND ps.size_name = ?";

        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, proName);
            ps.setString(2, sizeName);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new ProductsVariant(
                        rs.getInt("variant_id"),
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

    public List<ProductVariantInfomation> getAllInfoVariant() {
        List<ProductVariantInfomation> listAll = new ArrayList<>();
        String query = "Select \n"
                + "v.variant_id,\n"
                + "p.pro_id,\n"
                + "p.pro_name,\n"
                + "p.pro_price,\n"
                + "c.cat_name,\n"
                + "v.size_id,\n"
                + "p.description,\n"
                + "pc.color_name,\n"
                + "pi.imageURL\n"
                + "From ProductVariants v\n"
                + "JOIN Products p ON p.pro_id = v.pro_id\n"
                + "JOIN ProductImages pi ON pi.image_id = v.image_id\n"
                + "JOIN ProductColors pc ON pc.color_id  = v.color_id\n"
                + "JOIN Categories c ON c.cat_id = p.cat_id\n"
                + "ORDER BY v.variant_id DESC;";
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                listAll.add(new ProductVariantInfomation(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getDouble(4), rs.getString(5), ProductSizeType.values()[rs.getInt(6)], rs.getString(7), rs.getString(8), rs.getString(9)));
            }
        } catch (Exception e) {
        }
        return listAll;
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

    public ProductsVariant getProductByColorAndSize(String size_name, int color_id, int pro_id) {
        ProductSizeType sizeType = ProductSizeType.valueOf(size_name);
        int ordinalValue = sizeType.ordinal();
        ProductsVariant productV = null;
        String query = "Select * from ProductVariants where pro_id=? and size_id=? and color_id=?";
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, pro_id);
            ps.setInt(2, ordinalValue);
            ps.setInt(3, color_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                productV = new ProductsVariant(
                        rs.getInt(1),
                        rs.getInt(2),
                        ProductSizeType.values()[rs.getInt(3)],
                        rs.getInt(4),
                        rs.getInt(5)
                );
            }
        } catch (Exception e) {
        }
        return productV;

    }
}

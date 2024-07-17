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
import java.util.ArrayList;
import java.util.List;
import model.ImportBillDetail;
import model.ImportBillDetailInfor;
import model.OrderDetail;

/**
 *
 * @author My Computer
 */
public class ImportBillDetailService {

    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DBContext dbcontext = new DBContext();

    public List<ImportBillDetail> getImportBillDetailByBillIWhereBillID(int bill_id) {
        String query = "SELECT * FROM [dbo].[Import_Bill_Details] WHERE bill_id = ?";

        try {
            List<ImportBillDetail> li = new ArrayList<>();
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, bill_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                li.add(new ImportBillDetail(
                        rs.getInt("detailBill_id"),
                        rs.getInt("bill_id"),
                        rs.getInt("variant_id"),
                        rs.getInt("quantity"),
                        rs.getDouble("import_price")
                ));
            }
            return li;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public List<ImportBillDetailInfor> getImportBillDetailByBillI(int bill_id) {
        String query = "SELECT \n"
                + "    ib.bill_id,\n"
                + "    ibd.detailBill_id,\n"
                + "    p.pro_name,\n"
                + "    pv.size_id,\n"
                + "    c.color_name,\n"
                + "    ibd.quantity,\n"
                + "    ibd.import_price,\n"
                + "	m.imageURL\n"
                + "FROM \n"
                + "    Import_Bill ib\n"
                + "JOIN \n"
                + "    Import_Bill_Details ibd ON ib.bill_id = ibd.bill_id\n"
                + "JOIN \n"
                + "    ProductVariants pv ON ibd.variant_id = pv.variant_id\n"
                + "JOIN \n"
                + "    Products p ON pv.pro_id = p.pro_id\n"
                + "JOIN \n"
                + "    ProductColors c ON pv.color_id = c.color_id\n"
                + "JOIN\n"
                + "	[dbo].[ProductImages] m ON pv.color_id = m.image_id\n"
                + "WHERE \n"
                + "    ib.bill_id = ?;";

        try {
            List<ImportBillDetailInfor> li = new ArrayList<>();
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, bill_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                li.add(new ImportBillDetailInfor(
                        rs.getInt("detailBill_id"),
                        rs.getInt("bill_id"),
                        rs.getString("pro_name"),
                        rs.getInt("quantity"),
                        rs.getDouble("import_price"),
                        ProductSizeType.values()[rs.getInt("size_id")],
                        rs.getString("color_name"),
                        rs.getString("imageURL")
                ));
            }
            return li;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
public List<ImportBillDetailInfor> searchImportBillDetails(Integer bill_id, Integer detailBill_id, String pro_name, Integer size_id, String color_name, Integer quantityFrom, Integer quantityTo, Double import_priceFrom, Double import_priceTo) {
    String baseQuery = "SELECT \n"
            + "    ib.bill_id,\n"
            + "    ibd.detailBill_id,\n"
            + "    p.pro_name,\n"
            + "    pv.size_id,\n"
            + "    c.color_name,\n"
            + "    ibd.quantity,\n"
            + "    ibd.import_price,\n"
            + "    m.imageURL\n"
            + "FROM \n"
            + "    Import_Bill ib\n"
            + "JOIN \n"
            + "    Import_Bill_Details ibd ON ib.bill_id = ibd.bill_id\n"
            + "JOIN \n"
            + "    ProductVariants pv ON ibd.variant_id = pv.variant_id\n"
            + "JOIN \n"
            + "    Products p ON pv.pro_id = p.pro_id\n"
            + "JOIN \n"
            + "    ProductColors c ON pv.color_id = c.color_id\n"
            + "JOIN \n"
            + "    [dbo].[ProductImages] m ON pv.color_id = m.image_id\n"
            + "WHERE 1=1 ";

    if (bill_id != null) {
        baseQuery += " AND ib.bill_id = ?";
    }
    if (detailBill_id != null) {
        baseQuery += " AND ibd.detailBill_id = ?";
    }
    if (pro_name != null && !pro_name.isEmpty()) {
        baseQuery += " AND p.pro_name LIKE ?";
    }
    if (size_id != null) {
        baseQuery += " AND pv.size_id = ?";
    }
    if (color_name != null && !color_name.isEmpty()) {
        baseQuery += " AND c.color_name LIKE ?";
    }
    if (quantityFrom != null) {
        baseQuery += " AND ibd.quantity >= ?";
    }
    if (quantityTo != null) {
        baseQuery += " AND ibd.quantity <= ?";
    }
    if (import_priceFrom != null) {
        baseQuery += " AND ibd.import_price >= ?";
    }
    if (import_priceTo != null) {
        baseQuery += " AND ibd.import_price <= ?";
    }

    try {
        List<ImportBillDetailInfor> li = new ArrayList<>();
        connection = dbcontext.getConnection();
        ps = connection.prepareStatement(baseQuery);

        int paramIndex = 1;

        if (bill_id != null) {
            ps.setInt(paramIndex++, bill_id);
        }
        if (detailBill_id != null) {
            ps.setInt(paramIndex++, detailBill_id);
        }
        if (pro_name != null && !pro_name.isEmpty()) {
            ps.setString(paramIndex++, "%" + pro_name + "%");
        }
        
        
        if (size_id != null) {
            
           
            ps.setInt(paramIndex++, size_id);
        }
        if (color_name != null && !color_name.isEmpty()) {
            ps.setString(paramIndex++, "%" + color_name + "%");
        }
        if (quantityFrom != null) {
            ps.setInt(paramIndex++, quantityFrom);
        }
        if (quantityTo != null) {
            ps.setInt(paramIndex++, quantityTo);
        }
        if (import_priceFrom != null) {
            ps.setDouble(paramIndex++, import_priceFrom);
        }
        if (import_priceTo != null) {
            ps.setDouble(paramIndex++, import_priceTo);
        }

        rs = ps.executeQuery();
        while (rs.next()) {
            li.add(new ImportBillDetailInfor(
                    rs.getInt("detailBill_id"),
                    rs.getInt("bill_id"),
                    rs.getString("pro_name"),
                    rs.getInt("quantity"),
                    rs.getDouble("import_price"),
                    ProductSizeType.values()[rs.getInt("size_id")],
                    rs.getString("color_name"),
                    rs.getString("imageURL")
            ));
        }
        return li;
    } catch (Exception e) {
        throw new RuntimeException(e);
    } finally {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

public static void main(String[] args) {
    ImportBillDetailService service = new ImportBillDetailService();

    // Các tham số cho phương thức searchImportBillDetails
    Integer bill_id = null;
    Integer detailBill_id =null ;
    String pro_name = "";
    Integer size_id = 1;
    String color_name = "";
    Integer quantityFrom = null;
    Integer quantityTo = null;
    Double import_priceFrom = null;
    Double import_priceTo = null;

    // Gọi phương thức searchImportBillDetails và lưu kết quả
    List<ImportBillDetailInfor> results = service.searchImportBillDetails(
            bill_id, detailBill_id, pro_name, size_id, color_name,
            quantityFrom, quantityTo, import_priceFrom, import_priceTo
    );

    // In ra kết quả
    for (ImportBillDetailInfor info : results) {
        System.out.println(info.toString());
    }
}

}
//    private int detailBill_id;
//    private int bill_id;
//    private int quantity;
//    private double import_price;
//    private ProductSizeType size_name;
//    private String color_name;
//    private String imageURL;

//    private int detailBill_id;
//    private int bill_id;
//    private int variant_id;
//    private int quantity;
//    private double import_price;

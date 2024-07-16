/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import db.DBContext;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.ImportBill;

/**
 *
 * @author My Computer
 */
public class ImportBillService {

    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DBContext dbcontext = new DBContext();

    public List<ImportBill> getTop5ImportBill(int indexPage) {
        String query = "with x as (select ROW_NUMBER() over (order by bill_id desc) as r \n"
                + "                              , * from [dbo].[Import_Bill] )\n"
                + "                  select * from x where r between ?*5-4 and ?*5;";
        try {
            List<ImportBill> as = new ArrayList<>();
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, indexPage);
            ps.setInt(2, indexPage);
            rs = ps.executeQuery(); // chạy câu lệnh query, nhận kết quả trả về

            while (rs.next()) {
                as.add(new ImportBill(
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5)
                //                    private int bill_id;
                //    private String create_date;
                //    private double total_amount;
                //    private String image_bill;
                ));
            }
            return as;
        } catch (Exception e) {
            System.out.println("Loi");
        }
        return null;
    }

    public int countPageBillService() {
        String query = "select count(*) from Import_Bill ";
        int count = 0;
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);

            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("Loi");
        }
        return count;
    }

    public List<ImportBill> searchImportBills(String billId, String createDateFrom, String createDateTo, Double totalAmountFrom, Double totalAmountTo) {
        // Bao gồm cột image_bill trong câu truy vấn
        String baseQuery = "SELECT bill_id, create_date, total_amount, image_bill FROM [ClothesStore].[dbo].[Import_Bill] WHERE 1=1";

        if (billId != null && !billId.isEmpty()) {
            baseQuery += " AND bill_id LIKE ?";
        }
        if (createDateFrom != null && !createDateFrom.isEmpty()) {
            baseQuery += " AND create_date >= ?";
        }
        if (createDateTo != null && !createDateTo.isEmpty()) {
            baseQuery += " AND create_date <= ?";
        }
        if (totalAmountFrom != null) {
            baseQuery += " AND total_amount >= ?";
        }
        if (totalAmountTo != null) {
            baseQuery += " AND total_amount <= ?";
        }

        try {
            List<ImportBill> bills = new ArrayList<>();
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(baseQuery);

            int paramIndex = 1;

            if (billId != null && !billId.isEmpty()) {
                ps.setString(paramIndex++, "%" + billId + "%");
            }
            if (createDateFrom != null && !createDateFrom.isEmpty()) {
                ps.setDate(paramIndex++, Date.valueOf(createDateFrom));
            }
            if (createDateTo != null && !createDateTo.isEmpty()) {
                ps.setDate(paramIndex++, Date.valueOf(createDateTo));
            }
            if (totalAmountFrom != null) {
                ps.setDouble(paramIndex++, totalAmountFrom);
            }
            if (totalAmountTo != null) {
                ps.setDouble(paramIndex++, totalAmountTo);
            }

            rs = ps.executeQuery();

            while (rs.next()) {
                bills.add(new ImportBill(
                        rs.getInt("bill_id"), // bill_id
                        rs.getString("create_date"), // create_date
                        rs.getDouble("total_amount"), // total_amount
                        rs.getString("image_bill") // image_bill
                ));
            }
            return bills;
        } catch (Exception e) {
            e.printStackTrace();
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
        return null;
    }

    public int createImportBill(Date date, float totalAmount, String imageBill) {
        String query = "INSERT INTO Import_Bill (create_date, total_amount, image_bill) VALUES (?, ?, ?)";
        String getIdQuery = "SELECT @@IDENTITY AS id";
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setDate(1, date);
            ps.setFloat(2, totalAmount);
            ps.setString(3, imageBill);
            ps.executeUpdate();

            ps = connection.prepareStatement(getIdQuery);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return -1;
    }
}

public static void main(String[] args) {
        // Khởi tạo đối tượng ImportBillService
        ImportBillService importBillService = new ImportBillService();

        // Thông báo bắt đầu tìm kiếm
        System.out.println("Searching for Import Bills...");

        // Các tham số tìm kiếm (không cần nhập totalAmountFrom và totalAmountTo)
        String billId = "19";                   // ID hóa đơn (sử dụng % để tìm kiếm theo mẫu)
        String createDateFrom = "";  // Ngày bắt đầu tìm kiếm
        String createDateTo = "";    // Ngày kết thúc tìm kiếm
        Double totalAmountFrom = null;         // Số tiền tối thiểu (null để bỏ qua)
        Double totalAmountTo = null;           // Số tiền tối đa (null để bỏ qua)

        // Tìm kiếm hóa đơn dựa trên các tiêu chí
        List<ImportBill> searchResults = importBillService.searchImportBills(
                billId, createDateFrom, createDateTo, totalAmountFrom, totalAmountTo
        );

        // Kiểm tra và hiển thị kết quả tìm kiếm
        if (searchResults != null && !searchResults.isEmpty()) {
            System.out.println("Search Results for Import Bills:");
            for (ImportBill bill : searchResults) {
                System.out.println(bill);
            }
        } else {
            System.out.println("No Import Bills found matching the criteria.");
        }
    }


}

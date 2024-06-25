/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import db.DBContext;
import helper.OrderStatus;
import helper.PayStatus;
import helper.ShipStatus;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Bill;
import model.Order;

/**
 *
 * @author My Computer
 */
public class BillService {
      Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DBContext dbcontext = new DBContext();
    
     public List<Bill> getTop5Bill(int indexPage) {
    String query = "  with x as (select ROW_NUMBER() over (order by pro_id asc ) as r \n" +
"                     ,* from [dbo].[Bills] )\n" +
"                   select * from x where r between ?*5-4 and ?*5;";
    try {
        List<Bill> as = new ArrayList<>();
        connection = dbcontext.getConnection();
        ps = connection.prepareStatement(query);
        ps.setInt(1, indexPage);
        ps.setInt(2, indexPage);
        rs = ps.executeQuery(); // chạy câu lệnh query, nhận kết quả trả về

        while (rs.next()) {
            
            as.add(new Bill(
                    rs.getInt(2),
                    rs.getDate(3),
                    rs.getDouble(4),
                    rs.getString(5),
                    rs.getDouble(6),
                    rs.getInt(7),
                    rs.getString(8),
                    rs.getInt(9)

//                    OrderStatus.values()[(rs.getInt(9))],
//                        PayStatus.values()[(rs.getInt(10))],
//                        ShipStatus.values()[(rs.getInt(11))]
            ));
        }
//              private int bill_id;
//    private Date create_date;
//    private double total_amount;
//    private String pro_name;
//    private double import_price;
//    private int quantity;
//    private String image_bill;
//    private int pro_id;
        return as;
    } catch (Exception e) {
        e.printStackTrace(); // In ra thông báo lỗi
    }
    return null;
 }
         public int countPageBill(){
    String query = "  select count(*) from [dbo].[Bills] ";
    int count = 0;
   try {
        List<Order> as = new ArrayList<>();
        connection = dbcontext.getConnection();
        ps = connection.prepareStatement(query);

        
        rs = ps.executeQuery(); // chạy câu lệnh query, nhận kết quả trả về
      
        while (rs.next()) {
            count = rs.getInt(1);
            
        }

    } catch (Exception e) {
        e.printStackTrace(); // In ra thông báo lỗi
    }
   return count;

}
         public List<Bill> getTop10BillSearch(String searchText) {
        List<Bill> listTop5 = new ArrayList<>();
        try {
            String query = "with x as (select ROW_NUMBER() over (order by pro_id desc) as r \n"
                    + ", * from Bills where pro_name like ?  )\n"
                    + "select * from x where r between 1 and 10";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1,"%" +searchText+"%");
//            ps.setInt(2, indexPage);
//            ps.setInt(3, indexPage);
            rs = ps.executeQuery();
            while (rs.next()) {
                listTop5.add(new Bill(
                    rs.getInt(2),
                    rs.getDate(3),
                    rs.getDouble(4),
                    rs.getString(5),
                    rs.getDouble(6),
                    rs.getInt(7),
                    rs.getString(8),
                    rs.getInt(9)
                ));
            }
            return listTop5;
        } catch (Exception e) {
        }
        return null;
    }
//         public static void main(String[] args) {
//        BillService bn = new BillService();
//        for( Bill o : bn.getTop5BillSearch(1,"s")){
//            System.out.println(o);
//        }
    }

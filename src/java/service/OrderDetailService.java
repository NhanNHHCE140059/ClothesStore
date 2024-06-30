/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.OrderDetail;

/**
 * Service class for handling OrderDetails.
 */
public class OrderDetailService {

    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DBContext dbcontext = new DBContext();

    public List<OrderDetail> getTop10FeedbackNotNullByID(int pro_id) {
        List<OrderDetail> listTop10 = new ArrayList<>();
        String query = "SELECT TOP 10 od.*\n"
                + "FROM OrderDetails od\n"
                + "JOIN ProductVariants pv ON od.variant_id = pv.variant_id\n"
                + "WHERE pv.pro_id = ?\n"
                + "  AND od.feedback_details IS NOT NULL\n"
                + "ORDER BY NEWID();";
        try {

            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, pro_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                listTop10.add(new OrderDetail(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getDouble(4),
                        rs.getInt(5),
                        rs.getString(6)
                ));
            }
        } catch (Exception e) {
        }
        return listTop10;
    }

    /**
     * Retrieves order details by order ID.
     *
     * @param order_id the ID of the order
     * @return a list of OrderDetail objects
     */
    public List<OrderDetail> getOrderDetailByOrderID(int order_id) {
        String query = "SELECT * FROM OrderDetails WHERE order_id = ?";

        try {
            List<OrderDetail> li = new ArrayList<>();
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, order_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                li.add(new OrderDetail(
                        rs.getInt("order_detail_id"),
                        rs.getInt("order_id"),
                        rs.getInt("variant_id"),
                        rs.getDouble("UnitPrice"),
                        rs.getInt("Quantity"),
                        rs.getString("feedback_details")
                ));
            }
            return li;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Main method for testing getOrderDetailByOrderID.
     */
    public static void main(String[] args) {
        OrderDetailService service = new OrderDetailService();
        service.getTop10FeedbackNotNullByID(1);
        System.out.println(service.getTop10FeedbackNotNullByID(1).size());
    }
}

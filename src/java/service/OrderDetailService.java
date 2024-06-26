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

    /**
     * Retrieves order details by order ID.
     *
     * @param order_id the ID of the order
     * @return a list of OrderDetail objects
     */
    public List<OrderDetail> getOrderDetailByOrderID(int order_id) {
        String query = "Select * from OrderDetails where order_id = ?";

        try {
            List<OrderDetail> li = new ArrayList<>();
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, order_id);
            rs = ps.executeQuery(); // Execute the query and get the result set
            while (rs.next()) {
                li.add(new OrderDetail(rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3), (int) rs.getDouble(4) // Assuming UnitPrice is a double
                ));
            }
            return li;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Main method for testing getOrderDetailByOrderID.
     */
    public static void main(String[] args) {
        OrderDetailService orderDetailService = new OrderDetailService();
        List<OrderDetail> orderDetails = orderDetailService.getOrderDetailByOrderID(3);
        for (OrderDetail orderDetail : orderDetails) {
            System.out.println(orderDetail.toString());
        }
    }
}


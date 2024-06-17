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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Order;

/**
 *
 * @author My Computer
 */
public class OrderService {

    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DBContext dbcontext = new DBContext();

    public PayStatus mapPayStatus(int statusNumber) {
        switch (statusNumber) {
            case 0:
                return PayStatus.NOT_YET;
            case 1:
                return PayStatus.SUCCESS;
            default:
                throw new IllegalArgumentException("Unknown PayStatus value: " + statusNumber);

        }
    }
      public OrderStatus mapOrderStatus(int orderStatus) {
        switch (orderStatus) {
            case 0:
                return OrderStatus.NOT_YET;
            case 1:
                return OrderStatus.SUCCESS;
            default:
                throw new IllegalArgumentException("Unknown OrderStatus value: " + orderStatus);

        }
    }

    public ShipStatus mapShipStatus(int shipStatusNumber) {
        switch (shipStatusNumber) {
            case 0:
                return ShipStatus.NOT_YET;
            case 1:
                return ShipStatus.SHIPPING;
            case 2:
                return ShipStatus.SUCCESS;
            default:
                throw new IllegalArgumentException("Unknown ShipStatus value: " + shipStatusNumber);

        }
    }
    public List<Order> listAllOrdersShipped() {
        List<Order> listOrderShipped = new ArrayList<>();
        try {
            String query = "Select * from orders where shipping_status = 0";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listOrderShipped.add(new Order(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getDate(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getDouble(7),
                        mapOrderStatus(rs.getInt(8)),
                        mapPayStatus(rs.getInt(9)),
                        mapShipStatus(rs.getInt(10))
                ));         
            }
            return listOrderShipped;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL error occurred while fetching account.");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("An unexpected error occurred.");
        }
        return listOrderShipped;
    }

    public void deleteFeedbackById(int order_id) {
        try {
            String query = "UPDATE orders SET feedback_order = NULL WHERE order_id = ?";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, order_id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL error occurred while fetching account.");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("An unexpected error occurred.");
        }

    }
}

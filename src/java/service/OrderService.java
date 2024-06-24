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

    // Xu li phan trang cho order da ship ( for feedbackManager) 
    // Dem so luong trang can xu li 
    public int countPageforFeedback() {
        int countPage = 0;
        try {
            String query = "select count(*) from orders where shipping_status =0";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                countPage = rs.getInt(1);
            }
            return countPage;
        } catch (Exception e) {
        }
        return 0;
    }

    // Xuat ra so luong 5 order moi trang 
    public List<Order> getTop5Orders(int indexPage) {
        List<Order> listTop5 = new ArrayList<>();
        try {
            String query = "with x as (select ROW_NUMBER() over (order by order_id desc) as r \n"
                    + ", * from orders where shipping_status=0 )\n"
                    + "select * from x where r between ?*5-4 and ?*5";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, indexPage);
            ps.setInt(2, indexPage);
            rs = ps.executeQuery();
            while (rs.next()) {
                listTop5.add(new Order(
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getDate(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getDouble(8),
                        OrderStatus.values()[rs.getInt(9)],
                        PayStatus.values()[rs.getInt(10)],
                        ShipStatus.values()[rs.getInt(11)]
                ));
            }
            return listTop5;
        } catch (Exception e) {
        }
        return null;
    }
    ///// Xu li search tich hop phan trang 
       public List<Order> getTop5OrdersSearch(int indexPage,String searchText) {
        List<Order> listTop5 = new ArrayList<>();
        try {
            String query = "with x as (select ROW_NUMBER() over (order by order_id desc) as r \n"
                    + ", * from orders where phone like ? and shipping_status = 0 )\n"
                    + "select * from x where r between ?*5-4 and ?*5";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1,"%" +searchText+"%");
            ps.setInt(2, indexPage);
            ps.setInt(3, indexPage);
            rs = ps.executeQuery();
            while (rs.next()) {
                listTop5.add(new Order(
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getDate(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getDouble(8),
                        OrderStatus.values()[rs.getInt(9)],
                        PayStatus.values()[rs.getInt(10)],
                        ShipStatus.values()[rs.getInt(11)]
                ));
            }
            return listTop5;
        } catch (Exception e) {
        }
        return null;
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
     
       

    public static void main(String[] args) {   
      
    }
}

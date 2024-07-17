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
import model.Account;
import model.Order;
import model.OrderDetail;

/**
 *
 * @author My Computer
 */
public class OrderService {

    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DBContext dbcontext = new DBContext();

    public List<Order> listAllOrdersShipped() {
        List<Order> listOrderShipped = new ArrayList<>();
        try {
            String query = "Select * from orders where shipping_status = 0";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                listOrderShipped.add(new Order(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getDate(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getDouble(8),
                        OrderStatus.values()[rs.getInt(9)],
                        PayStatus.values()[rs.getInt(10)],
                        ShipStatus.values()[rs.getInt(11)]
                ));
            }
            return listOrderShipped;
        } catch (SQLException e) {
            System.out.println("SQL error occurred while fetching account.");
        } catch (Exception e) {
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

        } catch (Exception e) {
        }
        return countPage;
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
                        rs.getInt(7),
                        rs.getString(8),
                        rs.getDouble(9),
                        OrderStatus.values()[rs.getInt(10)],
                        PayStatus.values()[rs.getInt(11)],
                        ShipStatus.values()[rs.getInt(12)]
                ));
            }
            return listTop5;
        } catch (Exception e) {
        }
        return null;
    }

    ///// Xu li search tich hop phan trang 
    public List<Order> getTop5OrdersSearch(int indexPage, String searchText) {
        List<Order> listTop5 = new ArrayList<>();
        try {
            String query = "with x as (select ROW_NUMBER() over (order by order_id desc) as r \n"
                    + ", * from orders where phone like ? and shipping_status = 0 )\n"
                    + "select * from x where r between ?*5-4 and ?*5";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, "%" + searchText + "%");
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
                        rs.getInt(7),
                        rs.getString(8),
                        rs.getDouble(9),
                        OrderStatus.values()[rs.getInt(10)],
                        PayStatus.values()[rs.getInt(11)],
                        ShipStatus.values()[rs.getInt(12)]
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
            System.out.println("SQL error occurred while fetching account.");
        } catch (Exception e) {
            System.out.println("An unexpected error occurred.");
        }

    }

    public List<Order> getOrderHistoryByAccountID(String username) {
        String query = "SELECT * from [Orders] where username = ?";
        try {
            List<Order> ls = new ArrayList<>();
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, username);
            rs = ps.executeQuery();//chay cau lenh query, nhan ket qua tra ve

            while (rs.next()) {
                ls.add(new Order(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getDate(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getDouble(8),
                        OrderStatus.values()[rs.getInt(9)],
                        PayStatus.values()[rs.getInt(10)],
                        ShipStatus.values()[rs.getInt(11)]
                ));
            }
            return ls;
        } catch (Exception e) {
        }
        return null;
    }

    public List<Order> getTop5OrderHistory(int indexPage) {
        String query = "with x as (select ROW_NUMBER() over (order by order_id desc) as r \n"
                + "                      ,* from [dbo].[Orders] )\n"
                + "                     select * from x where r between ?*5-4 and ?*5;";
        try {
            List<Order> as = new ArrayList<>();
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, indexPage);
            ps.setInt(2, indexPage);
            rs = ps.executeQuery(); // chạy câu lệnh query, nhận kết quả trả về

            while (rs.next()) {
                as.add(new Order(
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getDate(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getString(8),
                        rs.getDouble(9),
                        OrderStatus.values()[rs.getInt(10)],
                        PayStatus.values()[rs.getInt(11)],
                        ShipStatus.values()[rs.getInt(12)]
                ));
            }
            return as;
        } catch (Exception e) {
            System.out.println("Loi");
        }
        return null;
    }

    public int countPageOrderStaff() {
        String query = "select count(*) from orders ";
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

    public void placeOrder(Account account, String shippingAddress, String shippingPhone) {
        String getCartItemsQuery = "SELECT variant_id, pro_quantity, pro_price FROM Carts WHERE acc_id = ?";
        String insertOrderQuery = "INSERT INTO Orders (feedback_order, orderDate, addressReceive, phone, acc_id, username, totalPrice, order_status, pay_status, shipping_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String insertOrderDetailQuery = "INSERT INTO OrderDetails (order_id, variant_id, UnitPrice, Quantity, feedback_details) VALUES (?, ?, ?, ?, ?)";
        String deleteCartQuery = "DELETE FROM Carts WHERE acc_id = ?";

        try {
            connection = dbcontext.getConnection();
            connection.setAutoCommit(false);

          
            ps = connection.prepareStatement(getCartItemsQuery);
            ps.setInt(1, account.getAcc_id());
            rs = ps.executeQuery();

            List<OrderDetail> orderDetails = new ArrayList<>();
            double totalPrice = 0.0;

            while (rs.next()) {
                int variantId = rs.getInt("variant_id");
                int quantity = rs.getInt("pro_quantity");
                double price = rs.getDouble("pro_price");
                double unitPrice = price * quantity;
                totalPrice += unitPrice;

                orderDetails.add(new OrderDetail(0, 0, variantId, price, quantity, null));
            }

     
            Order order = new Order(
                    0,
                    null,
                    new java.sql.Date(System.currentTimeMillis()),
                    shippingAddress,
                    shippingPhone,
                    account.getAcc_id(),
                    account.getUsername(),
                    totalPrice,
                    OrderStatus.NOT_YET,
                    PayStatus.NOT_YET,
                    ShipStatus.NOT_YET);

            ps = connection.prepareStatement(insertOrderQuery, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, order.getFeedback_order());
            ps.setDate(2, order.getOrderDate());
            ps.setString(3, order.getAddressReceive());
            ps.setString(4, order.getPhone());
            ps.setInt(5, order.getAcc_id());
            ps.setString(6, order.getUsername());
            ps.setDouble(7, order.getTotalPrice());
            ps.setInt(8, order.getOrder_status().ordinal());
            ps.setInt(9, order.getPay_status().ordinal());
            ps.setInt(10, order.getShipping_status().ordinal());
            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            ps = connection.prepareStatement(insertOrderDetailQuery);
            for (OrderDetail detail : orderDetails) {
                ps.setInt(1, orderId);
                ps.setInt(2, detail.getVariant_id());
                ps.setDouble(3, detail.getUnitPrice());
                ps.setInt(4, detail.getQuantity());
                ps.setString(5, detail.getFeedback_details());
                ps.addBatch();
            }
            ps.executeBatch();

            ps = connection.prepareStatement(deleteCartQuery);
            ps.setInt(1, account.getAcc_id());
            ps.executeUpdate();

            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                System.out.println("Rollback failed: " + ex.getMessage());
            }
            System.out.println("SQL error occurred while placing order: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("An unexpected error occurred: " + e.getMessage());
        }
        System.out.println("Susscessfully di ngu thoai");
    }

    public static void main(String[] args) {
        OrderService orderService = new OrderService();
    }
}

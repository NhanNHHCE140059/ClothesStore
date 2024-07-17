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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.OrderDetail;
import model.OrderDetailCustomer;
import model.OrderDetailStaff;

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

    public List<OrderDetailCustomer> getOrderDetailByOrderIDCustomer(int order_id) {
        String query = "SELECT \n"
                + "    o.order_id,\n"
                + "    o.orderDate,\n"
                + "    o.order_status,\n"
                + "    o.shipping_status,\n"
                + "    od.order_detail_id,\n" // Thêm cột này
                + "    p.pro_name,\n"
                + "    od.UnitPrice,\n"
                + "    od.Quantity,\n"
                + "    pc.color_name,\n"
                + "    ps.size_name,\n"
                + "    pi.imageURL,\n"
                + "    od.feedback_details,\n"
                + "    o.addressReceive,\n"
                + "    o.phone\n"
                + "FROM Orders o\n"
                + "JOIN OrderDetails od ON o.order_id = od.order_id\n"
                + "JOIN ProductVariants pv ON od.variant_id = pv.variant_id\n"
                + "JOIN Products p ON pv.pro_id = p.pro_id\n"
                + "JOIN ProductColors pc ON pv.color_id = pc.color_id\n"
                + "JOIN ProductSizes ps ON pv.size_id = ps.size_id\n"
                + "JOIN ProductImages pi ON pv.image_id = pi.image_id\n"
                + "WHERE o.order_id = ?;";

        List<OrderDetailCustomer> li = new ArrayList<>();

        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, order_id);
            rs = ps.executeQuery();

            while (rs.next()) {
                li.add(new OrderDetailCustomer(
                        rs.getInt(1), // order_id
                        rs.getDate(2), // orderDate
                        OrderStatus.values()[rs.getInt(3)], // order_status
                        ShipStatus.values()[rs.getInt(4)], // shipping_status
                        rs.getInt(5), // order_detail_id
                        rs.getString(6), // pro_name
                        rs.getDouble(7), // UnitPrice
                        rs.getInt(8), // Quantity
                        rs.getString(9), // color_name
                        rs.getString(10), // size_name
                        rs.getString(11), // imageURL
                        rs.getString(12), // feedback_details
                        rs.getString(13), // addressReceive
                        rs.getString(14) // phone
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
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
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return li;
    }

    public void updateFbDetailCustomer(String feedback_details, int order_detail_id) {
        String query = "     update [OrderDetails] set [feedback_details] = ? where [order_detail_id] = ? ";

        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, feedback_details);
            ps.setInt(2, order_detail_id);
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Loi");
        }

    }

    public List<OrderDetailStaff> getOrderDetailByOrderIDCustomerForStaff(int order_id) {
        String query = "SELECT \n"
                + "    o.order_id,\n"
                + "    o.orderDate,\n"
                + "    o.order_status,\n"
                + "    o.pay_status,\n"
                + "    o.shipping_status,\n"
                + "    p.pro_name,\n"
                + "    od.UnitPrice,\n"
                + "    od.Quantity,\n"
                + "    pc.color_name,\n"
                + "    ps.size_name,\n"
                + "    pi.imageURL,\n"
                + "    o.username,\n"
                + "    o.acc_id,\n"
                + "    od.feedback_details,\n"
                + "    o.feedback_order,\n"
                + "    o.phone,\n"
                + "    o.addressReceive\n"
                + "FROM Orders o\n"
                + "JOIN OrderDetails od ON o.order_id = od.order_id\n"
                + "JOIN ProductVariants pv ON od.variant_id = pv.variant_id\n"
                + "JOIN Products p ON pv.pro_id = p.pro_id\n"
                + "JOIN ProductColors pc ON pv.color_id = pc.color_id\n"
                + "JOIN ProductSizes ps ON pv.size_id = ps.size_id\n"
                + "JOIN ProductImages pi ON pv.image_id = pi.image_id\n"
                + "WHERE o.order_id = ?;";

        List<OrderDetailStaff> li = new ArrayList<>();

        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, order_id);
            rs = ps.executeQuery();

            while (rs.next()) {
                li.add(new OrderDetailStaff(
                        rs.getInt(1), // order_id
                        rs.getDate(2), // orderDate
                        OrderStatus.values()[rs.getInt(3)], // order_status
                        PayStatus.values()[rs.getInt(4)], // pay_status
                        ShipStatus.values()[rs.getInt(5)], // shipping_status
                        rs.getString(6), // pro_name
                        rs.getDouble(7), // UnitPrice
                        rs.getInt(8), // Quantity
                        rs.getString(9), // color_name
                        rs.getString(10), // size_name
                        rs.getString(11), // imageURL
                        rs.getString(12), // username
                        rs.getInt(13), // acc_id
                        rs.getString(14), // feedback_details
                        rs.getString(15), // feedback_order
                        rs.getString(16), // phone
                        rs.getString(17) // addressReceive
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
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
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return li;
    }
}

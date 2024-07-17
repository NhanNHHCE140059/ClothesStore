/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import db.DBContext;
import helper.OrderStatus;
import helper.PayStatus;
import helper.ProductSizeType;
import helper.ShipStatus;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import model.Account;
import model.Order;
import model.OrderDetail;
import model.StaticTopBillValue;
import model.TopProduct;

/**
 *
 * @author My Computer
 */
public class OrderService {

    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DBContext dbcontext = new DBContext();

    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        try {
            String query = "select * from orders";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("order_id"),
                        rs.getString("feedback_order"),
                        rs.getDate("orderDate"),
                        rs.getString("addressReceive"),
                        rs.getString("phone"),
                        rs.getInt("acc_id"),
                        rs.getString("username"),
                        rs.getFloat("totalPrice"),
                        OrderStatus.values()[rs.getInt("order_status")],
                        PayStatus.values()[rs.getInt("pay_status")],
                        ShipStatus.values()[rs.getInt("shipping_status")]
                );
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL error occurred while fetching orders.");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("An unexpected error occurred.");
        }
        return orders;
    }

    public List<StaticTopBillValue> getTop10OrdersByValue() {
        List<StaticTopBillValue> topOrders = new ArrayList<>();
        try {

            String query = "SELECT TOP 10 o.order_id, a.username, o.totalPrice, o.orderDate "
                    + "FROM orders o "
                    + "JOIN accounts a ON o.acc_id = a.acc_id "
                    + "ORDER BY o.totalPrice DESC";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                StaticTopBillValue order = new StaticTopBillValue(
                        rs.getInt("order_id"),
                        rs.getString("username"),
                        rs.getDouble("totalPrice"),
                        rs.getDate("orderDate")
                );
                topOrders.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL error occurred while fetching top 10 orders by value.");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("An unexpected error occurred.");
        }
        return topOrders;
    }

    public double[] getMonthlyRevenue() {
        double[] monthlyRevenue = new double[12];
        try {

            Calendar calendar = Calendar.getInstance();
            int currentYear = calendar.get(Calendar.YEAR);

            String query = "SELECT MONTH(orderDate) AS month, SUM(totalPrice) AS revenue "
                    + "FROM orders "
                    + "WHERE YEAR(orderDate) = ? "
                    + "GROUP BY MONTH(orderDate)";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, currentYear);
            rs = ps.executeQuery();

            while (rs.next()) {
                int month = rs.getInt("month");
                double revenue = rs.getDouble("revenue");
                monthlyRevenue[month - 1] = revenue;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL error occurred while fetching monthly revenue.");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("An unexpected error occurred.");
        }
        return monthlyRevenue;
    }

    public double calculateTodayProfit() {
        double totalProfit = 0.0;
        try {

            java.util.Date utilDate = new java.util.Date();
            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

            String getOrdersQuery = "SELECT order_id, totalPrice FROM orders WHERE orderDate = ?";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(getOrdersQuery);
            ps.setDate(1, sqlDate);
            rs = ps.executeQuery();

            List<Integer> orderIds = new ArrayList<>();
            double totalSalePrice = 0.0;

            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                double orderTotalPrice = rs.getDouble("totalPrice");
                orderIds.add(orderId);
                totalSalePrice += orderTotalPrice;
            }

            double totalCostPrice = 0.0;

            for (int orderId : orderIds) {
                String getOrderDetailsQuery = "SELECT od.variant_id, od.Quantity, ibd.import_price FROM OrderDetails od "
                        + "JOIN import_bill_details ibd ON od.variant_id = ibd.variant_id "
                        + "JOIN import_bill ib ON ibd.bill_id = ib.bill_id "
                        + "WHERE od.order_id = ?";
                ps = connection.prepareStatement(getOrderDetailsQuery);
                ps.setInt(1, orderId);
                ResultSet orderDetailsRs = ps.executeQuery();

                while (orderDetailsRs.next()) {
                    int quantity = orderDetailsRs.getInt("Quantity");
                    double importPrice = orderDetailsRs.getDouble("import_price");
                    totalCostPrice += (quantity * importPrice);
                }
                orderDetailsRs.close();
            }

            totalProfit = totalSalePrice - totalCostPrice;

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL error occurred while calculating today's profit.");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("An unexpected error occurred.");
        }
        return totalProfit;
    }

    public List<TopProduct> getTop20Products() {
        List<TopProduct> topProducts = new ArrayList<>();
        try {

            String query = "SELECT TOP 20 p.imageURL, p.pro_name AS name, pc.color_name, ps.size_name, p.pro_price AS price, "
                    + "SUM(od.Quantity) AS quantity "
                    + "FROM products p "
                    + "JOIN ProductVariants pv ON p.pro_id = pv.pro_id "
                    + "JOIN ProductColors pc ON pv.color_id = pc.color_id "
                    + "JOIN ProductSizes ps ON pv.size_id = ps.size_id "
                    + "JOIN OrderDetails od ON pv.variant_id = od.variant_id "
                    + "GROUP BY p.imageURL, p.pro_name, pc.color_name, ps.size_name, p.pro_price "
                    + "ORDER BY quantity DESC";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                TopProduct product = new TopProduct(
                        rs.getString("imageURL"),
                        rs.getString("name"),
                        rs.getString("color_name"),
                        ProductSizeType.valueOf(rs.getString("size_name")),
                        rs.getDouble("price"),
                        rs.getDouble("quantity")
                );
                topProducts.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL error occurred while fetching top 20 products.");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("An unexpected error occurred.");
        }
        return topProducts;
    }

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

    public List<Order> getTop50OrderHistoryByAccountID(String username, int indexPage) {
        String query = "with x as (select ROW_NUMBER() over (order by order_id desc) as r \n"
                + "                                     ,* from [dbo].[Orders] where username = ?)\n"
                + "                                    select * from x where r between ?*5-4 and ?*5";
        try {
            List<Order> ls = new ArrayList<>();
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, username);
            ps.setInt(2, indexPage);
            ps.setInt(3, indexPage);

            rs = ps.executeQuery();//chay cau lenh query, nhan ket qua tra ve

            while (rs.next()) {
                ls.add(new Order(
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
            return ls;
        } catch (Exception e) {
            e.printStackTrace();
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

    public int countPageOrderCustomer(String username) {
        String query = "  select count(*) from orders where [username] = ?";
        int count = 0;
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("Loi");
        }
        return count;
    }

    public void updateFbCustomer(String feedback, int orderid) {
        String query = "   update [Orders] set [feedback_order] = ? where [order_id] = ? ";

        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, feedback);
            ps.setInt(2, orderid);
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Loi");
        }

    }
    ///// Xu li search tich hop phan trang 

    public List<Order> getAllOrdersSearch(String username) {
        List<Order> listTop5 = new ArrayList<>();
        try {
            String query = " select * from Orders where username like ?";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, "%" + username + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                listTop5.add(new Order(
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
            return listTop5;
        } catch (Exception e) {
        }
        return null;
    }

    public List<Order> searchOrders(String orderId, String username, String orderDateFrom, String orderDateTo,
            String orderStatus, String shippingStatus, String payStatus) {
        String query = "SELECT * FROM [ClothesStore].[dbo].[Orders] WHERE 1=1";
        int paramIndex = 1;

        if (orderId != null && !orderId.isEmpty()) {
            query += " AND order_id LIKE ?";
        }
        if (username != null && !username.isEmpty()) {
            query += " AND username LIKE ?";
        }
        if (orderDateFrom != null && !orderDateFrom.isEmpty()) {
            query += " AND orderDate >= ?";
        }
        if (orderDateTo != null && !orderDateTo.isEmpty()) {
            query += " AND orderDate <= ?";
        }
        if (orderStatus != null && !orderStatus.isEmpty()) {
            query += " AND order_status = ?";
        }
        if (shippingStatus != null && !shippingStatus.isEmpty()) {
            query += " AND shipping_status = ?";
        }
        if (payStatus != null && !payStatus.isEmpty()) {
            query += " AND pay_status = ?";
        }

        try {
            List<Order> ls = new ArrayList<>();
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);

            if (orderId != null && !orderId.isEmpty()) {
                ps.setString(paramIndex++, "%" + orderId + "%");
            }
            if (username != null && !username.isEmpty()) {
                ps.setString(paramIndex++, "%" + username + "%");
            }
            if (orderDateFrom != null && !orderDateFrom.isEmpty()) {
                ps.setDate(paramIndex++, Date.valueOf(orderDateFrom));
            }
            if (orderDateTo != null && !orderDateTo.isEmpty()) {
                ps.setDate(paramIndex++, Date.valueOf(orderDateTo));
            }
            if (orderStatus != null && !orderStatus.isEmpty()) {
                ps.setInt(paramIndex++, OrderStatus.valueOf(orderStatus).ordinal());
            }
            if (shippingStatus != null && !shippingStatus.isEmpty()) {
                ps.setInt(paramIndex++, ShipStatus.valueOf(shippingStatus).ordinal());
            }
            if (payStatus != null && !payStatus.isEmpty()) {
                ps.setInt(paramIndex++, PayStatus.valueOf(payStatus).ordinal());
            }

            rs = ps.executeQuery();

            while (rs.next()) {
                ls.add(new Order(
                        rs.getInt(1), // order_id
                        rs.getString(2), // feedback_order
                        rs.getDate(3), // orderDate
                        rs.getString(4), // addressReceive
                        rs.getString(5), // phone
                        rs.getInt(6), // acc_id
                        rs.getString(7), // username
                        rs.getDouble(8), // totalPrice
                        OrderStatus.values()[rs.getInt(9)], // order_status
                        PayStatus.values()[rs.getInt(10)], // pay_status
                        ShipStatus.values()[rs.getInt(11)] // shipping_status
                ));
            }
            return ls;
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

    public int countPageOrderSearchCustomer(String orderId, String username, String orderDateFrom, String orderDateTo,
            String orderStatus, String shippingStatus, String payStatus) {
        String query = "SELECT COUNT(*) FROM [ClothesStore].[dbo].[Orders] WHERE 1=1";
        int paramIndex = 1;

        if (orderId != null && !orderId.isEmpty()) {
            query += " AND order_id LIKE ?";
        }
        if (username != null && !username.isEmpty()) {
            query += " AND username LIKE ?";
        }
        if (orderDateFrom != null && !orderDateFrom.isEmpty()) {
            query += " AND orderDate >= ?";
        }
        if (orderDateTo != null && !orderDateTo.isEmpty()) {
            query += " AND orderDate <= ?";
        }
        if (orderStatus != null && !orderStatus.isEmpty()) {
            query += " AND order_status = ?";
        }
        if (shippingStatus != null && !shippingStatus.isEmpty()) {
            query += " AND shipping_status = ?";
        }
        if (payStatus != null && !payStatus.isEmpty()) {
            query += " AND pay_status = ?";
        }

        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);

            if (orderId != null && !orderId.isEmpty()) {
                ps.setString(paramIndex++, "%" + orderId + "%");
            }
            if (username != null && !username.isEmpty()) {
                ps.setString(paramIndex++, "%" + username + "%");
            }
            if (orderDateFrom != null && !orderDateFrom.isEmpty()) {
                ps.setDate(paramIndex++, Date.valueOf(orderDateFrom));
            }
            if (orderDateTo != null && !orderDateTo.isEmpty()) {
                ps.setDate(paramIndex++, Date.valueOf(orderDateTo));
            }
            if (orderStatus != null && !orderStatus.isEmpty()) {
                ps.setInt(paramIndex++, OrderStatus.valueOf(orderStatus).ordinal());
            }
            if (shippingStatus != null && !shippingStatus.isEmpty()) {
                ps.setInt(paramIndex++, ShipStatus.valueOf(shippingStatus).ordinal());
            }
            if (payStatus != null && !payStatus.isEmpty()) {
                ps.setInt(paramIndex++, PayStatus.valueOf(payStatus).ordinal());
            }

            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
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
        return 0;
    }

    public List<Order> searchTop5Orders(String orderId, String username, String orderDateFrom, String orderDateTo,
            String orderStatus, String shippingStatus, String payStatus, int indexPage) {
        String baseQuery = "WITH OrderCTE AS ( "
                + "SELECT ROW_NUMBER() OVER (ORDER BY order_id DESC) AS rownum, * "
                + "FROM [ClothesStore].[dbo].[Orders] WHERE 1=1 ";

        if (orderId != null && !orderId.isEmpty()) {
            baseQuery += " AND order_id LIKE ?";
        }
        if (username != null && !username.isEmpty()) {
            baseQuery += " AND username LIKE ?";
        }
        if (orderDateFrom != null && !orderDateFrom.isEmpty()) {
            baseQuery += " AND orderDate >= ?";
        }
        if (orderDateTo != null && !orderDateTo.isEmpty()) {
            baseQuery += " AND orderDate <= ?";
        }
        if (orderStatus != null && !orderStatus.isEmpty()) {
            baseQuery += " AND order_status = ?";
        }
        if (shippingStatus != null && !shippingStatus.isEmpty()) {
            baseQuery += " AND shipping_status = ?";
        }
        if (payStatus != null && !payStatus.isEmpty()) {
            baseQuery += " AND pay_status = ?";
        }

        String query = baseQuery
                + ") SELECT * FROM OrderCTE WHERE rownum BETWEEN ?*5-4 AND ?*5";

        try {
            List<Order> ls = new ArrayList<>();
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);

            int paramIndex = 1;

            if (orderId != null && !orderId.isEmpty()) {
                ps.setString(paramIndex++, "%" + orderId + "%");
            }
            if (username != null && !username.isEmpty()) {
                ps.setString(paramIndex++, "%" + username + "%");
            }
            if (orderDateFrom != null && !orderDateFrom.isEmpty()) {
                ps.setDate(paramIndex++, Date.valueOf(orderDateFrom));
            }
            if (orderDateTo != null && !orderDateTo.isEmpty()) {
                ps.setDate(paramIndex++, Date.valueOf(orderDateTo));
            }
            if (orderStatus != null && !orderStatus.isEmpty()) {
                ps.setInt(paramIndex++, OrderStatus.valueOf(orderStatus).ordinal());
            }
            if (shippingStatus != null && !shippingStatus.isEmpty()) {
                ps.setInt(paramIndex++, ShipStatus.valueOf(shippingStatus).ordinal());
            }
            if (payStatus != null && !payStatus.isEmpty()) {
                ps.setInt(paramIndex++, PayStatus.valueOf(payStatus).ordinal());
            }
            ps.setInt(paramIndex++, indexPage);
            ps.setInt(paramIndex++, indexPage);

            rs = ps.executeQuery();

            while (rs.next()) {
                ls.add(new Order(
                        rs.getInt(2), // order_id
                        rs.getString(3), // feedback_order
                        rs.getDate(4), // orderDate
                        rs.getString(5), // addressReceive
                        rs.getString(6), // phone
                        rs.getInt(7), // acc_id
                        rs.getString(8), // username
                        rs.getDouble(9), // totalPrice
                        OrderStatus.values()[rs.getInt(10)], // order_status
                        PayStatus.values()[rs.getInt(11)], // pay_status
                        ShipStatus.values()[rs.getInt(12)] // shipping_status
                ));
            }
            return ls;
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

//    public static void main(String[] args) {
//        OrderService orderService = new OrderService();
//        System.out.println(orderService.getAllOrdersSearch("nyo").size());
//    }
    public List<Order> searchOrdersStaff(String orderId, String username, String orderDateFrom, String orderDateTo,
            String orderStatus, String shippingStatus, String payStatus, Double totalPriceFrom, Double totalPriceTo) {
        String baseQuery = "SELECT * "
                + "FROM [ClothesStore].[dbo].[Orders] WHERE 1=1 ";

        if (orderId != null && !orderId.isEmpty()) {
            baseQuery += " AND order_id LIKE ?";
        }
        if (username != null && !username.isEmpty()) {
            baseQuery += " AND username LIKE ?";
        }
        if (orderDateFrom != null && !orderDateFrom.isEmpty()) {
            baseQuery += " AND orderDate >= ?";
        }
        if (orderDateTo != null && !orderDateTo.isEmpty()) {
            baseQuery += " AND orderDate <= ?";
        }
        if (orderStatus != null && !orderStatus.isEmpty()) {
            baseQuery += " AND order_status = ?";
        }
        if (shippingStatus != null && !shippingStatus.isEmpty()) {
            baseQuery += " AND shipping_status = ?";
        }
        if (payStatus != null && !payStatus.isEmpty()) {
            baseQuery += " AND pay_status = ?";
        }
        if (totalPriceFrom != null) {
            baseQuery += " AND totalPrice >= ?";
        }
        if (totalPriceTo != null) {
            baseQuery += " AND totalPrice <= ?";
        }

        try {
            List<Order> ls = new ArrayList<>();
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(baseQuery);

            int paramIndex = 1;

            if (orderId != null && !orderId.isEmpty()) {
                ps.setString(paramIndex++, "%" + orderId + "%");
            }
            if (username != null && !username.isEmpty()) {
                ps.setString(paramIndex++, "%" + username + "%");
            }
            if (orderDateFrom != null && !orderDateFrom.isEmpty()) {
                ps.setDate(paramIndex++, Date.valueOf(orderDateFrom));
            }
            if (orderDateTo != null && !orderDateTo.isEmpty()) {
                ps.setDate(paramIndex++, Date.valueOf(orderDateTo));
            }
            if (orderStatus != null && !orderStatus.isEmpty()) {
                ps.setInt(paramIndex++, OrderStatus.valueOf(orderStatus).ordinal());
            }
            if (shippingStatus != null && !shippingStatus.isEmpty()) {
                ps.setInt(paramIndex++, ShipStatus.valueOf(shippingStatus).ordinal());
            }
            if (payStatus != null && !payStatus.isEmpty()) {
                ps.setInt(paramIndex++, PayStatus.valueOf(payStatus).ordinal());
            }
            if (totalPriceFrom != null) {
                ps.setDouble(paramIndex++, totalPriceFrom);
            }
            if (totalPriceTo != null) {
                ps.setDouble(paramIndex++, totalPriceTo);
            }

            rs = ps.executeQuery();

            while (rs.next()) {
                ls.add(new Order(
                        rs.getInt(1), // order_id
                        rs.getString(2), // feedback_order
                        rs.getDate(3), // orderDate
                        rs.getString(4), // addressReceive
                        rs.getString(5), // phone
                        rs.getInt(6), // acc_id
                        rs.getString(7), // username
                        rs.getDouble(8), // totalPrice
                        OrderStatus.values()[rs.getInt(9)], // order_status
                        PayStatus.values()[rs.getInt(10)], // pay_status
                        ShipStatus.values()[rs.getInt(11)] // shipping_status
                ));
            }
            return ls;
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

    public int countPageOrderSearchStaff(String orderId, String username, String orderDateFrom, String orderDateTo,
            String orderStatus, String shippingStatus, String payStatus, Double totalPriceFrom, Double totalPriceTo) {
        String query = "SELECT COUNT(*) FROM [ClothesStore].[dbo].[Orders] WHERE 1=1";
        int paramIndex = 1;

        if (orderId != null && !orderId.isEmpty()) {
            query += " AND order_id LIKE ?";
        }
        if (username != null && !username.isEmpty()) {
            query += " AND username LIKE ?";
        }
        if (orderDateFrom != null && !orderDateFrom.isEmpty()) {
            query += " AND orderDate >= ?";
        }
        if (orderDateTo != null && !orderDateTo.isEmpty()) {
            query += " AND orderDate <= ?";
        }
        if (orderStatus != null && !orderStatus.isEmpty()) {
            query += " AND order_status = ?";
        }
        if (shippingStatus != null && !shippingStatus.isEmpty()) {
            query += " AND shipping_status = ?";
        }
        if (payStatus != null && !payStatus.isEmpty()) {
            query += " AND pay_status = ?";
        }
        if (totalPriceFrom != null) {
            query += " AND totalPrice >= ?";
        }
        if (totalPriceTo != null) {
            query += " AND totalPrice <= ?";
        }

        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);

            if (orderId != null && !orderId.isEmpty()) {
                ps.setString(paramIndex++, "%" + orderId + "%");
            }
            if (username != null && !username.isEmpty()) {
                ps.setString(paramIndex++, "%" + username + "%");
            }
            if (orderDateFrom != null && !orderDateFrom.isEmpty()) {
                ps.setDate(paramIndex++, Date.valueOf(orderDateFrom));
            }
            if (orderDateTo != null && !orderDateTo.isEmpty()) {
                ps.setDate(paramIndex++, Date.valueOf(orderDateTo));
            }
            if (orderStatus != null && !orderStatus.isEmpty()) {
                ps.setInt(paramIndex++, OrderStatus.valueOf(orderStatus).ordinal());
            }
            if (shippingStatus != null && !shippingStatus.isEmpty()) {
                ps.setInt(paramIndex++, ShipStatus.valueOf(shippingStatus).ordinal());
            }
            if (payStatus != null && !payStatus.isEmpty()) {
                ps.setInt(paramIndex++, PayStatus.valueOf(payStatus).ordinal());
            }
            if (totalPriceFrom != null) {
                ps.setDouble(paramIndex++, totalPriceFrom);
            }
            if (totalPriceTo != null) {
                ps.setDouble(paramIndex++, totalPriceTo);
            }

            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
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
        return 0;
    }
}

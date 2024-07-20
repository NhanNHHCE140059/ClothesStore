/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import model.Account;
import model.OrderDetailCustomer;
import model.OrderDetailStaff;
import service.OrderDetailService;

@WebServlet(value = "/OrderDetailControl")

public class OrderDetailCustomerControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        HttpSession session = request.getSession();
        if (session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");

        } else {
            Account a = (Account) session.getAttribute("account");
            if (a.getRole() != helper.Role.Customer) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }
            int indexPage;
            if (request.getParameter("indexPage") != null && !request.getParameter("indexPage").isEmpty()) {
                indexPage = Integer.parseInt(request.getParameter("indexPage"));
            } else {
                indexPage = 1;
            }
            if (request.getParameter("indexPageback") != null && !request.getParameter("indexPageback").isEmpty()) {
                indexPage = Integer.parseInt(request.getParameter("indexPageback"));
            }
            response.setContentType("text/html;charset=UTF-8");
            String orderId = request.getParameter("orderId");
            OrderDetailService dao = new OrderDetailService();
            List<OrderDetailCustomer> count = dao.getOrderDetailByOrderIDCustomer(Integer.parseInt(orderId));
//        request.setAttribute("endPage", endPage);
            Set<String> colorInBill = new HashSet<>();
            Set<String> sizeInBill = new HashSet<>();
            for (OrderDetailCustomer billDT : count) {
                colorInBill.add(billDT.getColor_name());
            }
            for (OrderDetailCustomer billSZ : count) {
                sizeInBill.add(billSZ.getSize_name().toString()); // Sử dụng toString() để chuyển đổi ProductSizeType thành String
            }
            if (request.getParameter("search") != null && !request.getParameter("search").isEmpty()) {
                System.out.println("-------------------------------------------------------------------");
                System.out.println(request.getParameter("search"));
                String nameProduct = request.getParameter("NameProduct").trim();
                String priceFromStr = request.getParameter("priceFrom");
                String priceToStr = request.getParameter("priceTo");
                String orderDateFrom = request.getParameter("orderDateFrom");
                String orderDateTo = request.getParameter("orderDateTo");
                String size = request.getParameter("size");
                String color = request.getParameter("color");
                request.setAttribute("search", request.getParameter("search"));
                request.setAttribute("nameProduct", nameProduct);
                request.setAttribute("priceFrom", priceFromStr);
                request.setAttribute("priceTo", priceToStr);
                request.setAttribute("orderDateFrom", orderDateFrom);
                request.setAttribute("orderDateTo", orderDateTo);
                request.setAttribute("size", size);
                request.setAttribute("color", color);
                // Assuming your DAO method is called searchOrderDetailsStaff
                count = dao.searchOrderDetailsCustomer(orderId,
                        nameProduct, priceFromStr, priceToStr, orderDateFrom, orderDateTo, size, color
                );
            }
//        List<OrderDetailCustomer> prv = dao.getOrderDetailByOrderIDCustomer(Integer.parseInt(orderId));
//          List<OrderDetailCustomer> count = dao.getOrderDetailByOrderIDCustomer(Integer.parseInt(orderId));
            int orderPerPage = 5;
            int starCountList = (indexPage - 1) * orderPerPage;
            int endCountList = Math.min(starCountList + orderPerPage, count.size());
            List<OrderDetailCustomer> count1 = count.subList(starCountList, endCountList);
            int endPage = (int) Math.ceil((double) count.size() / orderPerPage);

            if (request.getParameter("feedbackid") != null) {
                String order_detail_id = (request.getParameter("feedbackid"));
                request.setAttribute("order_detail_id", order_detail_id);
            }
            request.setAttribute("prvlst", count1);
            request.setAttribute("colorInBill", colorInBill);
            request.setAttribute("sizeInBill", sizeInBill);
            request.setAttribute("orderIds", orderId);
            request.setAttribute("indexPage", indexPage);
            request.setAttribute("endPage", endPage);
            System.out.println(count);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/OrderDetail.jsp");
            dispatcher.forward(request, response);

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nameProduct = null;
        String priceFromStr = null;
        String priceToStr = null;
        String orderDateFrom = null;
        String orderDateTo = null;
        String size = null;
        String color = null;
        try {

            if (request.getParameter("search") != null && !request.getParameter("search").isEmpty()) {

                nameProduct = request.getParameter("NameProduct");
                priceFromStr = request.getParameter("priceFrom");
                priceToStr = request.getParameter("priceTo");
                orderDateFrom = request.getParameter("orderDateFrom");
                orderDateTo = request.getParameter("orderDateTo");
                size = request.getParameter("size");
                color = request.getParameter("color");
            }
            // Lấy tham số từ request
            String feedback_details = request.getParameter("feedback");
            String orderDetailIdStr = request.getParameter("order_detail_id");
            String orderIdStr = request.getParameter("orderId");
            // Kiểm tra và chuyển đổi tham số
            if (orderDetailIdStr == null || orderDetailIdStr.trim().isEmpty()
                    || orderIdStr == null || orderIdStr.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/OrderDetailControl");
                return;
            }

            int order_detail_id = Integer.parseInt(orderDetailIdStr);
            int orderId = Integer.parseInt(orderIdStr);

            // Tạo đối tượng dịch vụ
            OrderDetailService ordersv = new OrderDetailService();

            // Kiểm tra phản hồi rỗng hoặc chỉ chứa khoảng trắng
            if (feedback_details == null || feedback_details.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/OrderDetailControl?orderId=" + orderId);
                return;
            }

            // Cập nhật phản hồi của khách hàng
            ordersv.updateFbDetailCustomer(feedback_details, order_detail_id);
            System.out.println(request.getParameter("indexPage"));
            if (request.getParameter("search") != null && !request.getParameter("search").isEmpty()) {
                String redirectUrl = request.getContextPath() + "/OrderDetailControl?orderId=" + orderId
                        + "&indexPage=" + request.getParameter("indexPage")
                        + "&NameProduct=" + nameProduct
                        + "&priceFrom=" + priceFromStr
                        + "&priceTo=" + URLEncoder.encode(priceToStr, "UTF-8")
                        + "&orderDateFrom=" + URLEncoder.encode(orderDateFrom, "UTF-8")
                        + "&orderDateTo=" + URLEncoder.encode(orderDateTo, "UTF-8")
                        + "&size=" + URLEncoder.encode(size, "UTF-8")
                        + "&color=" + URLEncoder.encode(color, "UTF-8")
                        + "&search=" + request.getParameter("search");
                System.out.println("Go post");
                System.out.println(priceFromStr);
                System.out.println(request.getParameter("search"));
                response.sendRedirect(redirectUrl);
                return;
            }
            // Chuyển hướng về trang chi tiết đơn hàng với orderId
            response.sendRedirect(request.getContextPath() + "/OrderDetailControl?orderId=" + orderId + "&indexPage=" + request.getParameter("indexPage"));
            return;
        } catch (NumberFormatException e) {
            // Xử lý lỗi chuyển đổi số
            response.sendRedirect(request.getContextPath() + "/OrderDetailControl");
        } catch (Exception e) {
            // Xử lý các lỗi khác
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/OrderDetailControl");
        }
    }

    //         HttpSession session = request.getSession();
    //            if(session.getAttribute("account")==null){
    //            response.sendRedirect(request.getContextPath()+"/login.jsp");
    //           
    //        }else{
    //         String orderID = request.getParameter("orderId");
    //
    //        try {
    //            int parsedOrderID = Integer.parseInt(orderID);
    //            OrderDetailService dao = new OrderDetailService();
    //            ProductService daoo = new ProductService();
    //
    //            List<OrderDetail> lstOrderDetail = dao.getOrderDetailByOrderID(parsedOrderID); //ok
    //            List<Map<OrderDetail, Product>> lsoderduct = new ArrayList<>();
    //            for (OrderDetail od : lstOrderDetail) {
    //               
    //                Map<OrderDetail, Product> aaa = new HashMap<>();
    //                aaa.put(od,(daoo.GetProById(od.getPro_id())));
    //                lsoderduct.add(aaa);
    //            }
    //         
    //            request.setAttribute("lstOrderDetail", lsoderduct);
    //             request.getRequestDispatcher("OrderDetail.jsp").forward(request, response);
    //        } catch (NumberFormatException e) {
    //            String errorMessage = "ID đơn hàng không hợp lệ.";
    //            request.setAttribute("errorMessage", errorMessage);
    //            System.out.println(errorMessage);
    //        }
    //     
    //    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}

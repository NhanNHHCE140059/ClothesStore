/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.OrderDetail;
import model.Product;
import service.OrderDetailService;
import service.ProductService;
@WebServlet(value ="/OrderDetailControl")

public class OrderDetailControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

       

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
         HttpSession session = request.getSession();
            if(session.getAttribute("account")==null){
            response.sendRedirect(request.getContextPath()+"/login.jsp");
           
        }else{
         String orderID = request.getParameter("orderId");

        try {
            int parsedOrderID = Integer.parseInt(orderID);
            OrderDetailService dao = new OrderDetailService();
            ProductService daoo = new ProductService();

            List<OrderDetail> lstOrderDetail = dao.getOrderDetailByOrderID(parsedOrderID); //ok
            List<Map<OrderDetail, Product>> lsoderduct = new ArrayList<>();
            for (OrderDetail od : lstOrderDetail) {
               
                Map<OrderDetail, Product> aaa = new HashMap<>();
                aaa.put(od,(daoo.GetProById(od.getPro_id())));
                lsoderduct.add(aaa);
            }
         
            request.setAttribute("lstOrderDetail", lsoderduct);
             request.getRequestDispatcher("OrderDetail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            String errorMessage = "ID đơn hàng không hợp lệ.";
            request.setAttribute("errorMessage", errorMessage);
            System.out.println(errorMessage);
        }
     
    }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}

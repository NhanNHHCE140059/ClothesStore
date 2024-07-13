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
import java.util.List;
import model.Account;
import model.Order;
import service.OrderService;

/**
 *
 * @author HP
 */
@WebServlet(value = "/OrderSearchCustomerController")
public class OrderSearchCustomerController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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

            OrderService ordersv = new OrderService();
            String username = a.getUsername();

            int indexPage;
            if (request.getParameter("indexPage") != null&&!request.getParameter("indexPage").isEmpty() ) {
                indexPage = Integer.parseInt(request.getParameter("indexPage"));
            } else {
                indexPage = 1;
            }

            // Initialize variables before using them
            String orderId = request.getParameter("orderId");
            String orderDateFrom = request.getParameter("orderDateFrom");
            String orderDateTo = request.getParameter("orderDateTo");
            String orderStatus = request.getParameter("orderStatus");
            String shippingStatus = request.getParameter("shippingStatus");
            String payStatus = request.getParameter("payStatus");
            
     if(request.getParameter("feedback")!=null)   {

            String feedback = request.getParameter("feedback");
            int orderids = Integer.parseInt(request.getParameter("orderids"));
         System.out.println(orderids);
               System.out.println(feedback);

            if (feedback == null || feedback.trim().length() == 0) {
             response.sendRedirect(request.getContextPath() + "/OrderSearchCustomerController?orderId="+orderId+"&orderDateFrom="+orderDateFrom+"&orderDateTo="+orderDateTo+"&orderStatus="+orderStatus+"&shippingStatus="+shippingStatus+"&payStatus="+payStatus+"&indexPage="+indexPage);

                return;
            }
            ordersv.updateFbCustomer(feedback, orderids);
            response.sendRedirect(request.getContextPath() + "/OrderSearchCustomerController?orderId="+orderId+"&orderDateFrom="+orderDateFrom+"&orderDateTo="+orderDateTo+"&orderStatus="+orderStatus+"&shippingStatus="+shippingStatus+"&payStatus="+payStatus+"&indexPage="+indexPage);
                return;


        }
            // Calculate count after initializing variables
            int count = ordersv.countPageOrderSearchCustomer(orderId, a.getUsername(), orderDateFrom, orderDateTo, orderStatus, shippingStatus, payStatus);

            int size = 5;
            int endPage = count / size;
            if (count % size != 0) {
                endPage++;
            }
            if (request.getParameter("feedbackid") != null) {
                String orderid = (request.getParameter("feedbackid"));
                request.setAttribute("orderid", orderid);
            }
            if (endPage >= 1) {
                int aaa = 1;
                request.setAttribute("aaa", aaa);

            }
            List<Order> orders = ordersv.searchTop5Orders(orderId, a.getUsername(), orderDateFrom, orderDateTo, orderStatus, shippingStatus, payStatus, indexPage);
//            List<Order> orders = ordersv.searchOrders(orderId, a.getUsername(), orderDateFrom, orderDateTo, orderStatus, shippingStatus, payStatus);
            request.setAttribute("lstOrder", orders);

            request.setAttribute("endPage", endPage);
            request.getRequestDispatcher("orderHistory.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

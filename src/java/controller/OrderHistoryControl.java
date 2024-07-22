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
@WebServlet(value = "/OrderHistoryControl")

public class OrderHistoryControl extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");

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
            if (request.getParameter("indexPage") != null && !request.getParameter("indexPage").isEmpty()) {

                indexPage = Integer.parseInt(request.getParameter("indexPage"));
            } else {
                indexPage = 1;
            }

            int count = ordersv.countPageOrderCustomer(username);
            int size = 5;
            int endPage = count / size;
            if (count % size != 0) {
                endPage++;

            }
            if (request.getParameter("feedbackid") != null) {
                String orderid = (request.getParameter("feedbackid"));
                request.setAttribute("orderid", orderid);
            }
            List<Order> lstOrder = ordersv.getTop50OrderHistoryByAccountID(a.getUsername(), indexPage);

            request.setAttribute("lstOrder", lstOrder);
            request.setAttribute("endPage", endPage);
            System.out.println(lstOrder.toString());
            request.getRequestDispatcher("/orderHistory.jsp").forward(request, response);
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

        String feedback = request.getParameter("feedback");
        int orderid = Integer.parseInt(request.getParameter("orderid"));
        int indexPage = 1;
        if (request.getParameter("indexPage") != null && !request.getParameter("indexPage").isEmpty()) {
            indexPage = Integer.parseInt(request.getParameter("indexPage"));
        }

        OrderService ordersv = new OrderService();
        if (feedback == null || feedback.trim().length() == 0) {
            response.sendRedirect(request.getContextPath() + "/OrderHistoryControl?indexPage=" + indexPage);
            return;
        }
        ordersv.updateFbCustomer(feedback, orderid);
        response.sendRedirect(request.getContextPath() + "/OrderHistoryControl?indexPage=" + indexPage);

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

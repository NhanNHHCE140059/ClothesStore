/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import helper.PayStatus;
import helper.ShipStatus;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Order;
import service.AccountService;
import service.OrderService;

/**
 *
 * @author My Computer
 */
@WebServlet(value = {"/FeedBackManagementController", "/staff/manage"})
public class FeedBackManagementController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        if ((Account) session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        } else {
            Account account = (Account) session.getAttribute("account");
            if (account.getRole() == (helper.Role.Customer) || account == null) {
                session.removeAttribute("role");
                session.removeAttribute("account");
                response.sendRedirect("home");
                return;
            } else {
                AccountService as = new AccountService();
                OrderService odsv = new OrderService();
                List<Order> listOrderShipped = odsv.listAllOrdersShipped();
                request.setAttribute("account", account);
                request.setAttribute("listOrderShipped", listOrderShipped);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/feedbackManagement.jsp");
                dispatcher.forward(request, response);
            }
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int idOrder = Integer.parseInt(request.getParameter("idOrder"));
        OrderService odsv = new OrderService();
        odsv.deleteFeedbackById(idOrder);
        response.sendRedirect(request.getContextPath() + "/FeedBackManagementController");

    }

}

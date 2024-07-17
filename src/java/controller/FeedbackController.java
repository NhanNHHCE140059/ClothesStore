/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Order;
import service.OrderService;

/**
 *
 * @author HP
 */
@WebServlet(name = "FeedbackController", urlPatterns = {"/feedback"})
public class FeedbackController extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet FeedbackController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FeedbackController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
        try {
            OrderService orderDao = new OrderService();
            HttpSession session = request.getSession();
            if (session.getAttribute("account") == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
            } else {
                Account a = (Account) session.getAttribute("account");
                if (a.getRole() != helper.Role.Customer) {
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                    return;
                }
                String orderId = request.getParameter("orderId");
                Order order = orderDao.getOrderByIdAndUser(Integer.parseInt(orderId), a.getAcc_id());
                if (order != null) {
                    request.setAttribute("order", order);
                    request.getRequestDispatcher("feedback-order.jsp").forward(request, response);
                } else {
                    response.sendRedirect("OrderHistoryControl");
                }
            }
        } catch (Exception e) {
            response.sendRedirect("OrderHistoryControl");
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
        try {
            OrderService orderDao = new OrderService();
            HttpSession session = request.getSession();
            if (session.getAttribute("account") == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
            } else {
                Account a = (Account) session.getAttribute("account");
                if (a.getRole() != helper.Role.Customer) {
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                    return;
                }
                String orderId = request.getParameter("orderId");
                Order order = orderDao.getOrderByIdAndUser(Integer.parseInt(orderId), a.getAcc_id());
                if (order != null) {
                    String feedback = request.getParameter("feedback");
                    if (feedback != null && feedback.trim().length() == 0) {
                        request.setAttribute("error", "Please fill feedback for this order");
                        request.setAttribute("order", order);
                        request.getRequestDispatcher("feedback-order.jsp").forward(request, response);
                        return;
                    }
                    order.setFeedback_order(feedback);
                    int result = orderDao.feedback(order);
                    if(result > 0) {
                        response.sendRedirect("OrderHistoryControl?success=Feedback success");
                    } else {
                        response.sendRedirect("OrderHistoryControl?error=Feedback fail");
                    }
                } else {
                    response.sendRedirect("OrderHistoryControl");
                }
            }
        } catch (Exception e) {
            response.sendRedirect("OrderHistoryControl");
        }
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

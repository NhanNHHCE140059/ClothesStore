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
import java.util.List;
import model.Account;
import model.Order;
import model.OrderDetail;
import service.OrderDetailService;
import service.OrderService;
import service.WarehouseService;

/**
 *
 * @author HP
 */
@WebServlet(name = "CancelOrderControl", urlPatterns = {"/CancelOrderControl"})
public class CancelOrderControl extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CancelOrderControl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CancelOrderControl at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        if (session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        } else {
            Account a = (Account) session.getAttribute("account");
            if (a.getRole() != helper.Role.Staff) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }
        }
        String returnPage = "OrderHistoryStaffControllerManagement";
        try {
            String orderId = request.getParameter("orderId");
            OrderService orderDao = new OrderService();
            OrderDetailService ords = new OrderDetailService();
            WarehouseService wareService = new WarehouseService();
            Order order = orderDao.getOrderById(Integer.parseInt(orderId));
            if (order != null) {
//                int result = orderDao.changeStatusOrder(1, order.getOrder_id());
                List<OrderDetail> ors = ords.getOrderDetailByOrderID(order.getOrder_id());
                for (OrderDetail or : ors) {
                    wareService.updateInventoryByVariantId(or.getVariant_id(), or.getQuantity());
                }
                int result = orderDao.deleteOrder(order.getOrder_id());
                if (result > 0) {
                    response.sendRedirect("OrderHistoryStaffControllerManagement" + "?success=Cancel order successfully");
                    return;
                }

                response.sendRedirect("OrderHistoryStaffControllerManagement" + "?error=Cancel order fail");
            } else {
                response.sendRedirect("OrderHistoryStaffControllerManagement" + "?error=Cancel not found this order");
            }
        } catch (Exception e) {
            System.out.println("Cancel order: " + e);
            response.sendRedirect("OrderHistoryStaffControllerManagement" + "?error=Have a error with this order");
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
        processRequest(request, response);
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

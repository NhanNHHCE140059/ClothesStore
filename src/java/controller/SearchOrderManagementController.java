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
import java.util.List;
import model.Order;
import service.OrderService;

/**
 *
 * @author HP
 */

@WebServlet(value = "/SearchOrderManagementController")
public class SearchOrderManagementController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String Username= request.getParameter("Username");
        OrderService odsv = new OrderService();
        List<Order> listOrder = odsv.getAllOrdersSearch(Username);
        PrintWriter out = response.getWriter();
          if (listOrder != null && !listOrder.isEmpty()) {
        for (Order o : listOrder) {
    out.print("<tr>");
    out.print("<td>" + o.getOrder_id() + "</td>");
    out.print("<td>" + o.getOrderDate() + "</td>");
    out.print("<td>" + o.getUsername() + "</td>");
    out.print("<td>" + new java.text.DecimalFormat("#,##0").format(o.getTotalPrice()) + "</td>");
    out.print("<td>" + o.getOrder_status() + "</td>");
    out.print("<td>" + o.getPay_status() + "</td>");
    out.print("<td>" + o.getShipping_status() + "</td>");
    out.print("<td class=\"actions\">");
    out.print("<a href=\"OrderDetailStaffControl?orderId=" + o.getOrder_id() + "\" class=\"detail\" title=\"Detail Order " + o.getOrder_id() + "\">");
    out.print("<i class=\"material-icons\">visibility</i>");
    out.print("</a>");
    out.print("<a href=\"CancelOrderControl?orderId=" + o.getOrder_id() + "\" class=\"cancel\" title=\"Cancel Order " + o.getOrder_id() + "\">");
    out.print("<i class=\"material-icons\">cancel</i>");
    out.print("</a>");
    out.print("<a href=\"ConfirmOrderControl?orderId=" + o.getOrder_id() + "\" class=\"confirm\" title=\"Confirm Order " + o.getOrder_id() + "\">");
    out.print("<i class=\"material-icons\">check_circle</i>");
    out.print("</a>");
    out.print("</td>");
    out.print("</tr>");
}

          }else{
                 out.print("<tr class='NotFound'>\n");
    out.print("<td colspan='8'>Not Found Order</td>\n");
    out.print("</tr>\n");
          }
                
        }
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

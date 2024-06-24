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
 * @author My Computer
 */
@WebServlet(value = "/SearchFeedback")
public class SearchFeedback extends HttpServlet {

  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String phoneSearch = request.getParameter("phoneSearch");
        OrderService odsv = new OrderService();
        List<Order> listOrder = odsv.getTop5OrdersSearch(1, phoneSearch);
        PrintWriter out = response.getWriter();
        if (listOrder != null && !listOrder.isEmpty()) {
            for (Order o : listOrder) {
                out.print("<tr>\n");
                out.print("<td>" + o.getOrder_id() + "</td>\n");
                out.print("<td>" + o.getPhone() + "</td>\n");
                if (o.getFeedback_order() == null) {
                    out.print("<td class=\"error-message\">There are no feedback yet or the feedback has been deleted</td>\n");
                } else {
                    out.print("<td>" + o.getFeedback_order() + "</td>\n");
                }
                out.print("<td>\n");
                out.print("<form action=\"FeedBackManagementController\" method=\"POST\">\n");
                if (o.getFeedback_order() == null) {
                    out.print("<button class=\"non-action-button\">Delete Feedback</button>\n");
                } else {
                    out.print("<input type=\"hidden\" name=\"action\" value=\"delete\">\n");
                    out.print("<input type=\"hidden\" name=\"idOrder\" value=\"" + o.getOrder_id() + "\">\n");
                    out.print("<button class=\"action-button\" type=\"submit\">Delete Feedback</button>\n");
                }
                out.print("</form>\n");
                out.print("</td>\n");
                out.print("</tr>\n");
            }
        } else {
            out.print("<tr>\n");
            out.print("<td>Not Found Order</td>\n");
            out.print("<td>Not Found Feedback</td>\n");
            out.print("</tr>\n");
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

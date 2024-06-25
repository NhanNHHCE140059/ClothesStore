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
import java.sql.Date;
import java.util.List;
import model.Bill;
import service.BillService;

/**
 *
 * @author HP
 */
@WebServlet(value = "/SearchBill")
public class SearchBillController extends HttpServlet {

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
        String nameSearch = request.getParameter("nameSearch");
        BillService bsv = new BillService();
        List<Bill> listBill = bsv.getTop10BillSearch( nameSearch);
        PrintWriter out = response.getWriter();
        if (listBill != null && !listBill.isEmpty()) {
            for (Bill o : listBill) {
                out.print("<tr>\n");
                out.print("<td class=\"id\"><span>" + o.getBill_id() + "</span></td>\n");
                out.print("<td class=\"date\"><span>" + o.getCreate_date() + "</span></td>\n");
                out.print("<td class=\"totalAmount\"><span>" + String.format("%,d", (int) o.getTotal_amount()) + "</span></td>\n");
                out.print("<td class=\"pro_name\"><span>" + o.getPro_name() + "</span></td>\n");
                out.print("<td class=\"import_price\"><span>" + String.format("%,d", (int) o.getImport_price()) + "</span></td>\n");
                out.print("<td class=\"quantity\"><span>" + o.getQuantity() + "</span></td>\n");
                out.print("<td class=\"pro_id\"><span>" + o.getPro_id() + "</span></td>\n");
                out.print("<td class=\"image_bill\"><img src=\"" + o.getImage_bill() + "\" alt=\"Bill Image\" style=\"width:50px;height:50px;\"></td>\n");
                out.print("<td>\n");
                out.print("    <a href=\"BillDetailControl?billId=" + o.getBill_id() + "\">\n");
                out.print("       <i class=\"material-icons\" data-toggle=\"tooltip\" title=\"Detail\">visibility</i>\n");
                out.print("    </a>\n");
                out.print("</td>\n");
                out.print("</tr>\n");
            }
        } else {
            out.print("<tr>\n");
            out.print("<td colspan=\"9\">Not Found Order</td>\n");
            out.print("</tr>\n");
        }

//            private int bill_id;
//    private Date create_date;
//    private double total_amount;
//    private String pro_name;
//    private double import_price;
//    private int quantity;
//    private String image_bill;
//    private int pro_id;
    }
@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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

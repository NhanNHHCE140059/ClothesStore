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
import model.ImportBill;
import service.ImportBillService;

/**
 *
 * @author HP
 */
@WebServlet(value = "/SearchImportBillController")
public class SearchImportBillController extends HttpServlet {

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
            if (a.getRole() == helper.Role.Customer) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }

            ImportBillService billsv = new ImportBillService();

            int indexPage;
            if (request.getParameter("indexPage") != null && !request.getParameter("indexPage").isEmpty()) {
                indexPage = Integer.parseInt(request.getParameter("indexPage"));
            } else {
                indexPage = 1;
            }
            if (request.getParameter("indexPageback") != null && !request.getParameter("indexPageback").isEmpty()) {
                indexPage = Integer.parseInt(request.getParameter("indexPageback"));
            }
            // Initialize variables before using them
            String billId = request.getParameter("billId");
            if (request.getParameter("searchbillId") != null && !request.getParameter("searchbillId").isEmpty()) {
                billId = request.getParameter("searchbillId");
            }
            String createDateFrom = request.getParameter("createDateFrom");
            String createDateTo = request.getParameter("createDateTo");
            String totalPriceFromStr = request.getParameter("totalPriceFrom");
            String totalPriceToStr = request.getParameter("totalPriceTo");
            Double totalAmountFrom = null;
            Double totalAmountTo = null;
            try {
                if (totalPriceFromStr != null && !totalPriceFromStr.isEmpty()) {
                    totalAmountFrom = Double.parseDouble(totalPriceFromStr);
                }
                if (totalPriceToStr != null && !totalPriceToStr.isEmpty()) {
                    totalAmountTo = Double.parseDouble(totalPriceToStr);
                }
            } catch (NumberFormatException e) {
                // Handle the case where totalPriceFromStr or totalPriceToStr is not a valid Double
                e.printStackTrace(); // Or log the error
            }
// Calculate count after initializing variables
            List<ImportBill> count = billsv.searchImportBills(billId, createDateFrom, createDateTo, totalAmountFrom, totalAmountTo);
            int orderPerPage = 5;
            int starCountList = (indexPage - 1) * orderPerPage;
            int endCountList = Math.min(starCountList + orderPerPage, count.size());
            //trang1 0_ 5
            // trang 2 5  10
//            /trang 3 10  11

            List<ImportBill> count1 = count.subList(starCountList, endCountList);
            int endPage = (int) Math.ceil((double) count.size() / orderPerPage);

            if (count1.size() != 0) {
                int aaa = 1;
                request.setAttribute("aaa", aaa);

            }

//            List<Order> orders = ordersv.searchOrders(orderId, a.getUsername(), orderDateFrom, orderDateTo, orderStatus, shippingStatus, payStatus);
            request.setAttribute("lstBill", count1);
            request.setAttribute("endPage", endPage);
            request.setAttribute("searchbillId", billId);
            System.out.println(endPage);
            request.getRequestDispatcher("Bill_Import.jsp").forward(request, response);
        }
    }

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

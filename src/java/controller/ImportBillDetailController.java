/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import model.Account;
import model.ImportBillDetailInfor;

import service.ImportBillDetailService;

/**
 *
 * @author HP
 */
@WebServlet(value = "/ImportBillDetailController")
public class ImportBillDetailController extends HttpServlet {

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
        HttpSession session = request.getSession();
        if (session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        } else {
            Account a = (Account) session.getAttribute("account");
            if (a.getRole() == helper.Role.Customer) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }

            int indexPage;
            if (request.getParameter("indexPage") != null && !request.getParameter("indexPage").isEmpty()) {
                indexPage = Integer.parseInt(request.getParameter("indexPage"));
            } else {
                indexPage = 1;
            }
            String billId = request.getParameter("billId");

            ImportBillDetailService ibds = new ImportBillDetailService();
            Set<String> colorInBill = new HashSet<>();
            Set<String> sizeInBill = new HashSet<>();
            List<ImportBillDetailInfor> count = ibds.getImportBillDetailByBillI(Integer.parseInt(billId));
            for (ImportBillDetailInfor billDT : count) {
                colorInBill.add(billDT.getColor_name());
            }
            for (ImportBillDetailInfor billSZ : count) {
                sizeInBill.add(billSZ.getSize_name().toString()); // Sử dụng toString() để chuyển đổi ProductSizeType thành String
            }

            int orderPerPage = 5;
            int starCountList = (indexPage - 1) * orderPerPage;
            int endCountList = Math.min(starCountList + orderPerPage, count.size());
            //trang1 0_ 5
            // trang 2 5  10
//            /trang 3 10  11

            List<ImportBillDetailInfor> count1 = count.subList(starCountList, endCountList);
            int endPage = (int) Math.ceil((double) count.size() / orderPerPage);
            request.setAttribute("prvlst", count1);
            request.setAttribute("colorInBill", colorInBill);
            request.setAttribute("sizesInBill", sizeInBill);
            request.setAttribute("billId", billId);
            request.setAttribute("endPage", endPage);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Bill_ImportDetail.jsp");
            dispatcher.forward(request, response);
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

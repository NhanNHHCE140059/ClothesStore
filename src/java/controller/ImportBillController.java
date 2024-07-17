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
@WebServlet(value ="/ImportBillController")

public class ImportBillController extends HttpServlet {

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
        
        HttpSession session = request.getSession();
        if(session.getAttribute("account")==null){
            response.sendRedirect(request.getContextPath()+"/login.jsp");
           
        }else{
            
        Account a = (Account) session.getAttribute("account");
        if(a.getRole()== helper.Role.Customer){
                        response.sendRedirect(request.getContextPath()+"/index.jsp");

        }else{
        ImportBillService billsv = new ImportBillService();
        int indexPage;
        if (request.getParameter("indexPage") != null) {

            indexPage = Integer.parseInt(request.getParameter("indexPage"));
        } else {
            indexPage = 1;
        }
        if(request.getParameter("indexPageback")!= null && !request.getParameter("indexPageback").isEmpty()){
                indexPage = Integer.parseInt(request.getParameter("indexPageback"));
                System.out.println(indexPage);
        }

        int count = billsv.countPageBillService();
        int size = 5;
        int endPage = count / size;
        if (count % size != 0) {
            endPage++;

        }
        List<ImportBill> lstBill = billsv.getTop5ImportBill(indexPage);
        request.setAttribute("endPage", endPage);
        request.setAttribute("lstBill", lstBill);
        request.getRequestDispatcher("/Bill_Import.jsp").forward(request, response);

    }
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

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import helper.ProductSizeType;
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
@WebServlet(name="SearchImportBillDetailController", urlPatterns={"/SearchImportBillDetailController"})
public class SearchImportBillDetailController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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

        ImportBillDetailService importBillDetailService = new ImportBillDetailService();

        int indexPage;
        if (request.getParameter("indexPage") != null && !request.getParameter("indexPage").isEmpty()) {
            indexPage = Integer.parseInt(request.getParameter("indexPage"));
        } else {
            indexPage = 1;
        }

        // Initialize variables before using them
   

        String billIdStr = request.getParameter("billId");
        String detailBillIdStr = request.getParameter("detailBill_id");
        String pro_name = request.getParameter("pro_name");
        String sizeIdStr = request.getParameter("size_id");
        String color_name = request.getParameter("color_name");
        String quantityFromStr = request.getParameter("quantityFrom");
        String quantityToStr = request.getParameter("quantityTo");
        String import_priceFromStr = request.getParameter("import_priceFrom").replaceAll("[^\\d]", "");
        String import_priceToStr = request.getParameter("import_priceTo").replaceAll("[^\\d]", "");

        Integer billId = null;
        Integer detailBill_id = null;
        Integer size_id = null;
        Integer quantityFrom = null;
        Integer quantityTo = null;
        Double import_priceFrom = null;
        Double import_priceTo = null;

        try {
            if (billIdStr != null && !billIdStr.isEmpty()) {
                billId = Integer.parseInt(billIdStr);
            }
            if (detailBillIdStr != null && !detailBillIdStr.isEmpty()) {
                detailBill_id = Integer.parseInt(detailBillIdStr);
            }
            if (sizeIdStr != null && !sizeIdStr.isEmpty()) {
//                size_id = Integer.parseInt(sizeIdStr);
                         ProductSizeType pt = ProductSizeType.valueOf(sizeIdStr);
         size_id=pt.ordinal();
            }
            if (quantityFromStr != null && !quantityFromStr.isEmpty()) {
                quantityFrom = Integer.parseInt(quantityFromStr);
            }
            if (quantityToStr != null && !quantityToStr.isEmpty()) {
                quantityTo = Integer.parseInt(quantityToStr);
            }
            if (import_priceFromStr != null && !import_priceFromStr.isEmpty()) {
                import_priceFrom = Double.parseDouble(import_priceFromStr);
            }
            if (import_priceToStr != null && !import_priceToStr.isEmpty()) {
                import_priceTo = Double.parseDouble(import_priceToStr);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace(); // Or log the error
        }


        List<ImportBillDetailInfor> count = importBillDetailService.searchImportBillDetails(
                billId, detailBill_id, pro_name, size_id, color_name,
                quantityFrom, quantityTo, import_priceFrom, import_priceTo
        );
        System.out.println(billId);
                    List<ImportBillDetailInfor> count3 = importBillDetailService.getImportBillDetailByBillI((billId));
        System.out.println(count3);
                 Set<String> colorInBill = new HashSet<>();
      Set<String> sizeInBill = new HashSet<>();
            for (ImportBillDetailInfor billDT :count3){
                colorInBill.add(billDT.getColor_name());
            }
             for (ImportBillDetailInfor billSZ : count3) {
    sizeInBill.add(billSZ.getSize_name().toString()); // Sử dụng toString() để chuyển đổi ProductSizeType thành String
}      
   
        int orderPerPage = 5;
        int startCountList = (indexPage - 1) * orderPerPage;
        int endCountList = Math.min(startCountList + orderPerPage, count.size());

        List<ImportBillDetailInfor> count1 = count.subList(startCountList, endCountList);
        int endPage = (int) Math.ceil((double) count.size() / orderPerPage);

        if (count1.size() != 0) {
            int aaa = 1;
            request.setAttribute("aaa", aaa);
        }

        request.setAttribute("prvlst", count1);
        request.setAttribute("endPage", endPage);
           request.setAttribute("selectedColor", color_name);
           request.setAttribute("colorInBill", colorInBill);
             request.setAttribute("selectedSize", sizeIdStr);
           request.setAttribute("sizesInBill", sizeInBill);
                      request.setAttribute("billId", billId);
  request.setAttribute("indexPageback", request.getParameter("indexPageback"));//search roi quay ve dung trang 
        System.out.println(endPage);
       
        request.getRequestDispatcher("Bill_ImportDetail.jsp").forward(request, response);
    }
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

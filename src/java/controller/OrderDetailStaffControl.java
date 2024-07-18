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
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import model.Account;
import model.ImportBillDetailInfor;

import model.OrderDetailStaff;
import service.OrderDetailService;

/**
 *
 * @author HP
 */
@WebServlet(value = "/OrderDetailStaffControl")
public class OrderDetailStaffControl extends HttpServlet {

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
            response.setContentType("text/html;charset=UTF-8");
            String orderId = request.getParameter("orderIds");
            OrderDetailService dao = new OrderDetailService();
            List<OrderDetailStaff> count = dao.getOrderDetailByOrderIDCustomerForStaff(Integer.parseInt(orderId));
//        request.setAttribute("endPage", endPage);
            Set<String> colorInBill = new HashSet<>();
            Set<String> sizeInBill = new HashSet<>();
            for (OrderDetailStaff billDT : count) {
                colorInBill.add(billDT.getColor_name());
            }
            for (OrderDetailStaff billSZ : count) {
                sizeInBill.add(billSZ.getSize_name().toString()); // Sử dụng toString() để chuyển đổi ProductSizeType thành String
            }
            if (request.getParameter("search") != null && !request.getParameter("search").isEmpty()) {

                String nameProduct = request.getParameter("NameProduct");
                String priceFromStr = request.getParameter("priceFrom");
                String priceToStr = request.getParameter("priceTo");
                String orderDateFrom = request.getParameter("orderDateFrom");
                String orderDateTo = request.getParameter("orderDateTo");
                String size = request.getParameter("size");
                String color = request.getParameter("color");
                request.setAttribute("search", request.getParameter("search"));
                request.setAttribute("nameProduct", nameProduct);
                request.setAttribute("priceFrom", priceFromStr);
                request.setAttribute("priceTo", priceToStr);
                request.setAttribute("orderDateFrom", orderDateFrom);
                request.setAttribute("orderDateTo", orderDateTo);
                request.setAttribute("size", size);
                request.setAttribute("color", color);
                // Assuming your DAO method is called searchOrderDetailsStaff
                count = dao.searchOrderDetailsStaff(orderId,
                        nameProduct, priceFromStr, priceToStr, orderDateFrom, orderDateTo, size, color
                );
            }

            int orderPerPage = 4;
            int starCountList = (indexPage - 1) * orderPerPage;
            int endCountList = Math.min(starCountList + orderPerPage, count.size());
            System.out.println(starCountList + "   " + endCountList + "  " + count.size());
            List<OrderDetailStaff> count1 = count.subList(starCountList, endCountList);
            int endPage = (int) Math.ceil((double) count.size() / orderPerPage);
            request.setAttribute("lstof", count1);
            request.setAttribute("colorInBill", colorInBill);
            request.setAttribute("sizeInBill", sizeInBill);
            request.setAttribute("orderIds",orderId);
            request.setAttribute("indexPage", indexPage);
            request.setAttribute("endPage", endPage);
            request.getRequestDispatcher("/OrderDetailStaff.jsp").forward(request, response);

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

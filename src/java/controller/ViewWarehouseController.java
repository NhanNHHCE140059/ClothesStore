/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Warehouse;
import model.WarehouseProduct;
import service.WarehouseService;

/**
 *
 * @author Admin
 */
public class ViewWarehouseController extends HttpServlet {

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
            out.println("<title>Servlet ViewWarehouseController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewWarehouseController at " + request.getContextPath() + "</h1>");
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
        WarehouseService ws = new WarehouseService();
        int pageSize = 15; // number of products per page
        int pageIndex = 1; // default page index
        if (request.getParameter("page") != null) {
            pageIndex = Integer.parseInt(request.getParameter("page"));
        }
        int startIndex = (pageIndex - 1) * pageSize;
        int endIndex = startIndex + pageSize - 1;
        List<WarehouseProduct> list = ws.getAllWarehouse();
        request.setAttribute("listWarehouse", list);
        request.setAttribute("startIndex", startIndex);
        request.setAttribute("endIndex", endIndex);
        int endPage = (int) Math.ceil(list.size() / (double) pageSize);
        int maxPages = 5; // maximum number of pages to display
        int startPage = Math.max(1, pageIndex - (maxPages - 1) / 2);
        int endPageDisplay = Math.min(endPage, startPage + maxPages - 1);
        request.setAttribute("endPage", endPage);
        request.setAttribute("pageIndex", pageIndex);
        request.setAttribute("startPage", startPage);
        request.setAttribute("endPageDisplay", endPageDisplay);
        request.getRequestDispatcher("/view-warehouse.jsp").forward(request, response);
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

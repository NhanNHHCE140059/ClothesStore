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
import java.util.ArrayList;
import java.util.List;
import model.Product;
import model.WarehouseProduct;
import service.ProductService;
import service.WarehouseService;

/**
 *
 * @author Admin
 */
public class SearchProductWarehouse extends HttpServlet {

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
            out.println("<title>Servlet SearchProductWarehouse</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchProductWarehouse at " + request.getContextPath() + "</h1>");
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
        // request dispacher sang trang warehoust manage

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
        try {
            String content = request.getParameter("searchName");
            WarehouseService ws = new WarehouseService();
            
            int pageSize = 15; // Số sản phẩm trên mỗi trang
            int pageIndex = 1; // Trang mặc định là trang 1

            // Lấy trang từ tham số request
            if (request.getParameter("page") != null) {
                pageIndex = Integer.parseInt(request.getParameter("page"));
            }

            int startIndex = (pageIndex - 1) * pageSize;
            List<WarehouseProduct> list = ws.search(content);

            // Tính toán số trang và các tham số cho phân trang
            int endIndex = Math.min(startIndex + pageSize, list.size());
            int endPage = (int) Math.ceil(list.size() / (double) pageSize);

            request.setAttribute("listWarehouse", list.subList(startIndex, endIndex));
            request.setAttribute("startIndex", startIndex);
            request.setAttribute("endIndex", endIndex - 1); // endIndex - 1 vì subList không bao gồm endIndex
            request.setAttribute("endPage", endPage);
            request.setAttribute("pageIndex", pageIndex);

            request.getRequestDispatcher("view-warehouse.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); // In lỗi ra console để dễ dàng kiểm tra lỗi
        }
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

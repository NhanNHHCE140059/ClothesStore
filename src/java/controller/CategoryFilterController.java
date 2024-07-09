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
import model.Product;
import service.ProductService;

/**
 *
 * @author Admin
 */
@WebServlet(value = "/CategoryFilterController")
public class CategoryFilterController extends HttpServlet {

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
            out.println("<title>Servlet CategoryFilterController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CategoryFilterController at " + request.getContextPath() + "</h1>");
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
        int c1 = request.getParameter("c1") != null ? Integer.parseInt(request.getParameter("c1")) : 0;
        int c2 = request.getParameter("c2") != null ? Integer.parseInt(request.getParameter("c2")) : 0;

        ProductService ps = new ProductService();
        List<Product> filteredProducts = ps.filterCategory(c1, c2);

        int page = 1;
        int productsPerPage = 6;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        int start = (page - 1) * productsPerPage;
        int end = Math.min(start + productsPerPage, filteredProducts.size());

        List<Product> paginatedList = filteredProducts.subList(start, end);
        int noOfRecords = filteredProducts.size();
        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / productsPerPage);

        request.setAttribute("noOfPages", noOfPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("listP", paginatedList);
        request.setAttribute("c1", c1);
        request.setAttribute("c2", c2);
        request.getRequestDispatcher("/shop.jsp").forward(request, response);

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
        int c1 = request.getParameter("c1") != null ? Integer.parseInt(request.getParameter("c1")) : 0;
        int c2 = request.getParameter("c2") != null ? Integer.parseInt(request.getParameter("c2")) : 0;

        response.sendRedirect("CategoryFilterController?c1=" + c1 + "&c2=" + c2);
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

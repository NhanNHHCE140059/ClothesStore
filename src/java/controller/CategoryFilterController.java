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
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import model.Category;
import model.Product;
import service.CategoryService;
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
        CategoryService categoryService = new CategoryService();
        List<Category> categories = categoryService.getAllCategories();
        request.setAttribute("categories", categories);

        ProductService ps = new ProductService();
        String[] categoryIds = request.getParameterValues("cid");

        if (categoryIds == null || categoryIds.length == 0) {
            request.setAttribute("listP", Collections.emptyList());
            request.setAttribute("noOfPages", 0);
            request.setAttribute("currentPage", 1);
            request.setAttribute("cid", new int[0]);
            request.setAttribute("selectedCategories", Collections.emptyList());
            request.getRequestDispatcher("/shop.jsp").forward(request, response);
            return;
        }

        int[] cid = new int[categoryIds.length];
        for (int i = 0; i < categoryIds.length; i++) {
            cid[i] = Integer.parseInt(categoryIds[i]);
        }

        List<Product> filteredProducts = ps.filterCategory(cid[0], cid[1]);

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
        request.setAttribute("cid", cid);
        request.setAttribute("selectedCategories", Arrays.asList(categoryIds));

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
        CategoryService categoryService = new CategoryService();
        List<Category> categories = categoryService.getAllCategories();
        request.setAttribute("categories", categories);

        ProductService ps = new ProductService();
        String[] categoryIds = request.getParameterValues("cid");
        int[] cid = new int[categoryIds.length];
        if (categoryIds != null) {
            cid = new int[categoryIds.length];
            for (int i = 0; i < categoryIds.length; i++) {
                cid[i] = Integer.parseInt(categoryIds[i]);
            }
        } else {
            request.setAttribute("errorMessage", "No categories selected.");
            doGet(request, response); // Reuse doGet to show categories again
            return;
        }

        List<Product> filteredProducts = ps.filterCategory(cid[0], cid[1]);

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
        request.setAttribute("cid", cid); // Pass the selected category IDs back to the JSP

        request.getRequestDispatcher("/shop.jsp").forward(request, response);
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

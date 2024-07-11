/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import service.*;
import model.*;
import helper.*;
import java.util.*;

/**
 *
 * @author Huenh
 */
@WebServlet(value = "/main-manage-product")
public class MainManageProductController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        if (session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Account acc = (Account) session.getAttribute("account");
        if (acc.getRole() != Role.Customer) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        ProductService productService = new ProductService();
        int indexPage = 1;
        int productsPerPage = 5;
        List<Product> listAllProduct = productService.getAllProducts();
        String searchTxt = null;
        if (request.getParameter("searchTxt") != null && !request.getParameter("searchTxt").isEmpty()) {
            searchTxt = request.getParameter("searchTxt");
            listAllProduct = productService.searchByNameforStaff(searchTxt);
        }
        if (request.getParameter("page") != null && !request.getParameter("page").isEmpty()) {
            indexPage = Integer.parseInt(request.getParameter("page"));
        }
        int start = (indexPage - 1) * productsPerPage;
        int end = Math.min(start + productsPerPage, listAllProduct.size());

        List<Product> paginatedList = listAllProduct.subList(start, end);
        int noOfRecords = listAllProduct.size();
        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / productsPerPage);

        request.setAttribute("searchTxt", searchTxt);
        request.setAttribute("noOfPages", noOfPages);
        request.setAttribute("currentPage", indexPage);
        request.setAttribute("listP", paginatedList);
        request.getRequestDispatcher("main-manage-product.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        if (session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        Account acc = (Account) session.getAttribute("account");
        if (acc.getRole() != Role.Customer) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }
        if (req.getParameter("idPro") != null) {
            int idPro = Integer.parseInt(req.getParameter("idPro"));
            ProductService productService = new ProductService();
            Product product = productService.GetProById(idPro);
            req.setAttribute("product", product);

            if (req.getParameter("action") != null) {

                String action = req.getParameter("action");
                if (action.equals("hidden")) {
                    productService.hiddenProduct(idPro, 1);
                }
                if (action.equals("visible")) {
                    productService.hiddenProduct(idPro, 0);
                }
            }

            if (req.getParameter("page") != null) {
                String page = req.getParameter("page");
                req.setAttribute("currentPage", page);
            }
        }

        processRequest(req, resp);
    }
}

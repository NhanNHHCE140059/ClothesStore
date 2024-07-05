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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        if(session.getAttribute("account")==null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Account acc = (Account) session.getAttribute("account");
        if(acc.getRole() == Role.Customer ) {
                  response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        ProductService productService = new ProductService();
        int indexPage = 1;
        int productsPerPage = 5;
        List<Product> listAllProduct = productService.getAllProducts();
        if (request.getParameter("indexPage") != null) {
            indexPage = Integer.parseInt(request.getParameter("indexPage"));
        }
        int start = (indexPage - 1) * productsPerPage;
        int end = Math.min(start + productsPerPage, listAllProduct.size());

        List<Product> paginatedList = listAllProduct.subList(start, end);
        int noOfRecords = listAllProduct.size();
        int endPage = (int) Math.ceil(noOfRecords * 1.0 / productsPerPage);
        request.setAttribute("endPage", endPage);
        request.setAttribute("indexPage", indexPage);
        request.setAttribute("listP", paginatedList);
        request.getRequestDispatcher("main-manage-product.jsp").forward(request, response);
    }

}

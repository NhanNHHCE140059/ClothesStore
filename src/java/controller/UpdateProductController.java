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
import java.io.IOException;
import service.*;
import model.*;
import helper.*;
import java.util.*;

/**
 *
 * @author Huenh
 */
@WebServlet(value = "/update-product")
public class UpdateProductController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("idPro") != null) {
            int idPro = Integer.parseInt(request.getParameter("idPro"));
            ProductService productService = new ProductService();
            Product product = productService.GetProById(idPro);
            request.setAttribute("product", product);
        } else {
            response.sendRedirect(request.getContextPath() + ("/main-manage-product"));
            return;
        }
        request.getRequestDispatcher("update-product.jsp").forward(request, response);
    }

}

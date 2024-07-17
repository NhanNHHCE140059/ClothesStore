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
import model.*;
import service.*;
import java.util.*;

/**
 *
 * @author My Computer
 */
@WebServlet(value="/createBill")
public class Create_Import_Bill extends HttpServlet {
  

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        ProductVariantService prvSV = new ProductVariantService();
        List<ProductVariantInfo> listAll = prvSV.getAllVariantInfo();
        request.setAttribute("listAll",listAll);
        request.getRequestDispatcher("create_bill_and_import_bill.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
     
    }

}

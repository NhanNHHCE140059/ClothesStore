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
import model.ProductsVariant;
import service.ProductVariantService;
import service.WarehouseService;

/**
 *
 * @author My Computer
 */
@WebServlet(value = "/getQuantityBySizeAndColor")
public class getQuantityBySizeAndColor extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("pro_id"));
        String color = request.getParameter("color");
        String size = request.getParameter("size");
        ProductVariantService pvsv = new ProductVariantService();
        WarehouseService wssv = new WarehouseService();
        ProductsVariant proVa = pvsv.getPVbyColorAndSize(id, size, color);
        int quantity = (wssv.GetProByIdInWareHouse(proVa.getVariant_id())).getInventory_number();
        PrintWriter out = response.getWriter();
        if (quantity > 0) {
            out.println("<p style=\"padding-left: 50px; margin-top: 22px;\">"+quantity+" Product availability</p>");
        }
        out.flush();
    }

}

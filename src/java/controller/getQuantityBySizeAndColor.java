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
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Cart;
import model.ProductsVariant;
import service.CartService;
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
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        CartService cartService  = new CartService();       
        int id = Integer.parseInt(request.getParameter("pro_id"));
        String color = request.getParameter("color");
        String size = request.getParameter("size");
        ProductVariantService pvsv = new ProductVariantService();
        WarehouseService wssv = new WarehouseService();
        ProductsVariant proVa = pvsv.getPVbyColorAndSize(id, size, color);
        
        int quantity = (wssv.GetProByIdInWareHouse(proVa.getVariant_id())).getInventory_number();
        int quantityAvailable = 0;
        if (account!= null){
             for (Cart c : cartService.GetListCartByAccID(account.getAcc_id())){
            if (c.getVariant_id() == proVa.getVariant_id()){
                quantityAvailable = c.getPro_quantity();
            }
        }
        }
           
       
        PrintWriter out = response.getWriter();
        int newQuantity = quantity - quantityAvailable;
        if (account==null){
              out.println("<p style=\"padding-left: 50px; margin-top: 22px;\">"+quantity+" Product availability</p>");
        }else {
            out.println("<p style=\"padding-left: 50px; margin-top: 22px;\">"+newQuantity+" Product availability</p>");
        }
        out.flush();
    }

}

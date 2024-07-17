/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.ProductsVariant;
import service.ProductVariantService;

/**
 *
 * @author HP
 */
@WebServlet(value = "/CreateImportBill")

public class CreateImportBillController extends HttpServlet {
  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session.getAttribute("account")==null){
            response.sendRedirect(request.getContextPath()+"/login.jsp");
           
        }else{
            
        Account a = (Account) session.getAttribute("account");
        if(a.getRole()== helper.Role.Customer){
                        response.sendRedirect(request.getContextPath()+"/index.jsp");

        }else{
            ProductVariantService prvsv = new ProductVariantService();
            List<ProductsVariant> prv = prvsv.getAllProductsVra();
            request.setAttribute("prvlst", prv);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Create_Import_Bill.jsp");
            dispatcher.forward(request, response);
            
        }}
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

    }


}

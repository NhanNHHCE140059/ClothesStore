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
import model.*;
import service.*;
import helper.*;
import java.util.*;

/**
 *
 * @author My Computer
 */
@WebServlet(value = "/statistic")
public class StaticController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountService accountSV = new AccountService();
        ProductService productSV = new ProductService();
        OrderService orderSV = new OrderService();
        //getAll
        List<Account> lisstAllAccount = accountSV.getAllAccounts(null);
        request.setAttribute("listAllAccount", lisstAllAccount);
        request.setAttribute("totalAccount", lisstAllAccount.size());
        //getActive
        List<Account> listAccActive = accountSV.getAllAccounts(0);
        request.setAttribute("ListAcctive", listAccActive);
        request.setAttribute("totalAcctive", listAccActive.size());
        //Get Deactive
        List<Account> listAccDeactive = accountSV.getAllAccounts(1);
        request.setAttribute("ListDeacctive", listAccDeactive);
        request.setAttribute("totalDeacctive", listAccDeactive.size());
        //Get All Product
        List<Product> listAllProduct = productSV.getAllProducts();
        request.setAttribute("ListAllProduct", listAllProduct);
        request.setAttribute("totalProduct", listAllProduct.size());
        //Get All Order 
        List<Order> listAllOrder = orderSV.getAllOrders();
        request.setAttribute("listAllOrder", listAllOrder);
        request.setAttribute("totalOrder", listAllOrder.size());
        //Get tien lai hom nay 
        double dailyEarn = orderSV.calculateTodayProfit();
        request.setAttribute("daiLyErn", dailyEarn);
        //get  double[12] for month   
        double[] revenueMonth = orderSV.getMonthlyRevenue();
        request.setAttribute("revenueMonth", revenueMonth);
        //get top 10 Customer 
        List<StaticAccountPaid> listAccountPaid = accountSV.getTop10AccountPaid();
        request.setAttribute("listAccountPaid", listAccountPaid);
        //getTop 20 provariant
        List<TopProduct> top20Product = orderSV.getTop20Products();
        request.setAttribute("top20Product", top20Product);
        //get top 10 Bill
        List<StaticTopBillValue> listBillTopValue = orderSV.getTop10OrdersByValue();
        request.setAttribute("listBillTopValue", listBillTopValue);
        request.getRequestDispatcher("statistic.jsp").forward(request, response);

    }

}

package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;
import model.*;
import service.*;
import helper.*;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Huenh
 */
@WebServlet(value = "/checkout")
public class CheckoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        CartService cartSV = new CartService();
        Account account = (Account) session.getAttribute("account");
        double totalPrice = 0;
        for (Cart cart : cartSV.GetListCartByAccID(account.getAcc_id())) {
            totalPrice += cart.getTotal_price();
        }
        request.setAttribute("success", request.getParameter("status"));
        request.setAttribute("totalPrice", totalPrice);
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        OrderService odSV = new OrderService();
        String billingName = request.getParameter("billingName");
        String billingEmail = request.getParameter("billingEmail");
        String billingPhone = request.getParameter("billingPhone");
        String billingAddress = request.getParameter("billingAddress");
        boolean shipToDifferentAddress = request.getParameter("shipto") != null;
        System.out.println("Khong co tick");
        System.out.println(billingName);
        System.out.println(billingEmail);
        System.out.println(billingPhone);
        System.out.println(billingAddress);
        String shippingName = billingName;
        String shippingPhone = billingPhone;
        String shippingAddress = billingAddress;

        if (shipToDifferentAddress) {
            String shipName = request.getParameter("shipName");
            String shipPhone = request.getParameter("shipPhone");
            String shipAddress = request.getParameter("shipAddress");
            String shipCity = request.getParameter("shipCity");
            String shipDistrict = request.getParameter("shipDistrict");
            String shipWard = request.getParameter("shipWard");

            shippingName = shipName;
            shippingPhone = shipPhone;
            shippingAddress = shipAddress + ", " + shipWard + ", " + shipDistrict + ", " + shipCity;
            System.out.println("Co tick");
            System.out.println(shippingAddress);
            System.out.println(shippingPhone);
            System.out.println(shipName);

        }
        odSV.placeOrder(account, shippingAddress, shippingPhone);
        response.sendRedirect("checkout?status=success");
    }

}

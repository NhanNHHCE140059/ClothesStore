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
        if (request.getParameter("buyNow") != null && !request.getParameter("buyNow").isEmpty()) {
            ProductVariantService pVservice = new ProductVariantService();
            ProductService pService = new ProductService();
            WarehouseService wservice = new WarehouseService();
            String color = request.getParameter("color");
            String size = request.getParameter("size");
            String pro_id = request.getParameter("pro_id");
            String quantityString = request.getParameter("quantity");
            int proID = -1;
            int quantity = -1;
            try {
                proID = Integer.parseInt(pro_id);
                quantity = Integer.parseInt(quantityString);
            } catch (NumberFormatException e) {
                response.sendRedirect("detail?error=1&pid=" + proID);
                //// loi khong the chuyen doi quantity va id 
                return;
            }
            if (quantity <= 0) {
                response.sendRedirect("detail?error=7&pid=" + proID);
                return;
            }
            ProductsVariant productVariant = pVservice.getPVbyColorAndSize(proID, size, color);
            if (productVariant == null) {
                response.sendRedirect("detail?error=2&pid=" + proID);
                /// loi khong tim thay product Variant ( it xay ra )
                return;
            }
            if ((wservice.GetProByIdInWareHouse(productVariant.getVariant_id())).getInventory_number() < quantity) {
                System.out.println(productVariant.getVariant_id());
                System.out.println(wservice.countTotalProductInWareHouseByID(productVariant.getVariant_id()));
                System.out.println(quantity);
                response.sendRedirect("detail?error=3&pid=" + proID);
                //// So luong san pham trong Warehouse khong du
                return;
            }
            request.setAttribute("unitP", pService.GetProById(productVariant.getPro_id()).getPro_price());
            request.setAttribute("pvID", productVariant.getVariant_id());
            request.setAttribute("quantity", quantity);
            request.setAttribute("buyNow", request.getParameter("buyNow"));
        }

        request.setAttribute("success", request.getParameter("status"));
        request.setAttribute("totalPrice", totalPrice);
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        CartService cart = new CartService();
        if (cart.GetListCartByAccID(account.getAcc_id()).size() == 0) {
            response.sendRedirect("checkout?error=1");
            return;
        }
        if (cart.getAvailableCartItemsByAccID(account.getAcc_id()).size() <= 0) {
            response.sendRedirect("checkout?error=2");
            return;
        }
        double totalP = 0;
        for (Cart c : cart.GetListCartByAccID(account.getAcc_id())) {
            totalP += c.getTotal_price();
        }

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
        if (request.getParameter("buyNow") != null && !request.getParameter("buyNow").isEmpty()) {
            ProductService pService = new ProductService();
            ProductVariantService pVservice = new ProductVariantService();
            String quantityString = request.getParameter("quantity");
            String pvIDString = request.getParameter("pvID");
            odSV.placeOrderNow(account, Integer.parseInt(pvIDString), Integer.parseInt(quantityString), shippingAddress, shippingPhone);
            totalP = pService.GetProById(pVservice.getVariantByID(Integer.parseInt(pvIDString)).getPro_id()).getPro_price() * Integer.parseInt(quantityString);
            response.sendRedirect("checkout?price=" + totalP);
            return;
        }
        odSV.placeOrder(account, shippingAddress, shippingPhone);
        response.sendRedirect("checkout?price=" + totalP);
        return;
    }

}

package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import model.Account;
import model.Cart;
import model.Product;
import service.CartService;
import service.ProductService;
import service.WarehouseService;

/**
 *
 * @author Nguyen Thanh Thien - CE171253
 */
@WebServlet(value = "/cart")
public class CartController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CartController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");
        ProductService pservice = new ProductService();
        CartService cservice = new CartService();
        WarehouseService wservice = new WarehouseService();
        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/login"); //chuyen den trang login va bat nguoi dung login lai
        } else {
            String message = null;
            String messageloi = null;
            if (request.getParameter("action") != null) {
                String action = request.getParameter("action");
                switch (action) {

                    case "addToCart":
                        break;

                    case "decQuan":
                        LinkedList<Cart> cart = cservice.GetListCartByAccID(acc.getAcc_id());
                        int pro_id = Integer.parseInt(request.getParameter("pro_id"));
                        Product p = pservice.GetProById(pro_id);
                        for (Cart c : cart) {
                            if (pro_id == c.getPro_id()) {
                                int newquantity = c.getPro_quantity();
                                newquantity--;
                                if (newquantity <= 0) {
                                    messageloi = "Product quantity cannot be reduced to 0 or less than 1";
                                    break;
                                } else {
                                    int UpdateQuan = cservice.UpdateQuan(newquantity, c.getPro_price() * newquantity, c.getCart_id(), c.getPro_id());
                                    if (UpdateQuan == 0) {
                                        message = "Error";
                                        break;
                                    } else if (UpdateQuan == -1) {
                                        message = "Exceeded quantity";
                                        break;
                                    } else {
                                        message = "Reduce the number of successful products";
                                    }
                                }
                            }
                        }
                        break;

                    case "incQuan":
                        cart = cservice.GetListCartByAccID(acc.getAcc_id());
                        pro_id = Integer.parseInt(request.getParameter("pro_id"));
                        p = pservice.GetProById(pro_id);
                        for (Cart c : cart) {
                            if (pro_id == c.getPro_id()) {
                                int newquantity = c.getPro_quantity();
                                newquantity++;
                                if (wservice.GetProByIdInWareHouse(pro_id).getInventory_number() == 0) {
                                    messageloi = "Too much quantity";
                                    break;
                                }
                                if (wservice.GetProByIdInWareHouse(pro_id).getInventory_number() > 0) {
                                    int UpdateQuan = cservice.UpdateQuan(newquantity, c.getPro_price() * newquantity, c.getCart_id(), c.getPro_id());
                                    if (UpdateQuan == 0) {
                                        message = "Error";
                                        break;
                                    }
                                    if (UpdateQuan == -1) {
                                        message = "Exceeded quantity";
                                        break;
                                    } else {
                                        message = "Increase the number of successful products";
                                    }
                                }
                            }
                        }
                        break;

                    case "deletePro":
                        cart = cservice.GetListCartByAccID(acc.getAcc_id());
                        int cart_id = Integer.parseInt(request.getParameter("card_id"));
                        for (Cart c : cart) {
                            if (cart_id == c.getCart_id()) {
                                int deleteNum = cservice.DeleteCart(c.getCart_id());
                                break;
                            }
                        }
                }

            }
            int indexpage;
            if (request.getParameter("indexpage") != null) {
                indexpage = Integer.parseInt(request.getParameter("indexpage"));
            } else {
                indexpage = 1;
            }
            int count = cservice.CountPageCart(acc.getAcc_id());
            int size = 5;
            int endpage = count / size;
            if (count % size != 0) {
                endpage++;
            }
            LinkedList<Cart> cart_list = cservice.GetTop5CartByAccID(acc.getAcc_id(), indexpage);
            request.setAttribute("cart_list", cart_list);
            request.setAttribute("message", message);
            request.setAttribute("messageloi", messageloi);
            request.setAttribute("indexpage", indexpage);
            LinkedList<Map<Cart, Product>> cp_list = new LinkedList<>();
            for (Cart c : cart_list) {
                // Tạo một HashMap mới cho mỗi vòng lặp
                Map<Cart, Product> hashmap = new HashMap<>();
                hashmap.put(c, pservice.GetProById(c.getPro_id()));
                cp_list.add(hashmap);
            }

            int quantitypro = 0;
            for (Cart c : cservice.GetListCartByAccID(acc.getAcc_id())) {
                quantitypro++;
            }
            session.setAttribute("quantitypro", quantitypro);
            request.setAttribute("cp_list", cp_list);
            request.setAttribute("endpage", endpage);
            RequestDispatcher dispatcher = request.getRequestDispatcher("cart.jsp");
            dispatcher.forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}

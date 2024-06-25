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

            if (session.getAttribute("message") != null) {
                message = (String) session.getAttribute("message");
            }

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
                                    message = "Product quantity cannot be reduced less than 1!!!";
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
                                        message = "Reduce the number of successful products ✔";
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
                                    message = "The number of products in the Warehouse is no longer available!!";
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
                                        message = "Increase the number of successful products ✔";
                                    }
                                }
                            }
                        }
                        break;

                    case "quantityCustom":
                        cart = cservice.GetListCartByAccID(acc.getAcc_id());
                        pro_id = Integer.parseInt(request.getParameter("pro_id"));
                        p = pservice.GetProById(pro_id);
                        if (request.getParameter("quantity") == null) {
                            message = "Product quantity cannot be left blank ✘";
                            break;
                        } else {
                            int quantity = Integer.parseInt(request.getParameter("quantity"));
                            if (quantity <= 0) {
                                message = "Update product quantity failed ☺ <br> Default product quantity is 1";
                                break;
                            }
                            for (Cart c : cart) {
                                if (pro_id == c.getPro_id()) {
                                    int newquantity = quantity - c.getPro_quantity();
                                    if (newquantity < 0) {
                                        int UpdateQuan = cservice.UpdateQuan(quantity, c.getPro_price() * quantity, c.getCart_id(), c.getPro_id());
                                        message = "Reduce the number of successful products ✔";
                                        break;
                                    } else {
                                        if (newquantity > wservice.GetProByIdInWareHouse(pro_id).getInventory_number()) {
                                            message = "The quantity of the product you want to buy is currently insufficient ☺<br> Number of products in Warehouse: " + wservice.GetProByIdInWareHouse(pro_id).getInventory_number();
                                            break;
                                        } else {
                                            int UpdateQuan = cservice.UpdateQuan(quantity, c.getPro_price() * quantity, c.getCart_id(), c.getPro_id());
                                            message = "Increase the number of successful products ✔";
                                            break;
                                        }
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
            session.setAttribute("message", message);
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

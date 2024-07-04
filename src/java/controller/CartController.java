package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import model.Account;
import model.Cart;
import model.CartInfo;
import service.CartService;
import service.ProductVariantService;
import service.WarehouseService;

@WebServlet(value = "/cart")
public class CartController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");
        CartService cartService = new CartService();

        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        String message = null;
        int indexPage = 1;
        int proV_id = -1;

        if (request.getParameter("indexPage") != null) {
            try {
                indexPage = Integer.parseInt(request.getParameter("indexPage"));
            } catch (NumberFormatException e) {
                indexPage = 1;
            }
        }

        if (request.getParameter("proV_id") != null) {
            try {
                proV_id = Integer.parseInt(request.getParameter("proV_id"));
            } catch (NumberFormatException e) {
                System.out.println("WTFFFFF");
            }
        }

        if (action != null) {
            ProductVariantService pVservice = new ProductVariantService();
            WarehouseService wservice = new WarehouseService();
            List<Cart> list_cart = cartService.GetListCartByAccID(acc.getAcc_id());

            switch (action) {
                case "addToCart":

                case "decQuan":
                    for (Cart c : list_cart) {
                        if (c.getVariant_id() == proV_id) {
                            int newquantity = c.getPro_quantity() - 1;
                            if (newquantity <= 0) {
                                message = "Product quantity cannot be reduced less than 1!!!";
                            } else {
                                int updateQuan = cartService.UpdateQuan(newquantity, c.getPro_price() * newquantity, c.getCart_id(), c.getVariant_id());
                                if (updateQuan == 0) {
                                    message = "Error";
                                } else if (updateQuan == -1) {
                                    message = "Exceeded quantity";
                                } else {
                                    message = "Reduce the number of successful products ✔";
                                }
                            }
                            break;
                        }
                    }
                    break;
                case "incQuan":
                    for (Cart c : list_cart) {
                        if (c.getVariant_id() == proV_id) {
                            int newquantity = c.getPro_quantity() + 1;
                            if (wservice.GetProByIdInWareHouse(proV_id).getInventory_number() == 0) {
                                message = "The number of products in the Warehouse is no longer available!!";
                            } else if (wservice.GetProByIdInWareHouse(proV_id).getInventory_number() > 0) {
                                int updateQuan = cartService.UpdateQuan(newquantity, c.getPro_price() * newquantity, c.getCart_id(), c.getVariant_id());
                                if (updateQuan == 0) {
                                    message = "Error";
                                } else if (updateQuan == -1) {
                                    message = "Exceeded quantity";
                                } else {
                                    message = "Increase the number of successful products ✔";
                                }
                            }
                            break;
                        }
                    }
                    break;
                case "delete":
                    int cart_id = Integer.parseInt(request.getParameter("cart_id"));
                    for (Cart c : list_cart) {
                        if (cart_id == c.getCart_id()) {
                            int deleteNum = cartService.DeleteCart(c.getCart_id());
                            message = "Remove the products successful ✔"; /// Thong bao cho remove
                            break;
                        }
                    }
                    break;
                case "quantityCustom":
                    if (request.getParameter("quantityC").length() > 8) {
                        message = "Quantity input to long please re-enter!";
                        break;
                    }
                    int quantityC = Integer.parseInt(request.getParameter("quantityC"));
                    if (quantityC <= 0) {
                        message = "Quantity must be greater than 0.";
                        break;
                    }
                    for (Cart c : list_cart) {
                        if (c.getVariant_id() == proV_id) {
                            if (quantityC == c.getPro_quantity()) {
                                break;
                            }
                            if (quantityC < c.getPro_quantity()) {
                                int updateQuan = cartService.UpdateQuan(quantityC, c.getPro_price() * quantityC, c.getCart_id(), c.getVariant_id());
                                if (updateQuan == 0) {
                                    message = "Error";
                                    break;
                                } else if (updateQuan == -1) {
                                    message = "Exceeded quantity";
                                    break;
                                } else {
                                    message = "Reduce the number of successful products ✔";
                                    break;
                                }

                            } else {
                                if (wservice.GetProByIdInWareHouse(proV_id).getInventory_number() > 0 && quantityC <= wservice.GetProByIdInWareHouse(proV_id).getInventory_number()) {
                                    int updateQuan = cartService.UpdateQuan(quantityC, c.getPro_price() * quantityC, c.getCart_id(), c.getVariant_id());
                                    if (updateQuan == 0) {
                                        message = "Error";
                                        break;
                                    } else if (updateQuan == -1) {
                                        message = "Exceeded quantity";
                                        break;
                                    } else {
                                        message = "Increase the number of successful products ✔";
                                        break;
                                    }
                                } else {
                                    message = "The number of products in the Warehouse is no longer available!!";
                                    break;
                                }
                            }
                        }
                    }
                    break;
            }
            session.setAttribute("message", message);
        }

        int count = cartService.CountPageCart(acc.getAcc_id());
        int size = 5;
        int endpage = count / size;
        if (count % size != 0) {
            endpage++;
        }

        LinkedList<Cart> carttop5 = cartService.GetTop5CartByAccID(acc.getAcc_id(), indexPage);
        if (carttop5.size() == 0 && indexPage != 1) {
            response.sendRedirect(request.getContextPath() + "/cart?indexPage=" + (indexPage - 1));
            return;
        }
        double totalPrice = 0;
        int quantityProduct = 0;
        int quantityCart = 0;
        for (Cart c : cartService.GetListCartByAccID(acc.getAcc_id())) {
            totalPrice += c.getTotal_price();
            quantityProduct += c.getPro_quantity();
            ++quantityCart;
        }
        request.setAttribute("quantityProduct", quantityProduct);
        request.setAttribute("quantityCart", quantityCart);
        request.setAttribute("totalPrice", totalPrice);
        request.setAttribute("carttop5", carttop5);
        request.setAttribute("endpage", endpage);
        request.setAttribute("indexPage", indexPage);
        RequestDispatcher dispatcher = request.getRequestDispatcher("cart.jsp");
        dispatcher.forward(request, response);
    }
}

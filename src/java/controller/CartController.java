package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.CartInfo;
import java.util.LinkedList;
import java.util.List;
import model.Account;
import model.Cart;
import model.Product;
import model.ProductsVariant;
import service.CartService;
import service.ProductService;
import service.ProductVariantService;
import service.WarehouseService;

@WebServlet(value = "/cart")
public class CartController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");
        ProductService pservice = new ProductService();
        CartService cservice = new CartService();
        WarehouseService wservice = new WarehouseService();
        if (acc == null) {
            response.sendRedirect("login"); //chuyen den trang login va bat nguoi dung login lai
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
            }
        }

        if (action != null) {
            ProductVariantService pVservice = new ProductVariantService();
            List<Cart> list_cart = cservice.GetListCartByAccID(acc.getAcc_id());
            switch (action) {
                case "addToCart":
                    if (request.getParameter("size") != null && request.getParameter("color") != null) {
                        int noti = -1;
                        int proID = -1;
                        int quantity = -1;
                        String color = request.getParameter("color");
                        String size = request.getParameter("size");
                        String pro_id = request.getParameter("pro_id");
                        String quantityString = request.getParameter("quantity");
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
                        Product product = pservice.GetProById(productVariant.getPro_id());

                        if ((wservice.GetProByIdInWareHouse(productVariant.getVariant_id())).getInventory_number() < quantity) {
                            System.out.println(productVariant.getVariant_id());
                            System.out.println(wservice.countTotalProductInWareHouseByID(productVariant.getVariant_id()));
                            System.out.println(quantity);
                            response.sendRedirect("detail?error=3&pid=" + proID);
                            //// So luong san pham trong Warehouse khong du
                            return;
                        } else {
                            boolean isHave = false;
                            for (Cart c : list_cart) {
                                if (c.getVariant_id() == productVariant.getVariant_id()) {
                                    int provisinal = (wservice.GetProByIdInWareHouse(productVariant.getVariant_id())).getInventory_number() - c.getPro_quantity();
                                    if (quantity > provisinal) {
                                        response.sendRedirect("detail?error=6&pid=" + proID);
                                        return;
                                    }
                                    isHave = true;
                                    int newQuantity = quantity + c.getPro_quantity();
                                    noti = cservice.UpdateQuan(newQuantity, (double) newQuantity * c.getPro_price(), c.getCart_id(), productVariant.getVariant_id());

                                    if (noti != 1) {
                                        response.sendRedirect("detail?error=4&pid=" + proID);
                                        return;
                                    }
                                    response.sendRedirect("detail?succes=" + productVariant.getVariant_id() + "&pid=" + proID + "&size=" + size+ "&color=" +color);
                                    return;

                                }
                            }
                            if (!isHave) {
                                if ((wservice.GetProByIdInWareHouse(productVariant.getVariant_id())).getInventory_number() < quantity) {
                                    response.sendRedirect("detail?error=3&pid=" + proID);
                                    return;
                                }
                                noti = cservice.AddCart(acc.getAcc_id(), productVariant.getVariant_id(), quantity, product.getPro_price(), (double) product.getPro_price() * quantity);

                                if (noti != 1) {
                                    response.sendRedirect("detail?error=4&pid=" + proID);
                                    return;
                                }
                                response.sendRedirect("detail?succes=" + productVariant.getVariant_id() + "&pid=" + proID +"&size=" + size+ "&color=" +color);
                                return;
                            }
                        }
                        response.sendRedirect("detail?pid=" + proID);
                        return;
                    } else {
                        response.sendRedirect("home?error=5");
                        return;
                    }

                case "decQuan":
                    for (Cart c : list_cart) {
                        if (c.getVariant_id() == proV_id) {
                            int newquantity = c.getPro_quantity() - 1;
                            if (newquantity <= 0) {
                                message = "Product quantity cannot be reduced less than 1!!!";
                            } else {
                                int updateQuan = cservice.UpdateQuan(newquantity, c.getPro_price() * newquantity, c.getCart_id(), c.getVariant_id());
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
                                message = "The number of products in the Warehouse is no longer available!!!";
                            } else if (wservice.GetProByIdInWareHouse(proV_id).getInventory_number() > 0) {
                                if (newquantity > wservice.GetProByIdInWareHouse(proV_id).getInventory_number()) {
                                    message = "Not enough quantity<br>Available: "+ wservice.GetProByIdInWareHouse(proV_id).getInventory_number();
                                    break;
                                }
                                int updateQuan = cservice.UpdateQuan(newquantity, c.getPro_price() * newquantity, c.getCart_id(), c.getVariant_id());
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
                            int deleteNum = cservice.DeleteCart(c.getCart_id());
                            message = "Remove the products successful ✔"; /// Thong bao cho remove
                            break;
                        }
                    }
                    break;
                case "quantityCustom":
                    if (request.getParameter("quantityC").isEmpty()) {
                        message = "Product quantity cannot be left blank ✘";
                        break;
                    }
                    if (request.getParameter("quantityC").length() > 8) {
                        message = "Quantity input to long please re-enter!!!";
                        break;
                    }
                    int quantityC = Integer.parseInt(request.getParameter("quantityC"));
                    if (quantityC <= 0) {
                        message = "Please enter more than 0";
                        break;
                    }
                    for (Cart c : list_cart) {
                        if (c.getVariant_id() == proV_id) {
                            if (quantityC == c.getPro_quantity()) {
                                break;
                            }
                            if (quantityC < c.getPro_quantity()) {
                                int updateQuan = cservice.UpdateQuan(quantityC, c.getPro_price() * quantityC, c.getCart_id(), c.getVariant_id());
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
                                    int updateQuan = cservice.UpdateQuan(quantityC, c.getPro_price() * quantityC, c.getCart_id(), c.getVariant_id());
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
                                    message = "Not enough quantity<br>Available: " + wservice.GetProByIdInWareHouse(proV_id).getInventory_number();
                                    break;
                                }
                            }
                        }
                    }
                    break;
            }
            session.setAttribute("message", message);
        }

        int count = cservice.CountPageCart(acc.getAcc_id());
        int size = 5;
        int endpage = count / size;
        if (count % size != 0) {
            endpage++;
        }

        LinkedList<CartInfo> carttop5 = cservice.GetTop5CartByAccID(acc.getAcc_id(), indexPage);
        if (carttop5.isEmpty() && indexPage != 1) {
            response.sendRedirect(request.getContextPath() + "/cart?indexPage=" + (indexPage - 1));
            return;
        }
        double totalPrice = 0;
        int quantityProduct = 0;
        int quantityCart = 0;
        for (Cart c : cservice.GetListCartByAccID(acc.getAcc_id())) {
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
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getParameter("action") != null) {
            HttpSession session = request.getSession();
            String action = request.getParameter("action");
            String message = null;
            int pro_Vid = -1;
            CartService cservice = new CartService();
            WarehouseService wservice = new WarehouseService();
            if (session.getAttribute("account") == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            int indexpage = 1;
            if (request.getParameter("print") != null) {
                indexpage = Integer.parseInt(request.getParameter("indexpage"));
            }

            Account acc = (Account) session.getAttribute("account");
            List<Cart> list_cart = cservice.GetListCartByAccID(acc.getAcc_id());
            if (request.getParameter("pro_Vid") != null) {
                pro_Vid = Integer.parseInt(request.getParameter("pro_Vid"));
                pro_Vid = pro_Vid - 1;
            }
            switch (action) {
                case "decQuan":
                    for (Cart c : list_cart) {
                        if (c.getVariant_id() == pro_Vid) {
                            int newquantity = c.getPro_quantity();
                            newquantity--;
                            if (newquantity <= 0) {
                                message = "Product quantity cannot be reduced less than 1!!!";
                                break;
                            } else {
                                int UpdateQuan = cservice.UpdateQuan(newquantity, c.getPro_price() * newquantity, c.getCart_id(), c.getVariant_id());
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
                    for (Cart c : list_cart) {
                        if (c.getVariant_id() == pro_Vid) {
                            int newquantity = c.getPro_quantity();
                            newquantity++;
                            if (wservice.GetProByIdInWareHouse(pro_Vid).getInventory_number() == 0) {
                                message = "The number of products in the Warehouse is no longer available!!";
                                break;
                            }
                            if (wservice.GetProByIdInWareHouse(pro_Vid).getInventory_number() > 0) {
                                int UpdateQuan = cservice.UpdateQuan(newquantity, c.getPro_price() * newquantity, c.getCart_id(), c.getVariant_id());
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
                case "delete":
                    int cart_id = Integer.parseInt(request.getParameter("cart_id"));
                    for (Cart c : list_cart) {
                        if (cart_id == c.getCart_id()) {
                            int deleteNum = cservice.DeleteCart(c.getCart_id());
                            break;
                        }
                    }
                    break;

                case "addToCart":
//                    int color_id = Integer.parseInt(request.getParameter("color_id"));
//                    String size_name = request.getParameter("size_name");
//                    int pro_id = Integer.parseInt(request.getParameter("pro_id"));
//                    pro_Vid = pVservice.getProductByColorAndSize(size_name, color_id, pro_id).getVariant_id();
//                    break;
                case "quantityCustom":
                    int quantityC = Integer.parseInt(request.getParameter("quantityC"));
                    System.out.println(quantityC);
                    response.sendRedirect(request.getContextPath() + "/home");
                    return;
//                    cart = cservice.GetListCartByAccID(acc.getAcc_id());
//                    pro_id = Integer.parseInt(request.getParameter("pro_id"));
//                    p = pservice.GetProById(pro_id);
//                    if (request.getParameter("quantity") == null) {
//                        message = "Product quantity cannot be left blank ✘";
//                        break;
//                    } else {
//                        if (request.getParameter("quantity").length() > 9) {
//                            break;
//                        }
//                        int quantity = Integer.parseInt(request.getParameter("quantity"));
//                        if (quantity <= 0) {
//                            message = "Update product quantity failed ☺ <br> Default product quantity is 1";
//                            break;
//                        }
//                        for (Cart c : cart) {
//                            if (pro_id == c.getPro_id()) {
//                                int newquantity = quantity - c.getPro_quantity();
//                                if (newquantity < 0) {
//                                    int UpdateQuan = cservice.UpdateQuan(quantity, c.getPro_price() * quantity, c.getCart_id(), c.getPro_id());
//                                    message = "Reduce the number of successful products ✔";
//                                    break;
//                                } else {
//                                    if (newquantity > wservice.GetProByIdInWareHouse(pro_id).getInventory_number()) {
//                                        message = "The quantity of the product you want to buy is currently insufficient ☺<br> Number of products in Warehouse: " + wservice.GetProByIdInWareHouse(pro_id).getInventory_number();
//                                        break;
//                                    } else {
//                                        int UpdateQuan = cservice.UpdateQuan(quantity, c.getPro_price() * quantity, c.getCart_id(), c.getPro_id());
//                                        message = "Increase the number of successful products ✔";
//                                        break;
//                                    }
//                                }
//
//                            }
//                        }
//                    }
//
//                    break;
            }
            session.setAttribute("message", message);
            response.sendRedirect(request.getContextPath() + "/cart?indexpage=" + indexpage);
            return;
        }
    }
}

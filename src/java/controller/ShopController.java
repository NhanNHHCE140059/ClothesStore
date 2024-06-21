package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Product;
import service.ProductService;

/**
 *
 * @author Huenh
 */
@WebServlet(value = "/shop")
public class ShopController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ProductService p = new ProductService();
        List<Product> list = p.getAllProducts();
        req.setAttribute("listP", list);
        req.getRequestDispatcher("shop.jsp").forward(req, resp);
    }
    
}

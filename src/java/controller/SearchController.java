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
@WebServlet(value = "/search")
public class SearchController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8"); //Search by Vietnamese
        String txtSearch = req.getParameter("txt");
        ProductService p = new ProductService();
        List<Product> list = p.searchByName(txtSearch);

        if (list.size() <= 0) {
            req.getRequestDispatcher("shop-search-error.jsp").forward(req, resp);
        }
        
        req.setAttribute("listP", list);
        req.setAttribute("txtS", txtSearch);
        req.getRequestDispatcher("shop.jsp").forward(req, resp);
    }
}

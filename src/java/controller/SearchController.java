package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Category;
import model.Product;
import service.CategoryService;
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
        String txtSearch = req.getParameter("txt").trim();
        ProductService p = new ProductService();
        CategoryService cateSV = new CategoryService();
        List<Category> listAllCate = cateSV.getAllCate();
        List<Product> list = p.searchByName(txtSearch);
        if (txtSearch.trim().isEmpty()) {
            resp.sendRedirect("shop");
            return;
        }
        if (list.size() <= 0) {
            List<Product> top3Sell = p.getTop3BestSellingProducts();
            req.setAttribute("top3Sell", top3Sell);
            System.out.println("Search not found");
            req.setAttribute("listAllCate", listAllCate);
            req.setAttribute("listP", list);
            req.getRequestDispatcher("shop.jsp").forward(req, resp);
        } else {
            List<Product> top3Sell = p.getTop3BestSellingProducts();
            req.setAttribute("top3Sell", top3Sell);
            req.setAttribute("listP", list);
            req.setAttribute("txtS", txtSearch);
            req.setAttribute("listAllCate", listAllCate);
            req.getRequestDispatcher("shop.jsp").forward(req, resp);
        }
    }
}

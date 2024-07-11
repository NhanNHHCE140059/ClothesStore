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
@WebServlet(value = "/shop")
public class ShopController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ProductService p = new ProductService();
        CategoryService c = new CategoryService();
        List<Product> list = p.getAllProducts();
        List<Category> categories = c.getAllCategories();  // Lấy danh sách các danh mục

        int page = 1;
        int productsPerPage = 6;

        if (req.getParameter("page") != null) {
            page = Integer.parseInt(req.getParameter("page"));
        }
        if (req.getParameter("success") != null) {
            Product pro = p.GetProById(Integer.parseInt(req.getParameter("pro_id")));
            req.setAttribute("successP", pro);
        }

        int start = (page - 1) * productsPerPage;
        int end = Math.min(start + productsPerPage, list.size());

        List<Product> paginatedList = list.subList(start, end);
        int noOfRecords = list.size();
        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / productsPerPage); //ceil => làm tròn lên

        req.setAttribute("noOfPages", noOfPages);
        req.setAttribute("currentPage", page);
        req.setAttribute("listP", paginatedList);
        req.setAttribute("categories", categories); // Truyền danh sách các danh mục đến JSP

        req.getRequestDispatcher("shop.jsp").forward(req, resp);
    }

}

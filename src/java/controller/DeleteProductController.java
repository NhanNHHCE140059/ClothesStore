package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Category;
import model.Product;
import model.ProductColor;
import model.ProductsVariant;
import model.Warehouse;
import service.CategoryService;
import service.ProductColorService;
import service.ProductService;
import service.WarehouseService;

/**
 *
 * @author Huenh
 */
@WebServlet(value = "/delete-product")
public class DeleteProductController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("idPro") != null) {
            int idPro = Integer.parseInt(request.getParameter("idPro"));
            ProductService productService = new ProductService();
            Product product = productService.GetProById(idPro);
            request.setAttribute("product", product);
            if (request.getParameter("action") != null) {
                String action = request.getParameter("action");
                if (action.equals("hidden")) {
                    productService.hiddenProduct(idPro,1);
                    response.sendRedirect(request.getContextPath() + ("/main-manage-product"));
                    return;
                }
                if (action.equals("visible")) {
                    productService.hiddenProduct(idPro,0);
                    response.sendRedirect(request.getContextPath() + ("/main-manage-product"));
                    return;
                }
            }
        } else {
            response.sendRedirect(request.getContextPath() + ("/main-manage-product"));
            return;
        }
        request.getRequestDispatcher("delete-product.jsp").forward(request, response);
    }

}

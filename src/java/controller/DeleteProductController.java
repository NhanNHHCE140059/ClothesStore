package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Product;
import model.ProductsVariant;
import model.Warehouse;
import service.ProductService;
import service.WarehouseService;

/**
 *
 * @author Huenh
 */
@WebServlet(value = "/delete-product")
public class DeleteProductController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        int currentPage = 1;
        String action = null;
        int pro_id = -1;
        Warehouse warehouse = new Warehouse();
        WarehouseService wareservice = new WarehouseService();
        ProductsVariant pro_var = new ProductsVariant();
        if (req.getParameter("action") != null) {
            action = req.getParameter("action");
        }
        if (req.getParameter("pro_id") != null) {
            pro_id = Integer.parseInt(req.getParameter("pro_id"));
        }
        if (req.getParameter("currentPage") != null) {
            currentPage = Integer.parseInt(req.getParameter("currentPage"));
        }
        switch (action) {
            case "delete":
                warehouse = wareservice.GetProByIdInWareHouse(pro_id);
                if (warehouse.getInventory_number() != 0) {
                    session.setAttribute("quantity", warehouse.getInventory_number());
                    resp.sendRedirect(req.getContextPath() + "/manage-product?indexPage=" + currentPage);
                    return;
                }
                break;
            default:
                throw new AssertionError();
        }
    }

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

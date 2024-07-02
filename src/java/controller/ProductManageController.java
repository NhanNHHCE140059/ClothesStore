package controller;

import helper.Role;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import java.io.IOException;
import java.util.List;
import model.ProductsVariant;
import service.ProductVariantService;

/**
 *
 * @author Huenh
 */
@WebServlet(value = "/manage-product")
public class ProductManageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
                
        if(session.getAttribute("account")==null){
            resp.sendRedirect(req.getContextPath()+"/login");
            return;
        }
        Account acc = (Account) session.getAttribute("account");
        if(acc.getRole() == Role.Customer ) {
                  resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }
        int indexPage;
        if (req.getParameter("indexPage") != null) {
            indexPage = Integer.parseInt(req.getParameter("indexPage"));
        } else {
            indexPage = 1;
        }

        ProductVariantService p = new ProductVariantService();
        int count = p.countPageforProduct();
        int size = 5;
        int endPage = count / size;
        if (count % size != 0) {
            endPage++;
        }
        List<ProductsVariant> listPVar = p.getTop5Pro(indexPage);
        req.setAttribute("endPage", endPage);
        req.setAttribute("list", listPVar);
        req.setAttribute("currentPage", indexPage);
        req.getRequestDispatcher("manage-product.jsp").forward(req, resp);
    }
    
}

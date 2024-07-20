package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Account;
import model.Product;
import service.FavoriteService;
import service.ProductService;
import model.*;

/**
 *
 * @author Huenh
 */
@WebServlet(value = "/favorite")
public class FavoriteController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");
        FavoriteService p = new FavoriteService();
        ProductService prdSV = new ProductService();
        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/login"); //chuyen den trang login va bat nguoi dung login lai
        } else {

            Product message = null;
            boolean isHave = false;

            int page = 1;
            int productsPerPage = 6;

            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));

                if (request.getParameter("pid") != null) {

                    int pid = Integer.parseInt(request.getParameter("pid"));
                    message = prdSV.GetProById(pid);

                    for (Favorite fa : p.getAllFavoriteByAccID(acc.getAcc_id())) {
                        if (fa.getPro_id() == pid) {

                            isHave = true;
                            response.sendRedirect(request.getContextPath() + "/shop?fvss=1&page=" + page);
                            return;
                        }
                    }
                    if (!isHave) {
                        p.insertFavorite(acc.getAcc_id(), pid);
                        page = 1;
                    }
                }
            }
            List<Product> list = p.getAllProducts(acc.getAcc_id());
            int start = (page - 1) * productsPerPage;
            int end = Math.min(start + productsPerPage, list.size());

            List<Product> paginatedList = list.subList(start, end);
            int noOfRecords = list.size();
            int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / productsPerPage); //ceil => làm tròn lên

            request.setAttribute("message", message);
            request.setAttribute("noOfPages", noOfPages);
            request.setAttribute("currentPage", page);
            request.setAttribute("listP", paginatedList);
            request.getRequestDispatcher("favorite.jsp").forward(request, response);
        }
    }
    
        @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
                HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");
        FavoriteService p = new FavoriteService();
        for(Favorite fv : p.getAllFavoriteByAccID(acc.getAcc_id())){
            if(fv.getPro_id()== Integer.parseInt(request.getParameter("pro_id")) ){
                p.deleteProductFavoriteByProId(fv.getPro_id(), acc.getAcc_id());
            }
        }
        response.sendRedirect(request.getContextPath()+"/favorite?page="+request.getParameter("page")+"&delete=true");
        
    }
}

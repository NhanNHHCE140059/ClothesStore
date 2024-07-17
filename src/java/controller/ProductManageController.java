package controller;

import helper.Role;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Account;
import model.Product;
import model.ProductVariantInfomation;
import model.ProductsVariant;
import java.io.IOException;
import helper.*;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.text.NumberFormat;
import java.util.*;
import model.ProductVariantInfo;
import service.CategoryService;
import service.ProductService;
import service.ProductVariantService;

/**
 *
 * @author Huenh
 */
@WebServlet(value = "/manage-product")
public class ProductManageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();


        if (session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Account acc = (Account) session.getAttribute("account");
        if (acc.getRole() == Role.Customer) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        int indexPage = 1;
        if (request.getParameter("indexPage") != null) {
            indexPage = Integer.parseInt(request.getParameter("indexPage"));

        }


        ProductVariantService p = new ProductVariantService();
        CategoryService cateSV = new CategoryService();
        List<ProductVariantInfomation> listPVar = p.getAllInfoVariant();
        if (request.getParameter("search") != null && request.getParameter("search").equals("true")) {
            String color_Search = request.getParameter("color_Search");
            String name_Search  = request.getParameter("name_Search");
            String cate_Search = request.getParameter("cate_Search");
            String size_Search = request.getParameter("size_Search");
            System.out.println(color_Search + name_Search + cate_Search + size_Search);
            listPVar = p.searchProductVariants(size_Search, cate_Search, color_Search, name_Search);
            request.setAttribute("color_Search", color_Search);
            request.setAttribute("name_Search", name_Search);
            request.setAttribute("cate_Search", cate_Search);
            request.setAttribute("size_Search", size_Search);
            request.setAttribute("search", request.getParameter("search"));
        }
        System.out.println(listPVar.size());
        int productPerPage = 5;
        int start = (indexPage - 1) * productPerPage;
        int end = Math.min(start + productPerPage, listPVar.size());
        int endPage = (int) Math.ceil((double) listPVar.size() / productPerPage);
        listPVar = listPVar.subList(start, end);
        System.out.println(listPVar + "+" + endPage);
        request.setAttribute("endPage", endPage);
        request.setAttribute("list", listPVar);
        request.setAttribute("currentPage", indexPage);
        request.setAttribute("allCate", cateSV.getAllCate());
        request.getRequestDispatcher("manage-product.jsp").forward(request, response);
    }

}

package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Account;
import java.util.List;
import model.ProductsVariant;
import java.io.IOException;
import helper.*;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.text.NumberFormat;
import java.util.*;
import model.ProductVariantInfo;
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
        ProductVariantService productVRASV = new ProductVariantService();
        NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        int indexPage = 1;
        int variantPerPage = 5;

        if (request.getParameter("indexPage") != null && !request.getParameter("indexPage").isEmpty()) {
            try {
                indexPage = Integer.parseInt(request.getParameter("indexPage"));
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/manage-product");
                return;
            }
        }

        List<ProductVariantInfo> listAll = productVRASV.getAllVariantInfo();
        if (request.getParameter("searchName") != null && !request.getParameter("searchName").isEmpty()) {
            listAll = productVRASV.searchByName(request.getParameter("searchName"));
        }
        int start = (indexPage - 1) * variantPerPage;
        int end = Math.min(start + variantPerPage, listAll.size());
        int endPageList = (int) Math.ceil((double) listAll.size() / variantPerPage);
        listAll = listAll.subList(start, end); // Cat list phan trang
        PrintWriter out = response.getWriter();

        out.println("    <table class=\"table\">");
        out.println("        <thead>");
        out.println("            <tr>");
        out.println("                <th>ID Variant</th>");
        out.println("                <th>Image</th>");
        out.println("                <th>Product name</th>");
        out.println("                <th>Product price</th>");
        out.println("                <th>Category name</th>");
        out.println("                <th>Sizes</th>");
        out.println("                <th>Colors</th>");
        out.println("                <th>Action</th>");
        out.println("            </tr>");
        out.println("        </thead>");
        if (listAll.size() > 0) {

            for (ProductVariantInfo product : listAll) {
                out.println("        <tbody id=\"manage-product\">");
                out.println("            <tr>");
                out.println("                <td>" + product.getVariant_id() + "</td>");
                out.println("                <td style='max-width:50px;' >    <img style='width:100%;'src='" + product.getImageURL() + "'/></td>");
                out.println("                <td>" + product.getPro_name() + "</td>");
                out.println("                <td>" + currencyFormatter.format(product.getPro_price()) + "</td>");
                out.println("                <td>" + product.getCat_name() + "</td>");
                out.println("                <td>" + product.getSize_id() + "</td>");
                out.println("                <td>" + product.getColor_name() + "</td>");
                out.println("                <td><button class=\"btn-edit\">Edit</button></td>");
                out.println("            </tr>");
                out.println("        </tbody>");
            }
        } else {
            out.println("<tbody id=\"manage-product\">");
            out.println("<tr>");
            out.println("<td colspan='8' style='text-align: center;'>NOT FOUND ANY PRODUCT</td>");
            out.println("</tr>");
            out.println("</tbody>");
        }
        out.println("    </table>");
        out.println("<div class='pagination-container'>");

        int totalDisplayedPages = 15;
        int halfPagesToShow = totalDisplayedPages / 2;
        int startPage = Math.max(1, indexPage - halfPagesToShow);
        int endPage = Math.min(endPageList, indexPage + variantPerPage);

        if (endPage - startPage < totalDisplayedPages - 1) {
            if (startPage == 1) {
                endPage = Math.min(endPageList, startPage + totalDisplayedPages - 1);
            } else if (endPage == endPageList) {
                startPage = Math.max(1, endPage - totalDisplayedPages + 1);
            }
        }

        if (startPage > 1) {
            out.println("<a class='page-link' href='#' onclick='sendGetRequest(1,document.getElementById(\"autoSubmitInput\"))'>1</a>");
            if (startPage > 2) {
                out.println("<span class='three-doc'>.....</span>");
            }
        }

        for (int i = startPage; i <= endPage; i++) {
            if (i == indexPage) {
                out.println("<span class='page-link active'>" + i + "</span>");
            } else {
                out.println("<a class='page-link' href='#' onclick='sendGetRequest(" + i + ", document.getElementById(\"autoSubmitInput\"))'> " + i + "</a>");

            }
        }

        if (endPage < endPageList) {
            if (endPage < endPageList - 1) {
                out.println("<span class='three-doc'>.....</span>");
            }
            out.println("<a class='page-link' href='#'onclick='sendGetRequest(" + endPageList + ",document.getElementById(\"autoSubmitInput\"))'>" + endPageList + "</a>");
        }

        out.println("</div>");
    }

}

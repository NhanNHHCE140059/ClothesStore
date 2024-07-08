/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.*;
import service.*;
import helper.*;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.NumberFormat;
import java.util.Locale;
import service.ProductService;

/**
 *
 * @author My Computer
 */
@WebServlet(value = {"/Create_Product_Variant_Controller", "/createVariants"})
public class Create_Product_Variant_Controller extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        ProductService productService = new ProductService();
        CategoryService cateService = new CategoryService();
        String proName = request.getParameter("proName");
        Product product = productService.GetProByName(proName);
        DecimalFormatSymbols symbols = new DecimalFormatSymbols(new Locale("vi", "VN"));
        symbols.setGroupingSeparator('.');
        symbols.setDecimalSeparator(',');
        DecimalFormat decimalFormat = new DecimalFormat("#,### VND", symbols);
        String formattedAmount = decimalFormat.format(product.getPro_price());
        try ( PrintWriter out = response.getWriter()) {
            if (product != null) {
                String json = "{";
                json += "\"price\":\"" + formattedAmount + "\",";
                json += "\"description\":\"" + product.getDescription() + "\",";
                json += "\"categoryName\":\"" + cateService.getNameCateByIDCate(product.getCat_id()).getCat_name() + "\"";
                json += "}";
                out.print(json);
            } else {
                out.print("{}");
            }
            out.flush();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getParameter("proName") != null) {
            processRequest(request, response);
            return;
        }
        ProductService productService = new ProductService();
        ProductColorService productColorService = new ProductColorService();
        List<Product> listAllProduct = productService.getAllProducts();
        List<ProductColor> listAllColor = productColorService.getALLProductColor();
        request.setAttribute("listAllProduct", listAllProduct);
        request.setAttribute("listAllColor", listAllColor);
        request.setAttribute("allSize", ProductSizeType.values());
        request.getRequestDispatcher("create-product-variants.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}

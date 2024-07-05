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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Set;
import service.ProductVariantService;

/**
 *
 * @author My Computer
 */
@WebServlet(value = "/getSizeByColor")
public class getSizeByColor extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int pro_id = Integer.parseInt(request.getParameter("pro_id"));
        String color_name = request.getParameter("color_name");
        String size_old = request.getParameter("size");
        PrintWriter out = response.getWriter();
        ProductVariantService pvService = new ProductVariantService();
        List<String> sizeOrder = Arrays.asList("S", "M", "L", "XL", "XXL", "XXXL", "XXXL", "XXXXL", "XXXXXL");
        Map<String, Set<String>> size_color = pvService.getVariantsByProductId(pro_id);
        size_color.remove("ALL_COLORS");
        List<String> sizesList = new ArrayList<>(size_color.keySet());
        new Runnable() {
            @Override
            public void run() {
                Collections.sort(sizesList, (o1, o2) -> Integer.compare(sizeOrder.indexOf(o1), sizeOrder.indexOf(o2)));
            
            }
        }.run();
        Set<String> sizes = pvService.getSizesByProIDAndColorName(pro_id, color_name);
   
        if (sizes != null && !sizes.isEmpty()) {
            out.print("<label for=\"size\" style=\"margin:6px 12px 0 0;\" >Size:</label>");
            for (String size : sizesList) {
                if (size.equals(size_old) && pvService.getQuantityBySizeAndProductID(pro_id, size) > 0) {
                    out.print("<button class=\"size-btn active hintSize\" id=\"size_" + size + "\" data-size=\"" + size + "\" onclick=\"fetchColorsAndQuantities('" + size + "');selectSize('" + size + "')\">" + size + "</button>");
                } else if (sizes.contains(size) && pvService.getQuantityBySizeAndProductID(pro_id, size) > 0) {
                    out.print("<button class=\"size-btn hintSize\" id=\"size_" + size + "\" data-size=\"" + size + "\" onclick=\"fetchColorsAndQuantities('" + size + "');selectSize('" + size + "')\">" + size + "</button>");
                } else {
                    out.print("<button class=\"size-btn\" id=\"size_" + size + "\" data-size=\"" + size + "\" onclick=\"fetchColorsAndQuantities('" + size + "');selectSize('" + size + "')\" >" + size + "</button>");
                }
            }
        } else {
            out.print("<p>No colors available for this size.</p>");
        }
        out.flush();
    }

}

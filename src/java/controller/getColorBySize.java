/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import helper.ProductSizeType;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Map;
import java.util.Set;
import service.ProductVariantService;

/**
 *
 * @author My Computer
 */
@WebServlet(value = "/getColorBySize")
public class getColorBySize extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int pro_id = Integer.parseInt(request.getParameter("pro_id"));
        boolean isStill = false;
        int size_id = ProductSizeType.valueOf(request.getParameter("size")).ordinal();
        String color_old = request.getParameter("color");
        PrintWriter out = response.getWriter();
        ProductVariantService pvService = new ProductVariantService();
        Map<String, Set<String>> size_color = pvService.getVariantsByProductId(pro_id);
        Set<String> allColors = size_color.get("ALL_COLORS");
        Map<String, Integer> colorQuantityMap = pvService.getProductVariantByProIDAndSizeID(pro_id, size_id);
        response.setContentType("text/html;charset=UTF-8");
        if (allColors != null && !allColors.isEmpty()) {
            out.print("<label for=\"color\" style=\"margin:6px 12px 0 0;\">Color:</label>");
            for (String color : allColors) {
                if (color.equals(color_old) && colorQuantityMap.containsKey(color_old) && colorQuantityMap.get(color) > 0) {
                         isStill = true;
                    out.print("<button class=\"color-btn active\" data-color=\"" + color + "\" style=\"background-color:" + color + "; opacity: 1;\" onclick=\"selectColor('" + color + "');fetchSizeAndQuantities('" + color + "')\"></button>");
                } else {
                    if (colorQuantityMap.containsKey(color) && colorQuantityMap.get(color) > 0) {
                        isStill = true;
                        out.print("<button class=\"color-btn\" data-color=\"" + color + "\" style=\"background-color:" + color + "; opacity: 1;box-shadow: rgba(3, 102, 214, 0.3) 0px 0px 0px 3px;\"onclick=\"selectColor('" + color + "');fetchSizeAndQuantities('" + color + " ')\"></button>");
                    } else {
                        out.print("<button class=\"color-btn\" data-color=\"" + color + "\" style=\"background-color:" + color + "; opacity: 0.1;pointer-events: none;box-shadow: rgba(0, 0, 0, 0.17) 0px -23px 25px 0px inset, rgba(0, 0, 0, 0.15) 0px -36px 30px 0px inset, rgba(0, 0, 0, 0.1) 0px -79px 40px 0px inset, rgba(0, 0, 0, 0.06) 0px 2px 1px, rgba(0, 0, 0, 0.09) 0px 4px 2px, rgba(0, 0, 0, 0.09) 0px 8px 4px, rgba(0, 0, 0, 0.09) 0px 16px 8px, rgba(0, 0, 0, 0.09) 0px 32px 16px;\"></button>");
                    }
                }
            }
            if (!isStill) {
                out.print("<div class=\"out-of-stock-message\"style=\"padding:0;margin:0;line-height:32px;\">This size is currently out of stock, please choose another size!</div>");
            }

        } else {
            out.print("<p>No colors available for this size.</p>");
        }
        out.flush();
    }

}

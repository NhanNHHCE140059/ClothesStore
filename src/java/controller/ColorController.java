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
import jakarta.servlet.http.HttpSession;
import model.Account;
import service.CategoryService;
import service.ProductColorService;

/**
 *
 * @author My Computer
 */
@WebServlet(value = "/Color")
public class ColorController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if ((Account) session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Account account = (Account) session.getAttribute("account");
        if (account.getRole() == (helper.Role.Customer)) {
            session.removeAttribute("account");
            response.sendRedirect("home");
            return;

        }
        ProductColorService colorSV = new ProductColorService();
        request.setAttribute("listColor", colorSV.getALLProductColor());
        request.getRequestDispatcher("addnewColor.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if ((Account) session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Account account = (Account) session.getAttribute("account");
        if (account.getRole() == (helper.Role.Customer)) {
            session.removeAttribute("account");
            response.sendRedirect("home");
            return;
        }

            ProductColorService colorSV = new ProductColorService();
        if (request.getParameter("colorName") != null && !request.getParameter("colorName").isEmpty()) {
            boolean isOK = colorSV.addNewColor(request.getParameter("colorName"));
            if (isOK) {
                response.sendRedirect("Color?success=true");
            }
        } else {
            response.sendRedirect("Color");
            return;
        }
    }

}

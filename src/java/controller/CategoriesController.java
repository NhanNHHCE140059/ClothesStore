/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import service.CategoryService;

/**
 *
 * @author My Computer
 */
@WebServlet(value = "/categories")
public class CategoriesController extends HttpServlet {

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
        CategoryService cateSv = new CategoryService();
        request.setAttribute("listCate", cateSv.getAllCate());
        request.getRequestDispatcher("addnewCate.jsp").forward(request, response);
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

        CategoryService cateSv = new CategoryService();
        if (request.getParameter("categoryName") != null && !request.getParameter("categoryName").isEmpty()) {
            boolean isOK = cateSv.addNewCategory(request.getParameter("categoryName"));
            if (isOK) {
                response.sendRedirect("categories?success=true");
            }
        }else {
             response.sendRedirect("categories");
             return;
        }
    }

}

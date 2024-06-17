/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import model.Account;
import service.AccountService;

/**
 *
 * @author My Computer
 *
 *
 */
@WebServlet(value = {"/UserPofileController","/edit"})
public class UserPofileController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if ((Account) session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Account account = (Account) session.getAttribute("account");
        String username = account.getUsername();
        String changeInfo = request.getParameter("changeInfo");
        AccountService as = new AccountService();
        Account acc = as.getAccountByUsername(username);
        request.setAttribute("account", acc);
        RequestDispatcher dispatcher;
        if (changeInfo == null || changeInfo.trim().isEmpty()) {
            dispatcher = request.getRequestDispatcher("profileUser.jsp");
            dispatcher.forward(request, response);
        } else {
            switch (changeInfo) {
                case "editInfo":
                    dispatcher = request.getRequestDispatcher("editProfileUser.jsp");
                    dispatcher.forward(request, response);
                    break;
                case "editPass":
                    dispatcher = request.getRequestDispatcher("editPasswordUser.jsp");
                    dispatcher.forward(request, response);
                    break;
            }
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
     
    }

}

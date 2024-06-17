/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import service.AccountService;

/**
 *
 * @author My Computer
 */
@WebServlet(value = "/EditProfileController")
public class EditProfileController extends HttpServlet {
   @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
           HttpSession session = request.getSession();
        if ((Account) session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
             return;
        } 
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        String username = account.getUsername();
        AccountService as = new AccountService();

        String inputFullName = request.getParameter("inputFullName");

        String inputAddress = request.getParameter("inputAddress");

        String inputEmailAddress = request.getParameter("inputEmailAddress");

        String inputPhone = request.getParameter("inputPhone");

        as.updateInfoAccountUser(inputFullName, inputAddress, inputEmailAddress, inputPhone, username);

        Account acc = as.getAccountByUsername(username);

        request.setAttribute("account", acc);

        String successMessage = "Information changed successfully";

        session.setAttribute("successMessage", successMessage);

        response.sendRedirect(request.getContextPath() + "/UserPofileController?username=" + username);

    }

}

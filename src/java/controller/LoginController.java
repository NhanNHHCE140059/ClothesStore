package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import misc.Hash;
import model.Account;
import service.AccountService;

/**
 *
 * @author Huenh
 */
@WebServlet(value = "/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.getRequestDispatcher("login.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        Hash hash = new Hash();
        AccountService acsv = new AccountService();
        Account acc = acsv.getAccount(username, hash.getMd5(password));
        if (acc != null) {
            HttpSession session = req.getSession();
            session.setAttribute("account", acc);
            session.setAttribute("role", acc.getRole().name());
            res.sendRedirect("home");
        } else {
            req.setAttribute("msgError", "Wrong username or password.");
            req.getRequestDispatcher("login.jsp").forward(req, res);
        }
    }
}
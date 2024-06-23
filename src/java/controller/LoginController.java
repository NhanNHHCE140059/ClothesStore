package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import misc.Hash;
import model.Account;
import model.Cart;
import service.AccountService;
import service.CartService;

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
            CartService cservice = new CartService();
            int quantitypro = 0;
            for (Cart c : cservice.GetListCartByAccID(acc.getAcc_id())) {
                quantitypro++;
            }
            HttpSession session = req.getSession();
            session.setAttribute("quantitypro", quantitypro);
            session.setAttribute("account", acc);
            session.setAttribute("role", acc.getRole().name());
            
//            Cookie u = new Cookie("uCookie", username);
//            Cookie p = new Cookie("pwdCookie", password);
//            u.setMaxAge(60);
//            p.setMaxAge(60);
//            res.addCookie(u);
//            res.addCookie(p);
            
            res.sendRedirect("home");
        } else {
            req.setAttribute("msgError", "Wrong username or password.");
            req.getRequestDispatcher("login.jsp").forward(req, res);
        }
    }
}

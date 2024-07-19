package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Account;

/**
 *
 * @author Huenh
 */
@WebServlet(value = "/logout")
public class LogoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        session.removeAttribute("role");
        String name = null;
        if (session.getAttribute("account") != null) {
            name = ((Account) session.getAttribute("account")).getName();
        }
        session.removeAttribute("account");
        session.removeAttribute("quantitypro");
        session.removeAttribute("manageIndexPage");
        res.sendRedirect("home?name=" + name);
    }
}

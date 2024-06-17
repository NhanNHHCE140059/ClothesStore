package controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import misc.Hash;
import model.Account;
import service.AccountService;

@WebServlet(value = "/EditPasswordController")
public class EditPasswordController extends HttpServlet {

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
        RequestDispatcher dispatcher;
        boolean hasError = false;
        String messageError = null;
        HttpSession session = request.getSession();
        if ((Account) session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Account account = (Account) session.getAttribute("account");
        String username = account.getUsername();
        AccountService as = new AccountService();
        Account acc = as.getAccountByUsername(username);
        String pass = request.getParameter("inputNewPassword");
        String rePass = request.getParameter("inputConfirmPassword");
        Hash hash = new Hash();
        if (!as.isPasswordMatching(pass, rePass)) {
            hasError = true;

            messageError = "***Password does not match, please re-enter password";
        } else if (pass == null || pass.length() < 6 || pass.length() > 20) {
            hasError = true;
            messageError = "***Please enter a password longer than 6 characters and less than 20 character";
        } else if (hash.getMd5(pass).equals(acc.getPassword())) {
            hasError = true;
            messageError = "***Your new password cannot be the same as your old password";
        }
        if (hasError) {
            request.setAttribute("account", acc);
            request.setAttribute("messageError", messageError);
            dispatcher = request.getRequestDispatcher("editPasswordUser.jsp");
            dispatcher.forward(request, response);
        } else {
            String successMessage = "Password has been changed successfully";
            session.setAttribute("successMessage", successMessage);
            as.changePasswordUser(username, hash.getMd5(pass));
            response.sendRedirect(request.getContextPath() + "/UserPofileController?username=" + username);
        }
    }
}

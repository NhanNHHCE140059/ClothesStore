package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import service.AccountService;
import misc.Hash;

/**
 *
 * @author Huenh
 */
@WebServlet(value = "/register")
public class RegisterController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.getRequestDispatcher("register.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            String username = req.getParameter("username");
            String name = req.getParameter("name"); 
            String email = req.getParameter("email"); 
            String phoneNumber = req.getParameter("phone");
            String password = req.getParameter("password");
            String repassword = req.getParameter("repassword");
            String address = req.getParameter("address");
            
            boolean flag = false;
            AccountService aService = new AccountService();
            Hash hash = new Hash();
            
            if (aService.exists(username)) {
                req.setAttribute("usernameErr", username);
                flag = true;
            } 
            if (!email.contains("@")) {
                req.setAttribute("emailErr", "Email is invalid, please enter again");
                flag = true;
            } 
            if (!password.equals(repassword)) {
                req.setAttribute("repwdErr", "Re-password must be matched password");
                flag = true;
            }
            if(!phoneNumber.matches("^(0[3|5|7|8|9])+([0-9]{8})\\b$")){
                req.setAttribute("phoneErr", "Phone is invalid, please enter again");
                flag = true;
            }
            if(!password.matches("^[a-zA-Z0-9]{6,20}$")){
                req.setAttribute("pwdErr", "Password must have at least 6 characters");
                flag = true;
            }
            
            if (flag) {
                req.setAttribute("pwdVal", password);
                req.setAttribute("emailVal", email);
                req.setAttribute("userVal", username);
                req.setAttribute("phoneVal", phoneNumber);
                req.setAttribute("addressVal", address);
                req.setAttribute("nameVal", name);
                req.setAttribute("repwd", repassword);
                req.getRequestDispatcher("register.jsp").forward(req, res);
            } else {
                aService.createAccount(username, name, email, phoneNumber, hash.getMd5(password), address);
                res.sendRedirect("login");
            }
        } catch (IOException e) {
            System.out.println("Loi register controller");
            req.getRequestDispatcher("register.jsp").forward(req, res);
        }
    }
}

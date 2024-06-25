/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import jakarta.mail.MessagingException;
import model.Account;
import service.AccountService;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.UUID;
import java.util.HashMap;
import java.util.Map;
import service.EmailService;

/**
 *
 * @author bichtien03
 */
@WebServlet(value = "/reset-password")
public class ResetPasswordController extends HttpServlet {

    private final AccountService accountService = new AccountService();
    private final KeyStore keyStore = new KeyStore();
    EmailService emailService = new EmailService("smtp.mailersend.net", "587", "MS_iZQkc0@trial-o65qngkk30dgwr12.mlsender.net", "59BRY5nBAvozs8ac");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String code = req.getParameter("code");
        String email = req.getParameter("email");

        // Co email va co code
        if (email != null && code != null) {
            String emailInStore = keyStore.get(code);
            // khong tim thay email co code phu hop
            if (emailInStore == null && !email.equals(emailInStore)) {
                req.setAttribute("error-message", "Invalid Code! Please try again!");
                req.getRequestDispatcher("reset-password-error.jsp").forward(req, res);
            } else {
                // Tim thay email va code trong store
                req.setAttribute("code", code);
                req.setAttribute("email", email);
                req.getRequestDispatcher("reset-password-do.jsp").forward(req, res);
            }
        } else {
            req.getRequestDispatcher("reset-password-form.jsp").forward(req, res);
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String email = req.getParameter("email");
        String reqCode = req.getParameter("code");
        String state = req.getParameter("state");
        Account acc = accountService.getAccountByEmail(email);

        // Khong tim thay account
        if (acc == null) {
            req.setAttribute("error-message", "The email is not found on our system!");
            req.getRequestDispatcher("reset-password-error.jsp").forward(req, res);
        }

        // Request reset password
        else if ("request-change".equals(state) && acc != null) {
            String password = req.getParameter("password");
            String confirmPassword = req.getParameter("confirm_password");
            // password khong bang nhau
            if (!password.equals(confirmPassword)) {
                req.setAttribute("error-message", "The password are not matched! Please try again!");
                req.getRequestDispatcher("reset-password-error.jsp").forward(req, res);
            }

            // cap nhat mat khau
            acc.setPassword(password);
            try {
                // update trong DB
                accountService.updateAccountPassword(acc);
                // Xoa code
                keyStore.remove(reqCode);
                req.setAttribute("message", "Success! Now you can login with your new password!");
                req.getRequestDispatcher("reset-password-ok.jsp").forward(req, res);
            } catch (Exception e) {
                req.setAttribute("error-message", "Cannot update your account! Please try again later!");
                req.getRequestDispatcher("reset-password-error.jsp").forward(req, res);
            }
        }
        // Co email nhung khong co code
        // thi tao code va gui email
        else if (email != null && reqCode == null) {
            String code = UUID.randomUUID().toString();
            keyStore.set(code, email);
            req.setAttribute("message", "We have sent you an email to you, please check your inbox/spam.");
            req.setAttribute("code", "<a href=\"http://localhost:8080/clothesstore/reset-password?email=" + email + "&code=" + code + "\">Reset Link</a>");
            try {
                this.emailService.sendEmail(email, code);
                System.out.println("Reset email sent to: " + email);
            } catch (MessagingException e) {
                e.printStackTrace();
            }
            req.getRequestDispatcher("reset-password-ok.jsp").forward(req, res);
        }
    }
}

class KeyStore {

    private Map<String, String> store;

    public KeyStore() {
        this.store = new HashMap<>();
    }

    public Map<String, String> getStore() {
        return store;
    }

    public void setStore(Map<String, String> store) {
        this.store = store;
    }

    public String get(String key) {
        return store.get(key);
    }

    public void set(String key, String value) {
        store.put(key, value);
    }

    public boolean containsKey(String key) {
        return store.containsKey(key);
    }

    public void remove(String key) {
        store.remove(key);
    }
}

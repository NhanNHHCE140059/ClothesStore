package controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.Account;
import service.AccountService;

@WebServlet(value = "/EditAvatarUserController")
@MultipartConfig
public class EditAvatarUserController extends HttpServlet {

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
        if ((Account) session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Account account = (Account) session.getAttribute("account");
        String username = account.getUsername();
        AccountService as = new AccountService();
        Part part = request.getPart("file");

        if (part != null && part.getSize() > 0) {
            String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
            String uploadDir = getServletContext().getRealPath("/") + "assets/img";

            File uploadDirFile = new File(uploadDir);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdirs();
            }

            String absoluteFilePath = uploadDir + File.separator + filename;
            String relativeFilePath = "assets/img/" + filename;

            part.write(absoluteFilePath);
            as.updateImageUser(relativeFilePath, username);
            response.sendRedirect(request.getContextPath() + "/UserPofileController?username=" + username);
        } else {
            response.sendRedirect(request.getContextPath() + "/UserPofileController?username=" + username);
        }
    }
}

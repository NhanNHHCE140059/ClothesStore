package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Product;
import service.ProductService;

/**
 *
 * @author Huenh
 */
@WebServlet(value = "/detail")
public class DetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("pid");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr); // Chuyển đổi từ String sang int
                ProductService ps = new ProductService();
                Product p = ps.GetProById(id);
                req.setAttribute("pro_detail", p);
                req.getRequestDispatcher("detail.jsp").forward(req, resp);
            } catch (NumberFormatException e) {
                // Xử lý trường hợp idStr không phải là một số hợp lệ
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID");
            }
        } else {
            // Xử lý trường hợp pid không có trong request
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is required");
        }
//       String id = req.getParameter("pid");
//       ProductService ps = new ProductService();
//       Product p = ps.GetProById(id);
//       req.setAttribute("pro_detail", p);
//       req.getRequestDispatcher("detail.jsp").forward(req, resp);
    }
}

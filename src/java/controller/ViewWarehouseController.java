/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Warehouse;
import model.WarehouseProduct;
import service.WarehouseService;

/**
 *
 * @author Admin
 */
@WebServlet(value = {"/ViewWarehouse"})
public class ViewWarehouseController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ViewWarehouseController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewWarehouseController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Account account = (Account) session.getAttribute("account");
        if (account.getRole() == (helper.Role.Customer)) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        try {
            WarehouseService ws = new WarehouseService();
            int pageSize = 15; // Số sản phẩm trên mỗi trang
            int pageIndex = 1; // Trang mặc định là trang 1

            // Lấy trang từ tham số request
            if (request.getParameter("page") != null) {
                pageIndex = Integer.parseInt(request.getParameter("page"));
            }

            // Tính toán startIndex
            int startIndex = (pageIndex - 1) * pageSize;
            List<WarehouseProduct> list = ws.getAllWarehouse();

            // Tính toán số trang và các tham số cho phân trang
            int totalItems = list.size();
            int endPage = (int) Math.ceil((double) totalItems / pageSize);
            int maxPages = 5; // Số trang tối đa hiển thị
            int startPage = Math.max(1, pageIndex - (maxPages - 1) / 2);
            int endPageDisplay = Math.min(endPage, startPage + maxPages - 1);

            // Lấy danh sách sản phẩm cho trang hiện tại
            List<WarehouseProduct> paginatedList;
            if (totalItems == 0) {
                paginatedList = new ArrayList<>(); // Đặt danh sách trống nếu không có sản phẩm nào
            } else {
                paginatedList = list.subList(startIndex, Math.min(startIndex + pageSize, totalItems));
            }

            // Thiết lập các thuộc tính request
            request.setAttribute("listWarehouse", paginatedList);
            request.setAttribute("endPage", endPage);
            request.setAttribute("pageIndex", pageIndex);
            request.setAttribute("startPage", startPage);
            request.setAttribute("endPageDisplay", endPageDisplay);

            // Chuyển tiếp tới JSP
            request.getRequestDispatcher("view-warehouse.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); // In lỗi ra console để dễ dàng kiểm tra lỗi
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

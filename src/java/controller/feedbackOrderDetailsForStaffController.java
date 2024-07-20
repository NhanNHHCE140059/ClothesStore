package controller;

import helper.Role;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;
import model.Account;
import model.OrderDetailCustomer;
import model.OrderDetailStaff;
import service.OrderDetailService;

@WebServlet(value = "/feedbackorderForStaff")
public class feedbackOrderDetailsForStaffController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Account acc = (Account) session.getAttribute("account");
        if (acc.getRole() != Role.Staff) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        OrderDetailService orderDetailService = new OrderDetailService();
        List<OrderDetailCustomer> listAll = orderDetailService.getAllOrderDetailsWithProductDetails();
        String haveFeedback = "";
        if (request.getParameter("haveFeedback") != null && !request.getParameter("haveFeedback").isEmpty()) {
            listAll = orderDetailService.getAllOrderDetailsWithProductDetailsHaveFB();
            haveFeedback = request.getParameter("haveFeedback");
        }
        if (request.getParameter("nameSearch") != null && !request.getParameter("nameSearch").isEmpty()) {
            listAll = orderDetailService.searchOrderDetailsByProductName(request.getParameter("nameSearch"));
        }
        int indexPage = 1;
        int detailsPerPage = 7;
        if (request.getParameter("indexPage") != null) {
            indexPage = Integer.parseInt(request.getParameter("indexPage"));
        }
        int start = (indexPage - 1) * detailsPerPage;
        int end = Math.min(start + detailsPerPage, listAll.size());
        List<OrderDetailCustomer> paginatedList = listAll.subList(start, end);
        int noOfRecords = listAll.size();
        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / detailsPerPage);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<div class='table-container'>");
        out.println("<table class='table'>");
        out.println("<thead>");
        out.println("<tr>");
        out.println("<th class='col-1'>ID Order</th>");
        out.println("<th class='col-1-5'>Order DATE</th>");
        out.println("<th class='col-1-5 col-phone'>Phone Number</th>");
        out.println("<th class='col-1-5 col-name'>Product Name</th>");
        out.println("<th class='col-1 col-size'>Size</th>");
        out.println("<th class='col-1 col-color'>Color</th>");
        out.println("<th class='col-4 col-feed'>Feedback Content</th>");
        out.println("<th class='col-1 col-action'>Actions</th>");
        out.println("</tr>");
        out.println("</thead>");
        out.println("<tbody>");

        for (OrderDetailCustomer detail : paginatedList) {
            Date orderDate = detail.getOrderDate(); // Thay thế bằng phương thức lấy ngày tháng thực tế

            // Định dạng mong muốn
            SimpleDateFormat desiredFormat = new SimpleDateFormat("dd-MM-yyyy");

            // Định dạng lại đối tượng Date
            String formattedOrderDate = "";
            if (orderDate != null) {
                formattedOrderDate = desiredFormat.format(orderDate);
            }
            out.println("<tr>");
            out.println("<td>" + detail.getOrder_id() + "</td>");
            out.println("<td >" + formattedOrderDate + "</td>");
            out.println("<td >" + detail.getPhone() + "</td>");
            out.println("<td >" + detail.getPro_name() + "</td>");
            out.println("<td>" + detail.getSize_name() + "</td>");
            out.println("<td>" + detail.getColor_name() + "</td>");
            if (detail.getFeedback_details() != null) {
                out.println("<td >" + detail.getFeedback_details() + "</td>");
                out.println("<td >");
                out.println("<button class='action-button' onclick='sendPostRequest(" + indexPage + ",\"" + haveFeedback + "\"," + detail.getOrder_detail_id() + ", document.getElementById(\"autoSubmitInput\"))' type='submit'>Delete Feedback</button>");
                out.println("</td>");
            } else {
                out.println("<td >Customers do not give feedback or feedback has been removed before</td>");
                out.println("<td >");
                out.println("<button class='non-action-button' type='submit'>Delete Feedback</button>");
                out.println("</td>");
            }
            out.println("</tr>");
        }
        out.println("</tbody>");
        out.println("</table>");
        out.println("</div>");

        out.println("<div class='pagination-container'>");

        int totalDisplayedPages = 15;
        int halfPagesToShow = totalDisplayedPages / 2;
        int startPage = Math.max(1, indexPage - halfPagesToShow);
        int endPage = Math.min(noOfPages, indexPage + halfPagesToShow);

        if (endPage - startPage < totalDisplayedPages - 1) {
            if (startPage == 1) {
                endPage = Math.min(noOfPages, startPage + totalDisplayedPages - 1);
            } else if (endPage == noOfPages) {
                startPage = Math.max(1, endPage - totalDisplayedPages + 1);
            }
        }

        if (startPage > 1) {
            out.println("<a class='page-link' href='#' onclick='sendGetRequest(1, \"" + haveFeedback + "\", document.getElementById(\"autoSubmitInput\"))'>1</a>");
            if (startPage > 2) {
                out.println("<span class='three-doc'>...</span>");
            }
        }

        for (int i = startPage; i <= endPage; i++) {
            if (i == indexPage) {
                out.println("<span class='page-link active'>" + i + "</span>");
            } else {
                out.println("<a class='page-link' href='#' onclick='sendGetRequest(" + i + ", \"" + haveFeedback + "\", document.getElementById(\"autoSubmitInput\"))'>" + i + "</a>");
            }
        }

        if (endPage < noOfPages) {
            if (endPage < noOfPages - 1) {
                out.println("<span class='three-doc'>...</span>");
            }
            out.println("<a class='page-link' href='#' onclick='sendGetRequest(" + noOfPages + ", \"" + haveFeedback + "\", document.getElementById(\"autoSubmitInput\"))'>" + noOfPages + "</a>");
        }

        out.println("</div>");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("In here");
        String orderDetails_id = request.getParameter("orderDetails_id");
        System.out.println(orderDetails_id);
        OrderDetailService orderDetailService = new OrderDetailService();

        orderDetailService.deleteFeedbackOrderDetail(Integer.parseInt(orderDetails_id));
        System.out.println("Thanh cong xoa feedback");
    }
}

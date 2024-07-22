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
import java.util.ArrayList;
import java.util.List;
import model.Account;
import helper.*;
import service.AccountService;

/**
 *
 * @author My Computer
 */
@WebServlet(value = "/ajaxForAM")
public class AjaxAccountManagementController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int status = -1;
        int indexPage = 1;
        int productsPerPage = 5;

        if (request.getParameter("status") != null) {
            status = Integer.parseInt(request.getParameter("status"));
        }
        if (request.getParameter("indexPage") != null) {
            indexPage = Integer.parseInt(request.getParameter("indexPage"));
        }

        AccountService acSV = new AccountService();
        List<Account> listAllAcc = acSV.getListAccount(status);
        String userName = null;
        if (request.getParameter("Username") != null) {
            userName = request.getParameter("Username");
            listAllAcc = acSV.searchListAccountByUserName(userName);
        }
        listAllAcc.removeIf(acc -> acc.getRole() == Role.Admin);
        listAllAcc.removeIf(acc -> acc.getRole() == Role.Staff);
        int start = (indexPage - 1) * productsPerPage;
        int end = Math.min(start + productsPerPage, listAllAcc.size());

        List<Account> paginatedList = listAllAcc.subList(start, end);
        if (paginatedList.isEmpty() && indexPage > 1) {
            indexPage = indexPage - 1;
            start = (indexPage - 1) * productsPerPage;
            end = Math.min(start + productsPerPage, listAllAcc.size());
            paginatedList = listAllAcc.subList(start, end);
        }
        int noOfRecords = listAllAcc.size();
        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / productsPerPage);

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<div id=\"content-table\">");
        out.println("<table class=\"account-table\">");
        out.println("<thead>");
        out.println("<tr>");
        out.println("<th>Action</th>");
        out.println("<th>Status</th>");
        out.println("<th>Name</th>");
        out.println("<th>Account Type</th>");
        out.println("<th>Mobile</th>");
        out.println("<th>Username</th>");
        out.println("<th>Email</th>");
        out.println("</tr>");
        out.println("</thead>");
        out.println("<tbody id=\"data-load\">");

        if (paginatedList != null && !paginatedList.isEmpty()) {
            for (Account acc : paginatedList) {
                out.println("<tr>");
                if (request.getParameter("Username") != null) {
                    if (acc.getAcc_status() == helper.AccountStatus.ACTIVATE) {
                        out.println("<td style='width: 150px;min-width:150px;max-width:150px;'>");
                        out.println("<button onclick=\"sendPostRequest('deactivate'," + acc.getAcc_id() + "," + indexPage + "," + status + " ,document.getElementById('searchUsernameInput'))\" name='action' type='submit' value='deactivate' class='deactivate-button'>DEACTIVATE</button>");
                        out.println("</td>");
                        out.println("<td class='status_acc' style='width: 150px;min-width:150px;max-width:150px;'>ACTIVATE</td>");
                    } else {
                        out.println("<td style='width: 150px;min-width:150px;max-width:150px;'>");
                        out.println("<button onclick=\"sendPostRequest('activate'," + acc.getAcc_id() + "," + indexPage + "," + status + " ,document.getElementById('searchUsernameInput'))\" name='action' type='submit' value='activate' class='activate-button'>ACTIVATE</button>");
                        out.println("</td>");
                        out.println("<td class='status_acc' style='width: 150px;min-width:150px;max-width:150px;'>DEACTIVATE</td>");
                    }

                    out.println("<td style='width: 150px;min-width:150px;max-width:150px;'>" + acc.getName() + "</td>");
                    out.println("<td style='width: 150px;min-width:150px;max-width:150px;'>" + acc.getRole() + "</td>");
                    out.println("<td style='width: 150px;min-width:150px;max-width:150px;'>" + acc.getPhone() + "</td>");
                    out.println("<td style='width: 150px;min-width:150px;max-width:150px;'>" + acc.getUsername() + "</td>");
                    out.println("<td style='width: 250px;min-width:250px;max-width:250px;'>" + acc.getEmail() + "</td>");
                    out.println("</tr>");
                } else {
                    if (acc.getAcc_status() == helper.AccountStatus.ACTIVATE) {
                        out.println("<td style='width: 150px;min-width:150px;max-width:150px;'>");
                        out.println("<button onclick=\"sendPostRequest('deactivate'," + acc.getAcc_id() + "," + indexPage + "," + status + ")\" name='action' type='submit' value='deactivate' class='deactivate-button'>DEACTIVATE</button>");
                        out.println("</td>");
                        out.println("<td class='status_acc' style='width: 150px;min-width:150px;max-width:150px;'>ACTIVATE</td>");
                    } else {
                        out.println("<td style='width: 150px;min-width:150px;max-width:150px;'>");
                        out.println("<button onclick=\"sendPostRequest('activate'," + acc.getAcc_id() + "," + indexPage + "," + status + ")\" name='action' type='submit' value='activate' class='activate-button'>ACTIVATE</button>");
                        out.println("</td>");
                        out.println("<td class='status_acc' style='width: 150px;min-width:150px;max-width:150px;'>DEACTIVATE</td>");
                    }

                    out.println("<td style='width: 150px;min-width:150px;max-width:150px;'>" + acc.getName() + "</td>");
                    out.println("<td style='width: 150px;min-width:150px;max-width:150px;'>" + acc.getRole() + "</td>");
                    out.println("<td style='width: 150px;min-width:150px;max-width:150px;'>" + acc.getPhone() + "</td>");
                    out.println("<td style='width: 150px;min-width:150px;max-width:150px;'>" + acc.getUsername() + "</td>");
                    out.println("<td style='width: 250px;min-width:250px;max-width:250px;'>" + acc.getEmail() + "</td>");
                    out.println("</tr>");
                }
            }
        } else {
            out.println("<tr>");
            out.println("<td colspan='7'>No accounts found.</td>");
            out.println("</tr>");
        }

        out.println("</tbody>");
        out.println("</table>");
        out.println("<div class=\"pagination\" id=\"pagination\">");
        if (request.getParameter("Username") != null) {
            if (noOfPages != 0) {
                out.println("<div class=\"page-numbers\">");

                int startPage = Math.max(1, indexPage - 2);
                int endPage = Math.min(noOfPages, indexPage + 2);

                if (indexPage > 1) {
                    out.println("<button onclick=\"searchUsername(" + (indexPage - 1) + ",  document.getElementById('searchUsernameInput'))\" class=\"page-link\" title=\"Previous Page\">PREVIOUS</button>");
                }

                for (int i = startPage; i <= endPage; i++) {
                    if (i == indexPage) {
                        out.println("<button onclick=\"searchUsername(" + i + ",  document.getElementById('searchUsernameInput'))\" class=\"page-link active\" title=\"Go to page " + i + "\">" + i + "</button>");
                    } else {
                        out.println("<button onclick=\"searchUsername(" + i + ",  document.getElementById('searchUsernameInput'))\" class=\"page-link\" title=\"Go to page " + i + "\">" + i + "</button>");
                    }
                }

                if (indexPage < noOfPages) {
                    out.println("<button onclick=\"searchUsername(" + (indexPage + 1) + ",  document.getElementById('searchUsernameInput'))\" class=\"page-link\" title=\"Next Page\">NEXT</button>");
                }

                out.println("</div>");
            }
        } else {

            if (noOfPages != 0) {
                out.println("<div class=\"page-numbers\">");

                int startPage = Math.max(1, indexPage - 2);
                int endPage = Math.min(noOfPages, indexPage + 2);

                if (indexPage > 1) {
                    out.println("<button onclick=\"sendAjaxRequest(" + (indexPage - 1) + ", " + status + ")\" class=\"page-link\" title=\"Previous Page\">PREVIOUS</button>");
                }

                for (int i = startPage; i <= endPage; i++) {
                    if (i == indexPage) {
                        out.println("<button onclick=\"sendAjaxRequest(" + i + ", " + status + ")\" class=\"page-link active\" title=\"Go to page " + i + "\">" + i + "</button>");
                    } else {
                        out.println("<button onclick=\"sendAjaxRequest(" + i + ", " + status + ")\" class=\"page-link\" title=\"Go to page " + i + "\">" + i + "</button>");
                    }
                }

                if (indexPage < noOfPages) {
                    out.println("<button onclick=\"sendAjaxRequest(" + (indexPage + 1) + ", " + status + ")\" class=\"page-link\" title=\"Next Page\">NEXT</button>");
                }

                out.println("</div>");
            }
        }

        out.println("</div>");
        out.println("</div>");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getParameter("action") != null) {
            AccountService acSV = new AccountService();
            int acc_id = -1;
            String action = request.getParameter("action");
            if (request.getParameter("accID") != null) {
                System.out.println(request.getParameter("accID"));
                try {
                    acc_id = Integer.parseInt(request.getParameter("accID"));
                } catch (NumberFormatException e) {

                    System.out.println("Khong the chuyen doi ID");
                    response.sendRedirect("adminaccountcustomer");
                    return;
                }
            }
            switch (action) {
                case "deactivate":
                    acSV.updateStatusAccount(1, acc_id);
                    break;
                case "activate":
                    acSV.updateStatusAccount(0, acc_id);
                    break;

            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

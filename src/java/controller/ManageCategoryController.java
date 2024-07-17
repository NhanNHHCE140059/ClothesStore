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
import java.util.List;
import model.Account;
import model.Category;
import service.CategoryService;

/**
 *
 * @author HP
 */
@WebServlet(name="ManageCategoryController", urlPatterns={"/manage-category"})
public class ManageCategoryController extends HttpServlet {
   
    private CategoryService categoryDAO;

    @Override
    public void init() {
        categoryDAO = new CategoryService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        } else {
            Account a = (Account) session.getAttribute("account");
            if (a.getRole() != helper.Role.Staff) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }
        }
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "new":
                showNewForm(request, response);
                break;
            case "insert":
                insertCategory(request, response);
                break;
            case "delete":
                deleteCategory(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "update":
                updateCategory(request, response);
                break;
            default:
                listCategory(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
    

    private void listCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> categoryList = categoryDAO.getAllCategories();
        request.setAttribute("categoryList", categoryList);
        request.getRequestDispatcher("categories.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("category-form.jsp").forward(request, response);
    }

    private void insertCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("cat_name");
        Category newCategory = new Category();
        newCategory.setCat_name(name);
        categoryDAO.insertCategory(newCategory);
        response.sendRedirect("manage-category");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("cat_id"));
        Category existingCategory = categoryDAO.getCategory(id);
        request.setAttribute("category", existingCategory);
        request.getRequestDispatcher("category-form.jsp").forward(request, response);
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("cat_id"));
        String name = request.getParameter("cat_name");

        Category category = new Category(id, name);
        categoryDAO.updateCategory(category);
        response.sendRedirect("manage-category");
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("cat_id"));
        categoryDAO.deleteCategory(id);
        response.sendRedirect("manage-category");
    }

}

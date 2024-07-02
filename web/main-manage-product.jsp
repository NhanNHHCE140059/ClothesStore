<%-- 
    Document   : main-manage-product
    Created on : Jul 2, 2024, 8:07:02 PM
    Author     : Huenh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <%@page import="model.Account"%>
    <%@page import="helper.Role"%>
    <%@page import="model.Product" %>
    <%@page import="model.Category" %>
    <%@page import="model.ProductsVariant"%>
    <%@page import="service.ProductService" %>
    <%@page import="service.CategoryService" %>
    <%@page import="model.ProductColor"%>
    <%@page import="service.ProductColorService"%>
    <%@page import="service.ProductImageService"%>
    <%@page import="java.util.*"%>
    <%ProductColorService color = new ProductColorService(); %>
    <%ProductImageService img = new ProductImageService(); %>
    <%ProductService product = new ProductService(); %>
    <%CategoryService cate = new CategoryService(); %>
    <%Integer quantity = (Integer) session.getAttribute("quantity");%>
    <% Account account = (Account) request.getAttribute("account"); %>
    <% List<ProductsVariant> list = (List<ProductsVariant>) request.getAttribute("list"); %>
    <% Integer endPage = (Integer) request.getAttribute("endPage");%>
    <% String searchText = (String) request.getAttribute("searchText"); %>
    <% Integer currentPage =(Integer) request.getAttribute("currentPage"); %>
    <head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/manage-product.css"/>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Shop Management</title>
    </head>
    <body>
        <div class="sidebar">
            <div class="sidebar-header">Dashboard For Staff</div>
            <a href="#" class="menu-item">Product Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="/clothesstore/manage-product">Manage Product Variant</a>
                <a href="/clothesstore/main-manage-product">Manage Product</a>
            </div>
            <a href="#" class="menu-item">Category Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="#">Create Category</a>
                <a href="#">Update Category</a>
                <a href="#">Delete Category</a>
            </div>
            <a href="#" class="menu-item">Feedback Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="#">View Feedback</a>
            </div>
            <a href="#" class="menu-item">Orders Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="#">Confirm Orders</a>
                <a href="#">Cancel Orders</a>
                <a href="#">Change Ship Status</a>
            </div>
            <a href="#" class="menu-item">Warehouse Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="#">Create New Product (Warehouse)</a>
                <a href="#">Update Product (Warehouse)</a>
                <a href="#">Delete Product (Warehouse)</a>
            </div>
        </div>

        <div class="content">
            <a href="${pageContext.request.contextPath}/home" class=" back-home">Back to Home</a>
            <a href="/clothesstore/main-create-product" class="btn-create">Add new product</a>
            <table class="table">
                <thead>
                    <tr>
                        <th>ID Product</th>
                        <th>Image</th>
                        <th>Product name</th>
                        <th>Product price</th>
                        <th>Description</th>
                        <th>Category name</th>
                        <th>Sizes</th>
                        <th>Colors</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="main-manage-product">
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="actions">
                            <a href="/clothesstore/update-product" class="btn-update">Update</a>
                            <a href="/clothesstore/delete-product" class="btn-delete">Delete</a>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="col-12">
                <nav>
                    <ul class="pagination justify-content-center">
                        <li class="page-item"><a class="page-link" href="#">Previous</a></li>
                        <li class="page-item"><a class="page-link" href="#">Next</a></li>
                    </ul>
                </nav>
            </div>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="./assets/js/feedbackManagement.js" type="text/javascript"></script>
    </body>
</html>
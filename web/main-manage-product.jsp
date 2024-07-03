<%-- 
    Document   : main-manage-product
    Created on : Jul 2, 2024, 8:07:02 PM
    Author     : Huenh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="service.*" %>
<%@page import="model.*" %>
<%@page import="helper.*" %>
<%@page import="java.util.*" %>
<% CategoryService cateSv =  new CategoryService();%>
<% Integer endPage = (Integer) request.getAttribute("endPage");%>
<% Integer currentPage =(Integer) request.getAttribute("indexPage"); %>
<!DOCTYPE html>
<html lang="en">
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
                        <th>Status(Visible/Hidden)</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="main-manage-product">
                    <c:forEach var="product" items="${listP}"> 
                        <%
                      
                          Product prod = (Product) pageContext.findAttribute("product");
                          String description = prod.getDescription();
                          String truncatedDescription = (description != null && description.length() > 90) 
                                                        ? description.substring(0, 90) + "..." 
                                                        : description;
                         int cate_id = prod.getCat_id();
                        %>

                        <tr>
                            <td>${product.pro_id}</td>
                            <td>${product.imageURL}</td>
                            <td>${product.pro_name}</td>
                            <td>${product.pro_price}</td>
                            <td><%= truncatedDescription %></td>
                            <td><%= cateSv.getNameCateByIDCate(cate_id).getCat_name()%></td>
                            <td>${product.status_product}</td>
                            <td class="actions">
                                <a href="/clothesstore/update-product?idPro=${product.pro_id}" class="btn-update">Update</a>
                                <% if(prod.getStatus_product() == ProductStatus.HIDDEN){ %>
                                <a href="/clothesstore/delete-product?idPro=${product.pro_id}&action=visible" class="btn-delete">Visible</a>
                                <%}else {%>
                                <a href="/clothesstore/delete-product?idPro=${product.pro_id}&action=hidden" class="btn-delete">Hidden</a>
                                <%}%>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="col-12">
                <nav>
                    <ul class="pagination justify-content-center">
                        <%if (currentPage > 1){%>
                        <li class="page-item"><a class="page-link" href="main-manage-product?indexPage=${currentPage - 1}">Previous</a></li>
                            <%}%>
                            <%int pageRange = 5; 
                              int startPage = Math.max(1, currentPage - pageRange);
                              int end = Math.min(endPage, currentPage + pageRange);%>

                        <%for (int i = startPage; i <= end; i++){%>
                        <li><a class="page-link" href="main-manage-product?indexPage=<%=i%>"><%=i%></a></li>
                            <%}%>
                            <%if(currentPage < endPage){%>
                        <li class="page-item"><a class="page-link" href="main-manage-product?indexPage=${currentPage + 1}">Next</a></li>
                            <%}%>
                    </ul>
                </nav>
            </div>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="./assets/js/feedbackManagement.js" type="text/javascript"></script>
    </body>
</html>
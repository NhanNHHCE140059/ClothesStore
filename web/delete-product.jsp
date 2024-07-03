<%-- 
    Document   : delete-product
    Created on : Jul 1, 2024, 9:11:39 AM
    Author     : Huenh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="service.*" %>
<%@page import="model.*" %>
<% CategoryService cateSv =  new CategoryService();%>
<html lang="en">
    <head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/create-product.css"/>
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
            <div class="card">
                <div class="card-header">Hidden Product</div>
                <div class="card-body">
                    <form action="create-product">
                        <div class="input-group form-group">
                            <label>Product name:</label>
                            <input type="text" name="" value="${product.pro_name}" class="form-control" readonly placeholder="Product name">
                        </div>
                        <div class="input-group form-group">
                            <label>Image URL:</label>
                            <input type="text" value="${product.imageURL}" class="form-control" readonly placeholder="Image URL">
                        </div>
                        <div class="input-group form-group">
                            <label>Price:</label>
                            <input type="text"  value="${product.pro_price}" class="form-control" readonly placeholder="Price">
                        </div>
                        <div class="input-group form-group">
                            <label>Description:</label>
                            <input type="text" name="" value="${product.description}" class="form-control" readonly placeholder="Description">
                        </div>
                        <div class="select">
                            <% Product prod = (Product) pageContext.findAttribute("product");
                             int cate_id = prod.getCat_id();%>
                              <input type="text" name="" value="<%= cateSv.getNameCateByIDCate(cate_id).getCat_name()%>" class="form-control" readonly placeholder="category"> 
                        </div>
                        <div class="form-group d-flex justify-content-center">
<<<<<<< HEAD
                            <input type="submit" value="Delete" class="btn-delete">
                            <a href="${pageContext.request.contextPath}/manage-product" class="back-home">Cancel</a>
=======
                            
                            <a href="/clothesstore/delete-product?idPro=${product.pro_id}&action=hidden" class="btn-delete">Hidden</a>
                            <a href="${pageContext.request.contextPath}/main-manage-product" class="back-home">Cancel</a>
>>>>>>> 438da4e (update all for managementProduct)
                        </div>
                    </form>
                </div>
            </div>
        </div>        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="./assets/js/feedbackManagement.js" type="text/javascript"></script>
    </body>
</html>

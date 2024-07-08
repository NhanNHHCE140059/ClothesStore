<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <%@page import="service.*" %>
    <%@page import="model.*" %>
    <%@page import="helper.*" %>
    <%@page import="java.util.*" %>
    <% Account account = (Account) request.getAttribute("account"); %>
    <% List<Order> listOrderS = (List<Order>) request.getAttribute("listOrderShipped"); %>
    <% Integer endPage = (Integer) request.getAttribute("endPage");%>
    <% String searchText = (String) request.getAttribute("searchText"); %>
    <% Integer indexPage =(Integer) request.getAttribute("indexPage"); %>
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
            <div class="card">
                <div class="card-header">Create New Product</div>
                <div class="card-body">
                    <form action="main-create-product" method="post"  enctype="multipart/form-data">
                        <div class="input-group form-group">
                            <label>Product name:</label>
                            <input type="text" name="name_product" value="" class="form-control" required placeholder="Product name">
                        </div>
                        <div class="input-group form-group">
                            <label>Image URL:</label>
                            <input type="file" name="img_product" id="img_product" value="" class="form-control" required placeholder="Image URL">
                            <img id="previewImage" style="display: none; width: 200px; margin-top: 10px;" />
                        </div>
                        <div class="input-group form-group">
                            <label>Price:</label>
                            <input type="text" name="pro_price" id="amount" value="" class="form-control" required placeholder="Price">
                        </div>
                        <div class="input-group form-group">
                            <label>Description:</label>
                            <input type="text" name="description" value="" class="form-control" required placeholder="Description">
                        </div>
                        <div class="select">
                            <label>Choose category name:</label>
                            <select name="category">
                                <c:forEach var="cate" items="${listcate}">
                                    <option value="${cate.cat_id}">${cate.cat_name}</option>
                                </c:forEach>
                            </select>
                        </div> 
                        <div>
                            <fieldset>
                                <legend>Product Status</legend>
                                <input type="radio" name="status" value="active"> VISIBLE<br>
                                <input type="radio" name="status" value="hidden">HIDDEN<br>
                            </fieldset> 
                        </div>
                        <div class="form-group d-flex justify-content-center">
                            <input type="submit" value="Create" class="btn-create">
                            <a href="${pageContext.request.contextPath}/main-manage-product" style="display: inline-block; margin-top: 0px; background-color: #939aa3; color: white; padding: 0 14px; padding-top: 5px; padding-bottom: 9px; text-align: center; border-radius: 5px; text-decoration: none;">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                document.getElementById('img_product').addEventListener('change', function (event) {
                    var input = event.target;
                    if (input.files && input.files[0]) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            var previewImage = document.getElementById('previewImage');
                            previewImage.src = e.target.result;
                            previewImage.style.display = 'block';
                        };
                        reader.readAsDataURL(input.files[0]);
                    }
                });


                var amountInput = document.getElementById("amount");
                amountInput.addEventListener("input", function (e) {
                    var value = e.target.value.replace(/\D/g, "");
                    var formattedValue = value.replace(/\B(?=(\d{3})+(?!\d))/g, ".");
                    if (value) {
                        e.target.value = formattedValue + " VND";
                    } else {
                        e.target.value = "";
                    }
                    setTimeout(function () {
                        var position = e.target.selectionStart;
                        var length = e.target.value.length;
                        if (position > length - 4) {
                            e.target.selectionStart = e.target.selectionEnd = length - 4;
                        }
                    }, 0);
                });
            });

        </script>
    </body>
</html>

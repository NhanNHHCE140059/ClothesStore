<%-- 
    Document   : manage-product
    Created on : Jun 30, 2024, 9:17:04 PM
    Author     : DuyNK
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

    <%@page import="model.*"%>
    <%@page import="helper.*"%>
    <%@page import="service.*" %>

    <%@page import="java.util.*"%>
    <% Account account = (Account) session.getAttribute("account"); %>
    <%ProductColorService color = new ProductColorService(); %>
    <%ProductImageService img = new ProductImageService(); %>
    <%ProductService product = new ProductService(); %>
    <%CategoryService cate = new CategoryService(); %>
    <%Integer quantity = (Integer) session.getAttribute("quantity");%>
    <% List<ProductsVariant> list = (List<ProductsVariant>) request.getAttribute("list"); %>
    <% Integer endPage = (Integer) request.getAttribute("endPage");%>
    <% String searchText = (String) request.getAttribute("searchText"); %>
    <% Integer currentPage =(Integer) request.getAttribute("currentPage"); %>
    <head>

        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/clothesstore/assets/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">


        <title>Shop Management</title>
    </head>
    <style>
        .image_product img {
            width: 20%;
            height: 20%;
        }
        .pagination-container {
            display: flex;
            position: absolute;
            bottom:40px;
            left: 0;
            right: 0;
            justify-content: center;
            margin-top: 20px;
        }

        .page-link {
            margin: 0 5px;
            padding: 8px 16px;
            text-decoration: none;
            color: #000;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .page-link:hover {
            background-color: #f0f0f0;
        }

        .page-link.active {
            background-color: #4CAF50;
            color: white;
            border: 1px solid #4CAF50;
        }
        .three-doc {
            margin-top: 18px;
        }

    </style>
    <body>
        <style>

            @keyframes blink {
                0% {
                    opacity: 1;
                }

                50% {
                    opacity: 0;
                }

                100% {
                    opacity: 1;
                }
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f8f9fa;
            }

            .sidebar {
                width: 250px;
                background-color: #2c3e50;
                color: #ecf0f1;
                height: 100vh;
                position: fixed;
                box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            }

            .sidebar-header {
                background-color: #1a252f;
                padding: 20px;
                text-align: center;
                font-size: 20px;
                font-weight: bold;
                color: #ecf0f1;
            }

            .sidebar a {
                display: block;
                color: #bdc3c7;
                padding: 15px 20px;
                text-decoration: none;
                border-left: 4px solid transparent;
                transition: all 0.3s ease;
            }

            .sidebar a:hover {
                background-color: #34495e;
                border-left: 4px solid #3498db;
                color: #ecf0f1;
            }

            .sidebar .separator {
                height: 1px;
                background-color: #34495e;
                margin: 0 20px;
            }

            .sidebar .submenu {
                display: none;
                background-color: #34495e;
            }

            .sidebar .submenu a {
                padding: 10px 35px;
                border-top: 1px solid #2c3e50;
            }

            .content {
                margin-left: 260px;
                padding: 20px;
            }

            .header {
                margin-top:12px;
                background-color: #fff;
                padding: 15px 20px;
                border-bottom: 1px solid #e9ecef;
                display: flex;
                align-items: center;
                justify-content: space-between;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .header input[type="text"] {
                padding: 10px;
                border: 1px solid #ced4da;
                border-radius: 4px;
                width: 300px;
                margin-right: 20px;
            }

            .header .role-info {
                display: flex;
                align-items: center;
                background-color: #28a745;
                color: #fff;
                padding: 10px 15px;
                border-radius: 4px;
                position: relative;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .header .role-info span {
                margin-right: 10px;
                font-weight: bold;
            }

            .header .role-info::after {
                content: '•';
                color: #fff;
                position: absolute;
                left: 4px;
                font-size: 20px;
                animation: blink 1s infinite;
            }

            .table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                background-color: #fff;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .table th,
            .table td {
                border: 1px solid #dee2e6;
                padding: 15px;
            }

            .table th {
                background-color: #f1f1f1;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.1em;
            }

            .table tr:nth-child(even) {
                background-color: #f8f9fa;
            }

            .table .action-button {
                background-color: #e74c3c;
                color: #fff;
                border: none;
                padding: 5px 10px;
                cursor: pointer;
                border-radius: 4px;
                transition: background-color 0.3s ease;
            }

            .table .action-button:hover {
                background-color: #c0392b;
            }

            .priority-low {
                background-color: #27ae60;
                color: #fff;
                padding: 5px 10px;
                border-radius: 4px;
                text-align: center;
            }

            .priority-medium {
                background-color: #f39c12;
                color: #fff;
                padding: 5px 10px;
                border-radius: 4px;
                text-align: center;
            }

            .priority-high {
                background-color: #e74c3c;
                color: #fff;
                padding: 5px 10px;
                border-radius: 4px;
                text-align: center;
            }

            .menu-item::after {
                content: '▼';
                float: right;
                margin-right: -4px;
                transition: transform 0.3s ease;
                font-size: 0.6em;
                margin-top: 6px;
            }

            .menu-item.active::after {
                transform: rotate(-180deg);
            }
            .non-action-button {
                pointer-events: none;
                opacity: 0.6;
                cursor: not-allowed;
                background-color: #e74c3c;
                color: #fff;
                border: none;
                padding: 5px 10px;
                border-radius: 4px;
                transition: background-color 0.3s ease;

            }
            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }

            .page-link {
                margin: 0 5px;
                padding: 8px 16px;
                text-decoration: none;
                color: #000;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .page-link:hover {
                background-color: #f0f0f0;
            }

            .page-link.active {
                background-color: #4CAF50;
                color: white;
                border: 1px solid #4CAF50;
            }

            .modal {
                display: block;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.5);
                padding-top: 60px;
            }

            .modal-content {
                background-color: #ffffff;
                margin: 5% auto;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
                width: 80%;
                max-width: 500px;
                text-align: center;
            }

            .modal-footer {
                display: flex;
                justify-content: center;
                gap: 20px;
                margin-top: 20px;
            }

            .modal-button {
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                background-color: #f44336;
                color: white;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s ease;
            }

            .modal-button:hover {
                background-color: #d32f2f;
            }

            .modal-button.cancel {
                background-color: #555555;
            }

            .modal-button.cancel:hover {
                background-color: #333333;
            }

            input[type=number]::-webkit-outer-spin-button,
            input[type=number]::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }

            input[type="number"] {
                font-family: Arial, sans-serif;
                font-size: 16px;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
                width: 20%;
                box-sizing: border-box;
            }
            .back-home {
                background-color: #34db86;
                color: white;
                text-align: center;
                padding: 5px 10px;
                border-radius: 5px;
                font-size: 0.9em;
                text-decoration: none;
            }

            .btn-create {
                background-color: #0492c9;
                color: white;
                text-align: center;
                padding: 5px 10px;
                border-radius: 5px;
                font-size: 0.9em;
                text-decoration: none;
            }

            .imgPro{
                height: 60%;
                width: 60%;
            }

            .pagination{
                list-style: none;
            }

            .modal {
                display: block;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.5);
                padding-top: 60px;
            }

            .modal-content {
                background-color: #ffffff;
                margin: 5% auto;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
                width: 80%;
                max-width: 500px;
                text-align: center;
            }

            .modal-footer {
                display: flex;
                justify-content: center;
                gap: 20px;
                margin-top: 20px;
            }

            .modal-button {
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                background-color: #f44336;
                color: white;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s ease;
            }

            .modal-button:hover {
                background-color: #d32f2f;
            }

            .modal-button.cancel {
                background-color: #555555;
            }

            .modal-button.cancel:hover {
                background-color: #333333;
            }

            .btn {
                display: inline-block;
                padding: 10px 20px;
                border-radius: 5px;
                font-size: 0.9em;
                text-decoration: none;
                color: white;
                margin-top: 5px;
                cursor: pointer;
                text-align: center;
                box-sizing: border-box;
                width: 100%;
            }

            .btn-update {
                background-color: #00c40d;
            }

            .btn-delete {
                background-color: #f50202;
            }

            a.btn, button.btn {
                display: inline-block;
                box-sizing: border-box;
                text-align: center;
                width: 100%;
            }

            .actions form {
                margin: 0;
                padding: 0;
                width: 100%;
            }


            .imgPro{
                width: 150px;
                height: 150px;
                box-shadow: rgba(0, 0, 0, 0.16) 0px 1px 4px, rgb(51, 51, 51) 0px 0px 0px 3px;
            }
            td {
                text-align: center;
                vertical-align: middle;
            }


            textarea:focus, input:focus{
                outline: none;
            }
            .search-container {
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .search-container .row {
                width: calc(100% - 50px); /* Trừ đi chiều rộng của nút kính lúp */
            }
            .search-container .col-6 {
                display: flex;
                flex-direction: column;
            }
            .search-container label {
                font-weight: bold;
                margin-bottom: 5px;
            }
            .search-container input[type="text"] {
                padding: 10px;
                font-size: 16px;
                border: 1px solid #ccc;
                border-radius: 4px;
                width: 100%;
            }
            .search-icon {
                font-size: 20px;
                color: #aaa;
                cursor: pointer;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                background-color: #f0f0f0;
                height: 100%;
                text-decoration: none;
            }
            .cate_Select {
                padding: 6.5px;
                font-size: 16px;
                border: 1px solid #ccc;
                border-radius: 4px;
                width: 100%;
            }
            .header {
                margin-top: 12px;
                background-color: #fff;
                padding: 15px 20px;
                border-bottom: 1px solid #e9ecef;
                display: flex;
                align-items: center;
                justify-content: flex-end;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                margin-bottom: 12px;
            }
        </style>
        <jsp:include page="/shared/_slideBar.jsp" />

        <div class="content">
            <a style="text-decoration: none;" href="${pageContext.request.contextPath}/home" class=" back-home">Back to Home</a>
            <div class="header" >

                <div class="role-info">
                    <span><%= account.getRole()%> :</span><span><%= account.getName()%></span>
                </div>
            </div>

            <a style="text-decoration: none;" href="/clothesstore/createVariants" class="btn-create">Add new product</a>
            <a style="text-decoration: none;"  href="/clothesstore/manage-product" class="btn-create">Show All</a>
            <form action="manage-product" method="get">
                <div class="container mt-3">
                    <div class="search-container">
                        <div class="row w-100">
                            <div class="col-6 mb-2">
                                <input type="hidden" name="search" value="true">
                                <label for="search1">Color:</label>
                                <input name="color_Search" value="${color_Search}" type="text" id="search1" placeholder="Tìm kiếm..." class="form-control">
                            </div>
                            <div class="col-6 mb-2">
                                <label for="search2">Size:</label>
                                <input name="size_Search" value="${size_Search}"  type="text" id="search2" placeholder="Tìm kiếm..." class="form-control">
                            </div>
                            <div class="col-6">
                                <label for="search3">Name:</label>
                                <input name="name_Search" value="${name_Search}"  type="text" id="search3" placeholder="Tìm kiếm..." class="form-control">
                            </div>
                            <div class="col-6">
                                <label for="search4">Category:</label>
                                <select class="cate_Select" name="cate_Search" value="${cate_Search}" > 
                                    <c:forEach var="cate" items="${allCate}">
                                        <option value="${cate.cat_name}" <c:if test="${cate.cat_name == cate_Search}">selected</c:if>>${cate.cat_name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <button type="submit" class="search-icon">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
            </form>
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

                    </tr>
                </thead>
                <tbody id="manage-product">
                    <c:forEach var="productVariant" items="${list}">

                        <tr>
                            <td>${productVariant.pro_id}</td>
                            <td class="imageProTd"><img class="imgPro" src="${productVariant.imageURL}"></td>
                            <td>${productVariant.pro_name}</td>
                            <td><fmt:formatNumber value="${productVariant.pro_price}" type="number" pattern="#,##0"/> VND</td>
                            <%ProductVariantInfomation p = (ProductVariantInfomation) pageContext.findAttribute("productVariant"); %>
                            <td><%=p.getDescription().length() > 30 ? p.getDescription().substring(0, 100) + "..." : p.getDescription()%></td>
                            <td>${productVariant.cat_name}</td>
                            <td>${productVariant.size_name}</td>
                            <td>${productVariant.color_name}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty list}">
                        <tr>
                            <td class="col-8">NOT FOUND</td>
                        </tr>
                    </c:if>

                </tbody>
            </table>
            <div class="col-12">
                <nav>
                    <ul class="pagination justify-content-center">
                        <%if (currentPage > 1){%>
                        <li class="page-item"><a class="page-link" href="manage-product?indexPage=${currentPage - 1}&color_Search=${color_Search}&size_Search=${size_Search}&name_Search=${name_Search}&cate_Search=${cate_Search}&search=${search}">Previous</a></li>
                            <%}%>
                            <%int pageRange = 5; 
                              int startPage = Math.max(1, currentPage - pageRange);
                              int end = Math.min(endPage, currentPage + pageRange);%>
                            <%for (int i = startPage; i <= end; i++){%>
                        <li><a class="page-link" href="manage-product?indexPage=<%=i%>&color_Search=${color_Search}&size_Search=${size_Search}&name_Search=${name_Search}&cate_Search=${cate_Search}&search=${search}"><%=i%></a></li>
                            <%}%>
                            <%if(currentPage < endPage){%>
                        <li class="page-item"><a class="page-link" href="manage-product?indexPage=${currentPage + 1}&color_Search=${color_Search}&size_Search=${size_Search}&name_Search=${name_Search}&cate_Search=${cate_Search}&search=${search}">Next</a></li>
                            <%}%>
                    </ul>
                </nav>

            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.min.js"></script>
        <script src="./assets/js/feedbackManagement.js" type="text/javascript"></script>
        <script>

            function sendGetRequest(indexPage, param = null) {
                var searchName = "";
                if (param !== null) {
                    console.log("input không trống nhé");
                    searchName = param.value.trim();
                }
                console.log("GO ajax");
                $.ajax({
                    url: "/clothesstore/manage-product",
                    type: "get",
                    data: {
                        indexPage: indexPage,
                        searchName: searchName

                    },
                    success: function (data) {
                        var row = document.getElementById("table-container");
                        row.innerHTML = data;
                    },
                    error: function (xhr) {

                    }
                });
            }
            sendGetRequest(1);

        </script>

    </body>
</html>

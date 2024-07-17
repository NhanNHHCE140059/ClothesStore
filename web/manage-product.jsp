<%-- 
    Document   : manage-product
    Created on : Jun 30, 2024, 9:17:04 PM
    Author     : DuyNK
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/manage-product.css"/>

        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            <a href="/clothesstore/create-product" class="btn-create">Add new product</a>
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
                <tbody id="manage-product">
                    <%for(ProductsVariant pv : list){
                    Product p = product.GetProById(pv.getPro_id());
                    %>
                    <tr>
                        <td><%=p.getPro_id()%></td>
                        <td><img class="imgPro" src="<%=p.getImageURL()%>"></td>
                        <td><%=p.getPro_name()%></td>
                        <td><fmt:formatNumber value="<%=p.getPro_price()%>" type="number" pattern="#,##0"/> VND</td>
                        <td><%=p.getDescription()%></td>
                        <td><%=cate.getNameCateByIDCate(p.getCat_id()).getCat_name()%></td>
                        <td><%=pv.getSize_name()%></td>
                        <td><%=color.GetProColorByID(pv.getColor_id()).getColor_name()%></td>
                        <td class="actions">
                            <a href="/clothesstore/update-product" class="btn-update">Update</a>
                            <form action="delete-product" method="post">
                                <input type="hidden" name="pro_id" value="<%=pv.getVariant_id()%>">
                                <input type="hidden" name="currentPage" value="<%=currentPage%>">
                                <button type="submit" name="action" value="delete" class="btn-delete">Delete</button>
                            </form>
                        </td>
                    </tr>
                    <%}%>
                </tbody>
            </table>
            <div class="col-12">
                <nav>
                    <ul class="pagination justify-content-center">
                        <%if (currentPage > 1){%>
                        <li class="page-item"><a class="page-link" href="manage-product?indexPage=${currentPage - 1}">Previous</a></li>
                            <%}%>
                            <%int pageRange = 5; 
                              int startPage = Math.max(1, currentPage - pageRange);
                              int end = Math.min(endPage, currentPage + pageRange);%>

            </div>
            <a syle="margin-top: 10px ;" href="${pageContext.request.contextPath}/home" class=" add-new">ADD NEW</a>
            <div class="table-container" id="table-container">
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
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody id="manage-product">

                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td><button class="btn-edit">Edit</button></td>


                        </tr>

                    </tbody>
                </table>
            </div>
            <img src="">
        </div>
        <%if(session.getAttribute("quantity") != null){%>
        <div id="myModal" class="modal">
            <div class="modal-content">
                <p>The product is in stock so that cannot be deleted. The remaining quantity is: <%=quantity%></p>
                <%session.removeAttribute("quantity");%>
                <a href="manage-product?indexPage=${currentPage}">
                    <button>OK</button>
                </a>
            </div>
        </div>
        <%}%>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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

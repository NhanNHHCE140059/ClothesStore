<%-- 
    Document   : manage-product
    Created on : Jun 30, 2024, 9:17:04 PM
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
                        <td><%=p.getDescription().length() > 30 ? p.getDescription().substring(0, 100) + "..." : p.getDescription()%></td>
                        <td><%=(cate.getNameCateByIDCate(p.getCat_id())).getCat_name()%></td>
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

                        <%for (int i = startPage; i <= end; i++){%>
                        <li><a class="page-link" href="manage-product?indexPage=<%=i%>"><%=i%></a></li>
                            <%}%>
                            <%if(currentPage < endPage){%>
                        <li class="page-item"><a class="page-link" href="manage-product?indexPage=${currentPage + 1}">Next</a></li>
                            <%}%>
                    </ul>
                </nav>
            </div>
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
    </body>
</html>

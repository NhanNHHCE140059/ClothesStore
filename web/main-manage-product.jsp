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
    <% Account account = (Account) session.getAttribute("account"); %>
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
    <style>
        .btn-create .addNew{
            margin-top:10px;
            border:none;
        }

        .search__title {
            font-size: 22px;
            font-weight: 900;
            text-align: center;
            color: #ff8b88;
        }

        .search__input {
            width: 100%;
            padding: 12px 24px;
            background-color: transparent;
            transition: transform 250ms ease-in-out;
            font-size: 14px;
            line-height: 18px;
            color: #575756;
            background-repeat: no-repeat;
            background-size: 18px 18px;
            background-position: 95% center;
            border-radius: 50px;
            border: 1px solid #575756;
            transition: all 250ms ease-in-out;
            backface-visibility: hidden;
            transform-style: preserve-3d;
        }

        .search__input::placeholder {
            color: rgba(87, 87, 86, 0.8);
            text-transform: uppercase;
            letter-spacing: 1.5px;
        }

        .search__input:hover,
        .search__input:focus {
            padding: 12px 0;
            outline: 0;
            border: 1px solid transparent;
            border-bottom: 1px solid #575756;
            border-radius: 0;
            background-position: 100% center;
        }


        .button-29 {
            align-items: center;
            appearance: none;
            background-image: radial-gradient(100% 100% at 100% 0, #5adaff 0, #5468ff 100%);
            border: 0;
            border-radius: 6px;
            box-shadow: rgba(45, 35, 66, .4) 0 2px 4px,rgba(45, 35, 66, .3) 0 7px 13px -3px,rgba(58, 65, 111, .5) 0 -3px 0 inset;
            box-sizing: border-box;
            color: #fff;
            cursor: pointer;
            display: inline-flex;
            font-family: "JetBrains Mono",monospace;
            height: 30px;
            justify-content: center;
            line-height: 1;
            list-style: none;
            overflow: hidden;
            padding-left: 16px;
            padding-right: 16px;
            position: relative;
            text-align: left;
            text-decoration: none;
            transition: box-shadow .15s,transform .15s;
            user-select: none;
            -webkit-user-select: none;
            touch-action: manipulation;
            white-space: nowrap;
            will-change: box-shadow,transform;
            font-size: 18px;
        }

        .button-29:focus {
            box-shadow: #3c4fe0 0 0 0 1.5px inset, rgba(45, 35, 66, .4) 0 2px 4px, rgba(45, 35, 66, .3) 0 7px 13px -3px, #3c4fe0 0 -3px 0 inset;
        }

        .button-29:hover {
            box-shadow: rgba(45, 35, 66, .4) 0 4px 8px, rgba(45, 35, 66, .3) 0 7px 13px -3px, #3c4fe0 0 -3px 0 inset;
            transform: translateY(-2px);
        }

        .button-29:active {
            box-shadow: #3c4fe0 0 3px 7px inset;
            transform: translateY(2px);
        }
        #notfound-row{
            text-align: center!important;
            font-size: 18px;
            font-weight: 700;
            color: #ff8b88;
            background-color: #f7cac9;
            border: 1px solid #575756;
        }
    </style>
    <body>
     <jsp:include page="/shared/_slideBar.jsp" />

        <div class="content">
            <a href="${pageContext.request.contextPath}/home" class=" back-home">Back to Home</a>
            <div class="header">
                <form method="get" action="main-manage-product">
                    <div class="search__container">
                        <input class="search__input" type="text" name="searchTxt"value="${searchTxt}"placeholder="Search by name product...">
                        <button  class="button-29" type="submit"role="button"> Search                 
                        </button>
                    </div>                

                </form>
                <div class="role-info">
                  <span><%= account.getRole()%> :</span><span><%= account.getName()%></span>
                </div>

            </div>
            <a style="margin-top: 15px;display: inline-block;background-color: greenyellow;color:black" href="/clothesstore/main-create-product" class="btn-create addNew">Add new product</a>
            <a style="margin-top: 15px;display: inline-block;background-color: lightskyblue" href="/clothesstore//main-manage-product" class="btn-create addNew">View All Product</a>
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
                            <td ><img style="width:100px;height:100px"  src="${product.imageURL}" alt="alt"/></td>
                            <td>${product.pro_name}</td>
                            <td><fmt:formatNumber value="${product.pro_price}" type="number" pattern="#,##0"/> VND</td>
                            <td><%= truncatedDescription %></td>
                            <td><%= cateSv.getNameCateByIDCate(cate_id).getCat_name()%></td>
                            <td>${product.status_product}</td>
                            <td class="actions">
                                <a href="/clothesstore/update-product?idPro=${product.pro_id}&searchTxt=${searchTxt !=null ? searchTxt : ''}&page=${currentPage}" class="btn btn-update">Update</a>

                                <form action="/clothesstore/main-manage-product" method="POST">
                                    <input type="hidden" name="idPro" value="${product.pro_id}">
                                    <input type="hidden" name="page" value="${currentPage}">
                                    <input type="hidden" name="searchTxt" value="${searchTxt !=null ? searchTxt : ''}" />
                                    <input type="hidden" name="action" value="<%= prod.getStatus_product() == ProductStatus.HIDDEN ? "visible" : "hidden" %>">
                                    <button type="submit" class="btn btn-delete">
                                        <%= prod.getStatus_product() == ProductStatus.HIDDEN ? "Visible" : "Hidden" %>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>

                </tbody>
                <c:if test="${empty listP}">
                    <tr class="notfound-row " id="notfound-row">
                        <td colspan="12">Not found products</td>
                    </tr>  
                </c:if>
            </table>
            <div class="col-12">
                <nav>
                    <ul class="pagination justify-content-center">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item"><a class="page-link" href="main-manage-product?page=${currentPage - 1}&searchTxt=${searchTxt !=null ? searchTxt : ''}">Previous</a></li>
                            </c:if>
                            <c:forEach var="i" begin="1" end="${noOfPages}">
                            <li class="page-item"><a class="page-link ${i == currentPage ? 'active' : ''}" href="main-manage-product?page=${i}&searchTxt=${searchTxt !=null ? searchTxt : ''}">${i}</a></li>
                            </c:forEach>
                            <c:if test="${currentPage < noOfPages}">
                            <li class="page-item"><a class="page-link active" href="main-manage-product?page=${currentPage + 1}&searchTxt=${searchTxt !=null ? searchTxt : ''}">Next</a></li>
                            </c:if>
                    </ul>
                </nav>
            </div>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="./assets/js/feedbackManagement.js" type="text/javascript"></script>
    </body>
</html>
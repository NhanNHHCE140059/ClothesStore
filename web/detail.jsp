<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="model.ProductImage" %>
<%@page import="model.Product" %>
<%@page import="model.*" %>
<%@page import="service.*" %>
<%@page import="model.Account" %>
<%@page import="model.OrderDetail" %>
<%@page import="java.util.*" %>
<%@page import="service.ProductImageService" %>
<%@page import="service.AccountService" %>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%List<ProductImage> imgList = (List<ProductImage>) request.getAttribute("imgList");
 Integer isCap = (Integer) request.getAttribute("isCap"); 
 List<String>sizes = (List<String>) request.getAttribute("sizes");
 Set<String>allColors = (Set<String>) request.getAttribute("allColors");
 Map<String, Set<String>> size_color = ( Map<String, Set<String>>) request.getAttribute("color_size"); 
%>
<% List<Product> list9 = (List<Product>) request.getAttribute("list9"); 
   List<OrderDetail> listFb = (List<OrderDetail>) request.getAttribute("listFeedback");
   AccountService acsv = new AccountService();
%>
<% 
    Locale localeVN = new Locale("vi", "VN");
    NumberFormat currencyVN = NumberFormat.getCurrencyInstance(localeVN);
%>
<%  ProductService productService = new ProductService();
    String sizeA = (String) request.getParameter("size");
     String colorA = (String) request.getParameter("color");
    Product productA = productService.GetProById(Integer.parseInt((String)request.getParameter("pid")));
%>



<!DOCTYPE html>
<html>
    <jsp:include page="/shared/_head.jsp" />
    <style>
        .product-detail-img-container {
            width: 100%;
            height: 520px;
            display: flex;
            padding: 0 !important;
            justify-content: space-between;
            align-items: center;
            background-color: #f8f9fa;
            box-shadow: rgba(0, 0, 0, 0.1) 0px 20px 25px -5px, rgba(0, 0, 0, 0.04) 0px 10px 10px -5px;
        }

        .product-detail-img {
            max-width: 100%;
            max-height: 100%;
            object-fit: cover;
            box-shadow: rgba(0, 0, 0, 0.1) 0px 20px 25px -5px, rgba(0, 0, 0, 0.04) 0px 10px 10px -5px;
        }

        .box {
            width: 310px;
            height: 100px;
            background-color: #ffd333;
            position: absolute;
            top: 50%;
            right: -350px; /* Start outside the screen */
            transform: translateY(-50%);
            animation: moveAndHide 5s forwards;
            z-index: 1000;
            border: 2px solid #3d464d;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            padding: 10px;
        }

        .box img {
            width: 50px;
            height: 50px;
            border-radius: 5px;
            margin-left: 10px;
        }

        .box .content {
            display: flex;
            flex-direction: column;
            justify-content: center;
            flex-grow: 1;
        }

        .box .content p {
            color: #3d464d;
            font-weight: 600;
            margin: 0;
        }

        .box .content .product-name {
            font-size: 1.2em;
        }

        .box .content .product-price {
            color: #000;
            font-size: 1.1em;
        }

        @keyframes moveAndHide {
            0% {
                right: -350px; /* Start outside the screen */
                opacity: 1;
            }
            50% {
                right: 10px; /* Fully visible */
                opacity: 1;
            }
            100% {
                right: 10px;
                opacity: 0;
            }
        }

        .faillength {
            background: red;
        }

        .thumbnail-container {
            display: flex;
            justify-content: center;
            margin: 32px 0 10px 0px;
        }

        .thumbnail {
            width: 85px;
            height: 85px;
            margin: 0 5px;
            box-shadow: rgba(0, 0, 0, 0.1) 0px 20px 25px -5px, rgba(0, 0, 0, 0.04) 0px 10px 10px -5px;
            cursor: pointer;
        }
        .thumbnail:hover {
            box-shadow: rgba(255, 211, 51, 1) 0px 0px 0px 3px;
        }

        .thumbnail img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .size-options, .color-options {
            display: flex;
            margin-bottom: 15px;
        }

        .size-options button, .color-options button {
            margin-right: 10px;
            border: 1px solid #ccc;
            padding: 5px 10px;
            cursor: pointer;
            background-color: white;
        }

        .buy-now-btn {
            background-color: #ee4d2d;
            color: #3D464D;
            margin-top: 30px;
        }

        .button-container {
            display: flex;
            flex-direction: column;
            margin-left: 20px;
        }

        .add-cart-btn, .buy-now-btn {
            height: 50px;
            line-height: 38px;
            font-size: 16px;
            font-weight: bold;
        }

        .size-options button:hover, .color-options button:hover {
            border-color: #007bff;
        }

        .size-options button.active, .color-options button.active {
            border-color: #007bff;
            background-color: #ffd333;
            color: white;
        }
        .size-options button.hintSize {
            box-shadow: #ffd333 0px 1px 4px, #ffd333 0px 0px 0px 3px;
        }

        .color-options {
            display: flex;
            margin-bottom: 15px;

        }

        .color-options button {
            margin-right: 10px;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            border: none;
            cursor: pointer;
        }

        .color-options button:hover {
            box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.3);
        }

        .color-options button.active {
            box-shadow: rgba(0, 0, 0, 0.16) 0px 1px 4px, rgb(51, 51, 51) 0px 0px 0px 3px !important;
        }
        .color-btn {
            position: relative;
            box-shadow: rgba(255, 255, 255, 0.2) 0px 0px 0px 1px inset, rgba(0, 0, 0, 0.9) 0px 0px 0px 1px;
        }

        .color-btn.active::after {
            content: "";
            position: absolute;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background-color: #79ff79;
            bottom: -17px;
            left: 10px;
            animation: blink 1s infinite;
        }
        @keyframes blink {
            0%, 100% {
                opacity: 1;
            }
            50% {
                opacity: 0;
            }
        }
        .out-of-stock-message {
            background-color: #ffe6e6;
            color: #cc0000;
            border: 1px solid #cc0000;
            padding: 0 8px 0 8px !important;
            border-radius: 5px;
            font-weight: bold;
            font-size: 16px;
            text-align: center;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .toast {
            position: fixed;
            z-index: 99999;
            width: 400px;
            top: 25px;
            right: 30px;
            border-radius: 12px;
            background: #fff;
            padding: 20px 35px 20px 25px;
            box-shadow: 0 5px 10px rgba(0,0,0,0.1);
            border-left: 6px solid #ffc107; /* Màu vàng */
            overflow: hidden;
            transform: translateX(calc(100% + 30px));
            transition: all 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.35);
            opacity: 1!important;
        }

        .toast.active {
            transform: translateX(0%);
            opacity: 1!important;
        }

        .toast .toast-content {
            display: flex;
            align-items: center;
        }

        .toast-content .check {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 35px;
            width: 35px;
            background-color: #ffc107; /* Màu vàng */
            color: #ffc107;
            font-size: 20px;
            border-radius: 50%;
        }

        .toast-content .message {
            display: flex;
            flex-direction: column;
            margin: 0 20px;
        }

        .message .text {
            font-size: 20px;
            font-weight: 400;
            color: #666666;
        }

        .message .text.text-1 {
            font-weight: 600;
            color: #333;
        }

        .toast{
            position: fixed;
            z-index: 99999;
            width:400px;
            top: 25px;
            right: 30px;
            border-radius: 12px;
            background: #fff;
            padding: 20px 35px 20px 25px;
            box-shadow: 0 5px 10px rgba(0,0,0,0.1);
            border-left: 6px solid #4070f4;
            overflow: hidden;
            transform: translateX(calc(100% + 30px));
            transition: all 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.35);
            opacity: 1!important;
        }

        .toast.active{
            transform: translateX(0%);
            opacity: 1!important;
        }

        .toast .toast-content{
            display: flex;
            align-items: center;
        }

        .toast-content .check{
            display: flex;
            align-items: center;
            justify-content: center;
            height: 35px;
            width: 35px;
            background-color: #4070f4;
            color: #fff;
            font-size: 20px;
            border-radius: 50%;
        }
        .toast.logout-toast .check {
            background-color: #ffc107;
            height: 35px;
            width: 35px;
        }
        .toast-content .message{
            display: flex;
            flex-direction: column;
            margin: 0 20px;
        }

        .message .text{
            font-size: 20px;
            font-weight: 400;
            color: #666666;
        }

        .message .text.text-1{
            font-weight: 600;
            color: #333;
        }

        .toast .close{
            position: absolute;
            top: 10px;
            right: 15px;
            padding: 5px;
            cursor: pointer;
            opacity: 0.7;
        }

        .toast .close:hover{
            opacity: 1;
        }

        .toast .progress{
            position: absolute;
            bottom: 0;
            left: 0;
            height: 3px;
            width: 100%;
            background: #ddd;
        }

        .toast .progress:before{
            content: '';
            position: absolute;
            bottom: 0;
            right: 0;
            height: 100%;
            width: 100%;
            background-color: #4070f4;
        }
        .toast-fail {
            border-left: 6px solid #dc3545 !important;
        }

        .toast-fail .check {
            background-color: #dc3545;
        }

        .toast-fail .progress:before {
            background-color: #dc3545;
        }

        .toast.logout-toast{
            border-left: 6px solid #ffc107!important;
        }
        .toast.logout-toast .progress:before {
            background-color: #ffc107;
        }
        .progress.active:before{
            animation: progress 5s linear forwards;
        }

        @keyframes progress {
            100%{
                right: 100%;
            }
        }

    </style>
    <body>
        <jsp:include page="/shared/_header.jsp" />
        <jsp:include page="/shared/_nav.jsp" />  
        <!-- Breadcrumb Start -->       
        <c:if test="${param.error == 1}">
            <div class="toast toast-fail" id="toast">
                <div class="toast-content">
                    <i class="fas fa-times-circle check"></i>
                    <div class="message" >
                        <span class="text text-1" style="font-size:18px;">ERROR!!!!</span>
                        <span class="text text-2" style="font-size:14px">CHECK THE QUANTITY AGAIN!</span>
                    </div>
                </div>
                <span class="close">&times;</span>
                <div class="progress active"></div>
            </div>

        </c:if>

        <c:if test="${param.error == 2}">      
            <div class="toast toast-fail" id="toast">
                <div class="toast-content">
                    <i class="fas fa-times-circle check"></i>
                    <div class="message" >
                        <span class="text text-1" style="font-size:18px;">ERROR!!!!</span>
                        <span class="text text-2" style="font-size:14px">This product is error re-enter please!!</span>
                    </div>
                </div>
                <span class="close">&times;</span>
                <div class="progress active"></div>
            </div>
        </c:if>

        <c:if test="${param.error == 3}">
            <div class="toast toast-fail" id="toast" style="width:550px">
                <div class="toast-content">
                    <i class="fas fa-times-circle check" style="padding:18px"></i>
                    <div class="message" >
                        <span class="text text-1" style="font-size:18px;">ERROR!!!!</span>
                        <span class="text text-2" style="font-size:14px">The number of products in the Warehouse is not enough!!!</span>
                    </div>
                </div>
                <span class="close">&times;</span>
                <div class="progress active"></div>
            </div>
        </c:if>  

        <c:if test="${param.error == 4}">
            <div class="toast toast-fail" id="toast" style="width:550px">
                <div class="toast-content">
                    <i class="fas fa-times-circle check"></i>
                    <div class="message" >
                        <span class="text text-1" style="font-size:18px;">ERROR!!!!</span>
                        <span class="text text-2" style="font-size:14px">UNKNOW ERROR!! Please add again</span>
                    </div>
                </div>
                <span class="close">&times;</span>
                <div class="progress active"></div>
            </div>
        </c:if>
        <c:if test="${param.error == 6}">
            <div class="toast toast-fail" id="toast" style="width:550px">
                <div class="toast-content">
                    <i class="fas fa-times-circle check" style="padding:18px"></i>
                    <div class="message" >
                        <span class="text text-1" style="font-size:18px;">ERROR!!!!</span>
                        <span class="text text-2" style="font-size:14px">The number of products in the Warehouse is not enough!!!</span>
                    </div>
                </div>
                <span class="close">&times;</span>
                <div class="progress active"></div>
            </div>
        </c:if>
        <c:if test="${param.error == 7}">       
            <div class="toast toast-fail" id="toast" style="width:550px">
                <div class="toast-content">
                    <i class="fas fa-times-circle check" style="padding:18px"></i>
                    <div class="message" >
                        <span class="text text-1" style="font-size:18px;">ERROR!!!!</span>
                        <span class="text text-2" style="font-size:14px">The quantity must be greater than 0</span>
                    </div>
                </div>
                <span class="close">&times;</span>
                <div class="progress active"></div>
            </div>
        </c:if>
        <c:if test="${not empty param.succes}">                      
            <div class="toast" id="toast">
                <div class="toast-content">
                    <i class="fas fa-solid fa-check check"></i>
                    <div class="message" >
                        <span class="text text-1" style="font-size:18px;">Add to cart successfully!!</span>
                        <span class="text text-2" style="font-size:14px"><%= productA.getPro_name() %> <br>(Color: <%= colorA %>, Size: <%= sizeA %>)</span>
                    </div>
                </div>
                <span class="close">&times;</span>
                <div class="progress active"></div>
            </div>
        </c:if>
        <div class="container-fluid">
            <div class="row px-xl-5">
                <div class="col-12">
                    <nav class="breadcrumb bg-light mb-30">
                        <a class="breadcrumb-item text-dark" href="/clothesstore/home">Home</a>
                        <a class="breadcrumb-item text-dark" href="/clothesstore/shop">Shop</a>
                        <span class="breadcrumb-item active">Product Detail</span>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Breadcrumb End -->


        <!-- Shop Detail Start -->
        <div class="container-fluid pb-5">
            <div class="row px-xl-5 align-items-center">
                <div class="col-lg-5 mb-4 mb-lg-0 product-detail-img-container"  style="object-fit: fill;overflow:hidden" >
                    <!-- Thumbnail Images Start -->
                    <div class="row px-xl-2">

                        <div class="col-12 text-center">
                            <%        if ( imgList!=null) {
                             for (ProductImage img :imgList){ %>
                            <div class="thumbnail-container">                       
                                <div class="thumbnail">
                                    <img src="<%= img.getImageURL()%>" alt="Thumbnail" onmouseover="changeMainImage('<%= img.getImageURL() %>')">
                                </div>
                            </div>
                            <% }}%>
                        </div>
                    </div>
                    <!-- Thumbnail Images End -->
                    <img class="product-detail-img" id="mainImage" src="${pro_detail.imageURL}" alt="Image">
                </div>
                <div class="col-lg-7">
                    <div class="bg-light p-4 rounded">
                        <h3 class="my-3">${pro_detail.pro_name}</h3>
                        <div class="d-flex mb-3">
                            <div class="text-primary mr-2">
                                <small class="fas fa-star"></small>
                                <small class="fas fa-star"></small>
                                <small class="fas fa-star"></small>
                                <small class="fas fa-star-half-alt"></small>
                                <small class="far fa-star"></small>
                            </div>
                            <small class="pt-1">(99 Reviews)</small>
                        </div>
                        <h4 class="font-weight-semi-bold mb-4 my-3">
                            <fmt:formatNumber value="${pro_detail.pro_price}" type="number" pattern="#,##0"/> VND
                        </h4>
                        <p class="mb-4">${pro_detail.description}</p>
                        <!-- Size and Color Options Start -->

                        <div class="size-options mb-4" id="sizeOptions">
                            <% if (isCap != 3 ){ %>
                            <label for="size" style="margin:6px 12px 0 0;" >Size:</label>
                            <%  
                         if (imgList.size() !=0 ) {
                                     for (String size : sizes) {
                                if (!"ALL_COLORS".equals(size)) { 
                            %>
                            <button class="size-btn" id="size_<%= size %>" data-size="<%= size %>" onclick="fetchColorsAndQuantities('<%= size %>')"><%= size %></button>
                            <% 
                                }
                            } } }
                            %>
                        </div>
                        <div class="color-options mb-4" id="colorOptions" style="max-height:30px;">
                            <label for="color" style="margin:6px 12px 0 0;">Color:</label>
                            <%                             
                             for (String color : allColors) { 
                            %>
                            <button class="color-btn" data-color="<%= color %>" style="background-color: <%= color %>;"onclick="selectColor('<%= color %>');fetchSizeAndQuantities('<%= color %>')"></button>
                            <% 
                            }
                            %>


                        </div>
                        <a href="detail?pid=${pro_detail.pro_id}" style="text-decoration: none;background-color:#ffd333 ;padding:2px 4px 2px 4px;border-radius:4px;color:#3d464d;font-weight: 500;margin-top:10px;">Click to find size by color</a>
                        <!-- Size and Color Options End -->
                        <div class="d-flex align-items-center mb-4 pt-2">
                            <div class="input-group quantity mr-3" style="width: 130px;">
                                <div class="input-group-prepend">
                                    <button class="btn btn-primary btn-minus">
                                        <i class="fa fa-minus"></i>
                                    </button>
                                </div>

                                <input id="quantityInput" type="text" class="form-control bg-secondary border-0 text-center" value="1" oninput="this.value = this.value.replace(/[^0-9]/g, '');">

                                <div class="input-group-append">
                                    <button class="btn btn-primary btn-plus">
                                        <i class="fa fa-plus"></i>
                                    </button>
                                </div>
                            </div>
                            <div id="quantity">
                                <p style="padding-left: 50px; margin-top: 22px;"><%= request.getAttribute("totalP")%> Product availability</p>
                            </div>
                            <div class="button-container">
                                <button class="btn btn-primary add-cart-btn px-5" onclick="getValuesToAdd()">
                                    <i class="fa fa-shopping-cart mr-1"></i> Add To Cart
                                </button>
                                <button id="buyNowBtn" class="btn buy-now-btn px-5" onclick="handleBuyNow()">
                                    <i class="fa fa-credit-card mr-1"></i> Buy Now
                                </button>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <style>
                .container-more {
                    display: flex;
                    justify-content: space-between;
                    padding: 20px;
                }

                .comments, .products {
                    flex: 1;
                    margin: 10px;
                    padding: 20px;
                    border: 1px solid #ccc;
                    border-radius: 8px;
                    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                }


                .comments {
                    height: 50%;
                }
                .comment {
                    display: flex;
                    align-items: center;
                    margin-bottom: 15px;
                    background-color:white;
                    border: 1px solid #ccc;
                    border-radius: 8px;
                    padding: 20px;
                    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);


                }

                .comment img {
                    width: 50px;
                    height: 50px;
                    border-radius: 50%;
                    margin-right: 15px;
                }

                .comment .name {
                    font-weight: bold;
                    margin-bottom: 10px;
                    min-width: 250px;
                    max-width: 260px;
                }
                .star {
                    margin-bottom: 10px;
                }

                .products {
                    display: flex;
                    flex-wrap: wrap;
                    gap: 20px;
                }

                .card {
                    flex: 1 1 calc(33.333% - 20px); /* Three cards per row */
                    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                    border-radius: 8px;
                    overflow: hidden;
                    transition: transform 0.2s;
                    text-decoration: none !important;
                    cursor: pointer;
                }

                .card img {
                    width: 100%;
                    height: auto;
                }

                .card-body {
                    padding: 15px;
                }

                .card-body .product-name {
                    text-decoration: none;
                    font-weight: bold;
                    margin-bottom: 10px;
                }

                .card-body .product-description {
                    text-decoration: none;
                    margin-bottom: 10px;
                }

                .card:hover {
                    transform: translateY(-5px);
                }

            </style>
            <div class="container-more">
                <!-- Comments Section -->
                <div class="comments col-lg-5">
                    <h2>Feedback Product ${pro_detail.pro_name}</h2>
                    <% if (listFb != null) {
                        for (OrderDetail orderdetail : listFb) {
                    %>
                    <% Account acc = acsv.getAccountByOrdeDetailID(orderdetail.getOrder_detail_id());%>
                    <div class="comment">
                        <img src="<%=(acc.getImage() != null) ? acc.getImage() : "https://th.bing.com/th/id/OIP.7i35GvRSp092_L3KWHr4jgHaHv?rs=1&pid=ImgDetMain"%>" alt="Avatar 1">
                        <div class="d-flex row">
                            <div class="name col-lg-4"><%=acc.getName()%></div>  
                            <div class="star text-primary col-lg-6">
                                <small class="fas fa-star"></small>
                                <small class="fas fa-star"></small>
                                <small class="fas fa-star"></small>
                                <small class="fas fa-star"></small>
                                <small class="far fa-star"></small>
                            </div>

                            <div class="text col-12"><%=orderdetail.getFeedback_details()%></div>
                        </div>
                    </div>
                    <% }} else {%>
                    <p>There is no feedback for this product, please buy it and give me feedback</p>
                    <%}%>

                </div>

                <!-- Products Section -->

                <div class="products col-lg-7 text-center">
                    <h2 class="col-md-12">You might also like</h2>
                    <div class="row justify-content-center">
                        <%         if (list9!= null ) {
                                for (Product product: list9 ) {%>

                        <a href="/clothesstore/detail?pid=<%= product.getPro_id() %>"  class="card col-md-3 mb-4 mx-2">
                            <img src="<%=product.getImageURL()%>" alt="<%=product.getPro_name()%>">
                            <div class="card-body">
                                <div class="product-name"><%=product.getPro_name()%></div>
                                <div class="product-name"> <%= currencyVN.format(product.getPro_price()) %></div>
                                <div class="product-description">"  <%
                    String description = product.getDescription();
                    String truncatedDescription = description.length() > 30 ? description.substring(0, 30) + "..." : description;
                                    %>
                                    <%= truncatedDescription %></div>
                            </div>
                        </a>  

                        <%}}%>
                    </div>
                </div>
            </div>
            <!-- Shop Detail End -->
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
            <jsp:include page="/shared/_footer.jsp" />
    </body>
    <script>
                                    document.addEventListener("DOMContentLoaded", function () {
                                        var urlParams = new URLSearchParams(window.location.search);
                                        setTimeout(function () {
                                            toast.classList.add('active');
                                        }, 100);
                                        var toast = document.getElementById('toast');
                                        setTimeout(function () {
                                            toast.classList.remove('active');
                                        }, 5000);


                                        var closeToast = document.querySelector('.toast .close');
                                        if (closeToast) {
                                            closeToast.addEventListener('click', function () {
                                                var toast = document.getElementById('toast');
                                                toast.classList.remove('active');
                                            });
                                        }

                                        var currentUrl = new URL(window.location.href);
                                        var pathname = currentUrl.pathname;
                                        var pid = currentUrl.searchParams.get('pid');
                                        var newUrl = pathname + "?pid=" + pid;
                                        window.history.pushState({}, "", newUrl);

                                    });

                                    function getUrlParameter(name) {
                                        name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
                                        var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
                                        var results = regex.exec(location.search);
                                        return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
                                    }
                                    const pro_id = getUrlParameter('pid');
                                    function changeMainImage(newSrc) {
                                        document.getElementById('mainImage').src = newSrc;
                                    }

                                    document.addEventListener('DOMContentLoaded', function () {
                                        document.getElementById('addToCartBtn').addEventListener('click', function (event) {
                                            event.preventDefault();
                                            var quantity = document.getElementById('quantityInput').value;
                                            var href = this.getAttribute('href');
                                            var newHref = href + 'quantity=' + quantity;
                                            window.location.href = newHref;
                                        });
                                    });
                                    document.querySelectorAll('.size-btn').forEach(button => {
                                        button.addEventListener('click', function () {
                                            document.querySelectorAll('.size-btn').forEach(btn => btn.classList.remove('active'));
                                            this.classList.add('active');
                                            checkAndFetchTotalPrice();
                                        });
                                    });

                                    function checkAndFetchTotalPrice() {
                                        const activeColor = document.querySelector('.color-options .color-btn.active');
                                        const activeSize = document.querySelector('.size-options .size-btn.active');

                                        if (activeColor && activeSize) {
                                            fetchTotalPrice(activeColor.getAttribute('data-color'), activeSize.getAttribute('data-size'));
                                        }
                                    }



                                    function selectColor(color) {

                                        document.querySelectorAll('.color-btn').forEach(btn => btn.classList.remove('active'));


                                        var activeButton = document.querySelector('.color-btn[data-color="' + color + '"]');
                                        if (activeButton) {
                                            activeButton.classList.add('active');

                                        }


                                        var activeSize = document.querySelector('.size-options .size-btn.active');
                                        if (activeSize) {
                                            var size = activeSize.getAttribute('data-size');
                                            checkAndFetchTotalPrice();
                                            fetchSizeAndQuantities(color, size);
                                        }
                                    }
                                    function attachClickEvents() {
                                        document.querySelectorAll('.size-btn').forEach(button => {
                                            button.addEventListener('click', function () {

                                                document.querySelectorAll('.size-btn').forEach(btn => {
                                                    btn.classList.remove('active');

                                                });
                                                this.classList.add('active');
                                                checkAndFetchTotalPrice();
                                                if (!this.classList.contains('hintSize')) {
                                                    document.querySelectorAll('.size-btn').forEach(btn => {
                                                        btn.classList.remove('hintSize');
                                                    });
                                                }
                                            });
                                        });
                                    }
                                    function fetchTotalPrice(color, size) {
                                        $.ajax({
                                            url: "/clothesstore/getQuantityBySizeAndColor",
                                            method: "get",
                                            data: {
                                                color: color,
                                                size: size,
                                                pro_id: pro_id
                                            },
                                            success: function (data) {
                                                var quantityDiv = document.getElementById("quantity");
                                                quantityDiv.innerHTML = data;
                                            },
                                            error: function (xhr) {
                                                console.error('Error fetching total price:', error);
                                            }
                                        });
                                    }
                                    function fetchColorsAndQuantities(size) {
                                        var activeColor = document.querySelector('.color-options .color-btn.active');
                                        var color = '';
                                        if (activeColor) {
                                            color = activeColor.getAttribute('data-color');
                                        }
                                        $.ajax({
                                            url: "/clothesstore/getColorBySize",
                                            type: "get",
                                            data: {
                                                pro_id: pro_id,
                                                size: size,
                                                color: color
                                            },
                                            success: function (data) {
                                                var colorOptionsDiv = document.getElementById("colorOptions");
                                                colorOptionsDiv.innerHTML = data;

                                            },
                                            error: function (xhr) {
                                                console.error("Error fetching colors and quantities");
                                            }
                                        });
                                    }
                                    function fetchSizeAndQuantities(color) {
                                        var activeSize = document.querySelector('.size-options .size-btn.active');
                                        var size = '';
                                        if (activeSize) {
                                            size = activeSize.getAttribute('data-size');
                                        }
                                        $.ajax({
                                            url: "/clothesstore/getSizeByColor",
                                            type: "get",
                                            data: {
                                                pro_id: pro_id,
                                                color_name: color,
                                                size: size
                                            },
                                            success: function (data) {
                                                var sizeOptionsDiv = document.getElementById("sizeOptions");
                                                sizeOptionsDiv.innerHTML = data;
                                                attachClickEvents();

                                            },
                                            error: function (xhr) {
                                                console.error("Error fetching colors and quantities");
                                            }
                                        });
                                    }
                                    ///func for add to cart ( Check size, color, quantity )
                                    function getValuesToAdd() {

                                        var buttonSize = document.querySelector('.size-btn.active');
                                        var buttonColor = document.querySelector('.color-btn.active');

                                        if (!buttonSize || !buttonColor) {
                                            alert("Please choose color and size!!!");
                                            return;
                                        }
                                        var size = buttonSize.getAttribute('data-size');
                                        var color = buttonColor.getAttribute('data-color');

                                        console.log(`get values to add: ${buttonSize}, ${buttonColor}, ${size}, ${color}`);
                                        var quantity = document.getElementById('quantityInput').value;
                                        if (size && color && quantity) {
                                            var url = '${pageContext.request.contextPath}/cart?action=addToCart&size=' + encodeURIComponent(size) + '&color=' + encodeURIComponent(color) + '&quantity=' + encodeURIComponent(quantity) + "&pro_id=${param.pid}";
                                            window.location.href = url;
                                        } else {
                                            alert("Vui lòng chọn kích thước, màu và nhập số lượng.");
                                        }

                                        console.log("Size: " + size + ", Color: " + color + ", Quantity: " + quantity);
                                    }

                               
                                    function handleBuyNow() {
                                        var buttonSize = document.querySelector('.size-btn.active');
                                        var buttonColor = document.querySelector('.color-btn.active');

                                        if (!buttonSize || !buttonColor) {
                                            alert("Please choose color and sizeSSSSS!!!");
                                            return;
                                        }
                                        var size = buttonSize.getAttribute('data-size');
                                        var color = buttonColor.getAttribute('data-color');
                                        var quantity = document.getElementById('quantityInput').value;

                                        if (size && color && quantity) {
                                            var url = '${pageContext.request.contextPath}/checkout?buyNow=true&size=' + encodeURIComponent(size) + '&color=' + encodeURIComponent(color) + '&quantity=' + encodeURIComponent(quantity) + "&pro_id=${param.pid}";
                                            window.location.href = url;
                                        } else {
                                            alert("Please choose color and size!!!");
                                        }
                                    }

                                
    </script>
</html>
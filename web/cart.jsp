<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<%@page import="model.*" %>
<%@page import="helper.*" %>
<html>
    <jsp:include page="/shared/_head.jsp" />
    <body>
        <style>
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
            .quantity-custom {
                border: 1px solid #ccc;
                border-radius: 4px;
                padding: 10px;
                font-size: 16px;
            }
            input[type="number"] {
                -moz-appearance: textfield;
                -webkit-appearance: none;
                appearance: none;
                border: 1px solid #ccc;
                border-radius: 4px;
                padding: 10px;
                font-size: 16px;
            }
            input[type="number"]::-webkit-inner-spin-button,
            input[type="number"]::-webkit-outer-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }
            input[type="number"]::-ms-clear {
                display: none;
            }
            th:first-child {
                width: 10px;
                padding-right: 100px;
            }
            th:not(:first-child) {
                padding-left: 10px;
            }
            table {
                border-collapse: collapse;
            }
            th, td {
                border: 1px solid black;
                padding: 8px;
                white-space: nowrap;
            }
            th {
                width: auto;
            }
            html {
                position: relative;
            }
            .cartmanagement {
                position: relative;
                height: auto;
            }
            #cartsummary {
                margin-top: 20px;
                width: 100%;
                height: 115px;
                text-align: center;
                bottom: 10px;
                background-color: #fff;
                border-top: 1px solid #ddd;
                border: 1px solid #ffd333;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                z-index: 10000;
            }
            #cartsummary .bg-light {
                padding: 15px 30px;
            }
            #cartsummary h5 {
                margin: 0;
                padding: 0 10px;
                line-height: 40px;
            }
            #cartsummary .btn {
                height: 55px;
                width: 280px;
                font-size: 18px;
                border-radius: 4px;
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
            .disabled-row {
                background-color: white;        
            }
            .disabled-row td:not(.remove-button) {
               color: #aaa;
                pointer-events: none;
                opacity: 0.5;
            }
            .disabled-row .remove-button {
                pointer-events: auto;
                opacity: 1!important;
                z-index:10!important;
                color: black;
                background-color: red;
            }
        </style>

        <jsp:include page="/shared/_header.jsp" />
        <jsp:include page="/shared/_nav.jsp" />

        <!-- Breadcrumb Start -->
        <div class="container-fluid">
            <div class="row px-xl-5">
                <div class="col-12">
                    <nav class="breadcrumb bg-light mb-30">
                        <a class="breadcrumb-item text-dark" href="/clothesstore/home">Home</a>
                        <a class="breadcrumb-item text-dark" href="/clothesstore/shop">Shop</a>
                        <span class="breadcrumb-item active">Shopping Cart</span>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Breadcrumb End -->

        <!-- Cart Start -->
        <div class="container-fluid" style="margin-bottom:-95px;">
            <div class="row px-xl-5" style="max-height: 980px;">
                <div class="col-lg-12 table-responsive mb-5 cartmanagement">
                    <table class="table table-light table-borderless table-hover text-center mb-0">
                        <thead class="thead-dark">
                            <c:if test="${empty carttop5}">
                            <div id="message1" style="display: block;">
                                <h1 class="btn btn-block btn-primary font-weight-bold my-3 py-3">There are currently no products in your shopping cart ☺</h1>
                            </div>
                        </c:if>

                        <c:if test="${not empty sessionScope.message}">
                            <c:set var="message" value="${sessionScope.message}" />
                            <div class="toast" id="toast" style="width:750px">
                                <div class="toast-content" >
                                    <i class="fas fa-solid fa-exclamation"></i>
                                    <div class="message">
                                        <span class="text text-1"> Notification!!</span>
                                        <span class="text text-2">${sessionScope.message}</span>
                                    </div>
                                </div>
                                <span class="close">&times;</span>
                                <div class="progress active"></div>                     
                                <c:remove var="message" scope="session"/>
                            </c:if>
                            <tr>
                                <th>Products</th>
                                <th></th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th>Remove</th>
                            </tr>
                            </thead>
                            <tbody class="align-middle">
                                <c:if test="${not empty cartOutStock}">
                                    <c:forEach var="cartOut" items="${cartOutStock}">
                                        <tr class="disabled-row">
                                            <td class="align-middle" style="display: flex; align-items: center;">
                                                <img src="${cartOut.imageURL}" alt="imgProduct" style="width: 100px; height: 100px; margin-right: 20px;">
                                                <div>
                                                    <span style="display: block; font-size: 18px; font-weight: bold;">${cart.pro_name}</span>
                                                    <span style="display: inline-block; padding: 2px 5px; border: 1px solid red; color: red; margin-top: 5px;">Change your mind for free for 15 days</span>
                                                    <div style="margin-top: 10px;">
                                                        <span style="background-color: orange; color: white; padding: 2px 5px; margin-right: 5px;">QUALITY</span>
                                                        <span style="background-color: green; color: white; padding: 2px 5px; margin-right: 5px;">TREND</span>
                                                        <span style="background-color: yellow; color: black; padding: 2px 5px;">SPECTACULAR</span>
                                                    </div>
                                                </div>
                                            </td>
                                            <% CartInfo cartOutInfo = (CartInfo) pageContext.findAttribute("cartOut"); %>
                                            <td class="align-middle">Product Classification <br>Color: ${cartOut.color_name}, Size: <%= ProductSizeType.values()[cartOutInfo.getSize_id()] %></td>
                                            <td class="align-middle">
                                                <fmt:formatNumber value="${cartOut.pro_price}" type="number" pattern="#,##0" /> VND
                                            </td>
                                            <td class="align-middle">
                                                <div class="input-group quantity mx-auto" style="width: 120px;">

                                                    <a href="${pageContext.request.contextPath}/cart?action=decQuan&proV_id=${cartOut.variant_id}&indexPage=${indexPage}">  <div class="input-group-btn">
                                                            <button class="btn btn-sm btn-primary btn-plus" style="height: 34px;">
                                                                <i class="fa fa-minus"></i>
                                                            </button>
                                                        </div></a>

                                                    <input id="quantityCustom_${cartOut.variant_id}" class="form-control form-control-sm bg-secondary border-0 text-center quantity-custom" style="width: 60px;" type="number" value="${cartOut.pro_quantity}" name="quantityC" onblur="handleBlur(${cartOut.variant_id})" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                                                    <a href="${pageContext.request.contextPath}/cart?action=incQuan&proV_id=${cartOut.variant_id}&indexPage=${indexPage}">  <div class="input-group-btn">
                                                            <div class="input-group-btn">

                                                                <button class="btn btn-sm btn-primary btn-plus" style="height: 34px;">
                                                                    <i class="fa fa-plus"></i>
                                                                </button>
                                                            </div>
                                                    </a>
                                                </div>
                                            </td>
                                            <td class="align-middle">
                                                <fmt:formatNumber value="${cartOut.total_price}" type="number" pattern="#,##0" /> VND
                                            </td>
                                            <td class="align-middle">
                                                <form action="cart" method="get">
                                                    <input type="hidden" name="cart_id" value="${cartOut.cart_id}">
                                                    <input type="hidden" name="indexPage" value="${indexPage}">
                                                    <button type="submit" name="action" value="delete" onclick="return confirm('Do you want to delete this cart?')" class="btn btn-sm btn-danger remove-button" style="margin-left: 2px">
                                                        <i class="fa fa-times"></i>
                                                        Remove
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                                <c:forEach var="cart" items="${carttop5}">
                                    <tr>
                                        <td class="align-middle" style="display: flex; align-items: center;">
                                            <img src="${cart.imageURL}" alt="imgProduct" style="width: 100px; height: 100px; margin-right: 20px;">
                                            <div>
                                                <span style="display: block; font-size: 18px; font-weight: bold;">${cart.pro_name}</span>
                                                <span style="display: inline-block; padding: 2px 5px; border: 1px solid red; color: red; margin-top: 5px;">Change your mind for free for 15 days</span>
                                                <div style="margin-top: 10px;">
                                                    <span style="background-color: orange; color: white; padding: 2px 5px; margin-right: 5px;">QUALITY</span>
                                                    <span style="background-color: green; color: white; padding: 2px 5px; margin-right: 5px;">TREND</span>
                                                    <span style="background-color: yellow; color: black; padding: 2px 5px;">SPECTACULAR</span>
                                                </div>
                                            </div>
                                        </td>
                                        <% CartInfo cartInfo = (CartInfo) pageContext.findAttribute("cart"); %>
                                        <td class="align-middle">Product Classification <br>Color: ${cart.color_name}, Size: <%= ProductSizeType.values()[cartInfo.getSize_id()] %></td>
                                        <td class="align-middle">
                                            <fmt:formatNumber value="${cart.pro_price}" type="number" pattern="#,##0" /> VND
                                        </td>
                                        <td class="align-middle">
                                            <div class="input-group quantity mx-auto" style="width: 120px;">

                                                <a href="${pageContext.request.contextPath}/cart?action=decQuan&proV_id=${cart.variant_id}&indexPage=${indexPage}">  <div class="input-group-btn">
                                                        <button class="btn btn-sm btn-primary btn-plus" style="height: 34px;">
                                                            <i class="fa fa-minus"></i>
                                                        </button>
                                                    </div></a>

                                                <input id="quantityCustom_${cart.variant_id}" class="form-control form-control-sm bg-secondary border-0 text-center quantity-custom" style="width: 60px;" type="number" value="${cart.pro_quantity}" name="quantityC" onblur="handleBlur(${cart.variant_id})" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                                                <a href="${pageContext.request.contextPath}/cart?action=incQuan&proV_id=${cart.variant_id}&indexPage=${indexPage}">  <div class="input-group-btn">
                                                        <div class="input-group-btn">

                                                            <button class="btn btn-sm btn-primary btn-plus" style="height: 34px;">
                                                                <i class="fa fa-plus"></i>
                                                            </button>
                                                        </div>
                                                </a>
                                            </div>
                                        </td>
                                        <td class="align-middle">
                                            <fmt:formatNumber value="${cart.total_price}" type="number" pattern="#,##0" /> VND
                                        </td>
                                        <td class="align-middle">
                                            <form action="cart" method="get">
                                                <input type="hidden" name="cart_id" value="${cart.cart_id}">
                                                <input type="hidden" name="indexPage" value="${indexPage}">
                                                <button type="submit" name="action" value="delete" onclick="return confirm('Do you want to delete this cart?')" class="btn btn-sm btn-danger" style="margin-left: 2px">
                                                    <i class="fa fa-times"></i>
                                                    Remove
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                    </table>
                    <div class="pagination" id="pagination">
                        <c:if test="${endpage != 0}">
                            <c:forEach var="i" begin="1" end="${endpage}">
                                <a href="cart?indexPage=${i}" class="page-link">${i}</a>
                            </c:forEach>
                        </c:if>
                    </div>
                    <div class="text-center mb-0" id="cartsummary">
                        <div class="bg-light p-30 mb-5">
                            <div class="pt-2">
                                <div class="d-flex justify-content-between align-items-center mt-2">
                                    <div>
                                        <span class="h1 text-uppercase text-primary bg-dark px-2">Clothes</span>
                                        <span class="h1 text-uppercase text-dark bg-primary px-2 ml-n1">Store</span>
                                    </div>

                                    <div class="d-flex">
                                        <h5 class="m-0">Total Price (${quantityProduct}):</h5> 
                                        <h5 style="font-size: 28px"><fmt:formatNumber value="${totalPrice}" type="number" pattern="#,##0" /> VND</h5>
                                    </div>
                                    <div class="d-flex flex-column align-items-end">
                                        <a href="/clothesstore/checkout" class="btn btn-primary font-weight-bold py-3 px-4">Proceed To Checkout</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Cart End -->

        <jsp:include page="/shared/_footer.jsp" />
    </body>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            showDiv();
        });
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
            var pathname = window.location.pathname;
            window.history.pushState({}, "", pathname);
        });
        function showDiv() {
            var div = document.getElementById("message");
            div.style.display = "block";
            setTimeout(function () {
                div.style.display = "none";
            }, 3000);
        }

        async function sendGetRequest(proId) {
            var inputElement = document.getElementById('quantityCustom_' + proId);
            var newQuantity = inputElement.value;



            var url = '/clothesstore/cart?action=quantityCustom&proV_id=' + proId + '&quantityC=' + newQuantity + '&indexPage=' + document.querySelector('input[name="indexPage"]').value;

            window.location.href = url;
        }

        function handleBlur(proId) {
            sendGetRequest(proId);
        }
    </script>
</html>
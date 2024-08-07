<!DOCTYPE html>
<html lang="en">
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/feedbackManagement.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Shop Management</title>
    </head>
    <body>
        <style>
            body {
                position: relative;
            }
            .error {
                color: red;
                font-weight: bold;
                margin-top: 10px;
                display: block;
            }
            .input-group {
                margin-bottom: 10px;
            }
            .remove-button {
                background-color: red;
                color: white;
                border: none;
                padding: 5px 10px;
                cursor: pointer;
            }
            .preview-image {
                display: none;
                width: 200px;
                margin-top: 10px;
            }
            .toast{
                position: absolute;
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
            }

            .toast.active{
                transform: translateX(0%);
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

            .toast-content .message{
                display: flex;
                flex-direction: column;
                margin: 0 20px;
            }

            .message .text{
                font-size: 20px;
                font-weight: 400;
                ;
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

            .progress.active:before{
                animation: progress 5s linear forwards;
            }

            @keyframes progress {
                100%{
                    right: 100%;
                }
            }
            .remove-button{
                border-radius:4px;
                margin-top:2px;
            }
            #productNameError, #priceError, #descriptionError{
                color: red;
            }

        </style>
        <jsp:include page="/shared/_slideBar.jsp" />

        <div class="toast" id="toast" style="z-index:1000000">
            <div class="toast-content">
                <i class="fas fa-solid fa-check check"></i>
                <div class="message">
                    <span class="text text-1">Success</span>
                    <span class="text text-2">Add product successfully!!!</span>
                </div>
            </div>
            <span class="close">&times;</span>
            <div class="progress active"></div>
        </div>

        <div class="content">
            <a style="margin-top:12px" href="${pageContext.request.contextPath}/home" class="back-home">Back to Home</a>
            <div class="header" style="padding: 7px 20px 15px 20px; margin-bottom:24px;justify-content: end;">

                <div style="margin-top:12px;" class="role-info">
                    <span>${sessionScope.account.role}:</span><span>${sessionScope.account.name}</span>
                </div>
            </div>
            <div class="card">
                <div class="card-header">Create New Product</div>
                <div class="card-body">
                    <form action="main-create-product" method="post" enctype="multipart/form-data">
                        <div class="input-group form-group">
                            <label>Product name:</label>
                            <input type="text" name="name_product" value="" class="form-control" required placeholder="Product name" onblur="validateProductName()">
                            <span id="productNameError" class="error-message"></span>
                            <c:if test="${param.error!=null && param.error.equals('duplicateName')}">
                                <p id="error-message" class="error text-danger">Product name already exists</p>
                            </c:if>
                        </div>
                        <div class="input-group form-group">
                            <label>Main Image Product:</label>
                            <input type="file" name="img_product" id="img_product" class="form-control" required multiple placeholder="Image URL">
                            <img id="previewImage" class="preview-image" />
                        </div>
                        <div id="additional-images"></div>
                        <button type="button" id="add-more-images" class="btn">Add More Image</button>
                        <div class="input-group form-group">
                            <label>Price:</label>
                            <input type="text" name="pro_price" id="amount" value="" class="form-control" required placeholder="Price" onblur="validatePrice()">
                            <span id="priceError" class="error-message text-danger"></span>
                        </div>
                        <div class="input-group form-group">
                            <label>Description:</label>
                            <input type="text" name="description" value="" class="form-control" required placeholder="Description" onblur="validateDescription()">
                            <span id="descriptionError" class="error-message text-danger"></span>
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
                                <input type="radio" name="status" value="active" required> VISIBLE<br>
                                <input type="radio" name="status" value="hidden" required>HIDDEN<br>
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
        <script src="./assets/js/feedbackManagement.js" type="text/javascript"></script>
        <script>
                                document.addEventListener("DOMContentLoaded", function () {
                                    var errorMessage = document.getElementById('error-message');
                                    if (errorMessage) {
                                        setTimeout(function () {
                                            errorMessage.style.display = 'none';
                                        }, 4000);
                                    }

                                    var urlParams = new URLSearchParams(window.location.search);
                                    if (urlParams.get('success') === 'true') {
                                        var toast = document.getElementById('toast');
                                        toast.classList.add('active');
                                        setTimeout(function () {
                                            toast.classList.remove('active');
                                        }, 5000);
                                    }

                                    function handleFileSelect(input, previewImageId) {
                                        input.addEventListener('change', function (event) {
                                            var inputFile = event.target;
                                            if (inputFile.files && inputFile.files[0]) {
                                                var reader = new FileReader();
                                                reader.onload = function (e) {
                                                    var previewImage = document.getElementById(previewImageId);
                                                    previewImage.src = e.target.result;
                                                    previewImage.style.display = 'block';
                                                };
                                                reader.readAsDataURL(inputFile.files[0]);
                                            }
                                        });
                                    }

                                    handleFileSelect(document.getElementById('img_product'), 'previewImage');

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

                                    var imageIndex = 0;
                                    document.getElementById('add-more-images').addEventListener('click', function () {
                                        imageIndex++;
                                        var newImageDiv = document.createElement('div');
                                        newImageDiv.classList.add('input-group', 'form-group');
                                        var previewImageId = 'previewImage_' + imageIndex;
                                        newImageDiv.innerHTML =
                                                "<label>Additional Image URL:</label>" +
                                                "<input type='file' name='img_product' class='form-control' required multiple placeholder='Image URL'>" +
                                                "<img id='" + previewImageId + "' class='preview-image' />" +
                                                "<button type='button' class='remove-button'>Remove</button>"
                                                ;
                                        document.getElementById('additional-images').appendChild(newImageDiv);

                                        handleFileSelect(newImageDiv.querySelector('input[type="file"]'), previewImageId);

                                        newImageDiv.querySelector('.remove-button').addEventListener('click', function () {
                                            newImageDiv.remove();
                                        });
                                    });

                                    var pathname = window.location.pathname;
                                    window.history.pushState({}, "", pathname);
                                });

                                function validateProductName() {
                                    const productName = document.querySelector('input[name="name_product"]');
                                    const namePattern = /^[A-Za-z ]+$/;
                                    const productNameError = document.getElementById('productNameError');

                                    if (!namePattern.test(productName.value.trim())) {
                                        productNameError.textContent = "Product name can only contain letters and spaces (at least 1 letter).";
                                        productName.value = "";
                                    } else {
                                        productNameError.textContent = "";
                                    }
                                }

                                function validatePrice() {
                                    const price = document.querySelector('input[name="pro_price"]');
                                    const priceError = document.getElementById('priceError');


                                    let priceValue = price.value.replace(" VND", "").replace(/\./g, "");


                                    priceValue = Number(priceValue);


                                    if (isNaN(priceValue) || priceValue <= 0) {
                                        priceError.textContent = "Price must be greater than zero.";
                                        price.value = "";
                                    } else {
                                        priceError.textContent = "";
                                        price.value = priceValue.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".") + " VND";
                                    }
                                }
                                function validateDescription() {
                                    const description = document.querySelector('input[name="description"]');
                                    const descriptionError = document.getElementById('descriptionError');

                                    if (description.value.trim() === "") {
                                        descriptionError.textContent = "Description cannot be empty.";
                                        description.value = "";
                                    } else {
                                        descriptionError.textContent = "";
                                    }
                                }

                                document.querySelector('input[name="name_product"]').addEventListener('blur', validateProductName);
                                document.querySelector('input[name="pro_price"]').addEventListener('blur', validatePrice);
                                document.querySelector('input[name="description"]').addEventListener('blur', validateDescription);
        </script>
    </body>
</html>

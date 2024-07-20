<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create New Product</title>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/feedbackManagement.css"/>

        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f8f9fa;

            }

            .card {
                margin: auto auto;
                width: 60%;
                background-color: #fff;
                border: 1px solid #ddd;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin-bottom: 20px;
            }

            .card-header {
                background-color: #f5f5f5;
                border-bottom: 1px solid #ddd;
                padding: 15px;
                font-size: 18px;
                font-weight: bold;
                border-top-left-radius: 8px;
                border-top-right-radius: 8px;
            }

            .card-body {
                padding: 15px;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-control {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                margin-top: 5px;
            }

            .select,
            .choose-size,
            .choose-color,
            fieldset {
                border: 1px solid #ccc;
                padding: 10px;
                border-radius: 5px;
                margin-bottom: 15px;
            }

            legend {
                font-weight: bold;
            }

            .btn-create {
                padding: 10px 20px;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-align: center;
            }

            .btn-create:hover {
                background-color: #0056b3;
            }

            .back-home {
                display: inline-block;
                margin-top: 0px;
                background-color: #939aa3;
                color: white;
                padding: 0 14px;
                padding-top: 5px;
                padding-bottom: 9px;
                text-align: center;
                border-radius: 5px;
                text-decoration: none;
            }

            .back-home:hover {
                background-color: #7a828c;
            }

            .btn-add,
            .btn-remove {
                margin-top: 10px;
                padding: 10px 20px;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .btn-add:hover,
            .btn-remove:hover {
                background-color: #0056b3;
            }

            .btn-remove {
                background-color: #dc3545;
                margin-left: 10px;
            }

            .btn-remove:hover {
                background-color: #c82333;
            }

            .image-preview {
                display: block;
                margin-top: 10px;
                max-width: 100px;
                max-height: 100px;
                border: 1px solid #ddd;
                border-radius: 5px;
            }

            .input-group input[type="file"] {
                width: 40%;
            }

            .color-box {
                display: inline-block;
                width: 20px;
                height: 20px;
                margin-right: 10px;
                border: 1px solid #ccc;
                vertical-align: middle;
                border-radius: 50%;
            }



            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Poppins', sans-serif;
            }

            .toast {
                position: fixed;
                top: 25px;
                right: 30px;
                border-radius: 12px;
                background: #fff;
                padding: 20px 35px 20px 25px;
                box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
                border-left: 6px solid #4070f4;
                overflow: hidden;
                transform: translateX(calc(100% + 30px));
                transition: all 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.35);
                z-index: 1000;
            }

            .toast.active {
                transform: translateX(0%);
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
                background-color: #4070f4;
                color: #fff;
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

            .toast .close {
                position: absolute;
                top: 10px;
                right: 15px;
                padding: 5px;
                cursor: pointer;
                opacity: 0.7;
            }

            .toast .close:hover {
                opacity: 1;
            }

            .toast .progress {
                position: absolute;
                bottom: 0;
                left: 0;
                height: 3px;
                width: 100%;
                background: #ddd;
            }

            .toast .progress:before {
                content: '';
                position: absolute;
                bottom: 0;
                right: 0;
                height: 100%;
                width: 100%;
                background-color: #4070f4;
            }

            .progress.active:before {
                animation: progress 4s linear forwards;
            }

            @keyframes progress {
                100% {
                    right: 100%;
                }
            }

            /* Style cho toast v?i class error */
            .toast.error {
                border-left-color: #f44336;
            }

            .toast.error .toast-content .check {
                background-color: #f44336;
            }

            .toast.error .progress:before {
                background-color: #f44336;
            }
            .disabled-text{
                font-size: 12px;
                color: red;
                font-weight: 100;
                margin-left: 30px;
                border-radius: 2px;
                background-color: yellow;
                padding: 2px;
            }
            .color-name {
                display: inline-block;
                min-width: 60px;
                width: 60px;
                max-width: 60px;

            }
            #error-message, #size-error-message, #size-error-message{
                background-color: #ffcccc;
                padding: 5px;
                font-weight: 600;
                border:1px solid #ff6666;
                margin-left: 10px;
                border-radius: 4px;
                display: none;
                color : #cc0000;
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

        </style>
    </head>

    <body>
        <jsp:include page="/shared/_slideBar.jsp" />
        <!--Noti-->
        <c:if test="${param.error != null && param.error == 'ColorError'}">
            <div class="toast error" id='message-noti'>
                <div class="toast-content">
                    <i class="fas fa-solid fa-check check"></i>

                    <div class="message">
                        <span class="text text-1">Error</span>
                        <span class="text text-2">Color error, please try again!!!</span>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${param.error != null && param.error == 'SizeError'}">
            <div class="toast error" id='message-noti'>
                <div class="toast-content">
                    <i class="fas fa-solid fa-check check"></i>

                    <div class="message">
                        <span class="text text-1">Error</span>
                        <span class="text text-2">Size error, please try again!!!</span>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${param.error != null && param.error == 'notFoundProduct'}">
            <div class="toast error" id='message-noti'>
                <div class="toast-content">
                    <i class="fas fa-solid fa-check check"></i>

                    <div class="message">
                        <span class="text text-1">Error</span>
                        <span class="text text-2">Product not Found, please try again!!!</span>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${param.error != null && param.error == 'cantAddImg'}">
            <div class="toast error" id='message-noti'>
                <div class="toast-content">
                    <i class="fas fa-solid fa-check check"></i>

                    <div class="message">
                        <span class="text text-1">Error</span>
                        <span class="text text-2">Image Error, please try again!!!</span>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${param.error != null && param.error == 'canAddProduct'}">
            <div class="toast error" id='message-noti'>
                <div class="toast-content">
                    <i class="fas fa-solid fa-check check"></i>

                    <div class="message">
                        <span class="text text-1">Error</span>
                        <span class="text text-2">Can't add new Variant, please try again!!!</span>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${param.Success != null && param.Success == 'added'}">
            <div class="toast" id='message-noti'>
                <div class="toast-content">
                    <i class="fas fa-solid fa-check check"></i>

                    <div class="message">
                        <span class="text text-1">Success</span>
                        <span class="text text-2">Add product variant successfully !!!</span>
                    </div>
                </div>
            </div>
        </c:if>
        <!--endNoti-->


        <div class="content">
            <a style="margin-top:12px" href="${pageContext.request.contextPath}/home" class="back-home">Back to Home</a>
            <div class="header" style="padding: 7px 20px 15px 20px; margin-bottom:24px;justify-content: end;">

                <div style="margin-top:12px;" class="role-info">
                     <span>${sessionScope.account.role}:</span><span>${sessionScope.account.name}</span>
                </div>
            </div>
            <div class="card">
                <div class="card-header">Create New Product (Variant)</div>
                <div class="card-body">
                    <form action="createVariants" method="post" enctype="multipart/form-data">
                        <div class="input-group form-group">
                            <label>Product name:</label>
                            <input required list="nameProduct" id="productInput" name="pro_Name" onchange="onInputChange(this.value);validateProductSelection()" style="padding:5px;border-radius:6px; border: 0.5px solid;overflow: hidden" placeholder="Choose one product">
                            <datalist id="nameProduct">
                                <c:forEach var="product" items="${listAllProduct}">
                                    <option value="${product.pro_name}"></option>
                                </c:forEach>
                            </datalist>
                            <p id="error-message"">Please choose one Product</p>
                        </div>
                        <div class="form-group" id="image-group">
                            <label>Image:</label>
                            <div class="input-group">
                                <input type="file" name="imageURL[]" class="form-control" multiple require onchange="previewImage(this)" required>
                                <a href="imageURL[]" data-lightbox="image" data-title="image">
                                    <img class="image-preview" style="display:none;" />
                                </a>
                            </div>
                        </div>

                        <div>
                            <div class="input-group form-group">
                                <label>Price:</label>
                                <input type="text" id="price" name="price" style="pointer-events: none;" value="" class="form-control" placeholder="Price" readonly>
                            </div>
                            <div class="input-group form-group">
                                <label>Description:</label>
                                <textarea id="description" name="description" class="form-control" placeholder="Description" style="resize: none;pointer-events: none;height: 120px;" readonly></textarea>
                            </div>
                            <div class="select">
                                <label>Category name:</label>
                                <input type="text" id="categoryName" name="categoryName" class="form-control" placeholder="Category Name" style="width:90%;pointer-events: none;" readonly>
                            </div>
                        </div>
                        <div class="choose-size">
                            <fieldset>
                                <legend>Choose Sizes</legend>
                                <c:forEach var="size" items="${allSize}" begin="1" >
                                    <input type="radio" name="size" value="${size}" style="margin-bottom:10px;" onclick="ajaxColorBySize('${size}');validateForm()" required>   ${size}<br >
                                </c:forEach>
                                <p id="size-error-message">Please choose a one size before selecting color</p>

                            </fieldset>

                        </div>
                        <div class="choose-color">
                            <fieldset>
                                <legend>Choose Colors</legend>
                                <c:forEach var="color" items="${listAllColor}">
                                    <label>
                                        <input style="margin-bottom:10px;" type="radio" name="color" value="${color.color_name}" onclick="validateForm()" required>
                                        <span class="color-box" style="background-color: ${color.color_name};"></span><span class="color-name">${color.color_name}</span>
                                    </label>
                                    <br>
                                </c:forEach>

                            </fieldset>
                        </div>
                        <div class="form-group d-flex justify-content-center">
                            <input type="submit" name="action" value="Create" value="Create" class="btn-create">
                            <a href="${pageContext.request.contextPath}/manage-product" style=" padding-top:9px;padding-bottom:10px"  class="back-home">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/js/lightbox.min.js"></script>
        <script src="./assets/js/feedbackManagement.js" type="text/javascript"></script>

        <script>
                                            function previewImage(input) {
                                                if (input.files && input.files[0]) {
                                                    var reader = new FileReader();
                                                    reader.onload = function (e) {
                                                        var preview = input.nextElementSibling.nextElementSibling;
                                                        preview.src = e.target.result;
                                                        preview.style.display = 'block';
                                                    };
                                                    reader.readAsDataURL(input.files[0]);
                                                }
                                            }

                                            document.addEventListener("DOMContentLoaded", function () {

                                                var firstFileInput = document.querySelector('.input-group input[type="file"]');
                                                var firstPreviewImage = document.querySelector('.input-group .image-preview');
                                                if (firstFileInput && firstPreviewImage) {
                                                    firstFileInput.addEventListener('change', function () {
                                                        if (this.files && this.files[0]) {
                                                            var reader = new FileReader();
                                                            reader.onload = function (e) {
                                                                firstPreviewImage.src = e.target.result;
                                                                firstPreviewImage.style.display = 'block';
                                                            };
                                                            reader.readAsDataURL(this.files[0]);
                                                        }
                                                    });
                                                }
                                            });
                                            function enableOnlyColors(enabledColors) {
                                                var inputs = document.querySelectorAll('input[name="color"]');
                                                inputs.forEach(function (input) {
                                                    var label = input.closest('label');

                                                    var existingSpan = label.querySelector('.disabled-text');
                                                    if (existingSpan) {
                                                        label.removeChild(existingSpan);
                                                    }
                                                    if (!enabledColors.includes(input.value)) {
                                                        input.disabled = true;

                                                        if (input.checked) {
                                                            input.checked = false;
                                                        }

                                                        var span = document.createElement('span');
                                                        span.classList.add('disabled-text');
                                                        span.style.color = 'red';
                                                        span.style.marginLeft = '10px';
                                                        span.textContent = 'Products with the same size and color already exist';
                                                        label.appendChild(span);
                                                    } else {
                                                        input.disabled = false;
                                                    }
                                                });
                                            }

                                            function ajaxColorBySize(size) {
                                                var name = document.getElementById('productInput').value;
                                                console.log(size, name);
                                                $.ajax({
                                                    url: "/clothesstore/createVariants",
                                                    type: "get",
                                                    data: {
                                                        size: size,
                                                        name: name

                                                    },
                                                    success: function (data) {
                                                        console.log("Data Colors: ", data.colors);
                                                        enableOnlyColors(data.colors);
                                                    },
                                                    error: function (xhr) {

                                                    }
                                                });

                                            }
                                            function onInputChange(value) {
                                                console.log("imhere");
                                                console.log(value);
                                                if (value === "") {

                                                } else {
                                                    $.ajax({
                                                        url: "/clothesstore/createVariants",
                                                        type: "get",
                                                        data: {
                                                            proName: value
                                                        },
                                                        success: function (data) {
                                                            $('#price').val(data.price);
                                                            $('#description').val(data.description);
                                                            $('#categoryName').val(data.categoryName);
                                                        },
                                                        error: function (xhr) {

                                                        }
                                                    });
                                                }
                                            }

                                            document.addEventListener("DOMContentLoaded", () => {
                                                const toast = document.querySelector(".toast"),
                                                        closeIcon = document.querySelector(".close"),
                                                        progress = document.querySelector(".progress");
                                                let timer1, timer2;
                                                if (toast) {
                                                    toast.classList.add("active");
                                                    progress.classList.add("active");

                                                    toast.style.visibility = "visible";
                                                    toast.style.opacity = "1";
                                                    progress.style.visibility = "visible";
                                                    progress.style.opacity = "1";

                                                    timer1 = setTimeout(() => {
                                                        toast.style.visibility = "hidden";
                                                        toast.style.opacity = "0";
                                                    }, 4000);

                                                    timer2 = setTimeout(() => {
                                                        progress.style.visibility = "hidden";
                                                        progress.style.opacity = "0";
                                                    }, 4300);

                                                    closeIcon.addEventListener("click", () => {
                                                        toast.style.visibility = "hidden";
                                                        toast.style.opacity = "0";
                                                        setTimeout(() => {
                                                            progress.style.visibility = "hidden";
                                                            progress.style.opacity = "0";
                                                        }, 300);
                                                        clearTimeout(timer1);
                                                        clearTimeout(timer2);
                                                    });
                                                }
                                            });
                                            document.addEventListener("DOMContentLoaded", function () {

                                                function removeQueryString() {
                                                    var currentURL = window.location.href;
                                                    var baseURL = currentURL.split("?")[0];
                                                    return baseURL;
                                                }


                                                var newURL = removeQueryString();
                                                window.history.pushState({}, "", newURL);
                                            });
                                            function hideDiv() {
                                                if (document.getElementById('message-noti')) {
                                                    document.getElementById('message-noti').style.display = 'none';
                                                }
                                            }


                                            setTimeout(hideDiv, 4000);
                                            function validateProductSelection() {
                                                var input = document.getElementById('productInput');
                                                var datalist = document.getElementById('nameProduct');
                                                var options = datalist.options;
                                                var valid = false;

                                                for (var i = 0; i < options.length; i++) {
                                                    if (input.value === options[i].value) {
                                                        valid = true;
                                                        break;
                                                    }
                                                    if (valid === false) {
                                                        var sizeSelected = document.querySelector('input[name="size"]:checked');
                                                        var colorSelected = document.querySelector('input[name="color"]:checked');
                                                        if (sizeSelected) {
                                                            sizeSelected.checked = false;
                                                            var sizeSelecteds = document.querySelectorAll('.disabled-text');
                                                            sizeSelecteds.forEach(function (sizeSelected) {
                                                                sizeSelected.style.display = 'none';
                                                            });
                                                        }
                                                        if (colorSelected) {
                                                            colorSelected.checked = false;
                                                        }
                                                        document.getElementById('price').value = '';
                                                        document.getElementById('description').value = '';
                                                        document.getElementById('categoryName').value = '';

                                                    }
                                                }

                                                if (!valid) {
                                                    document.getElementById('error-message').style.display = 'inline-block';
                                                    input.value = '';
                                                    return false;
                                                } else {
                                                    document.getElementById('error-message').style.display = 'none';
                                                    return true;
                                                }
                                            }
                                            function validateForm() {

                                                var productInput = document.getElementById('productInput').value;
                                                var sizeSelected = document.querySelector('input[name="size"]:checked');
                                                var colorSelected = document.querySelector('input[name="color"]:checked');
                                                console.log(colorSelected);
                                                if (!productInput) {
                                                    validateProductSelection();
                                                    if (sizeSelected) {
                                                        sizeSelected.checked = false;
                                                    }
                                                    if (colorSelected) {
                                                        colorSelected.checked = false;
                                                    }
                                                    return false;
                                                }

                                                if (!sizeSelected) {
                                                    if (colorSelected) {
                                                        document.getElementById('size-error-message').style.display = 'inline-block';

                                                        colorSelected.checked = false;
                                                    }
                                                    return false;
                                                } else {
                                                    document.getElementById('size-error-message').style.display = 'none';
                                                }

                                                return true;
                                            }
        </script>
    </body>

</html>

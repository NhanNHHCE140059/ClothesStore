<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Shop Management</title>
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

            .btn-create,
            .btn-update {
                padding: 10px 20px;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-align: center;
            }

            .btn-create:hover,
            .btn-update:hover {
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

            .disabled-text {
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

            #error-message, #size-error-message, #size-error-message {
                background-color: #ffcccc;
                padding: 5px;
                font-weight: 600;
                border: 1px solid #ff6666;
                margin-left: 10px;
                border-radius: 4px;
                display: none;
                color: #cc0000;
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

            .toast.error {
                border-left-color: #f44336;
            }

            .toast.error .toast-content .check {
                background-color: #f44336;
            }

            .toast.error .progress:before {
                background-color: #f44336;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/shared/_slideBar.jsp" />
        <div class="content">
            <a style="background-color:#34db86;" href="${pageContext.request.contextPath}/home" class="back-home">Back to Home</a>
            <div class="header" style="padding: 7px 20px 15px 20px; margin-bottom:24px;justify-content: end;">

                <div style="margin-top:12px;" class="role-info">
                    <span>${sessionScope.account.role}:</span><span>${sessionScope.account.name}</span>
                </div>
            </div>
            <div class="card">
                <div class="card-header">Update Product</div>
                <div class="card-body">
                    <form action="update-product" method="post" id="form-update" enctype="multipart/form-data">
                        <input name="product_id" value="${product.pro_id}" type="hidden">
                        <div class="input-group form-group" style="margin-bottom: 30px;">
                            <label>Product name:</label>
                            <input type="text" name="name_product" value="${product.pro_name}" class="form-control" required placeholder="Product name">
                        </div>

                        <label>Image Product:</label>
                        <div class="input-group form-group" style="text-align: center; margin-bottom: 30px">
                            <img style="width:30%; border:1px solid;" src="${product.imageURL}" alt="alt">
                            <br>
                        </div>
                        <div style="margin-bottom: 30px">
                            <label>New Image Product: (No require)</label>                            
                            <input type="file" name="img_product" id="img_product" class="form-control" placeholder="Image URL">
                            <img id="previewImage" style="display: none; width: 200px; margin-top: 10px;" />
                        </div>
                        <div class="input-group form-group" style="margin-bottom: 30px">
                            <label>Price:</label>
                            <input type="hidden" name="pro_price" value="${product.pro_price}">
                            <fmt:formatNumber value="${product.pro_price}" type="number" pattern="#,##0"/> VND
                            </br>
                            <div style="margin-top:10px">
                                <label>New Price:</label>
                                <input style="padding:10px; border-radius:8px;overflow:hidden;" type="text" name="newPrice" id="amount" spellcheck="false" placeholder="(No require)"/>
                            </div>
                        </div>
                        <div class="input-group form-group" style="margin-bottom: 30px">
                            <label>Description:</label>
                            <input type="text" name="description" value="${product.description}" class="form-control" required placeholder="Description">
                        </div>
                        <div class="select" style="margin-bottom: 30px">
                            <label>Choose category name:</label>
                            <select name="category">
                                <c:forEach var="cate" items="${listcate}">
                                    <option value="${cate.cat_id}" ${cate.cat_id == product.cat_id ? 'selected' : ''}>${cate.cat_name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div>                     
                        </div>
                        <div class="form-group d-flex justify-content-center">
                            <input type="submit" value="Update" class="btn-update">
                            <a href="${pageContext.request.contextPath}/main-manage-product?searchTxt=${param.searchTxt !=null ? param.searchTxt : ''}&page=${param.page}" class="back-home">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="./assets/js/feedbackManagement.js" type="text/javascript"></script>
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

<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
    <head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/feedbackManagement.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Shop Management</title>
    </head>
    <body>
        <style>
            /* feedbackManagement.css */

            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                display: flex;
            }

            .content {
                margin-left: 250px;
                padding: 20px;
                flex-grow: 1;
            }

            .header {
                display: flex;
                justify-content: flex-end;
                align-items: center;
                margin-bottom: 20px;
            }

            .role-info {
                background-color: #ecf0f1;
                color: #2c3e50;
                padding: 10px 20px;
                border-radius: 5px;
            }

            .add-category, .list-category {
                text-align: center;
                align-items: center;
                justify-content: center;
                background-color: #ecf0f1;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }

            .add-category h2, .list-category h2 {
                margin-bottom: 20px;
                color: #2c3e50;
            }

            .add-category form, .list-category form {
                display: inline-block;
            }

            .add-category label, .list-category label {
                display: block;
                margin-bottom: 5px;
                color: #2c3e50;
            }

            .add-category input, .list-category input {
                width: 100%;
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #7f8c8d;
                border-radius: 5px;
            }

            .add-category button, .list-category button {
                padding: 10px 20px;
                background-color: #2980b9;
                color: #ecf0f1;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .add-category button:hover, .list-category button:hover {
                background-color: #3498db;
            }

            .list-category {
                text-align: center;
            }

            .category-item {
                padding: 20px;
                border-bottom: 1px solid #7f8c8d;
            }

            .add-category label {
                font-weight: 600;
            }

            .highlight {
                background-color: #ffeb00;
                animation: blinki 0.1s infinite alternate;
            }

            @keyframes blinki {
                from {
                    background-color: #ffeb00;
                }
                to {
                    background-color: transparent;
                }
            }
            .duplicate{
                color:red;
                display: none;
            }
            .show {
                display: block;
            }

            .hide {
                display: none;
            }
            .toast{
                position: absolute;
                top: 25px;
                z-index:10000;
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
        </style>

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
            <a href="#" class="menu-item">Category Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="categories">Create New Category</a>   
            </div>
            <a href="#" class="menu-item">Color Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="Color">Create New Color</a>   
            </div>
        </div>
        <div class="toast" id="toast">
            <div class="toast-content">
                <i class="fas fa-solid fa-check check"></i>
                <div class="message">
                    <span class="text text-1">Success</span>
                    <span class="text text-2">Add new category susscessfully!!!</span>
                </div>
            </div>
            <span class="close">&times;</span>
            <div class="progress active"></div>
        </div>
        <div class="content">
            <a href="${pageContext.request.contextPath}/home" class="back-home">Back to Home</a>
            <div class="header">
                <div class="role-info">
                    <span>Role:</span><span></span>
                </div>
            </div>

            <div class="add-category">
                <h2>Add New Category</h2>
                <form action="categories" method="post">
                    <label for="categoryName">Category Name:</label>
                    <p class="duplicate">Category name already exists</p>
                    <input onkeydown="return /[a-z ]/i.test(event.key)" id="categoryName" name="categoryName" required>
                    <button type="submit">Submit</button>
                </form>
            </div>

            <div class="list-category">
                <h2>LIST CATEGORY</h2>
                <c:forEach var="category" items="${listCate}">
                    <div class="category-item" data-category-name="${category.cat_name}">${category.cat_name}</div>                  
                </c:forEach>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="./assets/js/feedbackManagement.js" type="text/javascript"></script>
        <script>
                        $(document).ready(function () {
                            $('form').on('submit', function (event) {
                                var inputVal = $('#categoryName').val().trim().toLowerCase();
                                var isDuplicate = false;
                                $('.category-item').each(function () {
                                    if (inputVal === $(this).data('category-name').toLowerCase()) {
                                        var el = $(this);

                                        el.addClass('highlight show');
                                        setTimeout(function () {
                                            el.removeClass('highlight');
                                        }, 1000);


                                        isDuplicate = true;
                                    }
                                });
                                if (isDuplicate) {
                                    var message = document.getElementsByClassName("duplicate")[0];
                                    message.style.display = "block";

                                    setTimeout(function () {
                                        message.style.display = "none";
                                    }, 5000);
                                    event.preventDefault();
                                }
                            });
                        });
                        var urlParams = new URLSearchParams(window.location.search);
                        if (urlParams.get('success') === 'true') {
                            var toast = document.getElementById('toast');
                            toast.classList.add('active');
                            setTimeout(function () {
                                toast.classList.remove('active');
                            }, 5000);
                        }
                        var pathname = window.location.pathname;
                        window.history.pushState({}, "", pathname);
        </script>
    </body>
</html>

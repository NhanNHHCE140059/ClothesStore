<!DOCTYPE html>
<html lang="en">
    <%@page import="model.*"%>
    <%@page import="helper.*"%>
    <%if(session.getAttribute("account")== null) {
        response.sendRedirect("login");
        return;
    }
       Account account = (Account) session.getAttribute("account");
       if ( account.getRole()!= helper.Role.Staff) {
          response.sendRedirect("home");
          return;
        }
    
    
    
    
    
    %>
    <head>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Producter Feedback Dashboard</title>
        <style>
            .table-container {
                width: 100%;
                max-width: 1500px;
                margin: 20px auto;
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
                text-align: left;
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

            .pagination-container {
                display: flex;

                justify-content: center;
                align-items: center;
                margin: 20px 0;
            }

            .page-link {
                margin: 0 5px;
                padding: 8px 16px;
                text-decoration: none;
                color: #000;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .three-doc {
                margin: 0 -10px;
                padding: 8px 16px;
                text-decoration: none;
                color: #000;
                margin-top: 2px;
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

            .col-id {
                max-width: 30px;
            }

            .col-phone {
                max-width: 160px;
            }

            .col-size {
                width: auto;
            }

            .col-color {
                width: auto;
            }

            .btn {
                padding: 10px 20px;
                font-size: 16px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                margin-left: 10px;
            }

            .btn-show-details {
                background-color: #4CAF50;
                color: white;
                float: left;
            }

            .btn-show-details:hover {
                background-color: #45a049;
            }

            .btn-show-feedback {
                background-color: #008CBA;
                color: white;
            }

            .btn-show-feedback:hover {
                background-color: #007BB5;
            }

            .header {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
            }

            .header input {
                margin-right: 10px;
                padding: 10px;
                font-size: 16px;
                border-radius: 5px;
                border: 1px solid #ccc;
                width: 250px;
            }
            .btn.active {
                background-color: #f0ad4e;
                color: white;
            }
            .role-info{
                font-weight: 600;
            }
            .disabled-btn {
                opacity: 0.5;
                pointer-events: none;
            }

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
                width: 250px;
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
                content: '.';
                color: #fff;
                position: absolute;
                left: 4px;
                bottom: 4px;
                font-size: 40px;
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
                text-align: left;
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
                content: '?';
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
                background-color: #e74c3c; /* Màu n?n gi?ng v?i nút action-button */
                color: #fff; /* Màu ch? */
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
            .three-doc {
                margin: 0 -10px;
                padding: 8px 16px;
                text-decoration: none;
                color: #000;
                margin-top: 2px;
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
                gap: 20px; /* Space between buttons */
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

            /* ??nh d?ng l?i input cho gi?ng ki?u text */
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
        </style>
    </head>
    <body>

        <div class="sidebar">
            <div class="sidebar-header">Dashboard For Staff</div>
            <a href="#" class="menu-item">Product Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="#">Create Product</a>
                <a href="#">Update Product</a>
                <a href="#">Delete Product</a>
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
                <a href="${pageContext.request.contextPath}/managementfeedback">Feedback Order</a>
                <a href="${pageContext.request.contextPath}/feedbackOrderDetails.jsp">Feedback Details</a>
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
            <a href="${pageContext.request.contextPath}/home" class="back-home">Back to Home</a>
            <div class="header">
                <input oninput="sendGetRequest(1, '', this);handleInput(this)" type="text" id="autoSubmitInput" name="searchText" placeholder="Enter product name to search...">

                <div class="role-info"><%=account.getRole()%>:      <%=account.getName()%></div>

            </div>
            <button class="btn btn-show-details" onclick="sendGetRequest(1)">Show All FeedBack Details</button>
            <button class="btn btn-show-feedback" onclick="sendGetRequest(1, 'true')">Show Feedback Exists </button>
            <div id="table-container"></div>

            <div class="pagination-container" id="pagination-container"></div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="./assets/js/feedbackManagement.js" type="text/javascript"></script>
        <script>
                function sendGetRequest(indexPage, haveFeedback, param = null) {

                    if (param !== null) {
                        var nameSearch = param.value;
                    }
                    $.ajax({
                        url: "/clothesstore/feedbackorderForStaff",
                        type: "get",
                        data: {
                            indexPage: indexPage,
                            haveFeedback: haveFeedback,
                            nameSearch: nameSearch
                        },
                        success: function (data) {
                            $('#table-container').html(data);
                        },
                        error: function (xhr) {
                            console.error(xhr);
                        }
                    });
                }

                function sendPostRequest(indexPage, haveFeedback, orderDetails_id, param = null) {


                    $.ajax({
                        url: "feedbackorderForStaff",
                        type: "post",
                        data: {
                            orderDetails_id: orderDetails_id
                        },
                        success: function () {

                            sendGetRequest(indexPage, haveFeedback, param);
                        },
                        error: function (xhr) {
                            console.error(xhr);
                        }
                    });
                }

                sendGetRequest(1);
                $(document).ready(function () {
                    $('.btn').click(function () {
                        $('.btn').removeClass('active');
                        $(this).addClass('active');
                    });
                });

                function handleInput(input) {
                    var buttons = document.querySelectorAll('.btn-show-details, .btn-show-feedback');
                    if (input.value.trim() !== "") {
                        buttons.forEach(button => {
                            $('.btn').removeClass('active');
                            button.classList.add('disabled-btn');
                        });
                    } else {
                        buttons.forEach(button => {
                            $('.btn').removeClass('active');
                            button.classList.remove('disabled-btn');
                        });
                    }
                }



        </script>
    </body>
</html>

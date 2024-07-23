<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
    <%@page import="model.Account"%>
    <%@page import="model.*"%>
    <%@page import="helper.*" %>
    <%Account account = (Account) session.getAttribute("account");
      if (account == null) {
        response.sendRedirect("login");
        return;
        }else {
        if(account.getRole()!= helper.Role.Admin){
         response.sendRedirect("home");
         return;
        }
        }
      
    %>
    <head>
        <link rel="stylesheet" href="styles.css"/>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="css/all.min.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard</title>
    </head>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            color: #3d464d;
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
            color: #ffd333;
            text-transform: uppercase;
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

        .content {
            margin-left: 260px;
            padding: 20px;

        }

        .header {
            background-color: #fff;
            padding: 15px 20px;
            border-bottom: 1px solid #e9ecef;
            display: flex;
            border-radius: 8px;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 0px 8px rgba(0, 0, 0, 0.1);
        }


        .header h2 {
            margin: 0;
            color: #2c3e50;
        }

        .header-actions {
            display: flex;
            align-items: center;
        }

        .date-time {
            margin-right: 20px;
            color: #2c3e50;
        }

        .user-info {
            display: flex;
            align-items: center;
        }

        .user-info img {
            border-radius: 50%;
            width: 40px;
            height: 40px;
            margin-right: 10px;
        }

        .filters {
            display: flex;
            justify-content: flex-start;
            align-items: center;
            margin: 20px 0;
        }

        .search-container {
            display: flex;
            align-items: center;
            margin-right: 10px;
        }

        .search-container input {
            padding: 10px;
            border: 1px solid #2c3e50;
            border-radius: 4px;
            outline: none;
            background-color: white;
            color: #2c3e50;
        }



        .filter-button {
            margin-right: 10px;
            padding: 10px 15px;
            background-color: #2c3e50;
            color: #ffd333;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .filter-button.active{
            margin-right: 10px;
            padding: 10px 15px;
            background-color: #ffd333!important ;
            color:#2c3e50 !important;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .filter-button:hover{
            margin-right: 10px;
            padding: 10px 15px;
            background-color: #ffd333!important ;
            color:#2c3e50 !important;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .filter-button:hover {
            background-color: #1a252f;
            opacity: 0.8;
        }

        .account-table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            color: #2c3e50;
        }

        .account-table th,
        .account-table td {
            padding: 15px;
            text-align: center;
            border: 1px solid #2c3e50;
        }

        .account-table th {
            background-color: #2c3e50;
            color: #ffd333;
        }

        .account-table td i {
            margin-left: 10px;
            cursor: pointer;
        }

        .table-actions {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }

        .table-actions button {
            padding: 10px 15px;
            background-color: #2c3e50;
            color: #ffd333;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .table-actions button:hover {
            background-color: #1a252f;
        }
        .activate-button,
        .deactivate-button {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .activate-button {
            background-color: #28a745;
            color: white;
            margin-left: 10px;
            padding: 10px 20px;
            text-align: center;
            line-height: 1;
            min-width: 116px;
        }

        .deactivate-button {
            background-color: #dc3545;
            color: white;
            margin-left: 10px;
        }

        .activate-button:hover,
        .deactivate-button:hover {
            opacity: 0.8;
        }

        .pagination {
            margin-top: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .page-numbers {
            display: flex;
        }

        .page-link {
            padding: 10px 15px;
            margin: 0 5px;
            background-color: #2c3e50;
            color: #ffd333;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .page-link.active {
            background-color: #ffd333;
            color: #2c3e50;
        }

        .page-link:hover {
            background-color: #ffd333;
            color: #2c3e50;
        }

        td {
            height:  50px;
            max-height: 50px;
            min-height: 50px;
        }
        .date-time{
            font-weight: 700;
        }
        .filter-button:disabled {
            background-color: #ccc;
            color: #666;
            cursor: not-allowed;
        }
        .sidebar a.logout {
            background-color: red;
            color: #fff;
            text-align: center;
            font-weight: 700;
        }

        .sidebar a.logout:hover {
            background-color: #e74c3c;
            border-left: 4px solid #c0392b;
        }
        .menu-item{
            text-align: center;
        }
    </style>
    <body onload="updateTime()">
        <div class="sidebar">
            <div class="sidebar-header">administrator</div>
            <a href="/clothesstore/statistic" class="menu-item">STATISTICAL</a>
            <a href="DisableAccountADMIN.jsp" class="menu-item" style="margin-bottom: 32px;">ACCOUNT MANAGEMENT</a>
            <a href="logout" class="menu-item logout"  >LOG OUT</a>
        </div>
        <div class="content">
            <div class="header">
                <h2>ACCOUNT MANAGEMENT</h2>
                <div class="header-actions">
                    <span class="date-time"></span>
                    <div class="user-info">
                        <img src="https://static.vecteezy.com/system/resources/previews/000/287/517/original/administration-vector-icon.jpg" alt="User Avatar">
                        <span style="text-transform: uppercase;
                              font-weight: 600;"><%= account.getName() %></span>
                    </div>
                </div>
            </div>



            <div class="filters">
                <div class="search-container">
                    <input id="searchUsernameInput" oninput="searchUsername(1,this)" type="text" placeholder="Search...">
                </div>
                <button onclick="sendAjaxRequest(1, -1);setActive(this)" class="btn filter-button showall">Show All Accounts</button>
                <button onclick="sendAjaxRequest(1, 0);setActive(this)" class="btn filter-button">Show Active Accounts</button>
                <button onclick="sendAjaxRequest(1, 1);setActive(this)"  class="btn filter-button">Show Deactivated Accounts</button>


            </div>
            <div id="content-table">
            </div>  

        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
                    sendAjaxRequest(1);
                    document.querySelectorAll('.menu-item').forEach(item => {
                        item.addEventListener('click', () => {
                            document.querySelectorAll('.menu-item').forEach(i => i.classList.remove('active'));
                            item.classList.add('active');
                        });
                    });

                    function sendAjaxRequest(indexPage, status) {
                        $.ajax({
                            url: "ajaxForAM",
                            type: "GET",
                            data: {
                                indexPage: indexPage,
                                status: status
                            },
                            success: function (data) {
                                document.getElementById('content-table').innerHTML = data;
                            },
                            error: function (xhr, status, error) {

                                console.error("AJAX request failed:", status, error);
                            }
                        });
                    }

                    function sendPostRequest(action, accID, indexPage, status, param) {
                        console.log("da vao dc sendPost");
                        $.ajax({
                            url: "ajaxForAM",
                            type: "POST",
                            data: {
                                action: action,
                                accID: accID
                            },
                            success: function () {
                                if (param === undefined) {
                                    sendAjaxRequest(indexPage, status);
                                } else {
                                    searchUsername(indexPage, param);
                                }

                            },
                            error: function (xhr, status, error) {
                                console.error("POST request failed:", status, error);
                            }
                        });
                    }
                    function setActive(button) {

                        var buttons = document.querySelectorAll('.btn');


                        buttons.forEach(function (btn) {
                            btn.classList.remove('active');
                        });


                        button.classList.add('active');
                    }
                    document.addEventListener('DOMContentLoaded', (event) => {
                        const buttons = document.querySelectorAll('.btn');
                        if (buttons.length > 0) {
                            buttons[0].classList.add('active');
                        }
                    });
                    function searchUsername(indexPage, param) {
                        activateFirstButton();
                        var Username = param.value.trim();
                        var buttons = document.querySelectorAll('.filter-button');

                        if (Username !== "") {
                            buttons.forEach(function (btn) {
                                btn.disabled = true;
                            });
                        } else {
                            buttons.forEach(function (btn) {
                                btn.disabled = false;
                            });
                        }
                        if (Username === "") {
                            sendAjaxRequest(1);
                            return;
                        }

                        $.ajax({
                            url: "ajaxForAM",
                            type: "get",
                            data: {
                                Username: Username,
                                indexPage: indexPage
                            },
                            success: function (data) {
                                document.getElementById('content-table').innerHTML = data;

                            },
                            error: function (xhr) {

                            }
                        });
                    }
                    function activateFirstButton() {
                        const buttons = document.querySelectorAll('.btn');
                        buttons.forEach(button => button.classList.remove('active'));
                        if (buttons.length > 0) {
                            buttons[0].classList.add('active');
                        }
                    }
                    function updateTime() {
                        var now = new Date();
                        var options = {
                            weekday: 'short',
                            year: 'numeric',
                            month: 'short',
                            day: 'numeric',
                            hour: '2-digit',
                            minute: '2-digit',
                            hour12: true
                        };
                        document.querySelector('.date-time').innerText = now.toLocaleString('en-US', options);
                    }
                    document.addEventListener('DOMContentLoaded', function () {
                        updateTime();
                        setInterval(updateTime, 1000);
                    });
        </script>
        <script src="dashboardStaff.js" type="text/javascript"></script>
    </body>
</html>

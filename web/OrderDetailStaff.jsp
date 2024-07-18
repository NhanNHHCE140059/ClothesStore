<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Detail Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/feedbackManagement.css" />
    <link rel="stylesheet" type="text/css" href="assets/css/orderhistory.css" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
        .section-padding-100 {
            padding: 100px 0;
            text-align: center;
        }
        table {
            margin: 0 auto;
            width: 100%;
            max-width: 1100px;
            border-collapse: collapse;
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        table th {
            background-color: #f5f7fa;
        }
        .actions {
            text-align: center;
        }
        .actions a {
            display: inline-block;
            margin: 5px;
            padding: 8px 12px;
            text-decoration: none;
            color: #000;
            background-color: #f0f0f0;
            border: 1px solid #ccc;
            border-radius: 4px;
            transition: background-color 0.3s, color 0.3s, border-color 0.3s;
        }
        .actions a:hover {
            background-color: #e0e0e0;
        }
        .actions a.cancel {
            background-color: #ff6b6b;
            color: #fff;
        }
        .actions a.confirm {
            background-color: #6ab04c;
            color: #fff;
        }
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            flex-wrap: nowrap;
        }
        .page-numbers {
            display: flex;
            flex-wrap: wrap;
        }
        .page-link {
            margin: 0 5px;
            padding: 8px 16px;
            text-decoration: none;
            color: #000;
            border: 1px solid #ccc;
            border-radius: 4px;
            transition: background-color 0.3s, color 0.3s;
        }
        .page-link:hover {
            background-color: #f0f0f0;
        }
        .page-link.active {
            background-color: #4CAF50;
            color: white;
            border: 1px solid #4CAF50;
        }
        .page-link.prev, .page-link.next {
            display: flex;
            align-items: center;
        }
        input[type=text]::-webkit-outer-spin-button,
        input[type=text]::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
        input[type="text"] {
            font-family: Arial, sans-serif;
            font-size: 16px;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 20%;
            box-sizing: border-box;
        }
        .NotFound {
            text-align: center;
            vertical-align: middle;
            height: 100px;
        }
        .order-management-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 20px;
            padding: 20px;
        }
        .search-form-container {
            flex: 1;
            max-width: 250px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #ffffff;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .search-form-container form {
            display: flex;
            flex-direction: column;
        }
        .search-form-container label {
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
            font-size: 12px;
        }
        .search-form-container input,
        .search-form-container select {
            margin-bottom: 10px;
            padding: 6px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%;
            box-sizing: border-box;
            font-size: 12px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        .search-form-container input:focus,
        .search-form-container select:focus {
            border-color: #4CAF50;
            box-shadow: 0 0 5px rgba(76, 175, 80, 0.3);
        }
        .search-form-container .button-group {
            display: flex;
            justify-content: space-between;
        }
        .search-form-container .button-group input[type="submit"],
        .search-form-container .button-group .reset-button {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 12px;
        }
        .search-form-container .button-group input[type="submit"] {
            background-color: #4CAF50;
            color: white;
        }
        .search-form-container .button-group input[type="submit"]:hover {
            background-color: #45a049;
        }
        .search-form-container .button-group .reset-button {
            background-color: #f44336;
            color: white;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        .search-form-container .button-group .reset-button:hover {
            background-color: #e53935;
        }
        .table-container {
            flex: 2;
            width: calc(100% - 270px);
        }
        .table-container table {
            width: 100%;
            max-width: 100%;
            border-collapse: collapse;
            margin: 0 auto;
        }
        .not-found-row {
            height: 200px;
        }
        .not-found-cell {
            text-align: center;
            vertical-align: middle;
            font-size: 18px;
            color: #333;
            font-weight: bold;
            border: 1px solid #ddd;
        }
        .header {
            background-color: #fff;
            margin-top: 0px !important;
            padding: 0px 15px 20px 20px;
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
            width: 300px;
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
            content: '•';
            color: #fff;
            position: absolute;
            left: 4px;
            font-size: 20px;
            animation: blink 1s infinite;
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
    <div class="content">
        <div class="header">
            <a style="margin-top:12px" href="${pageContext.request.contextPath}/home" class="back-home">Back to Home</a>
            <div style="margin-top:12px" class="role-info">
                <span>Staff :</span><span>Staff</span>
            </div>
        </div>
        <div class="section-padding-100">
            <div class="cart-title mt-50">
                <h2>Order Detail Management</h2>
            </div>
            <div class="order-management-container">
                <div class="search-form-container">
                    <h2>Search Orders</h2>
                    <form action="OrderDetailStaffControl" method="get" id="searchForm">
                        <input type="hidden" name="orderIds" value="${orderIds}">
                        <input type="hidden" name="search" value="true" >
                        <label for="NameProduct">Product Name:</label>
                        <input type="text" id="NameProduct" name="NameProduct" value="${param.NameProduct}">

                        <label for="priceFrom">Price From:</label>
                        <input type="number" id="priceFrom" name="priceFrom" value="${param.priceFrom}" step="100">

                        <label for="priceTo">Price To:</label>
                        <input type="number" id="priceTo" name="priceTo" value="${param.priceTo}" step="100">

                        <label for="orderDateFrom">Order Date From:</label>
                        <input type="date" id="orderDateFrom" name="orderDateFrom" value="${param.orderDateFrom}">

                        <label for="orderDateTo">Order Date To:</label>
                        <input type="date" id="orderDateTo" name="orderDateTo" value="${param.orderDateTo}">

                        <label for="size">Size:</label>
                        <select id="size" name="size">
                            <option value="">Select</option>
                            <c:forEach items="${sizeInBill}" var="size">
                                <option value="${size}" ${param.size == size ? 'selected' : ''}>${size}</option>
                            </c:forEach>
                        </select>

                        <label for="color">Color:</label>
                        <select id="color" name="color">
                            <option value="">Select</option>
                            <c:forEach items="${colorInBill}" var="color">
                                <option value="${color}" ${param.color == color ? 'selected' : ''}>${color}</option>
                            </c:forEach>
                        </select>

                        <div class="button-group">
                            <input type="submit" value="Search">
                            <a href="${pageContext.request.contextPath}/OrderDetailStaffControl?orderIds=${orderIds}" class="reset-button">Reset</a>
                        </div>
                    </form>
                </div>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Order Date</th>
                                <th>Product Name</th>
                                <th>Unit Price</th>
                                <th>Quantity</th>
                                <th>Color</th>
                                <th>Size</th>
                                <th>Image</th>
                                <th>Username</th>
                                <th>Account ID</th>
                                <th>Feedback</th>
                                <th>Address</th>
                                <th>Phone</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${lstof}" var="o">
                                <tr>
                                    <td class="id"><span>${o.order_id}</span></td>
                                    <td class="date"><span>${o.orderDate}</span></td>
                                    <td class="pro_name"><span>${o.pro_name}</span></td>
                                    <td class="UnitPrice"><span><fmt:formatNumber value="${o.unitPrice}" type="number" pattern="#,##0" /></span></td>
                                    <td class="Quantity"><span>${o.quantity}</span></td>
                                    <td class="color_name"><span>${o.color_name}</span></td>
                                    <td class="size_name"><span>${o.size_name}</span></td>
                                    <td class="imageURL">
                                        <span>
                                            <a href="#imageModal" data-image-url="${o.imageURL}" class="image-link"><img src="${o.imageURL}" alt="Product Image" style="width:50px;height:auto;"/></a>
                                        </span>
                                    </td>
                                    <td class="username"><span>${o.username}</span></td>
                                    <td class="acc_id"><span>${o.acc_id}</span></td>
                                    <c:choose>
                                        <c:when test="${o.shipping_status == 'SUCCESS' && o.feedback_details != null}">
                                            <td class="Feed_Back"><span>${o.feedback_details}</span></td>
                                        </c:when>
                                        <c:when test="${o.shipping_status != 'SUCCESS'}">
                                            <td class="Feed_Back"><span>Not delivered yet</span></td>
                                        </c:when>
                                        <c:when test="${o.shipping_status == 'SUCCESS' && o.feedback_details == null}">
                                            <td class="Feed_Back"><span><a href="${pageContext.request.contextPath}/OrderDetailControl?feedbackid=${o.order_detail_id}&orderId=${param.orderId}"><button>Click to feedback</button></a></span></td>
                                        </c:when>
                                    </c:choose>
                                    <td class="phone"><span>${o.phone}</span></td>
                                    <td class="addressReceive"><span>${o.addressReceive}</span></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty lstof}">
                                <tr class="not-found-row">
                                    <td class="not-found-cell" colspan="13">Not Found</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="pagination" id="pagination">
                <c:if test="${endPage != 0}">
                    <a href="#" class="page-link prev" title="Previous Page">&#9664;</a>
                    <div class="page-numbers">
                        <c:forEach var="i" begin="1" end="${endPage}">
                            <a href="OrderDetailStaffControl?indexPage=${i}&orderIds=${orderIds}&search=${search}&NameProduct=${NameProduct}&priceFrom=${priceFrom}&priceTo=${priceTo}&orderDateFrom=${orderDateFrom}&orderDateTo=${orderDateTo}&size=${size}&color=${color}" class="page-link" title="Go to page ${i}">${i}</a>
                        </c:forEach>
                    </div>
                    <a href="#" class="page-link next" title="Next Page">&#9654;</a>
                </c:if>
            </div>
        </div>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="./assets/js/feedbackManagement.js" type="text/javascript"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var pageIndex = getQueryParameter('indexPage');
            var links = document.querySelectorAll('.page-numbers .page-link');
            var prevButton = document.querySelector('.page-link.prev');
            var nextButton = document.querySelector('.page-link.next');
            var currentPage = pageIndex ? parseInt(pageIndex) : 1;
            var totalPages = links.length;
            var maxVisiblePages = 5;
            var startPage = Math.max(currentPage - Math.floor(maxVisiblePages / 2), 1);
            var endPage = Math.min(startPage + maxVisiblePages - 1, totalPages);

            function showPageNumbers() {
                links.forEach(function (link, index) {
                    var pageNum = index + 1;
                    if (pageNum >= startPage && pageNum <= endPage) {
                        link.style.display = 'inline-block';
                    } else {
                        link.style.display = 'none';
                    }
                    if (pageNum == currentPage) {
                        link.classList.add('active');
                    } else {
                        link.classList.remove('active');
                    }
                });
            }

            prevButton.addEventListener('click', function (event) {
                event.preventDefault();
                if (startPage > 1) {
                    startPage--;
                    endPage--;
                    showPageNumbers();
                }
            });

            nextButton.addEventListener('click', function (event) {
                event.preventDefault();
                if (endPage < totalPages) {
                    startPage++;
                    endPage++;
                    showPageNumbers();
                }
            });

            links.forEach(function (link) {
                link.addEventListener('click', function (event) {
                    event.preventDefault();
                    currentPage = parseInt(link.textContent);
                    startPage = Math.max(currentPage - Math.floor(maxVisiblePages / 2), 1);
                    endPage = Math.min(startPage + maxVisiblePages - 1, totalPages);
                    showPageNumbers();
                });
            });

            showPageNumbers();
        });

        function getQueryParameter(name) {
            var urlParams = new URLSearchParams(window.location.search);
            return urlParams.get(name);
        }

        function searchByUsername(param) {
            var Username = param.value.trim();
            if (Username === "") {
                location.reload();
                document.getElementById('pagination').style.display = 'flex';
                return;
            }

            document.getElementById('pagination').style.display = 'none';
            $.ajax({
                url: "/clothesstore/SearchOrderManagementController",
                type: "get",
                data: {
                    Username: Username
                },
                success: function (data) {
                    var row = document.getElementById("searchstf");
                    row.innerHTML = data;
                },
                error: function (xhr) {

                }
            });
        }
    </script>
</body>
</html>

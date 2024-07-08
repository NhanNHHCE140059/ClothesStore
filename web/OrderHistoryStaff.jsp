<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="/shared/_head.jsp" />
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

/* Định dạng lại input cho giống kiểu text */
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
        text-align: center;  /* Center the text horizontally */
        vertical-align: middle;  /* Center the text vertically */
        height: 100px;  /* Adjust the height as needed */
    }
/* Flexbox container for the search form and table */
.order-management-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    gap: 20px;
    padding: 20px;
}

.search-form-container {
    flex: 1;
    max-width: 300px; /* Adjust the width as needed */
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 8px;
    background-color: #f5f7fa;
}

.search-form-container form {
    display: flex;
    flex-direction: column;
}

.search-form-container label {
    font-weight: bold;
    margin-bottom: 5px;
}

.search-form-container input,
.search-form-container select {
    margin-bottom: 15px;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
    width: 100%;
    box-sizing: border-box;
}

.search-form-container .button-group {
    display: flex;
    justify-content: space-between;
}

.search-form-container .button-group input[type="submit"],
.search-form-container .button-group .reset-button {
    padding: 10px 15px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.search-form-container .button-group input[type="submit"] {
    background-color: #4CAF50;
    color: white;
}

.search-form-container .button-group .reset-button {
    background-color: #f44336;
    color: white;
    text-decoration: none;
    display: inline-block;
    text-align: center;
}

.search-form-container .button-group input[type="submit"]:hover {
    background-color: #45a049;
}

.search-form-container .button-group .reset-button:hover {
    background-color: #e53935;
}

.table-container {
    flex: 2;
}

.table-container table {
    width: 100%;
    max-width: 1100px;
    border-collapse: collapse;
    margin: 0 auto;
}

.table-container th,
.table-container td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: center;
}

.table-container th {
    background-color: #f5f7fa;
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
}

.page-numbers {
    display: flex;
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

.page-link.prev,
.page-link.next {
    display: flex;
    align-items: center;
}

.NotFound {
    text-align: center;
    vertical-align: middle;
    height: 100px;
}
.search-form-container {
    flex: 1;
    max-width: 250px; /* Reduced width */
    padding: 10px; /* Reduced padding */
    border: 1px solid #ddd;
    border-radius: 8px;
    background-color: #ffffff;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px; /* Add some space at the bottom */
}

.search-form-container form {
    display: flex;
    flex-direction: column;
}

.search-form-container label {
    font-weight: bold;
    margin-bottom: 5px;
    color: #333;
    font-size: 12px; /* Smaller font size */
}

.search-form-container input,
.search-form-container select {
    margin-bottom: 10px; /* Reduced margin */
    padding: 6px; /* Reduced padding */
    border: 1px solid #ccc;
    border-radius: 4px;
    width: 100%;
    box-sizing: border-box;
    font-size: 12px; /* Smaller font size */
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
    padding: 6px 12px; /* Reduced padding */
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s;
    font-size: 12px; /* Smaller font size */
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

.order-management-container {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    padding: 20px;
    justify-content: space-between; /* Align search form and table horizontally */
}

.table-container {
    flex: 2;
    width: calc(100% - 270px); /* Adjust width to accommodate search form */
}

.table-container table {
    width: 100%;
    max-width: 100%;
    border-collapse: collapse;
    margin: 0 auto;
}
            /* CSS for Not Found Row */
            .not-found-row {
                height: 200px; /* Tùy chỉnh chiều cao theo ý muốn */
            }

            .not-found-cell {
                text-align: center;
                vertical-align: middle;
                font-size: 18px;
                color: #333;
                font-weight: bold;
                border: 1px solid #ddd; /* Giữ đường viền cho ô */
            }
        </style>
    </head>
    <body>

        <jsp:include page="/shared/_header.jsp" />
        <jsp:include page="/shared/_nav.jsp" />

        <div class="section-padding-100">
            <div class="cart-title mt-50">
                <h2>Order Management</h2>
            </div>

<div class="order-management-container">
    <div class="search-form-container">
        <h2>Search Orders</h2>
        <form action="OrderSearchStaffController" method="get" id="searchForm">
            <label for="orderId">Order ID:</label>
            <input type="text" id="orderId" name="orderId" pattern="\d+" title="Order ID must be a positive number" value="${param.orderId}">

            <label for="orderDateFrom">Order Date From:</label>
            <input type="date" id="orderDateFrom" name="orderDateFrom" value="${param.orderDateFrom}">

            <label for="orderDateTo">Order Date To:</label>
            <input type="date" id="orderDateTo" name="orderDateTo" value="${param.orderDateTo}">

            <label for="orderStatus">Order Status:</label>
            <select id="orderStatus" name="orderStatus">
                <option value="">Select</option>
                <option value="SUCCESS" ${param.orderStatus == 'SUCCESS' ? 'selected' : ''}>SUCCESS</option>
                <option value="NOT_YET" ${param.orderStatus == 'NOT_YET' ? 'selected' : ''}>NOT_YET</option>
            </select>

            <label for="shippingStatus">Shipping Status:</label>
            <select id="shippingStatus" name="shippingStatus">
                <option value="">Select</option>
                <option value="SUCCESS" ${param.shippingStatus == 'SUCCESS' ? 'selected' : ''}>SUCCESS</option>
                <option value="SHIPPING" ${param.shippingStatus == 'SHIPPING' ? 'selected' : ''}>SHIPPING</option>
                <option value="NOT_YET" ${param.shippingStatus == 'NOT_YET' ? 'selected' : ''}>NOT_YET</option>
            </select>

            <label for="payStatus">Pay Status:</label>
            <select id="payStatus" name="payStatus">
                <option value="">Select</option>
                <option value="SUCCESS" ${param.payStatus == 'SUCCESS' ? 'selected' : ''}>SUCCESS</option>
                <option value="NOT_YET" ${param.payStatus == 'NOT_YET' ? 'selected' : ''}>NOT_YET</option>
            </select>

            <label for="totalPriceFrom">Total Price From:</label>
            <input type="number" id="totalPriceFrom" name="totalPriceFrom" value="${param.totalPriceFrom}">

            <label for="totalPriceTo">Total Price To:</label>
            <input type="number" id="totalPriceTo" name="totalPriceTo" value="${param.totalPriceTo}">

            <div class="button-group">
                <input type="submit" value="Search">
                <a style = "height:31px"href="${pageContext.request.contextPath}/OrderHistoryStaffControl" class="reset-button">Reset</a>
            </div>
        </form>
    </div>
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Order Date</th>
                    <th>Username</th>
                    <th>Total Price</th>
                    <th>Order Status</th>
                    <th>Pay Status</th>
                    <th>Shipping Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="searchstf">
                <c:forEach items="${lstOrder}" var="o">
                    <tr>
                        <td>${o.order_id}</td>
                        <td>${o.orderDate}</td>
                        <td>${o.username}</td>
                        <td><fmt:formatNumber value="${o.totalPrice}" type="number" pattern="#,##0" /></td>
                        <td>${o.order_status}</td>
                        <td>${o.pay_status}</td>
                        <td>${o.shipping_status}</td>
                        <td class="actions">
                            <c:if test="${not empty aaa}">
                                <a href="OrderDetailStaffControl?orderIds=${o.order_id}&orderId=${param.orderId}&orderDateFrom=${param.orderDateFrom}&orderDateTo=${param.orderDateTo}&orderStatus=${param.orderStatus}&shippingStatus=${param.shippingStatus}&payStatus=${param.payStatus}&indexPage=${param.indexPage}&feedbackid=${o.order_id}&totalPriceTo=${param.totalPriceTo}&totalPriceFrom=${param.totalPriceFrom}&search=true" class="detail" title="Detail Order ${o.order_id}">
                                    <i class="material-icons">visibility</i>
                                </a>
                            </c:if>
                            <c:if test="${empty aaa}">
                                <a href="OrderDetailStaffControl?orderIds=${o.order_id}&indexPage=${param.indexPage}" class="detail" title="Detail Order ${o.order_id}">
                                    <i class="material-icons">visibility</i>
                                </a>
                            </c:if>
<!--                            <a href="CancelOrderControl?orderId=${o.order_id}" class="cancel" title="Cancel Order ${o.order_id}">
                                <i class="material-icons">cancel</i>
                            </a>
                            <a href="ConfirmOrderControl?orderId=${o.order_id}" class="confirm" title="Confirm Order ${o.order_id}">
                                <i class="material-icons">check_circle</i>
                            </a>-->
                        </td>
                    </tr>
                </c:forEach>
                            <c:if test="${empty lstOrder}">
                            <tr class="not-found-row">
                                <td class="not-found-cell" colspan="11">Not Found</td>
                            </tr>
                        </c:if>
            </tbody>
        </table>
    </div>
              
</div>

                <c:if  test ="${not empty aaa}">
                <div class="pagination" id="pagination">
                    <c:if test="${endPage != 0}">
                        <a href="#" class="page-link prev" title="Previous Page">&#9664;</a>
                        <div class="page-numbers">
                            <c:forEach var="i" begin="1" end="${endPage}">
                                <a href="OrderSearchStaffController?orderId=${param.orderId}&orderDateFrom=${param.orderDateFrom}&orderDateTo=${param.orderDateTo}&orderStatus=${param.orderStatus}&shippingStatus=${param.shippingStatus}&payStatus=${param.payStatus}&indexPage=${i}&feedbackid=${o.order_id}&totalPriceTo=${param.totalPriceTo}&totalPriceFrom=${param.totalPriceFrom}" class="page-link" title="Go to page ${i}">${i}</a>
                            </c:forEach>
                        </div>
                        <a href="#" class="page-link next" title="Next Page">&#9654;</a>
                    </c:if>
                </div>
                                    </c:if>
 <c:if  test ="${ empty aaa}">
                                <div class="pagination" id="pagination">
                    <c:if test="${endPage != 0}">
                        <a href="#" class="page-link prev" title="Previous Page">&#9664;</a>
                        <div class="page-numbers">
                            <c:forEach var="i" begin="1" end="${endPage}">
                                <a href="OrderHistoryStaffControl?indexPage=${i}" class="page-link" title="Go to page ${i}">${i}</a>
                            </c:forEach>
                        </div>
                        <a href="#" class="page-link next" title="Next Page">&#9654;</a>
                    </c:if>
                </div>
            </div>
        </div>
           </c:if>
        <jsp:include page="/shared/_footer.jsp" />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
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
            links.forEach(function(link, index) {
                var pageNum = index + 1;
                if (pageNum >= startPage && pageNum <= endPage) {
                    link.style.display = 'inline-block';
                } else {
                    link.style.display = 'none';
                }
            });
            setActivePage(currentPage);
        }

        function setActivePage(pageIndex) {
            links.forEach(function(link) {
                link.classList.remove('active');
                if (link.textContent == pageIndex) {
                    link.classList.add('active');
                }
            });
        }

        function updatePageNumbers(direction) {
            if (direction === 'next' && endPage < totalPages) {
                startPage++;
                endPage++;
            } else if (direction === 'prev' && startPage > 1) {
                startPage--;
                endPage--;
            }
            showPageNumbers();
        }

        prevButton.addEventListener('click', function(event) {
            event.preventDefault();
            if (startPage > 1) {
                updatePageNumbers('prev');
            }
        });

        nextButton.addEventListener('click', function(event) {
            event.preventDefault();
            if (endPage < totalPages) {
                updatePageNumbers('next');
            }
        });

        links.forEach(function(link) {
            link.addEventListener('click', function() {
                currentPage = parseInt(link.textContent);
                startPage = Math.max(currentPage - Math.floor(maxVisiblePages / 2), 1);
                endPage = Math.min(startPage + maxVisiblePages - 1, totalPages);
                showPageNumbers();
                setActivePage(currentPage);
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
        type: "get", //send it through get method
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

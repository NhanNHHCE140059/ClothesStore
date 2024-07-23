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
            .order-management-container {
                display: flex;
                flex-wrap: nowrap;
                justify-content: space-between;
                gap: 20px;
                padding: 20px;
            }
            .search-form-container {
                flex: 1;
                max-width: 300px;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 8px;
                background-color: #ffffff;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
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
                height: 30.55px;
            }
            .search-form-container .button-group .reset-button:hover {
                background-color: #e53935;
            }
            .table-container {
                flex: 2;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 8px;
                background-color: #ffffff;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }
            .table-container table {
                width: 100%;
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
            /* Existing styles */
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
                width: 100%;
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
                height: 562px;
                width: calc(100% - 270px);
            }
            .table-container table {
                width: 100%;
                max-width: 100%;
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
        </style>

    </head>
    <body>

        <jsp:include page="/shared/_header.jsp" />
        <jsp:include page="/shared/_nav.jsp" />
        <!-- Header Area -->

        <div class="section-padding-100">
            <div class="order-management-container">
                <div class="search-form-container">
                    <h2>Search Orders</h2>
                    <form action="OrderDetailControl" method="get" id="searchForm">
                        <input type="hidden" name="orderId" value="${orderIds}">
                        <input type="hidden" name="search" value="true">
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
                            <a href="${pageContext.request.contextPath}/OrderDetailControl?orderId=${orderIds}" class="reset-button">Reset</a>
                        </div>
                    </form>
                </div>

                <div class="table-container">
                    <div class="cart-title mt-50">
                        <h2>Order Detail</h2>
                    </div>
                    <div>
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
                                    <th>Feedback</th>
                                    <th>Address</th>
                                    <th>Phone</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${prvlst}" var="o">
                                    <tr>
                                        <td class="id"><span>${o.order_id}</span></td>
                                        <td class="date"><span>${o.orderDate}</span></td>
                                        <td class="pro_name"><span>${o.pro_name}</span></td>
                                        <td class="UnitPrice"><span><fmt:formatNumber value="${o.unitPrice}" type="number" pattern="#,##0" /></span></td>
                                        <td class="Quantity"><span>${o.quantity}</span></td>
                                        <td class="color_name"><span>${o.color_name}</span></td>
                                        <td class="size_name"><span>${o.size_name}</span></td>
                                        <td class="imageURL"><span><img src="${o.imageURL}" alt="Product Image" style="width:50px;height:auto;"/></span></td>

                                        <c:choose>
                                            <c:when test = "${o.shipping_status=='SUCCESS'&&o.feedback_details!= null}">
                                                <td class="Feed_Back"><span>${o.feedback_details}</span></td>
                                                    </c:when>   
                                                    <c:when test = "${o.shipping_status!='SUCCESS'}">
                                                <td class="Feed_Back"><span>Feedback After Received</span></td>

                                            </c:when>
                                            <c:when test = "${o.shipping_status=='SUCCESS'&& o.feedback_details == null }">
                                                <td class="Feed_Back"><span><a href="${pageContext.request.contextPath}/OrderDetailControl?feedbackid=${o.order_detail_id}&indexPage=${param.indexPage}&orderId=${orderIds}&search=${search}&NameProduct=${nameProduct}&priceFrom=${priceFrom}&priceTo=${priceTo}&orderDateFrom=${orderDateFrom}&orderDateTo=${orderDateTo}&size=${size}&color=${color}"><button>Click to feedback</button></a></span></td>
                                                <!--                                        <td class="Feed_Back"><span>chua đc giao hang nên ch đc fb</span></td>-->
                                            </c:when>
                                        </c:choose>

                                        <td class="addressReceive"><span>${o.addressReceive}</span></td>
                                        <td class="phone"><span>${o.phone}</span></td>
                                    </tr>
                                </c:forEach>
                                              <c:if test="${empty prvlst}">
                                <tr class="not-found-row">
                                    <td class="not-found-cell" colspan="13">Not Found</td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                        <c:if test="${empty aaa}">
                            <div class="pagination" id="pagination">
                                <c:if test="${endPage != 0}">
                                    <a href="#" class="page-link prev" title="Previous Page">&#9664;</a>
                                    <div class="page-numbers">
                                        <c:forEach var="i" begin="1" end="${endPage}">
                                            <a href="OrderDetailControl?indexPage=${i}&orderId=${orderIds}&search=${search}&NameProduct=${nameProduct}&priceFrom=${priceFrom}&priceTo=${priceTo}&orderDateFrom=${orderDateFrom}&orderDateTo=${orderDateTo}&size=${size}&color=${color}" class="page-link" title="Go to page ${i}">${i}</a>
                                        </c:forEach>
                                    </div>
                                    <a href="#" class="page-link next" title="Next Page">&#9654;</a>
                                </c:if>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <c:if test = "${not empty order_detail_id }">
            <div id="myModal" class="modal" >

                <form action="OrderDetailControl" method="post">
                    <input type="hidden"  name="NameProduct" value="${nameProduct}">
                    <input type="hidden" name="priceFrom" value="${priceFrom}">
                    <input type="hidden" name="priceTo" value="${priceTo}">
                    <input type="hidden" name="orderDateFrom" value="${orderDateFrom}">
                    <input type="hidden" name="orderDateTo" value="${orderDateTo}">
                    <input type="hidden" name="size" value="${size}">
                    <input type="hidden" name="color" value="${color}">
                    <input type="hidden" name="search" value="${search}">


                    <input type = "hidden" name ="indexPage" value="${indexPage}">
                    <input name="order_detail_id" value="${order_detail_id}" type="hidden">
                    <input name="orderId" value="${param.orderId}" type="hidden">
                    <div class="modal-content">
                        <p>DO YOU WANT TO FEEDBACK  <span id="feedbackId"></span>${nameProduct}</p>
                        <input type="text" id="feedbackInput" name="feedback" placeholder="Enter your feedback here">
                        <div class="modal-footer">
                            <button type="submit" class="modal-button" id="submitFeedback">Submit Feedback</button>
                            <a href="${pageContext.request.contextPath}/OrderDetailControl?indexPage=${param.indexPage}&orderId=${orderIds}&search=${search}&NameProduct=${nameProduct}&priceFrom=${priceFrom}&priceTo=${priceTo}&orderDateFrom=${orderDateFrom}&orderDateTo=${orderDateTo}&size=${size}&color=${color}" class="modal-button cancel">Cancel</a>
                        </div>
                    </div>
                </form>
            </div>
        </c:if>


        <!-- Footer Area -->

        <jsp:include page="/shared/_footer.jsp" />

        <!-- End of Footer Area -->
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
                    });
                    setActivePage(currentPage);
                }

                function setActivePage(pageIndex) {
                    links.forEach(function (link) {
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

                prevButton.addEventListener('click', function (event) {
                    event.preventDefault();
                    if (startPage > 1) {
                        updatePageNumbers('prev');
                    }
                });

                nextButton.addEventListener('click', function (event) {
                    event.preventDefault();
                    if (endPage < totalPages) {
                        updatePageNumbers('next');
                    }
                });

                links.forEach(function (link) {
                    link.addEventListener('click', function () {
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



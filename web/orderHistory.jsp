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
            /* Container tổng để căn giữa nội dung */
            .section-padding-100 {
                padding: 100px 0;
                display: flex;
                justify-content: center;
                align-items: flex-start; /* Căn chỉnh các phần tử con lên trên */
                gap: 20px; /* Khoảng cách giữa form và bảng */
            }

            /* CSS cho form Search Orders */
            .search-orders-container {
                width: 300px;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                background-color: #f9f9f9;
                text-align: left; /* Căn chỉnh văn bản sang trái */
            }

            .search-orders-container label {
                display: block;
                margin-bottom: 8px;
                font-weight: bold;
                color: #333;
            }

            .search-orders-container input[type="text"],
            .search-orders-container input[type="date"],
            .search-orders-container select {
                width: 100%;
                padding: 8px;
                margin-bottom: 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }

            .search-orders-container input[type="submit"] {
                width: 100%;
                padding: 10px 0;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s ease;
            }

            .search-orders-container input[type="submit"]:hover {
                background-color: #45a049;
            }

            /* CSS cho bảng Order History */
            table {
                width: 100%;
                max-width: 1100px;
                margin: 0 auto;
                border-collapse: collapse;
                text-align: center;
            }

            th, td {
                padding: 10px;
                border: 1px solid #ddd;
            }

            th {
                background-color: #f5f7fa;
                font-weight: bold;
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tr:hover {
                background-color: #f1f1f1;
            }

            .actions a.cancel {
                background-color: #ff6b6b;
                color: #fff;
            }

            .actions a.confirm {
                background-color: #6ab04c;
                color: #fff;
            }

            /* CSS cho phân trang */
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

            /* CSS cho modal */
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
                gap: 20px;
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
   /* CSS cho form Search Orders */

.search-orders-container {
    width: 300px;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    background-color: #f9f9f9;
    text-align: left; /* Căn chỉnh văn bản sang trái */
}

.search-orders-container label {
    display: block;
    margin-bottom: 8px;
    font-weight: bold;
    color: #333;
}

.search-orders-container input[type="text"],
.search-orders-container input[type="date"],
.search-orders-container select {
    width: 100%;
    padding: 8px;
    margin-bottom: 12px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

.search-orders-container .button-group {
    display: flex;
    gap: 10px;
}

.search-orders-container input[type="submit"],
.search-orders-container .reset-button {
    flex: 1;
    padding: 10px 0;
    font-size: 16px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    text-align: center;
}

.search-orders-container input[type="submit"] {
    background-color: #4CAF50;
    color: white;
}

.search-orders-container input[type="submit"]:hover {
    background-color: #45a049;
}

.search-orders-container .reset-button {
    background-color: #ccc;
    color: #333;
    text-decoration: none;
}

.search-orders-container .reset-button:hover {
    background-color: #bbb;
}

/* Additional CSS for other elements as needed */
/* ... (rest of your existing CSS) ... */
body {
    font-family: Arial, sans-serif;
}

.container {
    width: 100%;
    text-align: center;
    margin: 0 auto;
}
/*
.center-text {
    text-align: center;
    margin-bottom: 20px;  Khoảng cách dưới tiêu đề 
}

table {
    width: 100%;
    border-collapse: collapse;
    margin: 0 auto;
}

table, th, td {
    border: 1px solid black;
}

th, td {
    padding: 10px;
    text-align: left;
}*/


        </style>
    </head>
    <body>
        <jsp:include page="/shared/_header.jsp" />
        <jsp:include page="/shared/_nav.jsp" />

        <!-- Main Content Area -->
        <div class="section-padding-100">
            <!-- Search Orders Form -->
            <div class="search-orders-container">
                <h2>Search Orders</h2>
 <form action="OrderSearchCustomerController" method="get" id="searchForm">
                    <label for="orderId">Order ID:</label>
                    <input type="text" id="orderId" name="orderId" pattern="\d+" title="Order ID must be a positive number" value="${param.orderId}"><br><br>

                    <label for="orderDateFrom">Order Date From:</label>
                    <input type="date" id="orderDateFrom" name="orderDateFrom" value="${param.orderDateFrom}"><br><br>

                    <label for="orderDateTo">Order Date To:</label>
                    <input type="date" id="orderDateTo" name="orderDateTo" value="${param.orderDateTo}"><br><br>

                    <label for="orderStatus">Order Status:</label>
                    <select id="orderStatus" name="orderStatus">
                        <option value="">Select</option>
                        <option value="SUCCESS" ${param.orderStatus == 'SUCCESS' ? 'selected' : ''}>SUCCESS</option>
                        <option value="NOT_YET" ${param.orderStatus == 'NOT_YET' ? 'selected' : ''}>NOT_YET</option>
                    </select><br><br>

                    <label for="shippingStatus">Shipping Status:</label>
                    <select id="shippingStatus" name="shippingStatus">
                        <option value="">Select</option>
                        <option value="SUCCESS" ${param.shippingStatus == 'SUCCESS' ? 'selected' : ''}>SUCCESS</option>
                        <option value="SHIPPING" ${param.shippingStatus == 'SHIPPING' ? 'selected' : ''}>SHIPPING</option>
                        <option value="NOT_YET" ${param.shippingStatus == 'NOT_YET' ? 'selected' : ''}>NOT_YET</option>
                    </select><br><br>

                    <label for="payStatus">Pay Status:</label>
                    <select id="payStatus" name="payStatus">
                        <option value="">Select</option>
                        <option value="SUCCESS" ${param.payStatus == 'SUCCESS' ? 'selected' : ''}>SUCCESS</option>
                        <option value="NOT_YET" ${param.payStatus == 'NOT_YET' ? 'selected' : ''}>NOT_YET</option>
                    </select><br><br>

                    <div class="button-group">
                        <input type="submit" value="Search">
                        <a href="${pageContext.request.contextPath}/OrderHistoryControl" class="reset-button">Reset</a>
                    </div>
                </form>


            </div>
            <!-- Order History Table -->
            <div>
                <div class="container">
        <h1 class="center-text">Order History</h1>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Recipient's Name</th>
                            <th>Order Date</th>
                            <th>Address Received</th>
                            <th>Phone Number</th>
                            <th>Total Price</th>
                            <th>Ship Status</th>
                            <th>Order Status</th>
                            <th>Pay Status</th>
                            <th>Feed Back</th>
                            <th>Detail</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${not empty lstOrder}">
                            <c:forEach items="${lstOrder}" var="o">
                                <!-- Your existing rows for each order -->
                                <tr>
                                    <td class="id"><span>${o.order_id}</span></td>
                                    <td class="name"><span>${sessionScope.account.name}</span></td>
                                    <td style="min-width: 130px" class="date"><span>    <fmt:formatDate value="${o.orderDate}" pattern="dd-MM-yyyy" /></span></td>
                                    <td class="address"><span>${o.addressReceive}</span></td>
                                    <td class="sdt"><span>${o.phone}</span></td>
                                    <td class="totalPrice"><span><fmt:formatNumber value="${o.totalPrice}" type="number" pattern="#,##0" />VND</span></td>
                                    <td class="ship_status"><span>${o.shipping_status}</span></td>
                                    <td class="order_status"><span>${o.order_status}</span></td>
                                    <td class="pay_status"><span>${o.pay_status}</span></td>
                                    <td class="Feed_Back">
                                        <c:choose>
                                            <c:when test="${o.shipping_status == 'SUCCESS' && o.feedback_order != null}">
                                                <span>${o.feedback_order}</span>
                                            </c:when>
                                            <c:when test="${o.shipping_status != 'SUCCESS'}">
                                                <span>Chưa được giao hàng nên chưa được feedback</span>
                                            </c:when>
                                            <c:when test="${o.shipping_status == 'SUCCESS' && o.feedback_order == null}">
                                                <span>
                                                    <c:if test="${not empty aaa}">
                                                        <a href="${pageContext.request.contextPath}/OrderSearchCustomerController?orderId=${param.orderId}&orderDateFrom=${param.orderDateFrom}&orderDateTo=${param.orderDateTo}&orderStatus=${param.orderStatus}&shippingStatus=${param.shippingStatus}&payStatus=${param.payStatus}&indexPage=${param.indexPage }&feedbackid=${o.order_id}">
                                                            <button>Click to feedback</button>
                                                        </a>
                                                    </c:if>
                                                    <c:if test="${empty aaa}">
                                                        <a href="${pageContext.request.contextPath}/OrderHistoryControl?feedbackid=${o.order_id}&indexPage=${param.indexPage}">
                                                            <button>Click to feedback</button>
                                                        </a>
                                                    </c:if>
                                                </span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="OrderDetailControl?orderId=${o.order_id}">
                                            <i class="material-icons" data-toggle="tooltip" title="Detail">visibility</i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty lstOrder}">
                            <tr class="not-found-row">
                                <td class="not-found-cell" colspan="11">Not Found</td>
                            </tr>
                        </c:if>
                    </tbody>

                </table>

                <!-- Pagination -->
                <!-- Pagination -->


                <c:if test="${not empty aaa}"> 
                    <div class="pagination" id="pagination">
                        <c:if test="${endPage != 0}">
                            <c:if test="${endPage > 1}">
                                <a href="${pageContext.request.contextPath}/OrderSearchCustomerController?orderId=${param.orderId}&orderDateFrom=${param.orderDateFrom}&orderDateTo=${param.orderDateTo}&orderStatus=${param.orderStatus}&shippingStatus=${param.shippingStatus}&payStatus=${param.payStatus}&indexPage=${param.indexPage - 1}" class="page-link prev" title="Previous Page">&#9664;</a>
                            </c:if>
                            <div class="page-numbers">
                                <c:forEach var="i" begin="1" end="${endPage}">
                                    <a href="${pageContext.request.contextPath}/OrderSearchCustomerController?orderId=${param.orderId}&orderDateFrom=${param.orderDateFrom}&orderDateTo=${param.orderDateTo}&orderStatus=${param.orderStatus}&shippingStatus=${param.shippingStatus}&payStatus=${param.payStatus}&indexPage=${i}" class="page-link" title="Go to page ${i}">${i}</a>
                                </c:forEach>
                            </div>
                            <c:if test="${endPage > 1}">
                                <a href="${pageContext.request.contextPath}/OrderSearchCustomerController?orderId=${param.orderId}&orderDateFrom=${param.orderDateFrom}&orderDateTo=${param.orderDateTo}&orderStatus=${param.orderStatus}&shippingStatus=${param.shippingStatus}&payStatus=${param.payStatus}&indexPage=${param.indexPage + 1}" class="page-link next" title="Next Page">&#9654;</a>
                            </c:if>
                        </c:if>
                    </div>
                </c:if>
                <c:if test="${empty aaa}"> 
                    <div class="pagination" id="pagination">
                        <c:if test="${endPage != 0}">
                            <c:if test="${endPage > 1}">
                                <a href="OrderHistoryControl?indexPage=${param.indexPage - 1}" class="page-link prev" title="Previous Page">&#9664;</a>
                            </c:if>
                            <div class="page-numbers">
                                <c:forEach var="i" begin="1" end="${endPage}">
                                    <a href="OrderHistoryControl?indexPage=${i}" class="page-link" title="Go to page ${i}">${i}</a>
                                </c:forEach>
                            </div>
                            <c:if test="${endPage > 1}">
                                <a href="OrderHistoryControl?indexPage=${param.indexPage + 1}" class="page-link next" title="Next Page">&#9654;</a>
                            </c:if>
                        </c:if>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- Modal for Feedback -->
        <c:if test="${not empty aaa}">    
            <c:if test="${not empty orderid}">
                <div id="myModal" class="modal">
                    <form action="OrderSearchCustomerController" method="get">
                        <input name="orderids" value="${orderid}" type="hidden">
                        <input name="indexPage" value="${param.indexPage}" type="hidden">
                        <input name="orderId" value="${param.orderId}" type="hidden">
                        <input name="orderDateFrom" value="${param.orderDateFrom}" type="hidden">
                        <input name="orderDateTo" value="${param.orderDateTo}" type="hidden">
                        <input name="orderStatus" value="${param.orderStatus}" type="hidden">
                        <input name="shippingStatus" value="${param.shippingStatus}" type="hidden">
                        <input name="payStatus" value="${param.payStatus}" type="hidden">

                        <div class="modal-content">
                            <p>DO YOU WANT TO FEEDBACK FOR ORDER ID: <span id="feedbackId"></span>${orderid}</p>
                            <input type="text" id="feedbackInput" name="feedback" placeholder="Enter your feedback here">
                            <div class="modal-footer">
                                <button type="submit" class="modal-button" id="submitFeedback">Submit Feedback</button>
                                <a href="${pageContext.request.contextPath}/OrderSearchCustomerController?orderId=${param.orderId}&orderDateFrom=${param.orderDateFrom}&orderDateTo=${param.orderDateTo}&orderStatus=${param.orderStatus}&shippingStatus=${param.shippingStatus}&payStatus=${param.payStatus}&indexPage=${param.indexPage}">
                                    <button type="button" class="modal-button cancel" id="cancelFeedback">Cancel</button>
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
            </c:if>
        </c:if>
        <c:if test="${empty aaa}">    
            <c:if test="${not empty orderid}">
                <div id="myModal" class="modal">
                    <form action="OrderHistoryControl" method="post">
                        <input name="orderid" value="${orderid}" type="hidden">
                        <input name="indexPage" value="${param.indexPage}" type="hidden">

                        <div class="modal-content">
                            <p>DO YOU WANT TO FEEDBACK FOR ORDER ID: <span id="feedbackId"></span>${orderid}</p>
                            <input type="text" id="feedbackInput" name="feedback" placeholder="Enter your feedback here">
                            <div class="modal-footer">
                                <button type="submit" class="modal-button" id="submitFeedback">Submit Feedback</button>
                                <a href="${pageContext.request.contextPath}/OrderHistoryControl?indexPage=${param.indexPage}">
                                    <button type="button" class="modal-button cancel" id="cancelFeedback">Cancel</button>
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
            </c:if>
        </c:if>
        <!-- Include Footer -->
        <jsp:include page="/shared/_footer.jsp" />
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var pageIndex = getQueryParameter('indexPage');
                var links = document.querySelectorAll('.page-numbers .page-link');
                var prevButton = document.querySelector('.page-link.prev');
                var nextButton = document.querySelector('.page-link.next');
                var currentPage = pageIndex ? parseInt(pageIndex) : 1;
                var totalPages = links.length;
                var maxVisiblePages = 5;
                var startPage = 1;
                var endPage = maxVisiblePages;

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
                        setActivePage(currentPage);
                    });
                });

                showPageNumbers();
            });

            function getQueryParameter(name) {
                var urlParams = new URLSearchParams(window.location.search);
                return urlParams.get(name);
            }
//                function resetForm() {
//        document.getElementById("searchForm").reset();
//    }
document.getElementById('orderId').addEventListener('input', function (e) {
    e.target.value = e.target.value.replace(/[^0-9]/g, ''); // Chỉ cho phép số
});
        </script>
    </body>
</html>
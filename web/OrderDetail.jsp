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
            th, td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: center;
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
        </style>
    </head>
    <body>

        <jsp:include page="/shared/_header.jsp" />
        <jsp:include page="/shared/_nav.jsp" />
        <!-- Header Area -->

        <div class="section-padding-100">
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
<!--                                <td class="order_status"><span>${o.order_status}</span></td>
                                <td class="ship_status"><span>${o.shipping_status}</span></td>-->
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
                                                                        <td class="Feed_Back"><span>chua đc giao hang nên ch đc fb</span></td>

                                    </c:when>
                                                                           <c:when test = "${o.shipping_status=='SUCCESS'&&o.feedback_details== null}">
                                                                               <td class="Feed_Back"><span><a href="${pageContext.request.contextPath}/OrderDetailControl?feedbackid=${o.order_detail_id}&orderId=${param.orderId}"><button>Click to feedback</button></a></span></td>

                                    </c:when>
                                </c:choose>
                                
                                <td class="addressReceive"><span>${o.addressReceive}</span></td>
                                <td class="phone"><span>${o.phone}</span></td>
                            </tr>
                        </c:forEach>
                            
                    </tbody>
                </table>
            </div>
        </div>
<c:if test = "${not empty order_detail_id }">
    <div id="myModal" class="modal" >
        <form action="OrderDetailControl" method="post">
            <input name="order_detail_id" value="${order_detail_id}" type="hidden">
            <input name="orderId" value="${param.orderId}" type="hidden">
            <div class="modal-content">
                <p>DO YOU WANT TO FEEDBACK FOR ORDER ID: <span id="feedbackId"></span>${order_detail_id}</p>
                <input type="text" id="feedbackInput" name="feedback" placeholder="Enter your feedback here">
                <div class="modal-footer">
                    <button type="submit" class="modal-button" id="submitFeedback">Submit Feedback</button>
                    <a href="${pageContext.request.contextPath}/OrderDetailControl?orderId=${param.orderId}" class="modal-button cancel">Cancel</a>
                </div>
            </div>
        </form>
    </div>
</c:if>
 <c:if  test ="${ empty aaa}">
                                <div class="pagination" id="pagination">
                    <c:if test="${endPage != 0}">
                        <a href="#" class="page-link prev" title="Previous Page">&#9664;</a>
                        <div class="page-numbers">
                            <c:forEach var="i" begin="1" end="${endPage}">
                                <a href="OrderDetailControl?indexPage=${i}&orderId=${param.orderId}" class="page-link" title="Go to page ${i}">${i}</a>
                            </c:forEach>
                        </div>
                        <a href="#" class="page-link next" title="Next Page">&#9654;</a>
                    </c:if>
                </div>
            </div>
        </div>
           </c:if>

        <!-- Footer Area -->

        <jsp:include page="/shared/_footer.jsp" />

        <!-- End of Footer Area -->
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

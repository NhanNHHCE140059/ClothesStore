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
            /* CSS để căn giữa bảng order */
            .section-padding-100 {
                padding: 100px 0;
                text-align: center; /* căn giữa nội dung */
            }
            table {
                margin: 0 auto; /* căn giữa bảng */
                width: 100%; /* chiều rộng tối đa */
                max-width: 1100px; /* giới hạn chiều rộng */
                border-collapse: collapse; /* hợp nhất viền bảng */
            }
            table th, table td {
                border: 1px solid #ddd; /* đường viền các ô */
                padding: 8px; /* lề bên trong */
                text-align: center; /* căn giữa nội dung trong ô */
            }
            table th {
                background-color: #f5f7fa; /* màu nền của tiêu đề */
            }
            .actions {
                text-align: center; /* căn giữa các hành động */
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
            /* Màu sắc cho các nút */
            .actions a.cancel {
                background-color: #ff6b6b; /* Màu đỏ */
                color: #fff;
            }
            .actions a.confirm {
                background-color: #6ab04c; /* Màu xanh dương */
                color: #fff;
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

    .page-link:hover {
        background-color: #f0f0f0;
    }

    .page-link.active {
        background-color: #4CAF50;
        color: white;
        border: 1px solid #4CAF50;
    }
        </style>
    </head>
    <body>

        <jsp:include page="/shared/_header.jsp" />
        <jsp:include page="/shared/_nav.jsp" />

        <!-- Header Area -->
        <div class="section-padding-100">
            <div class="cart-title mt-50">
                <h2>Order History (Staff)</h2>
            </div>

            <div>
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
                    <tbody>
                    <form action="OrderHistoryStaffControl" method="post">
                        <c:forEach items="${lstOrder}" var="o">
                            <tr>
                                <td>${o.order_id}</td>
                                <td>${o.orderDate}</td>
                                <td>${o.username}</td>
                                <td><fmt:formatNumber value="${o.totalPrice}" type="number" pattern="#,##0" /></td>
                                <td>${o.order_status}</td>
                                <td>${o.pay_status}</td>
                                <td>${o.ship_status}</td>
                                <td class="actions">
                                    <a href="OrderDetailControl?orderId=${o.order_id}" title="Detail Order ${o.order_id}">
                                        <i class="material-icons">visibility</i>
                                    </a>
                                        
                                    <--><!-- -->
                                    <button  onclick="location.href='OrderStatus?orderId=${o.order_id}&status=1'" title="Cancel Order ${o.order_id}" type="button">
                                        <i class="material-icons">cancel</i>
                                    </button>
                                    
                                    <button  onclick="location.href='OrderStatus?orderId=${o.order_id}&status=0'"  title="Confirm Order ${o.order_id}" type="button" >
                                        <i class="material-icons">confirm</i>
                                    </button>
                                   
                                </td>
                            </tr>
                        </c:forEach>
                    </form>
                        
                    </tbody>
                </table>
                <div class="pagination" id="pagination">
                    <c:if test="${endPage != 0}">
                        <c:forEach var="i" begin="1" end="${endPage}">
                            <a href="OrderHistoryStaffControl?indexPage=${i}" onclick="setActive(this,${i})"class="page-link">${i}</a>
                        </c:forEach>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Footer Area -->
        <jsp:include page="/shared/_footer.jsp" />
        <!-- End of Footer Area -->
        <script>
            function setActive(element, pageIndex) {
            var links = document.querySelectorAll('.page-link');
            links.forEach(function(link) {
                link.classList.remove('active');
            });
            element.classList.add('active');
            localStorage.setItem('activePage', pageIndex); // Save active page index to localStorage
        }

        // Set the initial active page link from localStorage
        document.addEventListener('DOMContentLoaded', function() {
            var activePage = localStorage.getItem('activePage');
            if (activePage) {
                var links = document.querySelectorAll('.page-link');
                links.forEach(function(link) {
                    if (link.textContent === activePage) {
                        link.classList.add('active');
                    }
                });
            } else {
                var links = document.querySelectorAll('.page-link');
                if (links.length > 0) {
                    links[0].classList.add('active'); // Set the first page link as active initially
                }
            }
        });
        </script>
    </body>
</html>

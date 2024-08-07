<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/feedbackManagement.css"/>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Warehouse Management</title>
        <style>
            /* CSS để căn giữa bảng order */
            .section-padding-100 {
                padding: 0; /* Loại bỏ padding để giảm khoảng trống phía trên */
             
                margin-left: 250px; /* Thêm khoảng cách để tránh bị che bởi sidebar */
                margin-top: 0; /* Loại bỏ khoảng trắng phía trên */
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

            /* Thêm CSS cho form tìm kiếm */
            .search-form {
                display: flex;
                justify-content: center;
                margin-bottom: 20px;
            }

            .search-form input[type="text"] {
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                margin-right: 10px;
                width: 200px; /* Điều chỉnh chiều rộng của ô nhập liệu */
            }

            .search-form button {
                padding: 8px 16px;
                border: none;
                border-radius: 4px;
                background-color: #4CAF50;
                color: white;
                font-size: 16px;
                cursor: pointer;
            }

            .search-form button:hover {
                background-color: #45a049;
            }
            .sidebar {
                position: fixed; /* Đảm bảo sidebar luôn cố định */
                top: 0; /* Đặt ở trên cùng của trang */
                left: 0; /* Đặt ở bên trái của trang */
                height: 100vh; /* Chiều cao của sidebar bằng toàn bộ chiều cao của cửa sổ */
            }
            .pagination a.page-link {
                margin: 0 5px;
                padding: 8px 16px;
                text-decoration: none;
                color: #000;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .pagination a.page-link:hover {
                background-color: #f0f0f0;
            }

            .pagination a.page-link.active {
                background-color: #4CAF50;
                color: white;
                border: 1px solid #4CAF50;
            }

            .pagination a.page-link.first, .pagination a.page-link.last {
                margin: 0 10px;
                padding: 8px 16px;
                font-weight: bold;
            }

            .pagination a.page-link.first:hover, .pagination a.page-link.last:hover {
                background-color: #ccc;
            }
              .header {
                margin-top: 12px;
                background-color: #fff;
                padding: 15px 20px;
                border-bottom: 1px solid #e9ecef;
                display: flex;
                align-items: center;
                justify-content: flex-end;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                margin-bottom: 12px;
            }
        </style>
    </head>
    <body>
 <jsp:include page="/shared/_slideBar.jsp" />

        <!-- Header Area -->
        <div class="section-padding-100" style="padding: 12px 12px">
            
            <a style="text-decoration: none; " href="${pageContext.request.contextPath}/home" class=" back-home">Back to Home</a>
            <div class="header" >

                <div class="role-info">
                          <span>${sessionScope.account.role}:</span><span>${sessionScope.account.name}</span>
                </div>
            </div>
            <div class="cart-title mt-50">
                <h1 style="text-align: center">Warehouse Manage</h1>
            </div>

            <div>
                <!-- Form tìm kiếm -->
                <form action="${pageContext.request.contextPath}/SearchProduct" method="post" class="search-form">
                    <input type="text" name="searchName" placeholder="Search by product name" value="${searchName}" />
                    <button type="submit">Search</button>
                </form>

                <table id="warehouseTable">
                    <thead>
                        <tr>
                            <th>Product ID</th>
                            <th>Bill ID</th>
                            <th>Product Name</th>
                            <th>Product Price </th>
                            <th>Color</th>
                            <th>Size</th>
                            <th>Image</th>
                            <th>Inventory Number</th>
                            <th>Import Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty listWarehouse}">
                                <tr>
                                    <td colspan="9" style="text-align: center;">Product not found</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${listWarehouse}" var="o">
                                    <tr>
                                        <td>${o.pro_id}</td>
                                        <td>${o.bill_id}</td>
                                        <td>${o.pro_name}</td>
                                        <td><fmt:formatNumber value="${o.pro_price}" type="currency" currencySymbol="" minFractionDigits="0" maxFractionDigits="0" />
                                            VND</td>
                                        <td>${o.color_name}</td>
                                        <td>${o.size_name}</td>
                                        <td><img src="${o.imageURL}" alt="${o.pro_name}" width="100" /></td>
                                        <td>${o.inventory_number}</td>
                                        <td>${o.import_date}</td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>

                <!-- Pagination -->
                <div class="pagination" id="pagination">
                    <c:if test="${endPage != 0}">
                        <!-- Add links for Previous and Next pages -->
                        <c:choose>
                            <c:when test="${not empty searchName}">
                                <!-- Link to Previous Page -->
                                <c:if test="${pageIndex > 1}">
                                    <a href="${pageContext.request.contextPath}/SearchProduct?page=${pageIndex - 1}&searchName=${searchName}" class="page-link">Previous</a>
                                </c:if>

                                <!-- Pagination Number Links -->
                                <c:forEach var="i" begin="${startPage}" end="${endPageDisplay}">
                                    <a href="${pageContext.request.contextPath}/SearchProduct?page=${i}&searchName=${searchName}" 
                                       class="page-link ${i == pageIndex ? 'active' : ''}">${i}</a>
                                </c:forEach>

                                <!-- Link to Next Page -->
                                <c:if test="${pageIndex < endPage}">
                                    <a href="${pageContext.request.contextPath}/SearchProduct?page=${pageIndex + 1}&searchName=${searchName}" class="page-link">Next</a>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <!-- Link to Previous Page -->
                                <c:if test="${pageIndex > 1}">
                                    <a href="${pageContext.request.contextPath}/ViewWarehouse?page=${pageIndex - 1}" class="page-link">Previous</a>
                                </c:if>

                                <!-- Pagination Number Links -->
                                <c:forEach var="i" begin="${startPage}" end="${endPageDisplay}">
                                    <a href="${pageContext.request.contextPath}/ViewWarehouse?page=${i}" 
                                       class="page-link ${i == pageIndex ? 'active' : ''}">${i}</a>
                                </c:forEach>

                                <!-- Link to Next Page -->
                                <c:if test="${pageIndex < endPage}">
                                    <a href="${pageContext.request.contextPath}/ViewWarehouse?page=${pageIndex + 1}" class="page-link">Next</a>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </div>

            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var urlParams = new URLSearchParams(window.location.search);
                var pageIndex = urlParams.get('page') || '1';
                var links = document.querySelectorAll('.page-link');
                links.forEach(function (link) {
                    link.classList.remove('active');
                    if (link.textContent == pageIndex) {
                        link.classList.add('active');
                    }
                });
                if (!pageIndex && links.length > 0) {
                    links[0].classList.add('active');
                }
            });

            window.addEventListener('beforeunload', function () {
                localStorage.removeItem('activePage');
            });
        </script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="./assets/js/feedbackManagement.js" type="text/javascript"></script>
    </body>
</html>

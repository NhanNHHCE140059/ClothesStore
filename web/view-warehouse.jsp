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
                text-align: center; /* Căn giữa nội dung */
                margin-left: 250px; /* Thêm khoảng cách để tránh bị che bởi sidebar */
                margin-top: 0; /* Loại bỏ khoảng trắng phía trên */
            }

            .back-home {
                position: absolute; /* Đặt vị trí tuyệt đối */
                top: 15px; /* Cách phía trên */
                left: 260px; /* Cách phía bên trái sidebar */
                padding: 10px 10px;
                text-decoration: none;
                color: #fff;
                background-color: #4CAF50;
                border-radius: 5px;
                font-size: 15px;
                font-weight: bold;
                transition: background-color 0.3s ease;
            }

            .back-home:hover {
                background-color: #45a049;
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
                <a href="${pageContext.request.contextPath}/ViewWarehouse">Manage Warehouse </a>
            </div>
        </div>

        <!-- Header Area -->
        <div class="section-padding-100">
            <!-- Đưa nút "Back to Home" vào đúng vị trí -->
            <a href="${pageContext.request.contextPath}/home" class="back-home">Back to Home</a>
            <div class="cart-title mt-50">
                <h2>Warehouse Manage</h2>
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
                        <!-- Add links to jump to first and last page -->
                        <c:choose>
                            <c:when test="${not empty searchName}">
                                <a href="${pageContext.request.contextPath}/SearchProduct?page=1&searchName=${searchName}" class="page-link">First</a>
                                <c:forEach var="i" begin="${startPage}" end="${endPageDisplay}">
                                    <a href="${pageContext.request.contextPath}/SearchProduct?page=${i}&searchName=${searchName}" 
                                       class="page-link ${i == pageIndex ? 'active' : ''}">${i}</a>
                                </c:forEach>
                                <a href="${pageContext.request.contextPath}/SearchProduct?page=${endPage}&searchName=${searchName}" class="page-link">Last</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/ViewWarehouse?page=1" class="page-link">First</a>
                                <c:forEach var="i" begin="${startPage}" end="${endPageDisplay}">
                                    <a href="${pageContext.request.contextPath}/ViewWarehouse?page=${i}" 
                                       class="page-link ${i == pageIndex ? 'active' : ''}">${i}</a>
                                </c:forEach>
                                <a href="${pageContext.request.contextPath}/ViewWarehouse?page=${endPage}" class="page-link">Last</a>
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
    </body>
</html>

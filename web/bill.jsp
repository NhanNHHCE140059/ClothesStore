<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="/shared/_head.jsp" />
        <link rel="stylesheet" type="text/css" href="assets/css/bill.css" />
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <style>
            /* CSS để căn giữa bảng bill */
            .section-padding-100 {
                padding: 100px 0;
                text-align: center; /* căn giữa nội dung */
            }
            .cart-title {
                margin-bottom: 20px; /* khoảng cách phía dưới tiêu đề */
            }
            table {
                margin: 0 auto; /* căn giữa bảng */
                width: 100%; /* chiều rộng tối đa */
                max-width: 1100px; /* giới hạn chiều rộng */
                border-collapse: collapse; /* bỏ khoảng cách giữa các ô */
            }
            th, td {
                padding: 10px; /* thêm khoảng cách bên trong ô */
                border: 1px solid #ddd; /* thêm đường viền */
                text-align: center; /* căn giữa văn bản */
            }
            th {
                background-color: #f5f7fa;
                font-weight: bold; /* làm đậm chữ */
            }
            tr:nth-child(even) {
                background-color: #f9f9f9; /* màu nền xen kẽ */
            }
            tr:hover {
                background-color: #f1f1f1; /* màu nền khi hover */
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

            /* Thêm CSS cho khung tìm kiếm */
            .search-container {
                display: flex;
                justify-content: flex-start; /* căn về bên trái */
                margin-bottom: 10px; /* khoảng cách phía dưới */
                max-width: 1100px;
                margin: 0 auto; /* căn giữa khung tìm kiếm */
            }

            .search-container input[type="text"] {
                padding: 10px;
                font-size: 16px;
                border: 1px solid #ccc;
                border-radius: 4px;
                width: 300px;
                transition: width 0.4s ease-in-out, box-shadow 0.4s ease-in-out;
            }

            .search-container input[type="text"]:focus {
                width: 350px; /* tăng kích thước khi focus */
                box-shadow: 0 0 10px rgba(0, 123, 255, 0.25);
                border-color: #007bff; /* màu viền khi focus */
            }
        </style>
    </head>
    <body>

        <jsp:include page="/shared/_header.jsp" />
        <jsp:include page="/shared/_nav.jsp" />
        <!-- Header Area -->

        <div class="section-padding-100">
            <div class="cart-title mt-50">
                <h2>Bill Details</h2>
            </div>
            <div class="search-container">
                <input oninput="searchByName(this)" value="${nameSearch}" type="text" id="autoSubmitInput" name="searchText" placeholder="Enter product name to search...">
            </div>
            <div>
                <table>
                    <thead>
                        <tr>
                            <th>Bill ID</th>
                            <th>Create Date</th>
                            <th>Total Amount</th>
                            <th>Product Name</th>
                            <th>Import Price</th>
                            <th>Quantity</th>
                            <th>Product ID</th>
                            <th>Image</th>
                            <th>Edit</th>
                        </tr>
                    </thead>
                    <tbody id="contentBill">
                        <c:forEach items="${lstBill}" var="b">
                            <tr>
                                <td class="id"><span>${b.bill_id}</span></td>
                                <td class="date"><span>${b.create_date}</span></td>
                                <td class="totalAmount"><span><fmt:formatNumber value="${b.total_amount}" type="number" pattern="#,##0" /></span></td>
                                <td class="pro_name"><span>${b.pro_name}</span></td>
                                <td class="import_price"><span><fmt:formatNumber value="${b.import_price}" type="number" pattern="#,##0" /></span></td>
                                <td class="quantity"><span>${b.quantity}</span></td>
                                <td class="pro_id"><span>${b.pro_id}</span></td>
                                <td class="image_bill"><img src="${b.image_bill}" alt="Bill Image" style="width:50px;height:50px;"></td>
                                <td>
                                    <a href="BillDetailControl?billId=${b.bill_id}">
                                        <i class="material-icons" data-toggle="tooltip" title="Detail">visibility</i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="pagination" id="pagination">
                    <c:if test="${endPage != 0}">
                        <c:forEach var="i" begin="1" end="${endPage}">
                            <a href="/clothesstore/Bill?indexPage=${i}" onclick="setActive(this,${i})" class="page-link">${i}</a>
                        </c:forEach>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Footer Area -->

        <jsp:include page="/shared/_footer.jsp" />
        <!--<script </script>-->
        <!-- End of Footer Area -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script >
            function setActive(element, pageIndex) {
                var links = document.querySelectorAll('.page-link');
                links.forEach(function (link) {
                    link.classList.remove('active');
                });
                element.classList.add('active');
                localStorage.setItem('activePage', pageIndex); // Save active page index to localStorage
            }

            // Set the initial active page link from localStorage
            document.addEventListener('DOMContentLoaded', function () {
                var activePage = localStorage.getItem('activePage');
                if (activePage) {
                    var links = document.querySelectorAll('.page-link');
                    links.forEach(function (link) {
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
            
            function searchByName(param) {
                var nameSearch = param.value.trim();
                if (nameSearch === "") {
                    location.reload();
                    document.getElementById('pagination').style.display = 'flex';
                    return;
                }

                document.getElementById('pagination').style.display = 'none';
                $.ajax({
                    url: "/clothesstore/SearchBill",
                    type: "get", //send it through get method
                    data: {
                        nameSearch: nameSearch
                    },
                    success: function (data) {
                        var row = document.getElementById("contentBill");
                        row.innerHTML = data;
                    },
                    error: function (xhr) {

                    }
                });
            }
        </script>
    </body>
</html>

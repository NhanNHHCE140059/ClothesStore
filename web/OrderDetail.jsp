<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="/shared/_head.jsp" />
    <link rel="stylesheet" type="text/css" href="assets/css/orderhistory.css" />
    <style>
        /* CSS để căn giữa bảng order */
        .section-padding-100 {
            padding: 100px 0;
            text-align: center; /* căn giữa nội dung */
        }
        .table-container {
            margin: 0 auto;
            width: 100%; /* chiều rộng tối đa */
            max-width: 1100px; /* giới hạn chiều rộng */
            border: 2px solid #ccc; /* đường viền của khung */
            padding: 20px; /* khoảng cách bên trong khung */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* đổ bóng cho khung */
            background-color: #fff; /* nền trắng cho khung */
        }
        table {
            width: 100%;
            border-collapse: collapse; /* gộp các đường viền */
        }
        th, td {
            border: 1px solid #ddd; /* đường viền ô */
            padding: 8px; /* khoảng cách bên trong ô */
            text-align: center; /* căn giữa nội dung */
        }
        th {
            background-color: #f5f7fa; /* màu nền tiêu đề */
        }
        tr:nth-child(even) {
            background-color: #f9f9f9; /* màu nền cho các hàng chẵn */
        }
        tr:hover {
            background-color: #f1f1f1; /* màu nền khi rê chuột */
        }
        .back-button {
            margin-top: 20px;
            text-align: center;
        }
        .back-button a {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .back-button a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <jsp:include page="/shared/_header.jsp" />
    <jsp:include page="/shared/_nav.jsp" />
    <!-- Header Area -->

    <div class="section-padding-100">
        <div class="cart-title mt-50">
            <c:if test="${sessionScope.account.role == 'Customer'}">
                <h2>Order Detail</h2>
            </c:if>
            <c:if test="${sessionScope.account.role == 'Staff'}">
                <h2>Order Detail (Staff)</h2>
            </c:if>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th style="width: 100px">Product ID</th>
                        <th>Image</th>
                        <th>Product Name</th>
                        <th>Unit Price</th>
                        <th>Category</th>
                        <th>Quantity</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${lstOrderDetail}" var="map">
                        <c:forEach items="${map}" var="entry">
                            <c:set var="odd" value="${entry.key}"/>
                            <c:set var="product" value="${entry.value}"/>
                            <tr>
                                <td class="id">
                                    <span>${odd.pro_id}</span>
                                </td>
                                <td class="image">
                                    <a href="#"><img src="${product.imageURL}" alt="Product" style="width: 150px"></a>
                                </td>
                                <td class="productName">
                                    <span>${product.pro_name}</span>
                                </td>
                                <td class="price">
                                    <span><fmt:formatNumber value="${product.pro_price}" type="number" pattern="#,##0" /></span>
                                </td>
                                <td class="categoryName">
                                    <span>${product.cat_name}</span>
                                </td>
                                <td class="quantity">
                                    <span>${odd.quantity}</span>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <!-- Nút Back -->
        <div class="back-button">
            <c:if test="${sessionScope.account.role == 'Customer'}">
                <a href="/clothesstore/OrderHistoryControl">Back to Order History</a>
            </c:if>
            <c:if test="${sessionScope.account.role == 'Staff'}">
                <a href="/clothesstore/OrderHistoryStaffControl">Back to Staff Order History</a>
            </c:if>
        </div>
    </div>

    <!-- Footer Area -->
    <jsp:include page="/shared/_footer.jsp" />
    <!-- End of Footer Area -->

</body>
</html>

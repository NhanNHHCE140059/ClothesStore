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
        </style>
    </head>
    <body>

        <jsp:include page="/shared/_header.jsp" />
        <jsp:include page="/shared/_nav.jsp" />
        <!-- Header Area -->

        <div class="section-padding-100">
            <div class="cart-title mt-50">
                <h2>Order History</h2>
            </div>

            <div>
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
                            <th>Detail</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${lstOrder}" var="o">
                            <tr>
                                <td class="id"><span>${o.order_id}</span></td>
                                <td class="name"><span>${sessionScope.account.name}</span></td>
                                <td class="date"><span>${o.orderDate}</span></td>
                                <td class="address"><span>${o.addressReceive}</span></td>
                                <td class="sdt"><span>${o.phone}</span></td>
                                <td class="totalPrice"><span><fmt:formatNumber value="${o.totalPrice}" type="number" pattern="#,##0" /></span></td>
                                <td class="order_status"><span>${o.order_status}</span></td>
                                <td class="pay_status"><span>${o.pay_status}</span></td>
                                <td class="ship_status"><span>${o.ship_status}</span></td>
                                <td>
                                    <a href="OrderDetailControl?orderId=${o.order_id}">
                                       <i class="material-icons" data-toggle="tooltip" title="Detail">visibility</i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Footer Area -->

        <jsp:include page="/shared/_footer.jsp" />

        <!-- End of Footer Area -->

    </body>
</html>

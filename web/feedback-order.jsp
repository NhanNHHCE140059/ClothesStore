<%-- 
    Document   : feedback-order
    Created on : Jul 14, 2024, 5:00:13 PM
    Author     : HP
--%>

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
            <div class="container">
                <c:if test="${error != null}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:if>
                <form action="feedback" method="post">
                    <div class="form-group">
                        <label for="feedback">Leave Feedback for Order ${order.order_id}</label>
                        <textarea class="form-control" id="feedback" name="feedback" rows="3" required>${order.feedback_order}</textarea>
                    </div>
                    <input type="hidden" name="orderId" value="${order.order_id}">
                    <button type="submit" class="btn btn-success">Submit Feedback</button>
                </form>
            </div>
        </div>

        <!-- Footer Area -->

        <jsp:include page="/shared/_footer.jsp" />

        <!-- End of Footer Area -->

    </body>
</html>

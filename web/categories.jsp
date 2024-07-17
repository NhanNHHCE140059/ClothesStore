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
                <c:if test="${param.error != null}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${param.error}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:if>
                <c:if test="${param.success != null}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${param.success}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:if>
            </div>
            <div class="container">
                <h2>Category List</h2>
                <a href="manage-category?action=new" class="btn btn-success mb-3">Add New Category</a>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Name</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="category" items="${categoryList}" varStatus="index">
                            <tr>
                                <td>${index.index + 1}</td>
                                <td>${category.cat_name}</td>
                                <td>
                                    <a href="manage-category?action=edit&cat_id=${category.cat_id}" class="btn btn-warning">Edit</a>
                                    <a href="manage-category?action=delete&cat_id=${category.cat_id}" class="btn btn-danger">Delete</a>
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

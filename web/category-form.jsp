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
                <h2>${category != null ? 'Edit Category' : 'Add New Category'}</h2>
                <form action="manage-category" method="post">
                    <input type="hidden" name="action" value="${category != null ? 'update' : 'insert'}"/>
                    <input type="hidden" name="cat_id" value="${category != null ? category.cat_id : ''}"/>
                    <div class="form-group">
                        <label for="cat_name">Category Name:</label>
                        <input type="text" class="form-control" id="cat_name" name="cat_name" value="${category != null ? category.cat_name : ''}" required>
                    </div>
                    <button type="submit" class="btn btn-primary">${category != null ? 'Update' : 'Add'}</button>
                </form>
            </div>
            <!-- Footer Area -->

            <jsp:include page="/shared/_footer.jsp" />

            <!-- End of Footer Area -->

    </body>
</html>

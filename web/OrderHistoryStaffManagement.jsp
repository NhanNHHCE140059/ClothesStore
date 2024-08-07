<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="assets/css/orderhistory.css" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/feedbackManagement.css"/>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
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
            .bg-primary {
                background-color: #FFD333 !important;
                border-color: #FFD333 !important;
            }
            .text-primary {
                color: #FFD333 !important;
            }
            a{
                text-decoration: none!important;
            }
           
        </style>

    </head>
    <body>
     <jsp:include page="/shared/_slideBar.jsp" />
     <div class="content">
          <a href="${pageContext.request.contextPath}/home" class=" back-home">Back to Home</a>
          <div class="header" style="    justify-content: end;">
                <div class="role-info">
                    <span>${sessionScope.account.role} : ${sessionScope.account.name}</span>
                </div>
            </div>

     

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
            <div class="cart-title mt-50">
                <h2>Order History (Staff)</h2>
            </div>

            <div>
                <table id="data-table">
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
                        <c:forEach items="${lstOrder}" var="o">
                            <tr>
                                <td>${o.order_id}</td>
                                <td>${o.orderDate}</td>
                                <td>${o.username}</td>
                                <td><fmt:formatNumber value="${o.totalPrice}" type="number" pattern="#,##0" /></td>
                                <td>${o.order_status}</td>
                                <td>
                                    <span class="badge badge-dark" onclick="showPopup('${o.pay_status}', ${o.order_id})" style="cursor:pointer;">
                                        <i class="fas fa-pen"></i> ${o.pay_status}
                                    </span>
                                </td>
                                <td>
                                    <span class="badge badge-info"  onclick="showPopupShip('${o.shipping_status}', ${o.order_id})" style="cursor:pointer;">
                                        <i class="fas fa-pen"></i> ${o.shipping_status}
                                    </span>
                                </td>
                                <td class="actions">
                                    <a href="OrderDetailStaffControl?orderIds=${o.order_id}" class="detail" title="Detail Order ${o.order_id}">
                                        <i class="material-icons">visibility</i>
                                    </a>
                                    <c:if test="${o.order_status != 'NOT_YET'}">
                                        <a class="cancel disabled" title="Cancel Order ${o.order_id}" style="pointer-events: none; color: gray;">
                                            <i class="material-icons">cancel</i>
                                        </a>
                                    </c:if>
                                    <c:if test="${o.order_status == 'NOT_YET'}">
                                        <a onclick="return confirm('Are you sure to cancel this order?')" href="CancelOrderControl?orderId=${o.order_id}&returnPage=OrderHistoryStaffControllerManagement?indexPage=${param.indexPage != null ? param.indexPage : 1}" class="cancel" title="Cancel Order ${o.order_id}">
                                            <i class="material-icons">cancel</i>
                                        </a>
                                    </c:if>


                                    <c:if test="${o.order_status != 'NOT_YET'}">
                                        <a class="confirm disabled" title="Confirm Order ${o.order_id}" style="pointer-events: none; color: gray;">
                                            <i class="material-icons">check_circle</i>
                                        </a>
                                    </c:if>
                                    <c:if test="${o.order_status == 'NOT_YET'}">
                                        <a onclick="return confirm('Are you sure to confirm this order?')" href="ConfirmOrderControl?orderId=${o.order_id}&returnPage=OrderHistoryStaffControllerManagement?indexPage=${param.indexPage != null ? param.indexPage : 1}" class="confirm" title="Confirm Order ${o.order_id}">
                                            <i class="material-icons">check_circle</i>
                                        </a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
<div class="pagination" id="pagination">
    <c:if test="${endPage != 0}">
        <c:choose>
            <c:when test="${endPage <= 10}">
                <c:forEach var="i" begin="1" end="${endPage}">
                    <a href="OrderHistoryStaffControllerManagement?indexPage=${i}" class="page-link ${param.indexPage == i ? 'active' : ''}">${i}</a>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <c:set var="currentPage" value="${param.indexPage != null ? param.indexPage : 1}" />
                <c:set var="startPage" value="${currentPage <= 5 ? 1 : currentPage - 4}" />
                <c:set var="endPage" value="${currentPage + 5 > endPage ? endPage : currentPage + 5}" />
                <c:if test="${startPage > 1}">
                    <a href="OrderHistoryStaffControllerManagement?indexPage=1" class="page-link">1</a>
                    <span class="page-link">...</span>
                </c:if>
                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                    <a href="OrderHistoryStaffControllerManagement?indexPage=${i}" class="page-link ${param.indexPage == i ? 'active' : ''}">${i}</a>
                </c:forEach>
                <c:if test="${endPage < endPage}">
                    <span class="page-link">...</span>
                    <a href="OrderHistoryStaffControllerManagement?indexPage=${endPage}" class="page-link">${endPage}</a>
                </c:if>
            </c:otherwise>
        </c:choose>
    </c:if>
</div>




            </div>
        </div>
        <div class="modal fade" id="statusModal" tabindex="-1" role="dialog" aria-labelledby="statusModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="statusModalLabel">Update Status payment</h5>
                    </div>
                    <div class="modal-body">
                        <form id="statusForm" action="change-payment" method="post">
                            <input type="hidden" name="orderId" id="orderId">
                            <div class="form-group">
                                <label for="currentStatus">Current Status</label>
                                <span id="currentStatus" class="form-control-plaintext"></span>
                            </div>
                            <div class="form-group">
                                <label for="newStatus">New status payment</label>
                                <select class="form-control" name="status" id="status">
                                    <option value="0">SUCCESS</option>
                                    <option value="1">NOT_YET</option>
                                </select>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" onclick="$('#statusForm').submit();">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="statusShipModalLabel" tabindex="-1" role="dialog" aria-labelledby="statusShipModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="statusModalLabel">Update Status shipping</h5>
                    </div>
                    <div class="modal-body">
                        <form id="statusFormShip" action="change-shipping" method="post">
                            <input type="hidden" name="orderId" id="orderIdShip">
                            <div class="form-group">
                                <label for="currentStatus">Current ship status</label>
                                <span id="currentStatusShip" class="form-control-plaintext"></span>
                            </div>
                            <div class="form-group">
                                <label for="newStatus">New Status payment</label>
                                <select class="form-control" name="newStatus" id="newStatus">
                                    <option value="0">SUCCESS</option>
                                    <option value="1">SHIPPING</option>
                                    <option value="2">NOT_YET</option>
                                </select>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" onclick="$('#statusFormShip').submit();">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
</div>
        <!-- Footer Area -->
        <div style="display: none;">
              <jsp:include page="/shared/_footer.jsp" />
        </div>
         <script src="./assets/js/feedbackManagement.js" type="text/javascript"></script>
        <!-- End of Footer Area -->
        <script>
            function showPopup(status, orderId) {
                $('#currentStatus').text(status);
                $('#orderId').val(orderId);
                $('#statusModal').modal('show');
            }
        </script>
        <script>
            function showPopupShip(status, orderId) {
                $('#currentStatusShip').text(status);
                $('#orderIdShip').val(orderId);
                $('#statusShipModalLabel').modal('show');
            }
        </script>
        <script>

            function getQueryParameter(name) {
                var urlParams = new URLSearchParams(window.location.search);
                return urlParams.get(name);
            }

            function setActivePage(pageIndex) {
                var links = document.querySelectorAll('.page-link');
                links.forEach(function (link) {
                    link.classList.remove('active');
                    if (link.textContent == pageIndex) {
                        link.classList.add('active');
                    }
                });
            }

            document.addEventListener('DOMContentLoaded', function () {
                var pageIndex = getQueryParameter('indexPage');
                if (pageIndex) {
                    setActivePage(pageIndex);
                } else {
                    var links = document.querySelectorAll('.page-link');
                    if (links.length > 0) {
                        links[0].classList.add('active'); // Set the first page link as active initially
                    }
                }
            });

            window.addEventListener('beforeunload', function () {
                localStorage.removeItem('activePage');
            });
        </script>
        <!--        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
                <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
                <script src="https://cdn.datatables.net/1.10.24/js/dataTables.bootstrap4.min.js"></script>
                <script>
                    $(document).ready(function () {
                        $("#data-table").DataTable();
                    });
                </script>-->
    </body>
</html>




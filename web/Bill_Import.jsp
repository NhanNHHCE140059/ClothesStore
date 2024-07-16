<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<%@page import="model.Account"%>
    <%@page import="helper.Role"%>

    <% Account account = (Account) session.getAttribute("account"); %>
    <head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/feedbackManagement.css" />
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!--            <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">-->
        <title>Product Feedback Dashboard</title>
        <style>
            body {
                font-family: Arial, sans-serif;
            }

            .container {
                display: flex;
                justify-content: space-between;
                margin-top: 20px;
            }

            .form-container {
                width: 15%;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 5px;
                background-color: #f9f9f9;
            }

            .form-container h2 {
                margin-bottom: 20px;
                text-align: center;
            }

            .form-container label {
                display: block;
                margin-bottom: 5px;
            }

            .form-container input[type="text"],
            .form-container input[type="date"],
            .form-container input[type="number"] {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .form-container .button-group {
                display: flex;
                justify-content: space-between;
            }

            .form-container .button-group input[type="submit"],
            .form-container .button-group a {
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                text-decoration: none;
                text-align: center;
                cursor: pointer;
            }

            .form-container .button-group input[type="submit"] {
                background-color: #28a745;
                color: white;
            }

            .form-container .button-group input[type="submit"]:hover {
                background-color: #218838;
            }

            .form-container .button-group a {
                background-color: #dc3545;
                color: white;
            }

            .form-container .button-group a:hover {
                background-color: #c82333;
            }

            .bill-table-container {
                width: 85%;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 5px;
                background-color: #f9f9f9;
                box-sizing: border-box;
            }

            .bill-table {
                width: 100%;
                border-collapse: collapse;
            }

            .bill-table th,
            .bill-table td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }

            .bill-table th {
                background-color: #f2f2f2;
                font-weight: bold;
            }

            .bill-table td img {
                width: 50px;
                height: auto;
                cursor: pointer;
            }

            .detail-button {
                padding: 5px 10px;
                background-color: #007bff;
                color: white;
                border: none;
                cursor: pointer;
                border-radius: 3px;
            }

            .detail-button:hover {
                background-color: #0056b3;
            }

            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 20px;
                flex-wrap: nowrap;
            }

            .page-numbers {
                display: flex;
                flex-wrap: wrap;
            }

            .page-link {
                margin: 0 5px;
                padding: 8px 16px;
                text-decoration: none;
                color: #000;
                border: 1px solid #ccc;
                border-radius: 4px;
                transition: background-color 0.3s, color 0.3s;
            }

            .page-link:hover {
                background-color: #f0f0f0;
            }

            .page-link.active {
                background-color: #4CAF50;
                color: white;
                border: 1px solid #4CAF50;
            }

            .page-link.prev,
            .page-link.next {
                display: flex;
                align-items: center;
            }

            .modal {
                display: none;
                position: fixed;
                z-index: 1;
                padding-top: 60px;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgb(0, 0, 0);
                background-color: rgba(0, 0, 0, 0.9);
            }

            .modal-content {
                margin: auto;
                display: block;
                width: auto;
                max-width: 90%;
                max-height: 90%;
            }

            .modal-content,
            #caption {
                animation-name: zoom;
                animation-duration: 0.6s;
            }

            @keyframes zoom {
                from {
                    transform: scale(0);
                }

                to {
                    transform: scale(1);
                }
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
}
            .close {
                position: absolute;
                top: 15px;
                right: 35px;
                color: #fff;
                font-size: 40px;
                font-weight: bold;
                transition: 0.3s;
            }

            .close:hover,
            .close:focus {
                color: #bbb;
                text-decoration: none;
                cursor: pointer;
            }
            .not-found-row {
    height: 200px; /* Tùy ch?nh chi?u cao theo ý mu?n */
    font-weight: bold; /* In ??m ch? */

    justify-content: center;

    text-align: center; /* C?n gi?a n?i dung */
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
                <a href="#">Create New Product (Warehouse)</a>
                <a href="#">Update Product (Warehouse)</a>
                <a href="#">Delete Product (Warehouse)</a>
            </div>
            <a class="menu-item">Bill Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="/clothesstore/ImportBillController">View Import Bill</a>
                <a href="#">Create Import Bill</a>
            </div>
        </div>

        <div class="content">
            <a href="${pageContext.request.contextPath}/home" class="back-home">Back to Home</a>

            <div class="header">

                <div class="role-info">
                       <span><%= account.getRole()%> :</span><span><%= account.getName()%></span>
                </div>
            </div>
            <div class="container">
                <div class="form-container">
                    <h2>Search Orders</h2>
<form action="SearchImportBillController" method="get" id="searchForm">
    <label for="billId">Bill ID:</label>
    <input type="number" id="billId" name="billId" min="0" title="Bill ID must be a positive number" value="${param.billId}"><br><br>

    <label for="createDateFrom">Create Date From:</label>
    <input type="date" id="createDateFrom" name="createDateFrom" value="${param.createDateFrom}"><br><br>

    <label for="createDateTo">Create Date To:</label>
    <input type="date" id="createDateTo" name="createDateTo" value="${param.createDateTo}"><br><br>

    <label for="totalPriceFrom">Total Price From:</label>
    <input type="number" id="totalPriceFrom" name="totalPriceFrom" step="0.01" min="0" title="Total Price must be a positive number" value="${param.totalPriceFrom}"><br><br>

    <label for="totalPriceTo">Total Price To:</label>
    <input type="number" id="totalPriceTo" name="totalPriceTo" step="0.01" min="0" title="Total Price must be a positive number" value="${param.totalPriceTo}"><br><br>

    <div class="button-group">
        <input type="submit" value="Search">
        <a href="${pageContext.request.contextPath}/ImportBillController" class="reset-button">Reset</a>
    </div>
</form>



                </div>
                <!--                <div class="role-info">
                                    <span>Admin</span><span>Admin</span>
                                </div>-->


                <div class="bill-table-container">
                    <h2>Import Bills</h2>
                    <table class="bill-table">
                        <thead>
                            <tr>
                                <th>Bill ID</th>
                                <th>Create Date</th>
                                <th>Total Amount</th>
                                <th>Image Bill</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${lstBill}" var="o">
                                <tr>
                                    <td class="id"><span>${o.bill_id}</span></td>
                                    <td class="date"><span>${o.create_date}</span></td>
                                    <td class="totalAmount"><span><fmt:formatNumber value="${o.total_amount}" type="number" pattern="#,##0" /></span></td>

                                    <td class="image"><img src="${o.image_bill}" alt="Bill Image" onclick="showImageModal(this)"></td>
                                    <td>
                                        <c:if test="${ empty aaa}">
                                        <a href="ImportBillDetailController?billId=${o.bill_id}&indexPageback=${param.indexPage}">
                                            <i class="material-icons" data-toggle="tooltip" title="Detail">Detail</i>
                                        </a>
                                            </c:if>
                                           <c:if test="${ not empty aaa}">
                                               <a href="ImportBillDetailController?searchbillId=${searchbillId}&billId=${o.bill_id}&createDateFrom=${param.createDateFrom}&createDateTo=${param.createDateTo}&totalPriceFrom=${totalPriceFrom}&totalPriceTo=${param.totalPriceTo}&indexPageback=${param.indexPage}&search=true">
                                                 
                                            <i class="material-icons" data-toggle="tooltip" title="Detail">Detail</i>
                                        </a>
                                               </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                                                               <c:if test="${empty lstBill}">
                            <tr class="not-found-row">
                                <td class="not-found-cell col-5 " style=" text-align: center" colspan="11">Not Found</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                    <c:if test="${not empty aaa}"> 
                        <div class="pagination" id="pagination">
                            <c:if test="${endPage != 0}">
                                <a href="#" class="page-link prev" title="Previous Page">&#9664;</a>
                                <div class="page-numbers">
                                    <c:forEach var="i" begin="1" end="${endPage}">
                                        <a href="${pageContext.request.contextPath}/SearchImportBillController?billId=${param.billId}&createDateFrom=${param.createDateFrom}&createDateTo=${param.createDateTo}&totalPriceTo=${param.totalPriceTo}&totalPriceFrom=${param.totalPriceFrom}&indexPage=${i}" class="page-link">${i}</a>

                                    </c:forEach>
                                </div>
                                <a href="#" class="page-link next" title="Next Page">&#9654;</a>
                            </c:if>
                        </div>
                    </c:if>

                    <c:if test="${ empty aaa}"> 
                        <div class="pagination" id="pagination">
                            <c:if test="${endPage != 0}">
                                <a href="#" class="page-link prev" title="Previous Page">&#9664;</a>
                                <div class="page-numbers">
                                    <c:forEach var="i" begin="1" end="${endPage}">
                                        <a href="ImportBillController?indexPage=${i}" class="page-link">${i}</a>
                                    </c:forEach>
                                </div>
                                <a href="#" class="page-link next" title="Next Page">&#9654;</a>
                            </c:if>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <div id="imageModal" class="modal">
            <span class="close" onclick="closeImageModal()">&times;</span>
            <img class="modal-content" id="img01">
            <div id="caption"></div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="./assets/js/feedbackManagement.js" type="text/javascript"></script>
     <script>
    document.addEventListener('DOMContentLoaded', function () {
        var pageIndex = getQueryParameter('indexPage') || getQueryParameter('indexPageback');
        var links = document.querySelectorAll('.page-numbers .page-link');
        var prevButton = document.querySelector('.page-link.prev');
        var nextButton = document.querySelector('.page-link.next');
        var currentPage = pageIndex ? parseInt(pageIndex) : 1;
        var totalPages = links.length;
        var maxVisiblePages = 5;

        // Remove the 'active' class from prev and next buttons initially
        prevButton.classList.remove('active');
        nextButton.classList.remove('active');

        function updatePageNumbers() {
            var startPage = Math.max(currentPage - Math.floor(maxVisiblePages / 2), 1);
            var endPage = Math.min(startPage + maxVisiblePages - 1, totalPages);

            if (endPage - startPage < maxVisiblePages - 1) {
                startPage = Math.max(endPage - maxVisiblePages + 1, 1);
            }

            links.forEach(function (link, index) {
                var pageNum = index + 1;
                if (pageNum >= startPage && pageNum <= endPage) {
                    link.style.display = 'inline-block';
                } else {
                    link.style.display = 'none';
                }
            });
        }

        function setActivePage(pageIndex) {
            links.forEach(function (link) {
                link.classList.remove('active');
                if (parseInt(link.textContent) === pageIndex) {
                    link.classList.add('active');
                }
            });
        }

        prevButton.addEventListener('click', function (event) {
            event.preventDefault();
            if (currentPage > 1) {
                currentPage--;
                updatePageNumbers();
            }
        });

        nextButton.addEventListener('click', function (event) {
            event.preventDefault();
            if (currentPage < totalPages) {
                currentPage++;
                updatePageNumbers();
            }
        });

        links.forEach(function (link) {
            link.addEventListener('click', function () {
                currentPage = parseInt(link.textContent);
                setActivePage(currentPage);
                navigateToPage(currentPage);
            });
        });

        // Initialize page numbers and active page
        updatePageNumbers();
        if (!pageIndex) {
            setActivePage(1);
        } else {
            setActivePage(currentPage);
        }

        function navigateToPage(pageIndex) {
            var url = new URL(window.location.href);
            url.searchParams.set('indexPage', pageIndex);
            window.location.href = url.toString();
        }

        function getQueryParameter(name) {
            var urlParams = new URLSearchParams(window.location.search);
            return urlParams.get(name);
        }
    });

    // Image modal handling
    function showImageModal(img) {
        var modal = document.getElementById('imageModal');
        var modalImg = document.getElementById('img01');
        modal.style.display = 'block';
        modalImg.src = img.src;
    }

    function closeImageModal() {
        var modal = document.getElementById('imageModal');
        modal.style.display = 'none';
    }

    function openModal(imgURL) {
        var modal = document.getElementById("myModal");
        var modalImg = document.getElementById("img01");
        var captionText = document.getElementById("caption");
        modal.style.display = "block";
        modalImg.src = imgURL;
        captionText.innerHTML = imgURL;
    }

    function closeModal() {
        var modal = document.getElementById("myModal");
        modal.style.display = "none";
    }
</script>

    </body>

</html>

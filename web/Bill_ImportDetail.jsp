<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import = "java.util.*" %>
<%@page import = "model.*" %>
<%@page import = "service.*" %>
<%@page import="model.Account"%>
<%@page import="helper.Role"%>

<% Account account = (Account) session.getAttribute("account"); %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/feedbackManagement.css" />
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Producter Feedback Dashboard</title>
        <style>
            .bill-table-container {
                overflow-x: auto;
         
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
                width: 80%;
                max-width: 700px;
            }
            .modal-content, #caption {
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
            .container {
                display: flex;
             
            }
            .search-form-container,
            .bill-table-container {
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 8px;
                background-color: #f9f9f9;
                min-height: 500px; /* Ensuring both sections have the same minimum height */
                box-sizing: border-box; /* Include padding and border in the element's total width and height */
            }
            .search-form-container {
                flex: 1; /* Equal flex value to both containers to balance them */
                max-width: 400px; /* Set a max-width to ensure the search form doesn't stretch too much */
            }
            .bill-table-container {
                flex: 3; /* Make the bill table container larger compared to the search form */
            }
            .search-form-container h2,
            .bill-table-container h2 {
                margin-bottom: 20px;
            }
            #searchForm {
                display: flex;
                flex-direction: column;
                gap: 10px;
            }
            #searchForm label {
                font-weight: bold;
                margin-bottom: 5px;
            }
            #searchForm input,
            #searchForm select {
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
                width: 100%;
                box-sizing: border-box; /* Include padding and border in the element's total width and height */
            }
            .button-group {
                display: flex;
                gap: 10px;
            }
            .button-group input[type="submit"],
            .button-group .reset-button {
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                background-color: #007bff;
                color: white;
                cursor: pointer;
                text-decoration: none;
                text-align: center;
            }
            .button-group .reset-button {
                background-color: #6c757d;
            }
            .button-group input[type="submit"]:hover,
            .button-group .reset-button:hover {
                background-color: #0056b3;
            }
            .bill-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            .bill-table th,
            .bill-table td {
                padding: 12px;
                border: 1px solid #ddd;
                text-align: left;
            }
            .bill-table th {
                background-color: #f2f2f2;
            }
            .bill-table img {
                max-width: 50px;
                height: auto;
            }
            .pagination {
                margin-top: 20px;
                text-align: center;
            }
            .pagination a {
                margin: 0 5px;
                padding: 10px 15px;
                border: 1px solid #ddd;
                border-radius: 4px;
                text-decoration: none;
                color: #007bff;
                transition: background-color 0.3s, color 0.3s;
                display: inline-block;
            }
            .pagination a:hover {
                background-color: #f1f1f1;
                color: #0056b3;
            }
            .pagination .active {
                background-color: #4CAF50;
                color: white;
                border: 1px solid #4CAF50;
            }
            .pagination .previous-button,
            .pagination .next-button {
                display: inline-block;
                padding: 10px 15px;
                border-radius: 4px;
                border: 1px solid #ddd;
                color: #007bff;
                text-decoration: none;
                transition: background-color 0.3s, color 0.3s;
            }
            .pagination .previous-button:hover,
            .pagination .next-button:hover {
                background-color: #f1f1f1;
                color: #0056b3;
            }
        </style>
    </head>

    <body>

        <jsp:include page="/shared/_slideBar.jsp" />

        <div class="content">
            <c:if  test ="${not empty param.search}">
                <a href="${pageContext.request.contextPath}/SearchImportBillController?searchbillId=${param.searchbillId}&createDateFrom=${param.createDateFrom}&createDateTo=${param.createDateTo}&totalPriceFrom=${totalPriceFrom}&totalPriceTo=${param.totalPriceTo}&indexPageback=${param.indexPageback}" class="back-button">Back to Order Management</a>
            </c:if>
            <c:if  test ="${ empty param.search}">
                <a href="${pageContext.request.contextPath}/ImportBillController?indexPageback=${param.indexPageback}" class="back-home">Back to View ImportBill</a>
            </c:if>

            <div class="header">

                <div class="role-info">
                    <span><%= account.getRole()%> :</span><span><%= account.getName()%></span>
                </div>
            </div>
                    <h1 style="margin: 25px auto 15px auto;text-align: center;text-transform: uppercase">Bill Detail Management</h1>
            <div class="container">
                <div class="search-form-container">
                    <h2>Search Import Bill Details</h2>
                    <form action="SearchImportBillDetailController" method="get" id="searchForm">
                        <input type="hidden" name="indexPageback" value="${param.indexPageback != null ?  param.indexPageback : indexPageback}">

                        <label for="detailBill_id">Detail Bill ID:</label>
                        <input type="text" id="detailBill_id" name="detailBill_id" pattern="\d+" title="Detail Bill ID must be a positive number" value="${param.detailBill_id}">

                        <label for="pro_name">Product Name:</label>
                        <input type="text" id="pro_name" name="pro_name" value="${param.pro_name}">

                        <label for="size_id">Size:</label>
                        <select name="size_id" id="size_id">
                            <option value="" <c:if test="${selectedSize == null or selectedSize == ''}">selected</c:if>>Not selected</option>
                            <c:forEach var="size" items="${sizesInBill}">
                                <option value="${size}" <c:if test="${size == selectedSize}">selected</c:if>>${size}</option>
                            </c:forEach>
                        </select>

                        <label for="color_name">Color:</label>
                        <select name="color_name" id="color">
                            <option value="" <c:if test="${selectedColor == null or selectedColor == ''}">selected</c:if>>Not selected</option>
                            <c:forEach var="color" items="${colorInBill}">
                                <option value="${color}" <c:if test="${color == selectedColor}">selected</c:if>>${color}</option>
                            </c:forEach>
                        </select>

                        <label for="quantityFrom">Quantity From:</label>
                        <input type="text" id="quantityFrom" name="quantityFrom" pattern="\d+" title="Quantity must be a positive number" value="${param.quantityFrom}">

                        <label for="quantityTo">Quantity To:</label>
                        <input type="text" id="quantityTo" name="quantityTo" pattern="\d+" title="Quantity must be a positive number" value="${param.quantityTo}">

                        <label for="import_priceFrom">Import Price From:</label>
                        <input type="text" id="import_priceFrom" name="import_priceFrom" pattern="\d+(\.\d{1,2})?" title="Import Price must be a positive number" value="${param.import_priceFrom}">

                        <label for="import_priceTo">Import Price To:</label>
                        <input type="text" id="import_priceTo" name="import_priceTo" pattern="\d+(\.\d{1,2})?" title="Import Price must be a positive number" value="${param.import_priceTo}">

                        <input type="hidden" name="billId" value="${billId}">
                        <div class="button-group">
                            <input style="background-color: green; width: 20%;margin-right: auto;"type="submit" value="Search">
                            <a style="background: red;" href="${pageContext.request.contextPath}/ImportBillDetailController?billId=${param.billId}&indexPageback=${param.indexPageback}" class="reset-button">Reset</a>

                        </div>
                    </form>
                </div>

                <div class="bill-table-container" style="text-align: center">
                    <h2>Import Bill Details</h2>
                    <table class="bill-table"style="text-align: center" >
                        <thead>
                            <tr style="text-align: center">
                                <th style="text-align: center">Detail Bill ID</th>
                                <th style="text-align: center">Bill ID</th>
                                <th style="text-align: center">Name</th>
                                <th style="text-align: center">Color</th>
                                <th style="text-align: center">Size</th>
                                <th style="text-align: center">Quantity</th>
                                <th style="text-align: center">Image</th>
                                <th style="text-align: center">Import Price</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="detailBill" items="${prvlst}">
                                <tr>
                                    <td style="text-align: center">${detailBill.detailBill_id}</td>
                                    <td style="text-align: center">${detailBill.bill_id}</td>
                                    <td style="text-align: center">${detailBill.pro_name}</td>
                                    <td style="text-align: center">${detailBill.color_name}</td>
                                    <td style="text-align: center">${detailBill.size_name}</td>
                                    <td style="text-align: center">${detailBill.quantity}</td>
                                    <td style="text-align: center"><img src="${detailBill.imageURL}" alt="Product Image"></td>
                                    <td style="text-align: center" class="totalAmount"><span><fmt:formatNumber value="${detailBill.import_price}" type="number" pattern="#,##0" />VND</span></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty prvlst}">
                                <tr class="not-found-row" >
                                    <td class="not-found-cell col-8" style="text-align: center" colspan="8">Not Found</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>

                    <!-- Pagination Section -->
                    <div class="pagination" id="pagination">
                        <c:if test="${endPage != 0}">
                            <a href="javascript:void(0);" class="previous-button page-link prev">&#9664;</a>
                            <c:forEach var="i" begin="1" end="${endPage}">
                                <a href="ImportBillDetailController?indexPage=${i}&billId=${param.billId}&indexPageback=${param.indexPageback}" class="pagination-button page-link <c:if test='${param.indexPage == i}'>active</c:if>' data-page="${i}">${i}</a>
                            </c:forEach>
                            <a href="javascript:void(0);" class="next-button page-link next">&#9654;</a>
                        </c:if>
                    </div>
                </div>
            </div>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
            <script src="./assets/js/feedbackManagement.js" type="text/javascript"></script>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    var pageIndex = getQueryParameter('indexPage');
                    var links = document.querySelectorAll('.pagination-button');
                    var prevButton = document.querySelector('.page-link.prev');
                    var nextButton = document.querySelector('.page-link.next');
                    var currentPage = pageIndex ? parseInt(pageIndex) : 1;
                    var totalPages = links.length;
                    var maxVisiblePages = 5;
                    var startPage = Math.max(currentPage - Math.floor(maxVisiblePages / 2), 1);
                    var endPage = Math.min(startPage + maxVisiblePages - 1, totalPages);
                    prevButton.classList.remove('active');
                    nextButton.classList.remove('active');
                    function showPageNumbers() {
                        links.forEach(function (link, index) {
                            var pageNum = index + 1;
                            if (pageNum >= startPage && pageNum <= endPage) {
                                link.style.display = 'inline-block';
                            } else {
                                link.style.display = 'none';
                            }
                        });
                        setActivePage(currentPage);
                    }
                    function setActivePage(pageIndex) {
                        links.forEach(function (link) {
                            link.classList.remove('active');
                            if (link.textContent == pageIndex) {
                                link.classList.add('active');
                            }
                        });
                    }
                    function updatePageNumbers(direction) {
                        if (direction === 'next' && endPage < totalPages) {
                            startPage = Math.max(startPage + 1, 1);
                            endPage = Math.min(endPage + 1, totalPages);
                        } else if (direction === 'prev' && startPage > 1) {
                            startPage = Math.max(startPage - 1, 1);
                            endPage = Math.min(endPage - 1, totalPages);
                        }
                        showPageNumbers();
                    }
                    prevButton.addEventListener('click', function (event) {
                        event.preventDefault();
                        if (startPage > 1) {
                            updatePageNumbers('prev');
                        }
                    });
                    nextButton.addEventListener('click', function (event) {
                        event.preventDefault();
                        if (endPage < totalPages) {
                            updatePageNumbers('next');
                        }
                    });
                    links.forEach(function (link) {
                        link.addEventListener('click', function () {
                            currentPage = parseInt(link.textContent);
                            startPage = Math.max(currentPage - Math.floor(maxVisiblePages / 2), 1);
                            endPage = Math.min(startPage + maxVisiblePages - 1, totalPages);
                            showPageNumbers();
                            setActivePage(currentPage);
                        });
                    });
                    // Show page numbers and set active page for the initial load
                    showPageNumbers();
                    setActivePage(currentPage);
                });
                function getQueryParameter(name) {
                    var urlParams = new URLSearchParams(window.location.search);
                    return urlParams.get(name);
                }
                function searchByUsername(param) {
                    var Username = param.value.trim();
                    if (Username === "") {
                        location.reload();
                        document.getElementById('pagination').style.display = 'flex';
                        return;
                    }
                    document.getElementById('pagination').style.display = 'none';
                    $.ajax({
                        url: "/clothesstore/SearchOrderManagementController",
                        type: "get", //send it through get method
                        data: {
                            Username: Username
                        },
                        success: function (data) {
                            var row = document.getElementById("searchstf");
                            row.innerHTML = data;
                        },
                        error: function (xhr) {
                            // Handle error
                        }
                    });
                }
            </script>
    </body>
</html>
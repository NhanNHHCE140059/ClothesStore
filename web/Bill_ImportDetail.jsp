<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import = "java.util.*" %>
<%@page import = "model.*" %>
<%@page import = "service.*" %>

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
                margin-top: 20px;
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
              <c:if  test ="${not empty param.search}">
            <a href="${pageContext.request.contextPath}/SearchImportBillController?searchbillId=${param.searchbillId}&createDateFrom=${param.createDateFrom}&createDateTo=${param.createDateTo}&totalPriceFrom=${totalPriceFrom}&totalPriceTo=${param.totalPriceTo}&indexPageback=${param.indexPageback}" class="back-button">Back to Order Management</a>
                                                    </c:if>
     <c:if  test ="${ empty param.search}">
            <a href="${pageContext.request.contextPath}/ImportBillController?indexPageback=${param.indexPageback}" class="back-home">Back to View ImportBill</a>
                                                    </c:if>
            
            <div class="header">
               
                <div class="role-info">
                    <span>Admin</span><span>Admin</span>
                </div>
            </div>

            <div class="bill-table-container">
                <h2>Search Import Bill Details</h2>
<form action="SearchImportBillDetailController" method="get" id="searchForm">



    <label for="detailBill_id">Detail Bill ID:</label>
    <input type="text" id="detailBill_id" name="detailBill_id" pattern="\d+" title="Detail Bill ID must be a positive number" value="${param.detailBill_id}"><br><br>

    <label for="pro_name">Product Name:</label>
    <input type="text" id="pro_name" name="pro_name" value="${param.pro_name}"><br><br>

    <label for="size_id">Size ID:</label>
    
    <input type="text" id="size_id" name="size_id" pattern="\d+" title="Size ID must be a positive number" value="${param.size_id}"><br><br>


    
<select name="color_name" id="color">
    <c:forEach var="color" items="${colorInBill}">
        <option value="${color}">${color}</option>
    </c:forEach>

</select>
    <label for="quantityFrom">Quantity From:</label>
    <input type="text" id="quantityFrom" name="quantityFrom" pattern="\d+" title="Quantity must be a positive number" value="${param.quantityFrom}"><br><br>

    <label for="quantityTo">Quantity To:</label>
    <input type="text" id="quantityTo" name="quantityTo" pattern="\d+" title="Quantity must be a positive number" value="${param.quantityTo}"><br><br>

    <label for="import_priceFrom">Import Price From:</label>
    <input type="text" id="import_priceFrom" name="import_priceFrom" pattern="\d+(\.\d{1,2})?" title="Import Price must be a positive number" value="${param.import_priceFrom}"><br><br>

    <label for="import_priceTo">Import Price To:</label>
    <input type="text" id="import_priceTo" name="import_priceTo" pattern="\d+(\.\d{1,2})?" title="Import Price must be a positive number" value="${param.import_priceTo}"><br><br>
    <input type="hidden" name ="bill_id" value="${param.billId}">
    <div class="button-group">
        <input type="submit" value="Search">
        <a href="${pageContext.request.contextPath}/ImportBillDetailSearchController?bill_id=${param.billId}" class="reset-button">Reset</a>
    </div>
</form>

                <table class="bill-table">
                    <thead>
                        <tr>
                            <th>Detail Bill ID</th>
                            <th>Bill ID</th>
                            <th>Name</th>
                            <th>Color</th>
                            <th>Size</th>
                            <th>Quantity</th>
                            <th>Image</th>
                            <th>Import Price</th>
                        </tr>
                    </thead>
     <tbody>
                    <c:forEach var="detailBill" items="${prvlst}">
                        <tr>
                            <td>${detailBill.detailBill_id}</td>
                            <td>${detailBill.bill_id}</td>
                            <td>${detailBill.pro_name}</td>
                            <td>${detailBill.color_name}</td>
                            <td>${detailBill.size_name}</td>
                            <td>${detailBill.quantity}</td>
                            <td><img src="${detailBill.imageURL}" alt="Product Image"></td>
                            <td>${detailBill.import_price}</td>
                        </tr>
                    </c:forEach>
                </tbody>
                </table>
                <div class="pagination" id="pagination">
                    <c:if test="${endPage != 0}">
                             <c:if test="${endPage > 1}">
                                <a href="ImportBillDetailController?indexPage=${param.indexPage - 1}&billId=${param.billId}&indexPageback=${param.indexPageback}" class="page-link prev" title="Previous Page">&#9664;</a>
                            </c:if>
                        <c:forEach var="i" begin="1" end="${endPage}">
                            <a href="ImportBillDetailController?indexPage=${i}&billId=${param.billId}&indexPageback=${param.indexPageback}" class="page-link">${i}</a>
                        </c:forEach>
                                     <c:if test="${endPage > 1}">
                                <a href="ImportBillDetailController?indexPage=${param.indexPage + 1}&billId=${param.billId}&indexPageback=${param.indexPageback}" class="page-link next" title="Next Page">&#9654;</a>
                            </c:if>
                    </c:if>
                </div>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="./assets/js/feedbackManagement.js" type="text/javascript"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var pageIndex = getQueryParameter('indexPage');
        var links = document.querySelectorAll('.page-link');
        var prevButton = document.querySelector('.page-link.prev');
        var nextButton = document.querySelector('.page-link.next');
        var currentPage = pageIndex ? parseInt(pageIndex) : 1;
        var totalPages = links.length;
        var maxVisiblePages = 5;
        var startPage = Math.max(currentPage - Math.floor(maxVisiblePages / 2), 1);
        var endPage = Math.min(startPage + maxVisiblePages - 1, totalPages);

        function showPageNumbers() {
            links.forEach(function(link, index) {
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
            links.forEach(function(link) {
                link.classList.remove('active');
                if (link.textContent == pageIndex) {
                    link.classList.add('active');
                }
            });
        }

        function updatePageNumbers(direction) {
            if (direction === 'next' && endPage < totalPages) {
                startPage++;
                endPage++;
            } else if (direction === 'prev' && startPage > 1) {
                startPage--;
                endPage--;
            }
            showPageNumbers();
        }

        prevButton.addEventListener('click', function(event) {
            event.preventDefault();
            if (startPage > 1) {
                updatePageNumbers('prev');
            }
        });

        nextButton.addEventListener('click', function(event) {
            event.preventDefault();
            if (endPage < totalPages) {
                updatePageNumbers('next');
            }
        });

        links.forEach(function(link) {
            link.addEventListener('click', function() {
                currentPage = parseInt(link.textContent);
                startPage = Math.max(currentPage - Math.floor(maxVisiblePages / 2), 1);
                endPage = Math.min(startPage + maxVisiblePages - 1, totalPages);
                showPageNumbers();
                setActivePage(currentPage);
            });
        });

        // Show page numbers and set active page for the initial load
        showPageNumbers();
        setActivePage(currentPage);  // Ensure the first page is set as active
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

            }
        });
    }
</script>

    </body>
</html>

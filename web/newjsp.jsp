<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/feedbackManagement.css" />
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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

            .form-container,
            .bill-table-container {
                width: 48%;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 5px;
                background-color: #f9f9f9;
                box-sizing: border-box;
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
            <div class="container">
                <div class="form-container">
                    <h2>Search Orders</h2>
                    <form action="SearchImportBillController" method="get" id="searchForm">
                        <label for="billId">Bill ID:</label>
                        <input type="text" id="billId" name="billId" pattern="\d+" title="Bill ID must be a positive number"
                               value="${param.billId}"><br><br>

                        <label for="createDateFrom">Create Date From:</label>
                        <input type="date" id="createDateFrom" name="createDateFrom" value="${param.createDateFrom}"><br><br>

                        <label for="createDateTo">Create Date To:</label>
                        <input type="date" id="createDateTo" name="createDateTo" value="${param.createDateTo}"><br><br>

                        <label for="totalPriceFrom">Total Price From:</label>
                        <input type="number" id="totalPriceFrom" name="totalPriceFrom" step="0.01" min="0"
                               value="${param.totalPriceFrom}"><br><br>

                        <label for="totalPriceTo">Total Price To:</label>
                        <input type="number" id="totalPriceTo" name="totalPriceTo" step="0.01" min="0"
                               value="${param.totalPriceTo}"><br><br>

                        <div class="button-group">
                            <input type="submit" value="Search">
                            <a href="ImportBillController">Back to All Import Bills</a>
                        </div>
                    </form>
                </div>

                <div class="bill-table-container">
                    <h2>Import Bills</h2>
                    <table class="bill-table">
                        <thead>
                            <tr>
                                <th>Bill ID</th>
                                <th>Create Date</th>
                                <th>Total Price</th>
                                <th>Detail</th>
                                <th>Images</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="bill" items="${importBills}">
                                <tr>
                                    <td>${bill.id}</td>
                                    <td><fmt:formatDate value="${bill.createDate}" pattern="yyyy-MM-dd" /></td>
                                    <td>${bill.totalPrice}</td>
                                    <td><button class="detail-button" onclick="showDetail(${bill.id})">Detail</button></td>
                                    <td>
                                        <c:forEach var="image" items="${bill.images}">
                                            <img src="${pageContext.request.contextPath}/images/${image}" onclick="showModal(this)" />
                                        </c:forEach>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <div class="pagination">
                        <div class="page-numbers">
                            <c:forEach var="i" begin="1" end="${numberOfPages}">
                                <a class="page-link ${i == currentPage ? 'active' : ''}" href="ImportBillController?page=${i}">${i}</a>
                            </c:forEach>
                        </div>
                        <a class="page-link prev" href="ImportBillController?page=${currentPage - 1}">Previous</a>
                        <a class="page-link next" href="ImportBillController?page=${currentPage + 1}">Next</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- The Modal -->
        <div id="myModal" class="modal">
            <span class="close" onclick="closeModal()">&times;</span>
            <img class="modal-content" id="modalImage">
            <div id="caption"></div>
        </div>

        <script>
            function showModal(img) {
                const modal = document.getElementById('myModal');
                const modalImg = document.getElementById('modalImage');
                const captionText = document.getElementById('caption');

                modal.style.display = 'block';
                modalImg.src = img.src;
                captionText.innerHTML = img.alt;
            }

            function closeModal() {
                document.getElementById('myModal').style.display = 'none';
            }

            function showDetail(billId) {
                // Implement the detail display logic here, e.g., open a new page or show a modal
                alert('Showing details for bill ID: ' + billId);
            }
        </script>
    </body>

</html>

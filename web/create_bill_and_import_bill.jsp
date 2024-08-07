<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Invoice</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/feedbackManagement.css"/>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.18/css/bootstrap-select.min.css" rel="stylesheet">
        <style>
            /* Your existing CSS styles */
            body {
                font-family: 'Arial', sans-serif;
                background-color: #f8f9fa;
                margin: 0;
                padding: 0;
                position: relative;
            }
            .overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 1000;
            }
            .invoice {
                width: 1200px;
                max-width: 1200px;
                margin: 50px auto;
                padding: 80px;
                background: #fff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.15);
            }
            .invoice-header, .invoice-footer {
                text-align: center;
                margin-bottom: 20px;
            }
            .invoice-header h1 {
                margin: 0;
                color: #0056b3;
            }
            .invoice-header h3 {
                margin: 5px 0 0 0;
                color: #666;
            }
            .invoice-details {
                margin-bottom: 30px;
            }
            .invoice-details .row > div {
                padding: 10px 0;
            }
            .invoice-details label {
                font-weight: bold;
            }
            .table th, .table td {
                padding: 12px;
                vertical-align: middle;
            }
            .table th {
                background: #0056b3;
                color: #fff;
            }
            .table tfoot th {
                background: none;
                color: #333;
                font-size: 16px;
            }
            .contact-info, .terms-conditions {
                margin-top: 30px;
            }
            .terms-conditions {
                font-size: 14px;
            }
            .terms-conditions p {
                margin: 0;
            }
            .button-container {
                text-align: center;
                margin-top: 20px;
            }
            .button-container button {
                margin: 0 10px;
            }
            .remove-btn {
                display: none;
            }
            .product-detail:first-child .remove-btn {
                display: none;
            }
            .product-detail:not(:first-child) .remove-btn {
                display: inline-block;
            }
            input[type="file"] {
                display: none;
            }
            .custom-file-upload {
                border: 1px solid #ccc;
                display: block;
                width: 130px;
                padding: 6px 12px;
                cursor: pointer;
                border-radius: 4px;
                background-color: #28a745;
                color: white;
            }
            input[list] {
                width: 100%;
                box-sizing: border-box;
            }
            select option {
                font-family: monospace;
                white-space: pre;
            }
            #imagePreview {
                display: none;
                margin-top: 10px;
                max-width: 200px;
                max-height: 200px;
            }
            .sidebar a {
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/shared/_slideBar.jsp" />
        <div class="content">
            <a href="${pageContext.request.contextPath}/home" class="back-home">Back to Home</a>
            <div class="header" style="justify-content:right;">
                <div class="role-info">
                    <span>${sessionScope.account.role}:</span><span>${sessionScope.account.name}</span>
                </div>
            </div>
        </div>
        <form id="importForm" action="createBill" method="post"  enctype="multipart/form-data">
            <div class="container mt-5">
                <h2>Create Import Bill</h2>

                <div class="form-group">
                    <label for="importDate">Date Create</label>
                    <input name='importDate' type="date" class="form-control" id="importDate" required>
                </div>
                <div class="form-group">
                    <label for="file-upload" class="custom-file-upload">
                        Upload Image
                    </label>
                    <input id="file-upload" name='image' onchange="validateImage(this)" type="file" accept="image/*"  required />
                    <img id="imagePreview" src="#" alt="Image Preview" />
                </div>
                <div id="productDetails">
                    <div class="product-detail form-row align-items-center">
                        <div class="col-md-4">
                            <label for="productType">Product Type</label>
                            <input list="productV" id="productType" class="form-control w-100 productType" name="productVariant">
                            <datalist id="productV">
                                <c:forEach var="product" items="${listAll}">
                                    <option value="${product.variant_id} | ${product.pro_name}  (${product.color_name})   (${product.size_id})"></option>
                                </c:forEach>
                            </datalist>
                        </div>
                        <div class="col-md-3">
                            <label for="quantity">Quantity</label>
                            <input type="number" name="quantity" class="form-control w-100 quantity" required>
                        </div>
                        <div class="col-md-3">
                            <label for="importPrice">Import Price</label>
                            <input type="text" name="importPrice" class="form-control w-100 importPrice" required oninput="formatPrice(this)" onblur="setCaretPosition(this)">
                        </div>
                        <div class="col-md-2 mt-4">
                            <button type="button" class="btn btn-danger remove-btn">Remove</button>
                        </div>
                    </div>
                </div>
                <button type="button" class="btn btn-primary mt-3" id="addMoreDetail">Add More Detail</button>
                <button  class="btn btn-success mt-3" id="previewBill">Preview Bill</button>

            </div>
            <div class="overlay" id="overlay" style="display:none;">
                <div class="invoice">
                    <div class="invoice-header">
                        <h1>Import Bill</h1>
                    </div>
                    <div class="invoice-details">
                        <div class="row">
                            <div class="col-sm-6">
                                <label>Staff Info</label>
                                <br>
                                Date Create: <span id="importDateDisplay"></span></p>
                            </div>
                        </div>
                    </div>
                    <p class="text-warning">Please double check before creating the bill, you will not be able to edit or delete the bill once added</p>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Product Type</th>
                                <th>Price ( VND )</th>
                                <th>Quantity</th>
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody id="invoiceBody">
                            <!-- Dynamic rows will be added here -->
                        </tbody>
                        <tfoot>
                            <tr>
                                <th colspan="3" class="text-right">Total Quantity:</th>
                                <th id="totalQuantity"></th>
                            </tr>
                            <tr>
                                <th colspan="3" class="text-right">Total Price:</th>
                                <th id="totalPrice"></th>
                            </tr>
                        </tfoot>
                    </table>
                    <div class="button-container">
                        <button type="submit" class="btn btn-success">Submit Import</button>
                        <button type="button" class="btn btn-secondary" onclick="closeOverlay()">Cancel</button>
                    </div>
                </div>
            </div>
        </form>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="./assets/js/feedbackManagement.js" type="text/javascript"></script>
        <script>
                            var selectedOptions = [];
                            var allOptions = [];

                            function validateImage(input) {
                                const file = input.files[0];
                                const validImageTypes = ['image/gif', 'image/jpeg', 'image/png', 'image/webp'];

                                if (file && validImageTypes.includes(file.type)) {
                                    readURL(input);
                                } else {
                                    alert('Please upload a valid image file (gif, jpeg, png, webp).');
                                    input.value = '';
                                    $('#imagePreview').hide();
                                }
                            }

                            function closeOverlay() {
                                document.getElementById('overlay').style.display = 'none';
                            }

                            function validateProductType(input) {
                                var value = $(input).val();
                                var datalistOptions = $('#productV option');
                                var isValid = false;

                                datalistOptions.each(function () {
                                    if (value === $(this).val() && !selectedOptions.includes(value)) {
                                        isValid = true;
                                        return false; // break loop
                                    }
                                });

                                if (!isValid) {
                                    alert('Please select a valid product type from the list.');
                                    $(input).val(''); // Clear the invalid input
                                } else {
                                    $(input).removeClass('invalid');
                                }

                                return isValid;
                            }

                            function readURL(input) {
                                if (input.files && input.files[0]) {
                                    var reader = new FileReader();

                                    reader.onload = function (e) {
                                        $('#imagePreview').attr('src', e.target.result);
                                        $('#imagePreview').show();
                                    };

                                    reader.readAsDataURL(input.files[0]);
                                }
                            }

                            function formatPrice(input) {
                                var value = input.value.replace(/\D/g, '');
                                value = parseInt(value, 10);
                                if (isNaN(value)) {
                                    value = 0;
                                }
                                input.value = value.toLocaleString('vi-VN') + ' VND';
                                setTimeout(function () {
                                    setCaretPosition(input);
                                }, 0);
                            }

                            function setCaretPosition(input) {
                                var position = input.value.length - 4; // Move caret before " VND"
                                input.setSelectionRange(position, position);
                            }

                            $(document).ready(function () {
                                $('#file-upload').change(function () {
                                    readURL(this);
                                });

                                $('#addMoreDetail').on('click', function () {
                                    var newDetail = `
            <div class="product-detail form-row align-items-center">
                <div class="col-md-4">
                    <label for="productType">Product Type</label>
                    <input list="productV" id="productType" class="form-control w-100 productType" name="productVariant">
                </div>
                <div class="col-md-3">
                    <label for="quantity">Quantity</label>
                    <input type="number" name="quantity" class="form-control w-100 quantity" required>
                </div>
                <div class="col-md-3">
                    <label for="importPrice">Import Price</label>
                    <input type="text" name="importPrice" class="form-control w-100 importPrice" required oninput="formatPrice(this)" onblur="setCaretPosition(this)">
                </div>
                <div class="col-md-2 mt-4">
                    <button type="button" class="btn btn-danger remove-btn">Remove</button>
                </div>
            </div>`;
                                    $('#productDetails').append(newDetail);
                                });

                                $(document).on('click', '.remove-btn', function () {
                                    var productType = $(this).closest('.product-detail').find('.productType').val();
                                    selectedOptions = selectedOptions.filter(function (item) {
                                        return item !== productType;
                                    });
                                    $(this).closest('.product-detail').remove();
                                });

                                $('#previewBill').on('click', function (event) {
                                    event.preventDefault();

                                    let isValid = true;
                                    let errorMsg = '';
                                    let importDate = $('#importDate').val();
                                    let formattedImportDate = formatDate(importDate);
                                    let fileUpload = $('#file-upload').val();


                                    if (!importDate) {
                                        isValid = false;
                                        errorMsg += 'Please select a date.\n';
                                    }
                                    if (!fileUpload) {
                                        isValid = false;
                                        errorMsg += 'Please upload an image.\n';
                                    }

                                    let productDetailsCount = $('.product-detail').length;
                                    if (productDetailsCount === 0) {
                                        isValid = false;
                                        errorMsg += 'Please add at least one product.\n';
                                    } else {
                                        $('.product-detail').each(function () {
                                            let productType = $(this).find('.productType');
                                            let quantity = $(this).find('.quantity').val();
                                            let importPrice = $(this).find('.importPrice').val();
                                            if (!validateProductType(productType)) {
                                                isValid = false;
                                                errorMsg += 'Please select a valid product type for each product.\n';
                                                return false;
                                            }
                                            if (!quantity || !importPrice) {
                                                isValid = false;
                                                errorMsg += 'Please fill in all product details.\n';
                                                return false;
                                            }
                                        });
                                    }

                                    if (!isValid) {
                                        alert(errorMsg);
                                        return;
                                    }

                                    let totalQuantity = 0;
                                    let totalPrice = 0;
                                    let invoiceBody = '';
                                    $('.product-detail').each(function () {
                                        let productType = $(this).find('.productType').val();
                                        let quantity = parseInt($(this).find('.quantity').val(), 10);
                                        let importPrice = parseFloat($(this).find('.importPrice').val().replace(/[^0-9]/g, ''));
                                        let total = quantity * importPrice;
                                        totalQuantity += quantity;
                                        totalPrice += total;
                                        let importPriceFormatted = importPrice.toLocaleString('vi-VN');
                                        let totalFormatted = total.toLocaleString('vi-VN') + ' VND';

                                        invoiceBody +=
                                                '<tr>' +
                                                '<td>' + productType + '</td>' +
                                                '<td>' + importPriceFormatted + ' VND</td>' +
                                                '<td>' + quantity + '</td>' +
                                                '<td>' + totalFormatted + '</td>' +
                                                '</tr>';
                                    });

                                    let totalPriceFormatted = totalPrice.toLocaleString('vi-VN') + ' VND';
                                    $('#invoiceBody').html(invoiceBody);
                                    $('#totalQuantity').text(totalQuantity);
                                    $('#totalPrice').text(totalPriceFormatted);
                                    $('#importDateDisplay').text(formattedImportDate);
                                    $('#overlay').show();
                                });
                                function formatDate(dateString) {
                                    let date = new Date(dateString);
                                    let day = date.getDate();
                                    let month = date.getMonth() + 1;
                                    let year = date.getFullYear();
                                    if (day < 10) {
                                        day = '0' + day;
                                    }
                                    if (month < 10) {
                                        month = '0' + month;
                                    }

                                    return month + '-' + day + '-' + year;
                                }
                            });

        </script>
    </body>
</html>

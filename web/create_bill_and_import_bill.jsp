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
        </style>
    </head>
    <body>
        <div class="sidebar">
            <div class="sidebar-header">Dashboard For Staff</div>
            <a href="#" class="menu-item">Product Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="/clothesstore/manage-product">Manage Product Variant</a>
                <a href="/clothesstore/main-manage-product">Manage Product</a>
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
        </div>
        <div class="content">
            <a href="${pageContext.request.contextPath}/home" class="back-home">Back to Home</a>
            <div class="header" style="justify-content:right;">
                <div class="role-info">
                    <span> :</span><span></span>
                </div>
            </div>
        </div>
        <div class="container mt-5">
            <h2>Create Import Bill</h2>
            <form id="importForm">
                <div class="form-group">
                    <label for="importDate">Date Create</label>
                    <input type="date" class="form-control" id="importDate" required>
                </div>
                <div class="form-group">
                    <label for="file-upload" class="custom-file-upload">
                        Upload Image
                    </label>
                    <input id="file-upload" type="file" accept="image/*" required />
                    <img id="imagePreview" src="#" alt="Image Preview" />
                </div>
                <div id="productDetails">
                    <div class="product-detail form-row align-items-center">
                        <div class="col-md-4">
                            <label for="productType">Product Type</label>
                            <input list="productV" id="productType" class="form-control w-100 productType" onblur="validateProductType(this)">
                            <datalist id="productV">
                                <c:forEach var="product" items="${listAll}">
                                    <option value="${product.variant_id} | ${product.pro_name}  (${product.color_name})   (${product.size_id})"></option>
                                </c:forEach>
                            </datalist>
                        </div>
                        <div class="col-md-3">
                            <label for="quantity">Quantity</label>
                            <input type="number" class="form-control w-100 quantity" required>
                        </div>
                        <div class="col-md-3">
                            <label for="importPrice">Import Price</label>
                            <input type="text" class="form-control w-100 importPrice" required oninput="formatPrice(this)" onblur="setCaretPosition(this)">
                        </div>
                        <div class="col-md-2 mt-4">
                            <button type="button" class="btn btn-danger remove-btn">Remove</button>
                        </div>
                    </div>
                </div>
                <button type="button" class="btn btn-primary mt-3" id="addMoreDetail">Add More Detail</button>
                <button type="submit" class="btn btn-success mt-3" id="previewBill">Preview Bill</button>
            </form>
        </div>
        <div class="overlay" id="overlay" style="display:none;">
            <div class="invoice">
                <div class="invoice-header">
                    <h1>Import Bill</h1>
                    <h3>Invoice No: 12345</h3>
                </div>
                <div class="invoice-details">
                    <div class="row">
                        <div class="col-sm-6">
                            <label>Staff Info</label>
                            <br>
                            Account Phone: <span id="accountPhone"></span><br>
                            Account Name: <span id="accountName"></span><br>
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
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
            var selectedOptions = [];
            var allOptions = [];

            function closeOverlay() {
                document.getElementById('overlay').style.display = 'none';
            }

            function removeOption(optionValue) {
                $('#productV option').each(function() {
                    if ($(this).val() === optionValue) {
                        allOptions.push({
                            value: $(this).val(),
                            index: $(this).index()
                        });
                        $(this).remove();
                        selectedOptions.push(optionValue);
                    }
                });
            }

            function restoreOption(optionValue) {
                var optionData = allOptions.find(function(option) {
                    return option.value === optionValue;
                });
                if (optionData) {
                    var newOption = $('<option></option>').val(optionData.value);
                    if (optionData.index === 0) {
                        $('#productV').prepend(newOption);
                    } else {
                        $('#productV option').eq(optionData.index - 1).after(newOption);
                    }
                    allOptions = allOptions.filter(function(option) {
                        return option.value !== optionValue;
                    });
                    selectedOptions = selectedOptions.filter(function(item) {
                        return item !== optionValue;
                    });
                }
            }

            function validateProductType(input) {
                var value = $(input).val();
                var datalistOptions = $('#productV option');
                var isValid = false;

                datalistOptions.each(function () {
                    if (value === $(this).val()) {
                        isValid = true;
                        removeOption(value);
                        return false; // break loop
                    }
                });

                if (!isValid) {
                    alert('Please select a valid product type from the list.');
                    $(input).val(''); // Clear the invalid input
                }
            }

            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        $('#imagePreview').attr('src', e.target.result);
                        $('#imagePreview').show();
                    }

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
                setTimeout(function() {
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
                                <input list="productV" id="productType" class="form-control w-100 productType" onblur="validateProductType(this)">
                            </div>
                            <div class="col-md-3">
                                <label for="quantity">Quantity</label>
                                <input type="number" class="form-control w-100 quantity" required>
                            </div>
                            <div class="col-md-3">
                                <label for="importPrice">Import Price</label>
                                <input type="text" class="form-control w-100 importPrice" required oninput="formatPrice(this)" onblur="setCaretPosition(this)">
                            </div>
                            <div class="col-md-2 mt-4">
                                <button type="button" class="btn btn-danger remove-btn">Remove</button>
                            </div>
                        </div>`;
                    $('#productDetails').append(newDetail);
                });

                $(document).on('click', '.remove-btn', function () {
                    var productType = $(this).closest('.product-detail').find('.productType').val();
                    restoreOption(productType);
                    $(this).closest('.product-detail').remove();
                });

                $('#previewBill').on('click', function (event) {
                    event.preventDefault();

                    let isValid = true;
                    let errorMsg = '';
                    let importDate = $('#importDate').val();
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
                            let productType = $(this).find('.productType').val();
                            let quantity = $(this).find('.quantity').val();
                            let importPrice = $(this).find('.importPrice').val();
                            if (!productType || !quantity || !importPrice) {
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
                    $('#importDateDisplay').text(importDate);
                    $('#overlay').show();
                });
            });
        </script>
    </body>
</html>

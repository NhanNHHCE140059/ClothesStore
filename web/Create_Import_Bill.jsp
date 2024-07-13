<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import = "java.util.*" %>
<%@page import = "model.ProductColor" %>
<%@page import = "model.Product" %>
<%@page import = "service.ProductColorService" %>
<%@page import = "service.ProductService" %>
<%@page import = "model.ProductsVariant" %>

<%
    ProductColorService prcsv = new ProductColorService();
    ProductService prsv = new ProductService();
    List<ProductsVariant> prvlst = (List<ProductsVariant>)request.getAttribute("prvlst");
    
    

    %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/feedbackManagement.css" />
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.12.6/js/standalone/selectize.min.js" integrity="sha256-+C0A5Ilqmu4QcSPxrlGpaZxJ04VjsRjKu+G82kl5UJk=" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.12.6/css/selectize.bootstrap3.min.css" integrity="sha256-ze/OEYGcFbPRmvCnrSeKbRTtjG4vGLHXgOqsyLFTRjg=" crossorigin="anonymous" />
        <title>Producter Feedback Dashboard</title>
        <style>
            .main-content {
                margin-left: 0; /* Adjust to 0 to align with the left edge */
                padding: 20px;
                width: 100%; /* Adjust width to fill the remaining space */
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-group label {
                display: block;
                margin-bottom: 5px;
            }

            .form-control {
                width: 100%;
                padding: 8px;
                box-sizing: border-box;
            }

            .form-footer {
                margin-top: 20px;
            }

            .btn {
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            .btn-success {
                background-color: #28a745;
                color: white;
            }

            .btn-success:hover {
                background-color: #218838;
            }

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
            <a href="#" class="menu-item">Import Bill Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="#">Create New Bill (Import Bill)</a>
                <a href="#">View Bill (Import Bill)</a>
            </div>
       
        </div>

        <div class="content">
            <a href="${pageContext.request.contextPath}/home" class="back-home">Back to Home</a>
            <div class="header">

                <div class="role-info">
                    <span>Admin</span><span>Admin</span>
                </div>
            </div>
            <div class="main-content">
                <form action="addProduct" method="post">
                    <div class="form-group">
                        <label for="image">Image</label>
                        <input id="image" name="image" type="file" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="price">Price</label>
                        <input id="price" name="price" type="number" class="form-control" oninput="this.value = this.value.replace(/^0+/, '');" required>
                    </div>
                    <div class="form-group">
                        <label for="amount">Amount</label>
                        <input id="amount" name="amount" type="number" class="form-control" oninput="this.value = this.value.replace(/^0+/, '');" required>
                    </div>


                    <div class="form-group">
                        <label for="select-variant">Variant</label>
<select id="select-variant" name="variant" class="form-select" aria-label="Default select example" required>
    <option value="">Select a variant...</option>
    <% for(ProductsVariant p : prvlst) { %>
        <option value="<%= p.getVariant_id() %>">
            <span style="font-weight: bold; min-width: 300px;display: inline-block" >Name:</span>&nbsp;<%= prsv.GetProById(p.getPro_id()).getPro_name() %>&nbsp;&nbsp;|&nbsp;&nbsp; 
            <span style="font-weight: bold;min-width: 300px;display: inline-block">Size:</span>&nbsp;<%= p.getSize_name() %>&nbsp;&nbsp;|&nbsp;&nbsp; 
            <span style="font-weight: bold;min-width: 300px; margin-right: 10px;display: inline-block">Color:</span><%= prcsv.GetProColorByID(p.getColor_id()).getColor_name() %>
        </option>
    <% } %>
</select>


                    </div>
                    <div class="form-footer">
                        <input type="submit" class="btn btn-success" value="Add">
                    </div>
                </form>
            </div>
        </div>

        <script>
            $(document).ready(function () {
                $('#select-variant').selectize({
                    create: false,
                    sortField: 'text'
                });
            });
            document.querySelectorAll('.menu-item').forEach(item => {
    item.addEventListener('click', () => {
        const submenu = item.nextElementSibling.nextElementSibling;
        const separator = item.nextElementSibling;
        if (submenu.style.display === 'block') {
            submenu.style.display = 'none';
            separator.style.display = 'block';
            item.classList.remove('active');
        } else {
            document.querySelectorAll('.submenu').forEach(sub => sub.style.display = 'none');
            document.querySelectorAll('.separator').forEach(sep => sep.style.display = 'block');
            document.querySelectorAll('.menu-item').forEach(i => i.classList.remove('active'));
            submenu.style.display = 'block';
            separator.style.display = 'none';
            item.classList.add('active');
        }
    });
});
        </script>
    </body>

</html>

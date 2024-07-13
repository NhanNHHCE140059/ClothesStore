<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/feedbackManagement.css"/>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Shop Management</title>
    </head>
    <body>
        <style>
            
            
        </style>
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
        <div class="content" >
            <a href="${pageContext.request.contextPath}/home" class=" back-home">Back to Home</a>
            <div class="header" style="text-align: right;">
       
                <div class="role-info">
                    <span> :</span><span></span>
                </div>
            </div>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
            <script src="./assets/js/feedbackManagement.js" type="text/javascript"></script>
    </body>

</html>

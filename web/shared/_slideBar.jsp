<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="stylesheet" href="style.css">
        <script src="scripts.js" defer></script>
    </head>
    <body>
        <div class="sidebar" style="z-index: 99999">
            <div class="sidebar-header">Dashboard For Staff</div>
            <a href="#" class="menu-item">Product Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="/clothesstore/manage-product">Manage Product Variants</a>
                <a href="/clothesstore/main-manage-product">Manage Products</a>
            </div>
            <a href="#" class="menu-item">Orders Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="/clothesstore/OrderHistoryStaffControl">View Orders</a>        
                <a href="/clothesstore/OrderHistoryStaffControllerManagement">Actions Orders</a>  
            </div>
            <a href="#" class="menu-item">Warehouse Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="/clothesstore/ViewWarehouse">View Warehouse</a>
            </div>
            <a href="#" class="menu-item">Bill Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="/clothesstore/ImportBillController">View Bill</a>
                <a href="/clothesstore/createBill">Create Bill</a>
            </div>
            <a href="#" class="menu-item">Feedback Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="/clothesstore/managementfeedback">View Feedback Orders</a>
                <a href="/clothesstore/feebackDetailForStaff">View Feedback Details</a>
            </div>
            <a href="#" class="menu-item">Category Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="/clothesstore/categories">Create Category</a>
            </div>
            <a href="#" class="menu-item">Color Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="/clothesstore/Color">Create Color</a>
            </div>
             <a href="#" class="menu-item">Size Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="/clothesstore/ViewSizeController">View Size</a>
            </div>
        </div>
    </body>
</html>

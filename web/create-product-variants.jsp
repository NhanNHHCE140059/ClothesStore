<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create New Product</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/create-product.css"/>

        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f8f9fa;
            }

            .sidebar {
                width: 250px;
                background-color: #2c3e50;
                color: #ecf0f1;
                height: 100vh;
                position: fixed;
                box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
                padding-top: 20px;
            }

            .sidebar-header {
                background-color: #1a252f;
                padding: 20px;
                text-align: center;
                font-size: 20px;
                font-weight: bold;
                color: #ecf0f1;
            }

            .sidebar a {
                display: block;
                color: #bdc3c7;
                padding: 15px 20px;
                text-decoration: none;
                border-left: 4px solid transparent;
                transition: all 0.3s ease;
            }

            .sidebar a:hover {
                background-color: #34495e;
                border-left: 4px solid #3498db;
                color: #ecf0f1;
            }

            .sidebar .separator {
                height: 1px;
                background-color: #34495e;
                margin: 0 20px;
            }

            .sidebar .submenu {
                display: none;
                background-color: #34495e;
            }

            .sidebar .submenu a {
                padding: 10px 35px;
                border-top: 1px solid #2c3e50;
            }

            .content {
                margin-left: 260px;
                padding: 20px;
            }

            .card {
                background-color: #fff;
                border: 1px solid #ddd;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin-bottom: 20px;
            }

            .card-header {
                background-color: #f5f5f5;
                border-bottom: 1px solid #ddd;
                padding: 15px;
                font-size: 18px;
                font-weight: bold;
                border-top-left-radius: 8px;
                border-top-right-radius: 8px;
            }

            .card-body {
                padding: 15px;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-control {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                margin-top: 5px;
            }

            .select, .choose-size, .choose-color, fieldset {
                border: 1px solid #ccc;
                padding: 10px;
                border-radius: 5px;
                margin-bottom: 15px;
            }

            legend {
                font-weight: bold;
            }

            .btn-create {
                padding: 10px 20px;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-align: center;
            }

            .btn-create:hover {
                background-color: #0056b3;
            }

            .back-home {
                display: inline-block;
                margin-top: 0px;
                background-color: #939aa3;
                color: white;
                padding: 0 14px;
                padding-top: 5px;
                padding-bottom: 9px;
                text-align: center;
                border-radius: 5px;
                text-decoration: none;
            }

            .back-home:hover {
                background-color: #7a828c;
            }

            .btn-add, .btn-remove {
                margin-top: 10px;
                padding: 10px 20px;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .btn-add:hover, .btn-remove:hover {
                background-color: #0056b3;
            }

            .btn-remove {
                background-color: #dc3545;
                margin-left: 10px;
            }

            .btn-remove:hover {
                background-color: #c82333;
            }

            .image-preview {
                display: block;
                margin-top: 10px;
                max-width: 100px;
                max-height: 100px;
                border: 1px solid #ddd;
                border-radius: 5px;
            }
            .input-group input[type="file"]{

                width: 40%;
            }
              .color-box {
        display: inline-block;
        width: 20px;
        height: 20px;
        margin-right: 10px;
        border: 1px solid #ccc;
        vertical-align: middle;
        border-radius:50%;
    }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <div class="sidebar-header">Dashboard For Staff</div>
            <a href="#" class="menu-item">Product Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="#">Manage Product Variant</a>
                <a href="#">Manage Product</a>
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
            <div class="card">
                <div class="card-header">Create New Product</div>
                <div class="card-body">
                    <form action="create-product" method="post" enctype="multipart/form-data">
                        <div class="input-group form-group">
                            <label>Product name:</label>
                            <input list="nameProduct" id="productInput"   onchange="onInputChange(this.value)" style="padding:5px;border-radius:6px; border: 0.5px solid;overflow: hidden"placeholder="Please choose Product">
                            <datalist id="nameProduct">
                                <c:forEach var="product" items="${listAllProduct}">
                                    <option value="${product.pro_name}"></option>
                                </c:forEach>
                            </datalist>
                            <p id="error-message" style="color: red; display: none;">Please choose one Product</p>
                        </div>
                        <div class="form-group" id="image-group">
                            <label>Image:</label>
                            <div class="input-group" >
                                <input type="file" name="imageURL[]" class="form-control"  multiple require onchange="previewImage(this)">
                                <img class="image-preview" style="display:none;" />
                            </div>
                        </div>
                        <button type="button" class="btn-add" onclick="addImageField()">Add more image</button>
                        <div>
                            <div class="input-group form-group">
                                <label>Price:</label>
                                <input type="text" id="price" name="price" value="" class="form-control" placeholder="Price" readonly>
                            </div>
                            <div class="input-group form-group">
                                <label>Description:</label>
                                <textarea id="description" name="description" class="form-control" placeholder="Description" style="resize: none;height: 120px;" readonly></textarea>
                            </div>
                            <div class="select">
                                <label>Category name:</label>
                                <input type="text" id="categoryName" name="categoryName" class="form-control" placeholder="Category Name" style="width:90%"readonly>                     
                            </div>
                        </div>
                        <div class="choose-size">
                            <fieldset>
                                <legend>Choose Sizes</legend>
                                <c:forEach var="size" items="${allSize}" begin="1">
                                <input type="radio" name="size" value="${size}">${size}<br>
                                </c:forEach>
                            </fieldset>
                        </div>
                        <div class="choose-color">
                            <fieldset>
                                <legend>Choose Colors</legend>
                                <c:forEach var="color" items="${listAllColor}">
                                    <label>
                                        <input type="radio" name="color" value="${color.color_id}">
                                        <span class="color-box" style="background-color: ${color.color_name};"></span> ${color.color_name}
                                    </label>
                                    <br>
                                </c:forEach>


                                <button type="button" onclick="addColor()">New Color</button>
                            </fieldset>
                        </div>
                        <div class="form-group d-flex justify-content-center">
                            <input type="submit" value="Create" class="btn-create">
                            <a href="${pageContext.request.contextPath}/manage-product" class="back-home">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>



        <script>

                                    function addImageField() {
                                        var imageGroup = document.getElementById('image-group');
                                        var newImageDiv = document.createElement('div');
                                        newImageDiv.classList.add('input-group');
                                        newImageDiv.style.marginTop = '10px';
                                        var newImageField = document.createElement('input');
                                        newImageField.type = 'file';
                                        newImageField.multiple = true;
                                        newImageField.name = 'imageURL[]';
                                        newImageField.classList.add('form-control');
                                        newImageField.setAttribute("onchange", "previewImage(this)");
                                        var removeButton = document.createElement('button');
                                        removeButton.type = 'button';
                                        removeButton.classList.add('btn-remove');
                                        removeButton.textContent = 'Remove';
                                        removeButton.onclick = function () {
                                            removeImageField(this);
                                        };
                                        var previewImage = document.createElement('img');
                                        previewImage.classList.add('image-preview');
                                        previewImage.style.display = 'none';
                                        newImageDiv.appendChild(newImageField);
                                        newImageDiv.appendChild(removeButton);
                                        newImageDiv.appendChild(previewImage);
                                        imageGroup.appendChild(newImageDiv);
                                    }

                                    function removeImageField(button) {
                                        var imageGroup = document.getElementById('image-group');
                                        var inputGroup = button.parentNode;
                                        if (imageGroup.childElementCount > 1) {
                                            imageGroup.removeChild(inputGroup);
                                        }
                                    }

                                    function previewImage(input) {
                                        if (input.files && input.files[0]) {
                                            var reader = new FileReader();
                                            reader.onload = function (e) {
                                                var preview = input.nextElementSibling.nextElementSibling;
                                                preview.src = e.target.result;
                                                preview.style.display = 'block';
                                            };
                                            reader.readAsDataURL(input.files[0]);
                                        }
                                    }

                                    document.addEventListener("DOMContentLoaded", function () {
                                        var firstRemoveButton = document.querySelector('.input-group .btn-remove');
                                        if (firstRemoveButton) {
                                            firstRemoveButton.disabled = true;
                                            firstRemoveButton.style.backgroundColor = '#ccc';
                                            firstRemoveButton.style.cursor = 'not-allowed';
                                        }
                                    });
                                    document.addEventListener("DOMContentLoaded", function () {
                                        var firstFileInput = document.querySelector('.input-group input[type="file"]');
                                        var firstPreviewImage = document.querySelector('.input-group .image-preview');
                                        if (firstFileInput && firstPreviewImage) {
                                            firstFileInput.addEventListener('change', function () {
                                                if (this.files && this.files[0]) {
                                                    var reader = new FileReader();
                                                    reader.onload = function (e) {
                                                        firstPreviewImage.src = e.target.result;
                                                        firstPreviewImage.style.display = 'block';
                                                    };
                                                    reader.readAsDataURL(this.files[0]);
                                                }
                                            });
                                        }
                                    });
                                    function onInputChange(value) {
                                        console.log("imhere");
                                        console.log(value);
                                        if (value === "") {

                                        } else {

                                            $.ajax({
                                                url: "/clothesstore/createVariants",
                                                type: "get",
                                                data: {
                                                    proName: value
                                                },
                                                success: function (data) {
                                                    $('#price').val(data.price);
                                                    $('#description').val(data.description);
                                                    $('#categoryName').val(data.categoryName);
                                                },
                                                error: function (xhr) {

                                                }
                                            });
                                        }
                                    }

        </script>
    </body>
</html>

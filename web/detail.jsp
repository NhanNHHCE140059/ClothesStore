<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="model.ProductImage" %>
<%@page import="java.util.List" %>
<%@page import="service.ProductImageService" %>
<% ProductImageService proImgService = new  ProductImageService();
    List<ProductImage> imgList = proImgService.getImageByID(Integer.parseInt(request.getParameter("pid")));
%> 
<!DOCTYPE html>
<html>
    <jsp:include page="/shared/_head.jsp" />
    <style>
        .product-detail-img-container {
            width: 100%;
            height: 520px;
            display: flex;
             padding: 0 !important;
            justify-content: space-between;
            align-items: center;
            background-color: #f8f9fa;
          box-shadow: rgba(0, 0, 0, 0.1) 0px 20px 25px -5px, rgba(0, 0, 0, 0.04) 0px 10px 10px -5px;
        }

        .product-detail-img {
            max-width: 100%;
            max-height: 100%;
            object-fit: cover;
          box-shadow: rgba(0, 0, 0, 0.1) 0px 20px 25px -5px, rgba(0, 0, 0, 0.04) 0px 10px 10px -5px;
        }

        .box {
            width: 310px;
            height: 100px;
            background-color: #ffd333;
            position: absolute;
            top: 50%;
            right: -350px; /* Start outside the screen */
            transform: translateY(-50%);
            animation: moveAndHide 5s forwards;
            z-index: 1000;
            border: 2px solid #3d464d;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            padding: 10px;
        }

        .box img {
            width: 50px;
            height: 50px;
            border-radius: 5px;
            margin-left: 10px;
        }

        .box .content {
            display: flex;
            flex-direction: column;
            justify-content: center;
            flex-grow: 1;
        }

        .box .content p {
            color: #3d464d;
            font-weight: 600;
            margin: 0;
        }

        .box .content .product-name {
            font-size: 1.2em;
        }

        .box .content .product-price {
            color: #000;
            font-size: 1.1em;
        }

        @keyframes moveAndHide {
            0% {
                right: -350px; /* Start outside the screen */
                opacity: 1;
            }
            50% {
                right: 10px; /* Fully visible */
                opacity: 1;
            }
            100% {
                right: 10px;
                opacity: 0;
            }
        }

        .faillength {
            background: red;
        }

        .thumbnail-container {
            display: flex;
            justify-content: center;
            margin: 32px 30px 10px 0px;
        }

        .thumbnail {
            width: 85px;
            height: 85px;
            margin: 0 5px;
    box-shadow: rgba(0, 0, 0, 0.1) 0px 20px 25px -5px, rgba(0, 0, 0, 0.04) 0px 10px 10px -5px;
            cursor: pointer;
        }
        .thumbnail:hover {
            box-shadow: rgba(255, 211, 51, 1) 0px 0px 0px 3px;
        }

        .thumbnail img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
             .size-options, .color-options {
            display: flex;
            margin-bottom: 15px;
        }

        .size-options button, .color-options button {
            margin-right: 10px;
            border: 1px solid #ccc;
            padding: 5px 10px;
            cursor: pointer;
            background-color: white;
        }

        .size-options button:hover, .color-options button:hover {
            border-color: #007bff;
        }

        .size-options button.active, .color-options button.active {
            border-color: #007bff;
            background-color: #007bff;
            color: white;
        }
    </style>
    <body>
        <jsp:include page="/shared/_header.jsp" />
        <jsp:include page="/shared/_nav.jsp" />

        <!-- Breadcrumb Start -->
        <c:if test="${not empty successP}">
            <div class="box">
                <div class="content">
                    <p>Thank you for adding to cart!</p>
                    <p class="product-name">${successP.pro_name}</p>
                </div>
                <img src="${successP.imageURL}" alt="Product Image">
            </div>
        </c:if>   
        <c:if test="${param.fail == 1}">
            <div class="box faillength">
                <div class="content">
                    <p style="padding-left:20px">You entered too many quantities!!!</p>                    
                </div>               
            </div>
        </c:if>
        <c:if test="${param.fail == 3}">
            <div class="box faillength">
                <div class="content">
                    <p style="padding-left:40px">This product is out of stock!!!</p>                    
                </div>               
            </div>
        </c:if>
        <div class="container-fluid">
            <div class="row px-xl-5">
                <div class="col-12">
                    <nav class="breadcrumb bg-light mb-30">
                        <a class="breadcrumb-item text-dark" href="/clothesstore/home">Home</a>
                        <a class="breadcrumb-item text-dark" href="/clothesstore/shop">Shop</a>
                        <span class="breadcrumb-item active">Product Detail</span>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Breadcrumb End -->


        <!-- Shop Detail Start -->
        <div class="container-fluid pb-5">
            <div class="row px-xl-5 align-items-center">
                <div class="col-lg-5 mb-4 mb-lg-0 product-detail-img-container">
                       <!-- Thumbnail Images Start -->
            <div class="row px-xl-5">
                <div class="col-12 text-center">
                    <%         if (imgList.size() !=0 ) {
                             for (ProductImage img :imgList){ %>
                    <div class="thumbnail-container">                       
                            <div class="thumbnail">
                                <img src="<%= img.getImageURL()%>" alt="Thumbnail" onmouseover="changeMainImage('<%= img.getImageURL() %>')">
                            </div>
                    </div>
                    <% }}%>
                </div>
            </div>
            <!-- Thumbnail Images End -->
                    <img class="product-detail-img" id="mainImage" src="${pro_detail.imageURL}" alt="Image">
                </div>
                <div class="col-lg-7">
                    <div class="bg-light p-4 rounded">
                        <h3 class="my-3">${pro_detail.pro_name}</h3>
                        <div class="d-flex mb-3">
                            <div class="text-primary mr-2">
                                <small class="fas fa-star"></small>
                                <small class="fas fa-star"></small>
                                <small class="fas fa-star"></small>
                                <small class="fas fa-star-half-alt"></small>
                                <small class="far fa-star"></small>
                            </div>
                            <small class="pt-1">(99 Reviews)</small>
                        </div>
                        <h4 class="font-weight-semi-bold mb-4 my-3">
                            <fmt:formatNumber value="${pro_detail.pro_price}" type="number" pattern="#,##0"/> VND
                        </h4>
                        <p class="mb-4">${pro_detail.description}</p>
                          <!-- Size and Color Options Start -->
                        <div class="size-options mb-4">
                            <label for="size" style="margin:6px 12px 0 0;" >Size:</label>
                            <button class="size-btn">S</button>
                            <button class="size-btn">M</button>
                            <button class="size-btn">L</button>
                            <button class="size-btn">XL</button>
                        </div>
                        <div class="color-options mb-4">
                            <label for="color" style="margin:6px 12px 0 0;">Color:</label>
                            <button class="color-btn" style="background-color: #000000;"></button>
                            <button class="color-btn" style="background-color: #ffffff;"></button>
                            <button class="color-btn" style="background-color: #ff0000;"></button>
                            <button class="color-btn" style="background-color: #0000ff;"></button>
                        </div>
                        <!-- Size and Color Options End -->
                        <div class="d-flex align-items-center mb-4 pt-2">
                            <div class="input-group quantity mr-3" style="width: 130px;">
                                <div class="input-group-prepend">
                                    <button class="btn btn-primary btn-minus">
                                        <i class="fa fa-minus"></i>
                                    </button>
                                </div>
                                <c:choose>
                                    <c:when test= "${param.fail == 3}">
                                        <input id="quantityInput" type="text" class="form-control bg-secondary border-0 text-center" value="0" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                                    </c:when>
                                    <c:otherwise>
                                        <input id="quantityInput" type="text" class="form-control bg-secondary border-0 text-center" value="1" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                                    </c:otherwise> 
                                </c:choose>                                
                                <div class="input-group-append">
                                    <button class="btn btn-primary btn-plus">
                                        <i class="fa fa-plus"></i>
                                    </button>
                                </div>
                            </div>
                            <a id="addToCartBtn" class="btn btn-primary px-3" href="${pageContext.request.contextPath}/cart?action=addToCart&pro_id=${pro_detail.pro_id}&">
                                <i class="fa fa-shopping-cart mr-1"></i> Add To Cart
                            </a>
                            <p style="padding-left: 50px; margin-top: 22px;"><%= request.getAttribute("totalP")%> Product availability</p>
                        </div>
                    </div>
                </div>
            </div>

         

        </div>
        <!-- Shop Detail End -->

        <jsp:include page="/shared/_footer.jsp" />
    </body>
    <script>
        function changeMainImage(newSrc) {
            document.getElementById('mainImage').src = newSrc;
        }

        document.addEventListener('DOMContentLoaded', function () {
            document.getElementById('addToCartBtn').addEventListener('click', function (event) {
                event.preventDefault();
                var quantity = document.getElementById('quantityInput').value;
                var href = this.getAttribute('href');
                var newHref = href + 'quantity=' + quantity;
                window.location.href = newHref;
            });
        });
        
    </script>
</html>

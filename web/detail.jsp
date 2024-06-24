<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <jsp:include page="/shared/_head.jsp" />
    <style>
        .product-detail-img-container {
            width: 100%;
            height: 400px;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f8f9fa;
        }

        .product-detail-img {
            max-width: 100%;
            max-height: 100%;
            object-fit: cover;
        }
    </style>
    <body>
        <jsp:include page="/shared/_header.jsp" />
        <jsp:include page="/shared/_nav.jsp" />

        <!-- Breadcrumb Start -->
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
                    <img class="product-detail-img" src="${pro_detail.imageURL}" alt="Image">
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

                        <div class="d-flex align-items-center mb-4 pt-2">
                            <div class="input-group quantity mr-3" style="width: 130px;">
                                <div class="input-group-prepend">
                                    <button class="btn btn-primary btn-minus">
                                        <i class="fa fa-minus"></i>
                                    </button>
                                </div>
                                <input type="text" class="form-control bg-secondary border-0 text-center" value="1">
                                <div class="input-group-append">
                                    <button class="btn btn-primary btn-plus">
                                        <i class="fa fa-plus"></i>
                                    </button>
                                </div>
                            </div>
                            <button class="btn btn-primary px-3">
                                <i class="fa fa-shopping-cart mr-1"></i> Add To Cart
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- Shop Detail End -->

        <!-- Products End -->

        <jsp:include page="/shared/_footer.jsp" />
    </body>
</html>
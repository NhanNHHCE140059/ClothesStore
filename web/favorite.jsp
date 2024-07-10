<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <jsp:include page="/shared/_head.jsp" />
    <body>
        <jsp:include page="/shared/_header.jsp" />
        <jsp:include page="/shared/_nav.jsp" />

        <style>
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
        </style>
        <!-- Breadcrumb Start -->

        <c:if test="${ not empty message}">
            <div class="box">
                <div class="content">
                    <p>Product successfully added to Favorite List!</p>
                    <p class="product-name">${message.pro_name}</p>
                </div>
                <img src="${message.imageURL}" alt="Product Image">
            </div>
        </c:if>    
        <div class="container-fluid">
            <div class="row px-xl-5">
                <div class="col-12">
                    <nav class="breadcrumb bg-light mb-30">
                        <a class="breadcrumb-item text-dark" href="/clothesstore/home">Home</a>
                        <a class="breadcrumb-item text-dark" href="/clothesstore/shop">Shop</a>
                        <span class="breadcrumb-item active">Favorite List</span>
                    </nav>
                </div>
            </div>
        </div>

        <div>
            <div class="row px-xl-5">
                <!-- Shop Sidebar Start -->
                <div class="col-lg-3 col-md-4">
                    <h5 class="section-title position-relative text-uppercase mb-3"><span class="bg-secondary pr-3" style="padding-left: 15px">Favorite Products</span></h5>
                </div>
            </div>

            <div class="col-lg-9 col-md-8" style="margin: 0 0 0 200px;">
                <div class="row pb-3">
                    <style>
                        .product-item {
                            height: 100%;
                        }

                        .product-img img {
                            height: 340px;
                            object-fit: fill;
                        }
                    </style>
                    <div class="row">
                        <c:forEach items="${listP}" var="o" begin="0" end="8">
                            <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                <div class="product-item bg-light border rounded">
                                    <div class="product-img position-relative overflow-hidden">
                                        <img class="img-fluid w-100" src="${o.imageURL}">
                                        <div class="product-action">
                                            <a class="btn btn-outline-dark btn-sm" href="/clothesstore/detail?pid=${o.pro_id}"><i class="fa fa-shopping-cart"></i> Add to Cart</a>
                                            <a class="btn btn-outline-dark btn-sm" href="/clothesstore/detail?pid=${o.pro_id}"><i class="fa fa-trash"></i> Delete favorite product</a>
                                        </div>
                                    </div>
                                    <div class="text-center py-3">
                                        <a class="h6 text-decoration-none text-truncate text-dark" href="/clothesstore/detail?pid=${o.pro_id}">${o.pro_name}</a>
                                        <div class="d-flex align-items-center justify-content-center mt-2">
                                            <h5 class="font-weight-bold"><fmt:formatNumber value="${o.pro_price}" type="number" pattern="#,##0"/> VND</h5>
                                        </div>
                                        <div class="d-flex align-items-center justify-content-center mb-1">
                                            <small class="fa fa-star text-warning mr-1"></small>
                                            <small class="fa fa-star text-warning mr-1"></small>
                                            <small class="fa fa-star text-warning mr-1"></small>
                                            <small class="fa fa-star text-warning mr-1"></small>
                                            <small class="fa fa-star text-warning mr-1"></small>
                                            <small>(99)</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>


                    <div class="col-12">
                        <nav>
                            <ul class="pagination justify-content-center">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item"><a class="page-link" href="favorite?page=${currentPage - 1}">Previous</a></li>
                                    </c:if>
                                    <c:forEach var="i" begin="1" end="${noOfPages}">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}"><a class="page-link" href="favorite?page=${i}">${i}</a></li>
                                    </c:forEach>
                                    <c:if test="${currentPage < noOfPages}">
                                    <li class="page-item"><a class="page-link" href="favorite?page=${currentPage + 1}">Next</a></li>
                                    </c:if>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
            <!-- Shop Product End -->
        </div>
    </div>
    <!-- Shop End -->

    <jsp:include page="/shared/_footer.jsp" />
</body>
</html>
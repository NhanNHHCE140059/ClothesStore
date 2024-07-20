<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <jsp:include page="/shared/_head.jsp" />
    <body>
        <style>
            .toast {
                position: fixed;
                z-index: 99999;
                width: 400px;
                top: 25px;
                right: 30px;
                border-radius: 12px;
                background: #fff;
                padding: 20px 35px 20px 25px;
                box-shadow: 0 5px 10px rgba(0,0,0,0.1);
                border-left: 6px solid #ffc107; /* Màu vàng */
                overflow: hidden;
                transform: translateX(calc(100% + 30px));
                transition: all 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.35);
                opacity: 1!important;
            }

            .toast.active {
                transform: translateX(0%);
                opacity: 1!important;
            }

            .toast .toast-content {
                display: flex;
                align-items: center;
            }

            .toast-content .check {
                display: flex;
                align-items: center;
                justify-content: center;
                height: 35px;
                width: 35px;
                background-color: #ffc107; /* Màu vàng */
                color: #ffc107;
                font-size: 20px;
                border-radius: 50%;
            }

            .toast-content .message {
                display: flex;
                flex-direction: column;
                margin: 0 20px;
            }

            .message .text {
                font-size: 20px;
                font-weight: 400;
                color: #666666;
            }

            .message .text.text-1 {
                font-weight: 600;
                color: #333;
            }

            .toast .close {
                position: absolute;
                top: 10px;
                right: 15px;
                padding: 5px;
                cursor: pointer;
                opacity: 0.7;
            }

            .toast .close:hover {
                opacity: 1;
            }

            .toast .progress {
                position: absolute;
                bottom: 0;
                left: 0;
                height: 3px;
                width: 100%;
                background: #ddd;
            }

            .toast .progress:before {
                content: '';
                position: absolute;
                bottom: 0;
                right: 0;
                height: 100%;
                width: 100%;
                background-color: #ffc107; /* Màu vàng */
            }

            .progress.active:before {
                animation: progress 5s linear forwards;
            }

            @keyframes progress {
                100% {
                    right: 100%;
                }
            }

        </style>
        <jsp:include page="/shared/_header.jsp" />
        <jsp:include page="/shared/_nav.jsp" />
        <!-- Breadcrumb Start -->
        <c:if test="${param.fvss ==1}">
            <div class="toast" id="toast">
                <div class="toast-content">
                    <i class="fas fa-solid fa-exclamation"></i>
                    <div class="message">
                        <span class="text text-1"> Already in favorites!!</span>
                        <span class="text text-2">Product is available in Favorite List!!!</span>
                    </div>
                </div>
                <span class="close">&times;</span>
                <div class="progress active"></div>
            </div>
        </c:if>
        <div class="container-fluid">
            <div class="row px-xl-5">
                <div class="col-12">
                    <nav class="breadcrumb bg-light mb-30">
                        <a class="breadcrumb-item text-dark" href="/clothesstore/home">Home</a>
                        <a class="breadcrumb-item text-dark" href="/clothesstore/shop">Shop</a>
                        <span class="breadcrumb-item active">Shop List</span>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Breadcrumb End -->

        <!-- Shop Start -->
        <div class="container-fluid">
            <div class="row px-xl-5">
                <!-- Shop Sidebar Start -->
                <div class="col-lg-3 col-md-4">
                    <!-- Category Start -->
                    <h5 class="section-title position-relative text-uppercase mb-3"><span class="bg-secondary pr-3">Filter by Category</span></h5>
                    <div class="bg-light p-4 mb-30">
                        <form method="get" action="shop">
                            <c:forEach var="cate" items="${listAllCate}">
                                <div class="align-items-center justify-content-between mb-3">
                                    <input type="checkbox" name="cate_ids" value="${cate.cat_id}" id="price-${cate.cat_id}"
                                           <c:if test="${selectedCatIds != null && selectedCatIds.contains(cate.cat_id)}">
                                               checked
                                           </c:if>
                                           >
                                    <label for="price-${cate.cat_id}">${cate.cat_name}</label>
                                </div>
                            </c:forEach>
                            <button type="submit" style="background-color: #ffd333; color: #fff; border: none; padding: 10px 20px; border-radius: 5px; font-size: 16px; cursor: pointer;">
                                Filter
                            </button>
                        </form>
                    </div>
                    <!-- Category End -->


                    <!-- Random Products Start -->
                    <h5 class="section-title position-relative text-uppercase mb-3"><span class="bg-secondary pr-3">Top 3 Trending</span></h5>
                    <div class="bg-light p-4 mb-30 top-3-products text-center" style="max-height: 73-px">
                        <c:forEach var="product" items="${top3Sell}">
                            <div class="product-items" style="height:230px; width: auto;border:1px solid;margin-top: 4px; border-radius:4px" >
                                <div class="product-imgs">
                                    <img class="img-fluid" style="width: 30%;height: auto;margin-top:4px;" src="${product.imageURL}">
                                    <div class="product-actions">

                                        <a class="btn btn-outline-dark btn-sm" href="/clothesstore/detail?pid=${product.pro_id}"><i class="fa fa-info-circle"></i> More information and Buy</a>
                                    </div>
                                </div>
                                <div class="text-center py-3">
                                    <a class="h6 text-decoration-none text-truncate text-dark" href="/clothesstore/detail?pid=${product.pro_id}">${product.pro_name}</a>
                                    <div class="d-flex align-items-center justify-content-center mt-2">
                                        <h5 class="font-weight-bold"><fmt:formatNumber value="${product.pro_price}" type="number" pattern="#,##0"/> VND</h5>
                                    </div>
                                </div>
                            </div>

                        </c:forEach>
                    </div>
                    <!-- Random Products End -->
                </div>
                <!-- Shop Sidebar End -->

                <!-- Shop Product Start -->
                <div class="col-lg-9 col-md-8">
                    <div class="row pb-3">
                        <style>
                            .product-item {
                                height: 100%;
                            }

                            .product-img img {
                                height: 340px; /* Điều chỉnh chiều cao của hình ảnh */
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
                                                <c:set var="page" value="${param.page != null ? param.page : 1}" />
                                                <a class="btn btn-outline-dark btn-sm" href="/clothesstore/favorite?pid=${o.pro_id}&page=${page}"><i class="far fa-heart"></i> Add to Favorite</a>
                                                <a class="btn btn-outline-dark btn-sm" href="/clothesstore/detail?pid=${o.pro_id}"><i class="fa fa-info-circle"></i> More information and Buy</a>
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
                                        <li class="page-item">
                                            <a class="page-link" href="shop?page=${currentPage - 1}&<c:forEach var="id" items="${selectedCatIds}">cate_ids=${id}&</c:forEach>">Previous</a>
                                            </li>
                                    </c:if>
                                    <c:forEach var="i" begin="1" end="${noOfPages}">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="shop?page=${i}&<c:forEach var="id" items="${selectedCatIds}">cate_ids=${id}&</c:forEach>">${i}</a>
                                            </li>
                                    </c:forEach>
                                    <c:if test="${currentPage < noOfPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="shop?page=${currentPage + 1}&<c:forEach var="id" items="${selectedCatIds}">cate_ids=${id}&</c:forEach>">Next</a>
                                            </li>
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
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var urlParams = new URLSearchParams(window.location.search);
                setTimeout(function () {
                    toast.classList.add('active');
                }, 100);
                var toast = document.getElementById('toast');
                setTimeout(function () {
                    toast.classList.remove('active');
                }, 5000);


                var closeToast = document.querySelector('.toast .close');
                if (closeToast) {
                    closeToast.addEventListener('click', function () {
                        var toast = document.getElementById('toast');
                        toast.classList.remove('active');
                    });
                }
                var pathname = window.location.pathname;
                window.history.pushState({}, "", pathname);
            });

        </script>
    </body>
</html>

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
            .toast{
                position: fixed;
                z-index: 99999;
                width:400px;
                top: 25px;
                right: 30px;
                border-radius: 12px;
                background: #fff;
                padding: 20px 35px 20px 25px;
                box-shadow: 0 5px 10px rgba(0,0,0,0.1);
                border-left: 6px solid #4070f4;
                overflow: hidden;
                transform: translateX(calc(100% + 30px));
                transition: all 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.35);
                opacity: 1!important;
            }

            .toast.active{
                transform: translateX(0%);
                opacity: 1!important;
            }

            .toast .toast-content{
                display: flex;
                align-items: center;
            }

            .toast-content .check{
                display: flex;
                align-items: center;
                justify-content: center;
                height: 35px;
                width: 35px;
                background-color: #4070f4;
                color: #fff;
                font-size: 20px;
                border-radius: 50%;
            }
            .toast.logout-toast .check {
                background-color: #ffc107;
                height: 35px;
                width: 35px;
            }
            .toast-content .message{
                display: flex;
                flex-direction: column;
                margin: 0 20px;
            }

            .message .text{
                font-size: 20px;
                font-weight: 400;
                color: #666666;
            }

            .message .text.text-1{
                font-weight: 600;
                color: #333;
            }

            .toast .close{
                position: absolute;
                top: 10px;
                right: 15px;
                padding: 5px;
                cursor: pointer;
                opacity: 0.7;
            }

            .toast .close:hover{
                opacity: 1;
            }

            .toast .progress{
                position: absolute;
                bottom: 0;
                left: 0;
                height: 3px;
                width: 100%;
                background: #ddd;
            }

            .toast .progress:before{
                content: '';
                position: absolute;
                bottom: 0;
                right: 0;
                height: 100%;
                width: 100%;
                background-color: #4070f4;
            }

            .toast.logout-toast{
                border-left: 6px solid #ffc107!important;
            }
            .toast.logout-toast .progress:before {
                background-color: #ffc107;
            }
            .progress.active:before{
                animation: progress 5s linear forwards;
            }

            @keyframes progress {
                100%{
                    right: 100%;
                }
            }
        </style>
        <!-- Breadcrumb Start -->

        <c:if test="${ not empty message}">     
            <div class="toast" id="toast">
                <div class="toast-content">
                    <i class="fas fa-solid fa-check check"></i>
                    <div class="message">
                        <span class="text text-1">Add Successfully!!!!</span>
                        <span class="text text-2">${message.pro_name}</span>
                    </div>
                </div>
                <span class="close">&times;</span>
                <div class="progress active"></div>
            </div>
        </c:if>  
        <c:if test="${ not empty param.delete}">     
            <div class="toast" id="toast">
                <div class="toast-content">
                    <i class="fas fa-solid fa-check check"></i>
                    <div class="message">
                        <span class="text text-1">Delete Successfully!!!!</span>
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
                                            <form method="post" action="favorite">
                                                <input  type="hidden" name = "pro_id" value="${o.pro_id}">
                                                <input  type="hidden" name = "page" value="${currentPage}">
                                                <button style="all: unset;" type= "submit" >
                                                    <a  class="btn btn-outline-dark btn-sm"><i class="fa fa-trash"></i> Delete favorite product</a>
                                                </button>
                                            </form>

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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <jsp:include page="/shared/_head.jsp" />
    <body style="overflow: hidden; position: relative">
        <jsp:include page="/shared/_header.jsp" />

        <jsp:include page="/shared/_nav.jsp" />
        <style>
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
        <c:if test="${not empty sessionScope.account}">
            <div class="toast" id="toast">
                <div class="toast-content">
                    <i class="fas fa-solid fa-check check"></i>
                    <div class="message">
                        <span class="text text-1">Login Successfully !</span>
                        <span class="text text-2">Welcome, ${sessionScope.account.name}</span>
                    </div>
                </div>
                <span class="close">&times;</span>
                <div class="progress active"></div>
            </div>
        </c:if>
        <c:if test="${not empty param.name}">
            <div class="toast logout-toast" id="toast">
                <div class="toast-content">
                    <i class="fas fa-solid fa-check check"></i>
                    <div class="message">
                        <span class="text text-1">Logout Successfully!</span>
                        <span class="text text-2">Goodbye, ${param.name}</span>
                    </div>
                </div>
                <span class="close">&times;</span>
                <div class="progress active"></div>
            </div>
        </c:if>
        <!-- Carousel Start -->
        <div class="container-fluid mb-3">
            <div class="row px-xl-5">
                <div class="col-lg-8">
                    <div id="header-carousel" class="carousel slide carousel-fade mb-30 mb-lg-0" data-ride="carousel">
                        <ol class="carousel-indicators">
                            <li data-target="#header-carousel" data-slide-to="0" class="active"></li>
                            <li data-target="#header-carousel" data-slide-to="1"></li>
                            <li data-target="#header-carousel" data-slide-to="2"></li>
                        </ol>
                        <div class="carousel-inner">
                            <div class="carousel-item position-relative active" style="height: 430px;">
                                <img class="position-absolute w-100 h-100" src="/clothesstore/assets/img/carousel-1.jpg" style="object-fit: cover;">
                                <div class="carousel-caption d-flex flex-column align-items-center justify-content-center">
                                    <div class="p-3" style="max-width: 700px;">
                                        <h1 class="display-4 text-white mb-3 animate__animated animate__fadeInDown">Men Fashion</h1>
                                        <p class="mx-md-5 px-5 animate__animated animate__bounceIn">Lorem rebum magna amet lorem magna erat diam stet. Sadips duo stet amet amet ndiam elitr ipsum diam</p>
                                        <a class="btn btn-outline-light py-2 px-4 mt-3 animate__animated animate__fadeInUp" href="/clothesstore/shop">Shop Now</a>
                                    </div>
                                </div>
                            </div>
                            <div class="carousel-item position-relative" style="height: 430px;">
                                <img class="position-absolute w-100 h-100" src="/clothesstore/assets/img/carousel-2.jpg" style="object-fit: cover;">
                                <div class="carousel-caption d-flex flex-column align-items-center justify-content-center">
                                    <div class="p-3" style="max-width: 700px;">
                                        <h1 class="display-4 text-white mb-3 animate__animated animate__fadeInDown">Women Fashion</h1>
                                        <p class="mx-md-5 px-5 animate__animated animate__bounceIn">Lorem rebum magna amet lorem magna erat diam stet. Sadips duo stet amet amet ndiam elitr ipsum diam</p>
                                        <a class="btn btn-outline-light py-2 px-4 mt-3 animate__animated animate__fadeInUp" href="/clothesstore/shop">Shop Now</a>
                                    </div>
                                </div>
                            </div>
                            <div class="carousel-item position-relative" style="height: 430px;">
                                <img class="position-absolute w-100 h-100" src="/clothesstore/assets/img/carousel-3.jpg" style="object-fit: cover;">
                                <div class="carousel-caption d-flex flex-column align-items-center justify-content-center">
                                    <div class="p-3" style="max-width: 700px;">
                                        <h1 class="display-4 text-white mb-3 animate__animated animate__fadeInDown">Kids Fashion</h1>
                                        <p class="mx-md-5 px-5 animate__animated animate__bounceIn">Lorem rebum magna amet lorem magna erat diam stet. Sadips duo stet amet amet ndiam elitr ipsum diam</p>
                                        <a class="btn btn-outline-light py-2 px-4 mt-3 animate__animated animate__fadeInUp" href="/clothesstore/shop">Shop Now</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="product-offer mb-30" style="height: 200px;">
                        <img class="img-fluid" src="/clothesstore/assets/img/offer-1.jpg" alt="">
                        <div class="offer-text">
                            <h6 class="text-white text-uppercase">Quality Product</h6>
                            <h3 class="text-white mb-3">Special Offer</h3>
                            <a href="/clothesstore/shop" class="btn btn-primary">Shop Now</a>
                        </div>
                    </div>
                    <div class="product-offer mb-30" style="height: 200px;">
                        <img class="img-fluid" src="/clothesstore/assets/img/offer-2.jpg" alt="">
                        <div class="offer-text">
                            <h6 class="text-white text-uppercase">Quality Product</h6>
                            <h3 class="text-white mb-3">Special Offer</h3>
                            <a href="/clothesstore/shop" class="btn btn-primary">Shop Now</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Carousel End -->


        <!-- Featured Start -->
        <div class="container-fluid pt-5">
            <div class="row px-xl-5 pb-3">
                <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                    <div class="d-flex align-items-center bg-light mb-4" style="padding: 30px;">
                        <h1 class="fa fa-check text-primary m-0 mr-3"></h1>
                        <h5 class="font-weight-semi-bold m-0">Quality Product</h5>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                    <div class="d-flex align-items-center bg-light mb-4" style="padding: 30px;">
                        <h1 class="fa fa-shipping-fast text-primary m-0 mr-2"></h1>
                        <h5 class="font-weight-semi-bold m-0">Free Shipping</h5>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                    <div class="d-flex align-items-center bg-light mb-4" style="padding: 30px;">
                        <h1 class="fas fa-exchange-alt text-primary m-0 mr-3"></h1>
                        <h5 class="font-weight-semi-bold m-0">14-Day Return</h5>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                    <div class="d-flex align-items-center bg-light mb-4" style="padding: 30px;">
                        <h1 class="fa fa-phone-volume text-primary m-0 mr-3"></h1>
                        <h5 class="font-weight-semi-bold m-0">24/7 Support</h5>
                    </div>
                </div>
            </div>
        </div>
        <!-- Featured End -->

        <jsp:include page="/shared/_footer.jsp" />
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var urlParams = new URLSearchParams(window.location.search);
                if (urlParams.get('status') === 'loginSS' || urlParams.get('name')) {
                    var toast = document.getElementById('toast');
                    setTimeout(function () {
                        toast.classList.add('active');
                    }, 100);
                    setTimeout(function () {
                        toast.classList.remove('active');
                    }, 6000);
                }

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
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
            .toast-fail {
                border-left: 6px solid #dc3545 !important;
            }

            .toast-fail .check {
                background-color: #dc3545;
            }

            .toast-fail .progress:before {
                background-color: #dc3545;
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
        <jsp:include page="/shared/_header.jsp" />
        <jsp:include page="/shared/_nav.jsp" />
        <c:if test="${not empty param.price}">                      
            <div class="toast" id="toast">
                <div class="toast-content">
                    <i class="fas fa-solid fa-check check"></i>
                    <div class="message" >
                        <span class="text text-1" style="font-size:18px;">Place order successfully!!</span>
                        <span class="text text-2" style="font-size:14px">Total cost:   <fmt:formatNumber value="${param.price}" type="number" pattern="#,##0" /> VND</span>
                    </div>
                </div>
                <span class="close">&times;</span>
                <div class="progress active"></div>
            </div>
        </c:if>
        <c:if test="${not empty param.error &&  param.error == 1}">                      
            <div class="toast toast-fail" id="toast" style="width:550px">
                <div class="toast-content">
                    <i class="fas fa-exclamation-circle" style="padding:18px;font-size:24px" ></i>
                    <div class="message" >
                        <span class="text text-1" style="font-size:18px;">Notification !!!!</span>
                        <span class="text text-2" style="font-size:14px">You don't have any products in the store</span>
                    </div>
                </div>
                <span class="close">&times;</span>
                <div class="progress active"></div>
            </div>
        </c:if>
        <c:if test="${not empty param.error &&  param.error == 2}">                      
            <div class="toast toast-fail" id="toast" style="width:550px">
                <div class="toast-content">
                    <i class="fas fa-exclamation-circle" style="padding:18px;font-size:24px" ></i>
                    <div class="message" >
                        <span class="text text-1" style="font-size:18px;">Notification !!!!</span>
                        <span class="text text-2" style="font-size:14px">The product in your cart is out of stock, please check again</span>
                    </div>
                </div>
                <span class="close">&times;</span>
                <div class="progress active"></div>
            </div>
        </c:if>
        <!-- Breadcrumb Start -->
        <div class="container-fluid">
            <div class="row px-xl-5">
                <div class="col-12">
                    <nav class="breadcrumb bg-light mb-30">
                        <a class="breadcrumb-item text-dark" href="/clothesstore/home">Home</a>
                        <a class="breadcrumb-item text-dark" href="/clothesstore/shop">Shop</a>
                        <span class="breadcrumb-item active">Checkout</span>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Breadcrumb End -->
        <!-- Checkout Start -->
        <div class="container-fluid">
            <form action="checkout" method="POST">
                <div class="row px-xl-5">
                    <div class="col-lg-8">
                        <h5 class="section-title position-relative text-uppercase mb-3"><span class="bg-secondary pr-3">Billing Address</span></h5>
                        <div class="bg-light p-30 mb-5">
                            <div class="row">
                                <div class="col-md-6 form-group">
                                    <label>Full Name</label>
                                    <input class="form-control" type="text" name="billingName" readonly value="${sessionScope.account.name}" placeholder="John"required>
                                </div>                      
                                <div class="col-md-6 form-group">
                                    <label>E-mail</label>
                                    <input class="form-control" type="text" name="billingEmail" readonly value="${sessionScope.account.email}" placeholder="example@email.com"required>
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>Mobile No</label>
                                    <input class="form-control" type="text" name="billingPhone" readonly value="${sessionScope.account.phone}"  placeholder="+123 456 789"required>
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>Address</label>
                                    <input class="form-control" type="text" name="billingAddress" readonly value="${sessionScope.account.address}"  phoneplaceholder="123 Street"required>
                                </div>


                                <div class="col-md-12">
                                    <div class="custom-control custom-checkbox">
                                        <input type="checkbox" class="custom-control-input" name="shipto" id="shipto">
                                        <label class="custom-control-label" for="shipto"  data-toggle="collapse" data-target="#shipping-address">Ship to different address</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="collapse mb-5" id="shipping-address">
                            <h5 class="section-title position-relative text-uppercase mb-3"><span class="bg-secondary pr-3">Shipping Address</span></h5>
                            <div class="bg-light p-30">
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <label>Full Name</label>
                                        <input class="form-control" name="shipName" type="text" placeholder="John">
                                    </div>


                                    <div class="col-md-6 form-group">
                                        <label>Mobile No</label>
                                        <input class="form-control" name="shipPhone" type="text" placeholder="+123 456 789" >
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <label>Address</label>
                                        <input class="form-control"  name="shipAddress" type="text" placeholder="123 Nguyen Van Cu Noi Dai">
                                    </div>

                                    <div class="col-md-6 form-group">
                                        <label>Province/City</label>
                                        <input class="form-control" name="shipCity" type="text" placeholder="Can Tho">
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <label>District</label>
                                        <input class="form-control" name="shipDistrict" type="text" placeholder="Quan Ninh Kieu">
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <label>Ward/Commune</label>
                                        <input class="form-control" name="shipWard" type="text" placeholder="Phuong An Khanh">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <h5 class="section-title position-relative text-uppercase mb-3"><span class="bg-secondary pr-3">Order Total</span></h5>
                        <div class="bg-light p-30 mb-5">
                            <div class="pt-2">
                                <div class="d-flex justify-content-between mt-2">
                                    <h2>Total Price</h2>
                                    <c:set var="totalP" value="${totalPrice}"></c:set>
                                    <c:if test="${not empty buyNow && not empty quantity && not empty pvID && not empty unitP}">
                                        <c:set var="totalP" value="${quantity * unitP }"></c:set>
                                    </c:if>
                                    <h2>   <fmt:formatNumber value="${totalP}" type="number" pattern="#,##0" /> VND</h2>
                                </div>
                            </div>
                        </div>
                        <div class="mb-5">
                            <h5 class="section-title position-relative text-uppercase mb-3"><span class="bg-secondary pr-3">Payment</span></h5>
                            <div class="bg-light p-30">

                                <div class="form-group mb-4">
                                    <div class="custom-control custom-radio">
                                        <input type="radio"  class="custom-control-input" name="payment" checked="true" id="banktransfer">
                                        <label class="custom-control-label" for="banktransfer" >CASH ON DELIVERY (COD)</label>
                                    </div>
                                </div>
                                <input type="hidden" name="buyNow" value="${buyNow}">
                                <input type="hidden" name="quantity" value="${quantity}">
                                <input type="hidden" name="pvID" value="${pvID}">
                                <button type="submit" class="btn btn-block btn-primary font-weight-bold py-3">Place Order</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <!-- Checkout End -->

        <jsp:include page="/shared/_footer.jsp" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
            $(function () {
                $('input[type="text"]').change(function () {
                    this.value = $.trim(this.value);
                });
            });
            document.addEventListener("DOMContentLoaded", function () {
                var shipToCheckbox = document.getElementById('shipto');
                var shippingFields = [
                    document.querySelector('input[name="shipName"]'),
                    document.querySelector('input[name="shipPhone"]'),
                    document.querySelector('input[name="shipAddress"]'),
                    document.querySelector('input[name="shipCity"]'),
                    document.querySelector('input[name="shipDistrict"]'),
                    document.querySelector('input[name="shipWard"]')
                ];

                shipToCheckbox.addEventListener('change', function () {
                    if (this.checked) {
                        shippingFields.forEach(function (field) {
                            field.setAttribute('required', 'required');
                        });
                    } else {
                        shippingFields.forEach(function (field) {
                            field.removeAttribute('required');
                        });
                    }
                });

                // Initialize the required attributes based on the checkbox state
                if (shipToCheckbox.checked) {
                    shippingFields.forEach(function (field) {
                        field.setAttribute('required', 'required');
                    });
                }
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
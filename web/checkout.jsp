<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <jsp:include page="/shared/_head.jsp" />
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
                                <input class="form-control" type="text" name="billingName" value="${sessionScope.account.name}" placeholder="John">
                            </div>                      
                            <div class="col-md-6 form-group">
                                <label>E-mail</label>
                                <input class="form-control" type="text" name="billingEmail" value="${sessionScope.account.email}" placeholder="example@email.com">
                            </div>
                            <div class="col-md-6 form-group">
                                <label>Mobile No</label>
                                <input class="form-control" type="text" name="billingPhone" value="${sessionScope.account.phone}"  placeholder="+123 456 789">
                            </div>
                            <div class="col-md-6 form-group">
                                <label>Address</label>
                                <input class="form-control" type="text" name="billingAddress" value="${sessionScope.account.address}"  phoneplaceholder="123 Street">
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
                                    <input class="form-control" name="shipPhone" type="text" placeholder="+123 456 789">
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
                                <h2>   <fmt:formatNumber value="${totalPrice}" type="number" pattern="#,##0" /> VND</h2>
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
                            <button type="submit" class="btn btn-block btn-primary font-weight-bold py-3">Place Order</button>
                        </div>
                    </div>
                </div>
            </div>
                            </form>
        </div>
        <!-- Checkout End -->
        
        <jsp:include page="/shared/_footer.jsp" />
    </body>
</html>
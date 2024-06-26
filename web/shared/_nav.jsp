<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.LinkedList"%>
<%@ page import="model.Cart"%>
<%@ page import="service.CartService"%>
<%@ page import="model.Account" %>
<% CartService cservice = new CartService();
int quantityPro = 0;
if (session.getAttribute("account") != null) {
Account acc = (Account) session.getAttribute("account");
for (Cart c : cservice.GetListCartByAccID(acc.getAcc_id())) {
quantityPro++;
    }  
    }
%>
<!-- Navbar Start -->
<div class="container-fluid bg-dark mb-30">
    <div class="row px-xl-5">
        <div class="col-lg-12">
            <nav class="navbar navbar-expand-lg bg-dark navbar-dark py-3 py-lg-0 px-0">
                <a href="" class="text-decoration-none d-block d-lg-none">
                    <span class="h1 text-uppercase text-dark bg-light px-2">Multi</span>
                    <span class="h1 text-uppercase text-light bg-primary px-2 ml-n1">Shop</span>
                </a>
                <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
                    <div class="navbar-nav mr-auto py-0">
                        <a href="/clothesstore/home" class="nav-item nav-link active">Home</a>
                        <a href="/clothesstore/shop" class="nav-item nav-link">Shop</a>
                        <a href="/clothesstore/contact" class="nav-item nav-link">Contact</a>
                        <!-- Chỉ hiển thị Lịch sử đặt hàng cho vai trò Customer -->
                        
                     <c:if test="${sessionScope.account.role == 'Customer'}">
    <a href="OrderHistoryControl" class="nav-item nav-link">Order History</a>
</c:if>
                        
                         <c:if test="${sessionScope.account.role == 'Staff'}">
    <a href="OrderHistoryStaffControl" class="nav-item nav-link">Order History(Staff)</a>
</c:if>

                        
                    </div>
                    <div class="navbar-nav ml-auto py-0 d-none d-lg-block">
                        <a href="/clothesstore/favorite" class="btn px-0">
                            <i class="fas fa-heart text-primary"></i>
                            <span class="badge text-secondary border border-secondary rounded-circle" style="padding-bottom: 2px;">0</span>
                        </a>
                        <a href="/clothesstore/cart" class="btn px-0 ml-3">
                            <i class="fas fa-shopping-cart text-primary"></i>
                            <span class="badge text-secondary border border-secondary rounded-circle" style="padding-bottom: 2px;">
                                <%= quantityPro %>
                            </span>
                        </a>
                    </div>
                </div>
            </nav>
        </div>
    </div>
</div>
<!-- Navbar End -->
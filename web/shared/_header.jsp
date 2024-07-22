<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Topbar Start -->
<div class="container-fluid">
    <div class="row bg-secondary py-1 px-xl-5">
        <div class="col-lg-6 d-none d-lg-block">
            <div class="d-inline-flex align-items-center h-100">
                <a class="text-body mr-3" href="">About</a>
            </div>
        </div>
        <div class="col-lg-6 text-center text-lg-right">
            <div class="d-inline-flex align-items-center">
                <div class="btn-group">
                    <button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown">My Account</button>
                    <div class="dropdown-menu dropdown-menu-right">
                        <c:choose>
                            <c:when test="${sessionScope.account == null}">
                                <button class="dropdown-item" type="button" onclick="login()">Login</button>
                                <button class="dropdown-item" type="button" onclick="register()">Register</button>
                            </c:when>
                            <c:otherwise>
                                <c:if test="${sessionScope.role == 'Admin'}">
                                    <button class="dropdown-item" type="button" onclick="dashboard()">Go To Dashboard</button>
                                    <button class="dropdown-item" type="button" onclick="logout()">Logout</button>
                                </c:if>
                                <c:if test="${sessionScope.role == 'Staff'}">
                                    <button class="dropdown-item" type="button" onclick="manage_shop()">Management shop</button>
                                    <button class="dropdown-item" type="button" onclick="logout()">Logout</button>
                                </c:if>
                                <c:if test="${sessionScope.role == 'Customer'}">
                                    <button class="dropdown-item" type="button" onclick="editProfile()">Edit Profile</button>
                                    <button class="dropdown-item" type="button" onclick="logout()">Logout</button>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            <div class="d-inline-flex align-items-center d-block d-lg-none">
                <a href="" class="btn px-0 ml-2">
                    <i class="fas fa-heart text-dark"></i>
                    <span class="badge text-dark border border-dark rounded-circle" style="padding-bottom: 2px;">0</span>
                </a>
                <a href="" class="btn px-0 ml-2">
                    <i class="fas fa-shopping-cart text-dark"></i>
                    <span class="badge text-dark border border-dark rounded-circle" style="padding-bottom: 2px;">0</span>
                </a>
            </div>
        </div>
    </div>
    <div class="row align-items-center bg-light py-3 px-xl-5 d-none d-lg-flex">
        <div class="col-lg-4">
            <a href="/clothesstore/home" class="text-decoration-none" >
                <span class="h1 text-uppercase text-primary bg-dark px-2" style="border-radius: 10px">Clothes</span>
                <span class="h1 text-uppercase text-dark bg-primary px-2 ml-n1" style="border-radius: 10px">Store</span>
            </a>
        </div>
        <div class="col-lg-4 col-6 text-left">
            <form action="/clothesstore/search">
                <div class="input-group">
                    <input value="${txtS}" name="txt" type="text" class="form-control" placeholder="Search for products">
                    <button style="all: unset;display: inline-block;cursor: pointer; " type="submit" >
                        <div class="input-group-append">
                            <span class="input-group-text bg-transparent text-primary" style="padding:10px 8px;">
                                <i class="fa fa-search"></i>
                            </span>
                        </div>
                    </button>
                </div>
            </form>
        </div>
        <div class="col-lg-4 col-6 text-right">
            <p class="m-0">Customer Service</p>
            <h5 class="m-0">0912 123 456</h5>
        </div>
    </div>
</div>
<!-- Topbar End -->

<script>
    function login() {
        window.location.href = "/clothesstore/login";
    }
    function register() {
        window.location.href = "/clothesstore/register";
    }

    function editProfile() {
        window.location.href = "/clothesstore/edit";
    }
    function logout() {
        window.location.href = "/clothesstore/logout";
    }
    function manage_shop() {
        window.location.href = "/clothesstore/FeedBackManagementController";
    }
    function dashboard() {
        window.location.href = "/clothesstore/admin/dashboard";
    }
</script>
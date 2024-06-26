<%-- 
    Document   : login
    Created on : Jun 4, 2024, 4:33:51 AM
    Author     : Huenh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <jsp:include page="/shared/_head.jsp" />
    <link rel="stylesheet" type="text/css" href="assets/css/login.css" />
    <body>
        <div class="container">
            <div class="d-flex justify-content-center h-100">
                <div class="card">
                    <div class="card-header">
                        <h3>LOGIN ACCOUNT</h3>
                    </div>
                    <div class="card-body">
                        <form action="/clothesstore/login" method="post">
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                </div>
                                <input type="text" class="form-control" placeholder="username" name="username">

                            </div>
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-key"></i></span>
                                </div>
                                <input type="password" class="form-control" placeholder="password" name="password">
                            </div>
                            <div class="row align-items-center remember">
                                <input type="checkbox">Remember Me
                            </div>
                            <div class="form-group">
                                <input type="submit" value="Login" class="btn float-right login_btn">
                            </div>
                        </form>
                    </div>
                    <div class="card-footer d-flex flex-column align-items-center">
                        <span class="text-danger mb-3">${msgError}</span>
                        <div class="d-flex justify-content-center links">
                            Don't have an account?<a href="/clothesstore/register">Register</a>
                        </div>
                        <div class="d-flex justify-content-center">
                            <a href="/clothesstore/reset-password">Forgot your password?</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
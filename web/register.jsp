<%-- 
    Document   : register
    Created on : Jun 4, 2024, 4:34:01 AM
    Author     : Huenh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <jsp:include page="/shared/_head.jsp" />
    <link rel="stylesheet" type="text/css" href="assets/css/register.css">
    <body>
        <div class="container">
            <div class="d-flex justify-content-center h-100">
                <div class="card" id="card">
                    <div class="card-header">
                        <h3>REGISTER ACCOUNT</h3>
                    </div>
                    <div class="card-body">
                        <form action="register" method="post">
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                </div>
                                <input type="text" name="username" value="${userVal}" class="form-control" required placeholder="username*">
                                <c:if test="${usernameErr != null}">
                                    <span class="text-danger mt-2">Username ${usernameErr} is already exist.</span>
                                </c:if>
                            </div>
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                </div>
                                <input type="text" name="name" value="${nameVal}" class="form-control" required placeholder="fullname*">
                            </div>
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-envelope-open"></i></span>
                                </div>
                                <input type="text" name="email" value="${emailVal}" class="form-control" required placeholder="email*"> </br>
                                <c:if test="${emailErr != null}">
                                    <span class="text-danger mt-2">${emailErr}</span>
                                </c:if>
                            </div>
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                </div>
                                <input type="tel" name="phone" value="${phoneVal}" class="form-control" required placeholder="phone*">
                                <c:if test="${phoneErr != null}">
                                    <span class="text-danger mt-2">${phoneErr}</span>
                                </c:if>
                            </div>
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-home"></i></span>
                                </div>
                                <input type="text" name="address" value="${addressVal}" class="form-control" required placeholder="address*">
                            </div>
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-key"></i></span>
                                </div>
                                <input type="password" name="password" value="${pwdVal}" class="form-control" required placeholder="password*">
                                <c:if test="${pwdErr != null}">
                                    <span class="text-danger mt-2">${pwdErr}</span>
                                </c:if>
                            </div>
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-key"></i></span>
                                </div>
                                <input type="password" name="repassword" value="${repwd}" class="form-control" required placeholder="repeat password*">
                                <c:if test="${repwdErr != null}">
                                    <span class="text-danger mt-2">${repwdErr}</span>
                                </c:if>
                            </div>
                            <div class="form-group d-flex justify-content-center">
                                <input type="submit" value="Register" class="btn regis_btn">
                            </div>
                        </form>
                    </div>
                    <div class="card-footer">
                        <div class="d-flex justify-content-center links">
                            Already have an account?<a href="/clothesstore/login">Login</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function check() {
                var card = document.getElementById('card');
                var hasError = document.querySelectorAll('.text-danger');

                if (hasError.length > 0) {
                    card.classList.add('error');
                }
            }
            
            check();
        </script>
    </body>
</html>
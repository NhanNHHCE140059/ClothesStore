<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="model.Account"%>
<%@page import="helper.Role"%>
<% Account account = (Account) request.getAttribute("account"); %>
<% String messageError = (String) request.getAttribute("messageError"); %>
<html lang="en">
    <head>
        <link rel="stylesheet" href="/clothesstore/assets/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="/clothesstore/assets/css/editPasswordUser.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
    </head>
    <style>

    </style>
    <body>
        <div class="background-info">
            <div class="container-xl px-4 mt-4">
                <a href="/clothesstore/home" class="btn-back-home">Back to Home</a>
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1 class="mb-0 header-title">
                        Profile Management
                    </h1>
                </div>
                <hr class="custom-hr">
                <div class="row">
                    <div class="col-xl-4">
                        <!-- Profile picture card-->
                        <div class="card mb-4 mb-xl-0">
                            <div class="card-header">Profile Picture</div>
                            <div class="card-body text-center">
                                <!-- Profile picture image-->
                                <%
                       String imageUrl = account.getImage();
                       if (imageUrl == null || imageUrl.isEmpty()) {
                           imageUrl = "http://bootdey.com/img/Content/avatar/avatar1.png";
                       } else {
                           imageUrl = request.getContextPath() + "/" + imageUrl;
                       }
                                %>
                                <img id="profile-image" class="img-account-profile rounded-circle mb-2" src="<%= imageUrl %>" alt="">
                                <!-- Profile picture help block-->
                                <div class="small font-italic text-muted mb-4">JPG or PNG no larger than 5 MB</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-8">
                        <!-- Account details card-->
                        <div class="card mb-4">
                            <div class="card-header">
                                Account Details
                            </div>
                            <div class="card-body">
                                <form action="EditPasswordController" method="POST">
                                    <!-- Form Group (username)-->
                                    <div class="mb-3">
                                        <label class="small mb-1" for="inputUsername">Username</label>
                                        <input class="form-control" id="inputUsername" type="text" value="<%= account.getUsername()%>" readonly>
                                    </div>
                                    <!-- Form Group (new password)-->
                                    <div class="mb-3 password-wrapper">
                                        <label class="small mb-1" for="inputNewPassword">New Password</label>
                                        <div class="input-group">
                                            <input class="form-control" name ="inputNewPassword" id="inputNewPassword" type="password" required>
                                            <span class="input-group-text toggle-password" onclick="togglePassword('inputNewPassword')">
                                                <i class="fas fa-eye"></i>
                                            </span>
                                        </div>
                                    </div>
                                    <!-- Form Group (confirm password)-->
                                    <div class="mb-3 password-wrapper">
                                        <label class="small mb-1" for="inputConfirmPassword">Confirm Password</label>
                                        <div class="input-group">
                                            <input class="form-control" name="inputConfirmPassword" id="inputConfirmPassword" type="password" required>
                                            <span class="input-group-text toggle-password icon-eye-pass" onclick="togglePassword('inputConfirmPassword')">
                                                <i class="fas fa-eye"></i>
                                            </span>
                                        </div>
                                    </div>
                                    <% if ( messageError!= null ) { %>
                                    <div class="error-message-password"><%= messageError %></div>
                                    <% } %>
                                    <!-- Save changes button-->

                                    <div class="mb-3">
                                        <button class="btn btn-primary" type="submit">Save Password</button>
                                        <a href="UserPofileController?username=<%= account.getUsername() %>" class="btn btn-secondary">Back to View Profile</a>
                                    </div>   
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function togglePassword(inputId) {
                var passwordInput = document.getElementById(inputId);
                var toggleIcon = passwordInput.nextElementSibling.querySelector('i');
                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    toggleIcon.classList.remove('fa-eye');
                    toggleIcon.classList.add('fa-eye-slash');
                } else {
                    passwordInput.type = 'password';
                    toggleIcon.classList.remove('fa-eye-slash');
                    toggleIcon.classList.add('fa-eye');
                }
            }
        </script>
    </body>
</html>

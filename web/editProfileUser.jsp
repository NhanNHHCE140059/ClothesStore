<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="model.Account"%>
<%@page import="helper.Role"%>
<% Account account = (Account) request.getAttribute("account"); %>
<html lang="en">
    <head>
        <link rel="stylesheet" href="/clothesstore/assets/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="/clothesstore/assets/css/editProfileUser.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
    </head>
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
                                <span class="role-badge"><%= account.getRole() %></span>
                            </div>
                            <div class="card-body">
                                <form id="profileForm" action="EditProfileController" method="POST" onsubmit="return validateForm()">
                                    <!-- Form Group (username)-->
                                    <div class="mb-3">
                                        <label class="small mb-1" for="inputUsername">Username</label>
                                        <input class="form-control" id="inputUsername" type="text" value="<%= account.getUsername() %>" readonly>
                                    </div>
                                    <!-- Form Group (full name)-->
                                    <div class="mb-3">
                                        <label class="small mb-1" for="inputFullName">Full name</label>
                                        <input class="form-control" name="inputFullName" id="inputFullName" type="text" value="<%= account.getName() %>" required>
                                    </div>
                                    <!-- Form Group (address)-->
                                    <div class="mb-3">
                                        <label class="small mb-1" for="inputAddress">Address</label>
                                        <input class="form-control" name="inputAddress" id="inputAddress" type="text" value="<%= account.getAddress() %>"required>
                                    </div>
                                    <!-- Form Group (email address)-->
                                    <div class="mb-3">
                                        <label class="small mb-1" for="inputEmailAddress">Email address</label>
                                        <input class="form-control" name="inputEmailAddress" id="inputEmailAddress" type="text" value="<%= account.getEmail() %>"required>
                                        <div class="error-message" id="emailError"></div>
                                    </div>
                                    <!-- Form Group (phone number)-->
                                    <div class="mb-3">
                                        <label class="small mb-1" for="inputPhone">Phone number</label>
                                        <input class="form-control" name="inputPhone" id="inputPhone" type="tel" value="<%= account.getPhone() %>"required>
                                        <div class="error-message" id="phoneError"></div>
                                    </div>
                                
                                    <!-- Save changes button-->
                                    <div class="mb-3">
                                        <button class="btn btn-primary" type="submit">Save changes</button>
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
            function togglePassword() {
                var passwordInput = document.getElementById('inputPassword');
                var toggleIcon = document.querySelector('.toggle-password i');
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

            function validateForm() {
                var email = document.getElementById('inputEmailAddress').value;
                var phone = document.getElementById('inputPhone').value;
                var emailError = document.getElementById('emailError');
                var phoneError = document.getElementById('phoneError');

                var emailPattern = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
                var phonePattern = /^0\d{9,10}$/;

                var isValid = true;

                emailError.textContent = "";
                phoneError.textContent = "";

                if (!emailPattern.test(email)) {
                    emailError.textContent = "Please enter a valid email address.(Ex. abc@gmail.com)";
                    isValid = false;
                }

                if (!phonePattern.test(phone)) {
                    phoneError.textContent = "Please enter a valid phone number starting with 0 and containing 10 or 11 digits.";
                    isValid = false;
                }

                return isValid;
            }
        </script>
    </body>
</html>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="model.Account"%>
<%@page import="helper.Role"%>
<% Account account = (Account) request.getAttribute("account"); %>
<html lang="en">
    <head>
        <link rel="stylesheet" href="/clothesstore/assets/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="/clothesstore/assets/css/profileUser.css"/>
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
                                <!-- Profile picture upload button-->
                                <form id="upload-form" action="EditAvatarUserController" method="post" enctype="multipart/form-data">
                                    <div class="file-upload-wrapper">
                                        <button class="btn btn-primary file-upload-button" type="button" onclick="document.getElementById('file-input').click()">Upload new avatar</button>
                                        <input type="file" id="file-input" name="file" accept="image/*" style="display:none;" onchange="uploadFile()">
                                    </div>
                                </form>
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
                                <form>
                                    <!-- Form Group (username)-->
                                    <div class="mb-3">
                                        <label class="small mb-1" for="inputUsername">Username</label>
                                        <input class="form-control" id="inputUsername" type="text" value="<%= account.getUsername() %>" readonly>
                                    </div>
                                    <!-- Form Group (full name)-->
                                    <div class="mb-3">
                                        <label class="small mb-1" for="inputFullName">Full name</label>
                                        <input class="form-control" id="inputFullName" type="text" value="<%= account.getName() %>" readonly>
                                    </div>
                                    <!-- Form Group (address)-->
                                    <div class="mb-3">
                                        <label class="small mb-1" for="inputAddress">Address</label>
                                        <input class="form-control" id="inputAddress" type="text" value="<%= account.getAddress() %>" readonly>
                                    </div>
                                    <!-- Form Group (email address)-->
                                    <div class="mb-3">
                                        <label class="small mb-1" for="inputEmailAddress">Email address</label>
                                        <input class="form-control" id="inputEmailAddress" type="email" value="<%= account.getEmail() %>" readonly>
                                    </div>
                                    <!-- Form Group (phone number)-->
                                    <div class="mb-3">
                                        <label class="small mb-1" for="inputPhone">Phone number</label>
                                        <input class="form-control" id="inputPhone" type="tel" value="<%= account.getPhone() %>" readonly>
                                    </div>
                                   
                              
                                    <% if (session.getAttribute("successMessage") != null) { %>
                                    <div class="success-message">
                                        <%= session.getAttribute("successMessage") %>
                                    </div>
                                    <% } session.removeAttribute("successMessage"); %>
                                    <!-- Change information button-->
                                    <form action="UserPofileController" method="get">
                                        <input type="hidden" name="changeInfo" value="editInfo">
                                        <div class="mb-3">
                                            <button class="btn btn-primary button-custom-pass" type="submit">Change Information</button>
                                        </div>
                                    </form>
                                    <!-- Change password button-->
                                    <form action="UserPofileController" method="get">
                                        <input type="hidden" name="changeInfo" value="editPass">
                                        <div class="mb-3">
                                            <button class="btn btn-warning button-custom-pass" type="submit">Change Password</button>
                                        </div>
                                    </form>
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

            function uploadFile() {
                var form = document.getElementById('upload-form');
                var fileInput = document.getElementById('file-input');
                var image = document.getElementById('profile-image');
                var file = fileInput.files[0];

                console.log("File selected:", file); // Debug thông báo khi tệp được chọn

                if (file) { // Kiểm tra xem tệp có được chọn hay không
                    var url = URL.createObjectURL(file);

                    // Giải phóng URL cũ nếu có
                    if (image.src && image.src.startsWith('blob:')) {
                        URL.revokeObjectURL(image.src);
                    }

                    image.src = url;
                    console.log("Submitting form...");
                    form.addEventListener('submit', function (event) {
                        console.log('Form is being submitted');
                    });

                    // Submit form tự động
                    form.submit();
                } else {
                    console.log("No file selected."); // Debug thông báo khi không có tệp được chọn
                }
            }
        </script>
    </body>
</html>

<%-- Document : register Created on : Jun 4, 2024, 4:34:01 AM Author : Huenh --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <jsp:include page="/shared/_head.jsp" />
    <link rel="stylesheet" type="text/css" href="assets/css/reset-password.css" />


    <body class="d-flex justify-content-center align-items-center">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h3>Reset Password</h3>
                        </div>
                        <div class="card-body">
                            <form action="./reset-password" method="POST" id="update-password-form">
                                <div class="form-group d-none">
                                    <input type="text" class="form-control" id="state" name="state" value="request-change" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="number">Reset Code</label>
                                    <input type="text" class="form-control" id="number" name="code" value="<%= request.getAttribute("code") %>" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="email">Email Address</label>
                                    <input type="email" class="form-control" id="email" name="email" value="<%= request.getAttribute("email") %>" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="password" class="form-control" id="password" name="password" minlength="6" maxlength="20" required>
                                </div>
                                <div class="form-group">
                                    <label for="confirm_password">Confirm Password</label>
                                    <input type="password" class="form-control" id="confirm_password" name="confirm_password" minlength="6" maxlength="20" required>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary btn-block">Submit</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>

    <script>
        document.getElementById('update-password-form').addEventListener('submit', function (event) {
            var password = document.getElementById('password').value;
            var confirmPassword = document.getElementById('confirm_password').value;
            if (password !== confirmPassword) {
                var alertDiv = document.createElement('div');
                alertDiv.className = 'alert alert-danger';
                alertDiv.setAttribute('role', 'alert');
                alertDiv.textContent = 'Passwords do not match. Please try again.';
                document.getElementById('update-password-form').appendChild(alertDiv);

                setTimeout(function () {
                    alertDiv.parentNode.removeChild(alertDiv);
                }, 2000);

                event.preventDefault();
            }
        });
    </script>
</html>
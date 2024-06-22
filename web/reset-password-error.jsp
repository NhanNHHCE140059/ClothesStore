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
                            <form action="./reset-password" method="POST">
                                <div class="form-group">
                                    <label for="email">Email Address</label>
                                    <input type="email" class="form-control" id="email" name="email" required>
                                </div>
                                <div class="alert alert-danger" role="alert">
                                    <%= request.getAttribute("error-message") %>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary btn-block">Reset Password</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>

</html>
<%-- Document : register Created on : Jun 4, 2024, 4:34:01 AM Author : Huenh --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <jsp:include page="/shared/_head.jsp" />

    <body class="d-flex justify-content-center align-items-center" style="background: url('https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=1920');height: 100vh;">
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
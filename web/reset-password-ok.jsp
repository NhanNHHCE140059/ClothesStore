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
                            <div class="alert alert-success" role="alert">
                                ${message}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <div class="d-none">${code}</div>

</html>
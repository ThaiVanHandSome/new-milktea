<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="<c:url value='/security/css/bootstrap.css'/>" rel="stylesheet" />
    <script>
    function checkPasswordMatch() {
        var password = document.getElementById("password").value;
        var retype = document.getElementById("floatingRetype").value;
        var submitButton = document.getElementById("submit");

        if (password === retype) {
            submitButton.disabled = false;
        } else {
            submitButton.disabled = true;
        }
    }
    </script>
</head>

<body>
    <section class="bg-white">
        <div class="container py-2">
            <div class="row justify-content-center" style="margin-top:180px">
              <div class="col-md-6">
                    <img src='<c:url value="/security/img/change_password.jpg" />' alt="Image" class="img-fluid me-3"
                        style="margin-left: -50px;">
                </div>
                <div class="col-md-6 col-sm-12">
                    <div class="card rounded-4 shadow">
                        <div class="card-body p-md-5 p-sm-2">
                            <h2 class="fw-bold mb-4">Change Password</h2>
                            <form action="/security/change-password" method="post" style="min-width: fit-content;">
                                <sec:csrfInput />
                                <input type="hidden" name="token" value="${token}" />
                                <div class=" rounded p-3">
                                    <div>
                                        <p>
                                            <input type="password" id="password" name="password" class="form-control"
                                                placeholder="Enter your new password" required autofocus />
                                        </p>
                                        <p>
                                            <input type="password" class="form-control"
                                                placeholder="Confirm your new password" id="floatingRetype" required
                                                oninput="checkPasswordMatch(this);" />
                                        </p>
                                        <p class="text-center">
                                            <input type="submit" id="submit" value="Change Password"
                                                class="btn btn-primary" />
                                        </p>
                                    </div>
                                </div>
                                <div class="alert">
                                    <c:if test="${not empty message}">
                                        <div class="alert alert-success">${message}</div>
                                    </c:if>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>

</html>

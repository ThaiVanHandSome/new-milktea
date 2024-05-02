<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Security</title>
    <meta http-equiv="Content-Security-Policy" content="default-src 'self'; style-src 'self'; ">
    <link href="<c:url value='/security/css/bootstrap.css'/>" rel="stylesheet" />
<%--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet"--%>
<%--        integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">--%>
<%--<style type="text/css">--%>
.custom-center {
    margin-top:15px;
}
</style>
</head>
<body>
<div class="custom-center">
    <section class="bg-white">
        <div class="container py-2 h-100"> 
            <div class="row d-flex justify-content-center align-items-center">
               
              <div class="col-md-6">
                    		<img src='<c:url value="/security/img/login.jpg" />'alt="Image" class="img-fluid me-3"style="margin-left: -50px;">
                		</div>
                <div class="col-md-6">
                    <div class="card rounded-4 shadow">
                        <div class="card-body p-md-5 p-sm-2">
                            <form action="/security/login" method="post">
                                <sec:csrfInput />
                                <h3 class="fw-bold mb-4 text-center">Sign in</h3>
                                <div class="alert">
                                    <c:if test="${not empty message}">
                                        <div class="alert alert-success">${message}</div>
                                    </c:if>
                                   
                                </div>
                                <div class="mb-3">
                                    <div class="form-floating">
                                        <input type="text" id="username" name="username" value="${username}" class="form-control" placeholder="Username" />
                                        <label class="form-label">User Name</label>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <div class="form-floating">
                                        <input type="password" id="password" name="password" value="${password}" class="form-control" placeholder="Password" />
                                        <label class="form-label">Password</label>
                                    </div>
                                </div>
                                <div class="form-check d-flex justify-content-start mb-4">
                                    <input class="form-check-input me-2" type="checkbox" name="remember-me" id="form1Example3" />
                                    <label class="form-check-label"> Remember password? </label>
                                    <a href="/security/forgot-password" class="ms-auto text-decoration-none">Forgot password?</a>
                                </div>
                                <div class="d-grid gap-2 mb-2">
                                    <button type="submit" id="submit" class="btn btn-lg rounded-3 btn-primary">Sign In</button>
                                </div>
                                <hr class="my-4">
                                <h2 class="fs-5 fw-bold mb-3 text-center">Or</h2>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-7 offset-md-4 text-end mb-3">
		<div class="d-inline">
			<p class="d-inline">
				<b>Bạn chưa có tài khoản ?</b>
			</p>
			<a href="/security/register" class="text-primary text-decoration-none d-inline"><b> Đăng ký</b></a>
		</div>
	</div>
    </section>
</div>
</body>
</html>

<%@page import="hcmute.service.impl.CookieServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="hcmute.entity.MilkTeaCategoryEntity"%>
<%@ page import="hcmute.entity.MilkTeaTypeEntity"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="hcmute.service.IMilkTeaCategoryService"%>
<%@ page import="hcmute.service.IMilkTeaTypeService"%>
<%@ page import="hcmute.service.IUserService"%>
<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="hcmute.entity.UserEntity" %>
<%
WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);

// Retrieve the beans
IMilkTeaCategoryService milkTeaCategoryService = context.getBean(IMilkTeaCategoryService.class);
IMilkTeaTypeService milkTeaTypeService = context.getBean(IMilkTeaTypeService.class);
IUserService userService = context.getBean(IUserService.class);

List<MilkTeaCategoryEntity> categories = milkTeaCategoryService.findAll();
List<List<MilkTeaTypeEntity>> types = new ArrayList<>();

request.setAttribute("categories", categories);

for (MilkTeaCategoryEntity category : categories) {
	List<MilkTeaTypeEntity> typesForCategory = milkTeaTypeService.findAllByCategoryId(category.getIdCategory());
	types.add(typesForCategory);
}

request.setAttribute("types", types);
Cookie[] cookies = request.getCookies();
if (cookies != null) {
	for (Cookie cookie : cookies) {
		if ("USER_ID".equals(cookie.getName())) {
	int idUser = Integer.parseInt(cookie.getValue());
	UserEntity user = userService.findById(idUser).get();
	request.setAttribute("user", user);
	request.setAttribute("user_id", idUser);
	break;
		}
	}
}
%>

<!DOCTYPE html>
<html>
<head>
<link href='<c:url value="/user/css/header.css" />' rel="stylesheet" />
</head>
<body>
	<header class="header">
		<div class="container-left">
			<a class="d-block" href="/home"> <img
				src="https://raw.githubusercontent.com/ThaiVanHandSome/logo/master/alotra-high-resolution-logo-black-transparent.png"
				class="logo" />
			</a>
			<ul class="nav-list">
				<li class="nav-item"><a class="nav-item-link" href="/products">Menu</a>
					<div class="header-menu">
						<div class="row">
							<c:set var="index" value="0" />
							<c:forEach var="category" items="${categories}">
								<div class="col">
									<p class="header-category">${category.name}</p>
									<ul class="type-product-list">
										<c:forEach var="type" items="${types[index]}">
											<li class="type-product-item"><a
												href="/products/type/${type.idType}"
												class="type-product-link">${type.name}</a></li>
										</c:forEach>
									</ul>
								</div>
								<c:set var="index" value="${index + 1}" />
							</c:forEach>
						</div>
					</div></li>
				<li class="nav-item"><a class="nav-item-link" href="/branches">Cửa
						hàng</a></li>
			</ul>
		</div>

		<form action="/header/moveToSearchPage" method="get"
			accept-charset="UTF-8">
			<div class="search-container">
				<input type="text" class="search-inp" name="content" />
				<button class="search-btn" type="submit">
					<i class="fa-solid fa-magnifying-glass"></i>
				</button>
			</div>
		</form>

		<div class="container-right">
			<div class="header-info">
				<img
					src="${user.imageUrl}"
					class="avatar" />
				<p class="username">
					<c:if test="${not empty pageContext.request.remoteUser}">
						<span class="fw-bold"><c:out
								value="${pageContext.request.remoteUser}" /></span>
					</c:if>
				</p>
				<ul class="header-action">
					<c:if test="${not empty pageContext.request.remoteUser}">
						<li class="header-action-item"><a
							href="/user_infor/${user_id }" class="header-action-link"
							href="#">Quản lý tài khoản</a></li>
						<li class="header-action-item"><a class="header-action-link"
							href="/cart">Giỏ hàng của tôi</a></li>
						<li class="header-action-item"><a class="header-action-link"
							href="/order">Đơn hàng của tôi</a></li>
						<li class="header-action-item"><a class="header-action-link"
							href="/help">Trợ giúp</a></li>
						<li class="header-action-item"><a class="header-action-link"
							href="/security/forgot-password">Quên mật khẩu</a></li>
						<li class="header-action-item"><a class="header-action-link"
							href="/admin/index">Quản trị</a></li>
							<li class="header-action-item"><a class="header-action-link"
							href="/manager/index">Manager</a></li>
						<li class="header-action-item"><a class="header-action-link"
							href="/security/logout">Đăng xuất</a></li>
					</c:if>
					<c:if test="${empty pageContext.request.remoteUser}">
						<li class="header-action-item"><a class="header-action-link"
							href="/security/login">Đăng nhập</a></li>
						<li class="header-action-item"><a class="header-action-link"
							href="/security/register">Đăng ký</a></li>
						<li class="header-action-item"><a class="header-action-link"
							href="/security/forgot-password">Quên mật khẩu</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</header>
</body>
</html>
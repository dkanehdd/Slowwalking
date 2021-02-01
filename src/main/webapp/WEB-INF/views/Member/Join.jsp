<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../links/linkOnly2dot.jsp"%>
<title>Login.jsp</title>
</head>
<body>
	<!-- Top메뉴 -->
	<%@ include file="../include/top.jsp"%>
	<section class="section-padding" style="background-color:#eee;">
		<div class="container">
			<div class="section_title">
				<h1 class="mb-5"><strong>Join</strong> 가입하기</h1>
			</div>
			<div class="loginContainer input-group mb-3" data-aos="fade-up" data-aos-delay="400">
				<div class="form joinFrm">
					<a class="float-left" href="./memberjoin?flag=parents"><i class="fa fa-users" aria-hidden="true"></i>부모회원으로 가입하기</a>
					<a class="float-right"href="./memberjoin?flag=sitter"><i class="fa fa-address-card" aria-hidden="true"></i>시터회원으로 가입하기</a>
				</div>
			</div>
		</div>
	</section>

	<!-- Footer메뉴 -->
	<%@ include file="../include/footer.jsp"%>
</body>
</html>
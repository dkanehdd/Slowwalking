<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../links/linkOnly2dot.jsp"%>
<title>Login.jsp</title>
</head>
<body>
	<!-- Top메뉴 -->
	<%@ include file="../include/top.jsp"%>

	<section class="testimonial section-padding"
		style="background-color: var(- -project-bg);">
		<div class="container">
			<c:url value="/loginAction" var="loginUrl" />
			<form:form name="loginFrm" action="${loginUrl}" method="post">
				<c:if test="${param.error != null }">
					<p>아이디와 패스워드가 잘못되었습니다.</p>
				</c:if>
				<c:if test="${param.login != null }">
					<p>로그아웃 하였습니다.</p>
				</c:if>
				<div class="loginBox input-group mb-3" data-aos="fade-up" data-aos-delay="400">
					<input type="text" class="form-control" name="id" value="" placeholder="아이디" /> 
					<input type="password" class="form-control" name="pass" value="" placeholder="비밀번호"/>
					<button type="submit" class="btn btn-danger">로그인</button>
					<input type="checkbox" id="idSave" name="idSave" /><label for="idSave">아이디 저장</label>
					<ul>
						<li><a href="#" id="idFind" name="idFind">아이디 찾기</a></li>
						<li><a href="#" id="pwFind" name="idFind">아이디 찾기</a></li>
						<li><a href="../member/join" id="signUp" name="signUp">회원가입</a></li>
					</ul>
				</div>
			</form:form>
		</div>
	</section>

	<!-- Footer메뉴 -->
	<%@ include file="../include/footer.jsp"%>
	<!-- 스크립트 -->
	<script src="../resources/js/jquery.min.js"></script>
	<script src="../resources/js/bootstrap.min.js"></script>
	<script src="../resources/js/aos.js"></script>
	<script src="../resources/js/owl.carousel.min.js"></script>
	<script src="../resources/js/smoothscroll.js"></script>
	<script src="../resources/js/custom.js"></script>
</body>
</html>
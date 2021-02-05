<%@page import="java.math.BigInteger"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
 <%
    String clientId = "MMNYqKIa7wxHjRIOOA6z";//애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://localhost:8080/slowwalking/naver/callback", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL ="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=MMNYqKIa7wxHjRIOOA6z&redirect_uri=";
    apiURL += redirectURI;
    apiURL += "&state="+state;
    session.setAttribute("state", state);
 %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<%@ include file="../links/linkOnly2dot.jsp"%>
<title>Login.jsp</title>
</head>
<body>
	<!-- Top메뉴 -->
	<%@ include file="../include/top.jsp"%>

	<section class="section-padding" style="background-color:#eee;">
		<div class="container">
			<c:url value="/loginAction" var="loginUrl" />
			<form:form name="loginFrm" action="${loginUrl}" method="post">
				<div class="loginContainer input-group mb-3" data-aos="fade-up" data-aos-delay="400">
					<div class="form">
						<div class="lc_top">
							<p class="lct_img"></p>
							<c:if test="${param.error != null }">
								<p class="errTxt">아이디 또는 패스워드가 잘못되었습니다.</p>
							</c:if>
							<c:if test="${param.login != null }">
								<p>로그아웃 하였습니다.</p>
							</c:if>
						</div>						
						<input type="text" class="form-control" name="id" value="" placeholder="아이디" /> 
						<input type="password" class="form-control" name="pass" value="" placeholder="비밀번호"/>
						<button type="submit" class="btn btn-danger">로그인</button><br>
						<div class="form-check">
							<input type="checkbox" id="idSave" name="idSave" class="clear form-check-input"/>
							<label for="idSave" class="form-check-label">아이디 저장</label>
						</div>
					<ul>
						<li><a href="#" id="idFind" name="idFind">아이디 찾기</a></li>
						<li><a href="#" id="pwFind" name="pwFind">비밀번호 찾기</a></li>
						<li><a href="../member/join" id="signUp" class="non-af" name="signUp">회원가입</a></li> 
					</ul>
					<a href="<%=apiURL%>"><img height="50" src="../img/naverlogin.png"/></a>
					<a href="https://kauth.kakao.com/oauth/authorize?client_id=e1bfbd13b698ee8d3ecba1e269ed3918&redirect_uri=http://localhost:8080/slowwalking/kakao/callback&response_type=code">
						<img alt="" src="../img/kakao.png" style="height:50px; width:231px ">
						</a>
					</div>
				</div>
				
			</form:form>
		</div>
	</section>

	<!-- Footer메뉴 -->
	<%@ include file="../include/footer.jsp"%>
</body>
</html>
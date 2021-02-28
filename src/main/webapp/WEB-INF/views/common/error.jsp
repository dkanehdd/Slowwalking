<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
<style type="text/css">
	@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap');
	html, body {
		width: 100%;  
		height: 100%;
		-webkit-font-smoothing: antialiased;
		display: flex;
		justify-content: center;
		align-items: center;
		font-family: 'Noto Sans KR', sans-serif;
	}
	.errBg{		
		width: 600px;
		height: 572px;
		margin: auto auto;
		box-sizing: border-box;
		background-image: url('../resources/images/errorPage.jpg');
		background-repeat: no-repeat;
		background-position: center;
		background-size: cover;
		text-align:center;
		font-size: 17px;
	}
	.errBg strong{
		font-size: 37px;
		font-weight: 900;
		color: #dc5c05;
		display:block;
	}
</style>
</head>
<body>
<!-- 
에러 페이지를 원상복구 하고 싶으면
web.xml 하단의

	<error-page>
	    <exception-type>java.lang.Throwable</exception-type>
	    <location>/WEB-INF/views/common/error.jsp</location>
	</error-page>

와, /Slowwalking/src/main/webapp/WEB-INF/views/common/error.jsp 를 삭제합니다.
 -->
	<div class="errBg">		
	 	<strong>Page Not Found</strong>
	 	<span style="color: #aaa;">관리자에게 문의하세요</span>
	 	<p>+82 1577 0000</p>
	</div>
</body>
</html>
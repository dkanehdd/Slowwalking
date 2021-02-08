<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-3">
	<form name="editFrm" method="post" action="../mypage/editAction?${_csrf.parameterName}=${_csrf.token}" >
	<input type="hidden" name="idx" value="${dto.its_idx}"/>
	<input type="hidden" name="mode" value="${mode }"/>
	<div class="item">
		<h3>후기 수정</h3>
		<p class="s-font">${dto.rece_id } 님에 대한 후기를 수정해 보세요.<p>
	</div>
	<div class="item" id="textarea">
		<textarea class="noresize" rows="13" name="content">${dto.content }</textarea></div>
	
	<!-- 버튼만들기 -->
	<div class="text-center mt-3">
		<button type="submit" class="btn btn-warning" id="edit">수정하기</button>
		<button type="button" class="btn btn-secondary" onclick="history.back()">취소하기</button>
	</div>
	</form>
</div>
</body>
<style>
body{background:url(../resources/images/diary_back2.jpg)}
p {font-size: 14px;}
#sitter{height:50px;}
#textarea{height: 380px;}
.container {display:flex; flex-direction:column; justify-content:center; align-itmes:center;}
.item {background:white; border-radius:10px; width:450px; height:100px; padding:15px; margin:5px 10px;}
.noresize {resize:none; box-sizing: border-box; width:420px; margin-top:7px;
			border:1px solid #c0c0c0; border-radius: 10px;}
.s-font { font-size: 12px; }
</style>
</html>
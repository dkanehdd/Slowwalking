<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${dto.name } 님께 보내는 알림장</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
body {
	background:#ddd url("../resources/images/diaryView.png") no-repeat 360px 15px;
	background-size:120px;
}
p {font-size: 14px;}
.container {display:flex; flex-direction:column; justify-content:center; align-itmes:center;}
.item {background:white; border-radius:10px; width:450px; height:70px; padding:15px; margin:5px 10px;}
.noresize {resize:none; box-sizing: border-box; width:420px; margin-top:3px;
			border:1px solid #c0c0c0; border-radius: 10px;}
.s-font { font-size: 12px; }
#secBox{height:50px;}
#textarea{height: 300px;}
.itemT {border-radius:10px; width:450px; height:80px; padding:15px; margin:5px 10px; text-align:center;}
</style>
</head>
<body>
<div class="container">
	<div class="itemT mt-5" style="text-align:left;">
		<h3 style="font-weight:700;">알림장</h3>
	</div>
	<div class="item" id="secBox">
		<c:choose>
			<c:when test="${flag eq 'parents' }">
				<p>오늘의 선생님 : ${dto.name }</p>
			</c:when>
			<c:otherwise>
				<p>${dto.name } 님께 보내는 알림장</p>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="item" id="textarea">
		<textarea style="border:none;" class="noresize" rows="7" id="content" readonly="readonly">${dto.content }</textarea>
	</div>
</div>
</body>
</html>
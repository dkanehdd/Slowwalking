<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
body {background:url(../resources/images/diary_back.jpg) }
p {font-size: 14px;}
.container {display:flex; flex-direction:column; justify-content:center; align-itmes:center;}
.item {background:white; border-radius:10px; width:450px; height:100px; padding:15px; margin:5px 10px;}
.noresize {resize:none; box-sizing: border-box; width:420px; margin-top:3px;
			border:1px solid #c0c0c0; border-radius: 10px;}
.s-font { font-size: 12px; }
#sitter{height:50px;}
#textarea{height: 230px;}

</style>
</head>
<body>
<div class="container">
	<input type="hidden" id="parents_id" value="${dto.parents_id }"/>
	<input type="hidden" id="sitter_id" value="${dto.sitter_id }"/>
	<input type="hidden" id="idx" value="${dto.idx }"/>
	<div class="item">
		<h3>알림장</h3>
	</div>
	<div class="item" id="sitter">
		<p>오늘의 선생님 : ${dto.sitter_name }</p>
	</div>
	<div class="item" id="textarea">
		<textarea class="noresize" rows="7" id="content">
		dto내용
		</textarea></div>
</div>
</body>
</html>
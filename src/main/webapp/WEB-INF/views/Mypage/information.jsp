<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
	<img src="../resources/images/contact.png" />
	<div>${dto.name } 님의 연락처는</div>
	<div>${dto.phone } 입니다.</div>
</div>
</body>
<style>
body {background: }
img {width:100px;}
.container {text-align:center;}
</style>
</html>
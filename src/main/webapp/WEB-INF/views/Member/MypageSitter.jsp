<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script >
</head>
<body>
	<h2>sitter</h2>
	<h3>아이디: ${dto.sitter_id}</h3>
	
	<p><a href="../mypage/proEdit" target="iframe">정보수정</a></p>
	<iframe src="" name="iframe" width="600" height="600" seamless></iframe>
	<a href="../advertisement/requestBoard_write">의뢰서 쓰기로 이동</a>
</body>
</html>
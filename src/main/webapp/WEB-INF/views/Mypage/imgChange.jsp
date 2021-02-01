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
<style>
.container img {width:200px; height:200px; display:block; margin-left:auto; margin-right:auto; margin-top: 50px;}
</style>
</head>
<body>
<div class="container">
<c:choose>
<c:when test="${not empty image_path }">
이미지: ${image_path }
<img src="../resources/upload/${image_path }" alt="" />
</c:when>
<c:otherwise>
<img src="../resources/images/anonymous-avatar.jpg" alt="" />
</c:otherwise>
</c:choose>
<form action="../mypage/imgChange" enctype="multipart/form-data">
<input type="file" name="newImage" class="mt-3 ml-4"/>
<div class="mt-3 text-center">
<buton type="submit" class="btn btn-warning">수정하기</buton>
</form>
</div>
</div>
</body>
</html>
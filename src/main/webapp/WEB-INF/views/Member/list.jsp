<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list.jsp</title>
</head>
<body>
	
	<h2>회원목록을 보여주는 테스트 페이지</h2>
	
	
	<c:forEach items="${lists }" var="row">		
		${row.name }
	</c:forEach>
</body>
</html>
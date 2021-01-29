<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RequestBoard_view</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script >
</head>
<body>
	<h2>부모가 올린 구직의뢰서 상세보기 페이지</h2>
	<table class="table table-borderless">
		<tbody>
			<tr>
				<td>
					<img src="../images/${dto.image }" style="width:300px; height:300px">
				</td>
			</tr>
			<tr>
				<td>
					부모님 이름 : 
				</td>
			</tr>
			<tr>
				<td>
					지역 : ${dto.region }
				</td>
			</tr>
		</tbody>
	</table>
	
</body>
</html>
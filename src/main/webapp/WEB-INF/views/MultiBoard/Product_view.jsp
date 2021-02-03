<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product_view.jsp</title>
<%@ include file="../links/linkOnly2dot.jsp"%>
<link rel="stylesheet" href="../common/bootstrap4.5.3/css/bootstrap.css" />
<script src="../common/jquery/jquery-3.5.1.js"></script>
</head>
<body>
	<%@ include file="../include/top.jsp"%>
	<section class="section-padding" style="background-color: #eee;">
		<div class="container">
			<input type="hid`den" name="idx" value="${dto.idx }" />
			<table>
				<tr>
					<th class="text-center table-active align-middle">상품의 일련번호</th>
					<td>${dto.idx }</td>
					<th class="text-center table-active align-middle">상품의 이름</th>
					<td>${dto.product_name }</td>
				</tr>
				<tr>
					<th class="text-center table-active align-middle">상품의 가격</th>
					<td colspan="3">${dto.price }</td>
				</tr>
				<tr>
					<th class="text-center table-active align-middle">상품의 정보</th>
					<td colspan="3" class="align-middle" style="height: 200px;">
						${dto.content }</td>
				</tr>
				<tr>
					<th class="text-center table-active align-middle">상품의 이미지</th>
					<td colspan="3" class="align-middle" style="height: 200px;">
						${dto.image }</td>
				</tr>
				</tbody>
			</table>
		</div>
		<!-- Footer메뉴 -->
		<%@ include file="../include/footer.jsp"%>
</body>
</html>
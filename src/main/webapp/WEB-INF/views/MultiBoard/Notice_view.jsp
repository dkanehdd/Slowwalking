<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice_view.jsp</title>
<%@ include file="../links/linkOnly2dot.jsp"%>
<link rel="stylesheet" href="../common/bootstrap4.5.3/css/bootstrap.css" />
<script src="../common/jquery/jquery-3.5.1.js"></script>
</head>
<body>
	<%@ include file="../include/top.jsp"%>
	<section class="section-padding" style="background-color: #eee;">
		<div class="container">
			<input type="hidden" name="idx" value="${dto.idx }" />
			<table>
				<tr>
					<th class="text-center table-active align-middle">작성자</th>
					<td>${dto.id }</td>
					<th class="text-center table-active align-middle">작성일</th>
					<td>${dto.postdate }</td>
				</tr>
				<tr>
					<th class="text-center table-active align-middle">조회수</th>
					<td>${dto.visitcount }</td>
				</tr>
				<tr>
					<th class="text-center table-active align-middle">제목</th>
					<td colspan="3">${dto.title }</td>
				</tr>
				<tr>
					<th class="text-center table-active align-middle">내용</th>
					<td colspan="3" class="align-middle" style="height: 200px;">
						${dto.content }</td>
				</tr>

				</tbody>
			</table>
		</div>
		<!-- Footer메뉴 -->
		<%@ include file="../include/footer.jsp"%>
</body>
</html>
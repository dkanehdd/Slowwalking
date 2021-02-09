<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script type="text/javascript">
<c:if test="${not empty message}">
	alert('${message}');
</c:if>
</script>
</head>
<body>
<div class="ml-3 mt-3">
	<div>
		<span class="title">나의 후기</span>&nbsp;<span class="count">${count}개</span>
	</div>
</div>
<div class="container mt-3">
	<c:forEach var="row" items="${lists }">
	<table class="table table-borderless">
		<c:choose>
			<c:when test="${mode eq 'receive' }">
				<colgroup>
					<col width="10%">
					<col width="*">
				</colgroup>
				<tr>
					<td>
						<c:choose>
							<c:when test="${flag eq 'sitter' }">
								<img src="../resources/images/family.png" class="media-object rounded-circle" style="width:70px;"/>
							</c:when>
							<c:otherwise>
								<img src="../resources/images/sitter.png" class="media-object rounded-circle" style="width:70px;"/>
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						 <span class="info">${row.send_id } | ${row.regidate }</span><br/>
						${row.content }
					</td>
				</tr>
			</c:when>
			<c:otherwise>
				<colgroup>
					<col width="60%">
					<col width="*">
				</colgroup>
				<tr>
					<td>
						 <span class="info">${row.rece_id } | ${row.regidate }</span><br/>
						${row.content }
					</td>
					<td style="text-align:right; vertical-align:middle;">
						<button class="btn btn-warning btn-sm" onclick="location.href='../mypage/editComment?idx=${row.its_idx }&mode=send';">수정</button>
						<button class="btn btn-secondary btn-sm" onclick="location.href='../mypage/delComment?idx=${row.its_idx }&mode=send';">삭제</button>
					</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
	</c:forEach>
	</form>
	<br/>
</div>
<!-- 방명록 반복 부분 e -->
<ul class="pagination justify-content-center">
	${pagingImg }
</ul>
</body>
<style>
body {background-color:#F0F0F0;}
table {background-color: white; border-radius: 10px;}
.title {font-size:25px; font-weight: bold;}
.count {color:#FF7000; font-size:15px; font-weight: bold;}
.info {color:#888280; }
</style>
</html>
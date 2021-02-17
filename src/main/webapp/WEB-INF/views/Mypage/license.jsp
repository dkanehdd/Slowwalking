<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<style>
.container img {width:200px; height:200px; display:block; margin-left:auto; margin-right:auto; margin-top: 50px;}
</style>
<script type="text/javascript">
</script>
</head>
<body>
<div class="ml-2">
<div class="section_title">
	<h3 class="mb-5"><strong>My Certification</strong> 자격증</h3>
</div>
</div>
<div class="container">
	<form:form action="../mypage/updatelicense?${_csrf.parameterName}=${_csrf.token}" name="fileFrm" method="post" 
               enctype="multipart/form-data" onsubmit="return checkImg();">
		<input type="hidden"  name="sitter_id"  value="${dto.sitter_id}">
			<table class="table form joinF">
			<tr>
				<th scope="row">장애영유아보육교사 자격증</th>
				<td style="vertical-align:middle;">
				<c:choose>
					<c:when test="${not empty dto.license_check }">
						장애영유아보육교사 자격증을 확인하였습니다.	파일명 : ${dto.license_check }
					</c:when>
				</c:choose>
				</td>
			</tr>
			<tr>
				<th scope="row">인성검사확인</th>
				<td>
				<c:choose>
					<c:when test="${not empty dto.personality_check }">
						인적성검사 확인증을 등록하셨습니다. 파일명 : ${dto.personality_check }
					</c:when>
					<c:otherwise>
						<input type="file" name='personality_check' />
					</c:otherwise>
				</c:choose>
				</td>
			</tr>
			</table>
		<div class="mt-3 text-center">
			<c:choose>
					<c:when test="${not empty dto.license_check and not empty dto.personality_check}">
						<th scope="row">자격증 검사가 완료되었습니다.</th>
					</c:when>
					<c:otherwise>
						<button type="submit" class="btn btn-warning" >등록하기</button>
					</c:otherwise>
			</c:choose>
		</div>
	</form:form>
</div>
</body>
</html>
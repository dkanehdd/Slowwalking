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
<h3>내 프로필 사진</h3>
</div>
<div class="container">
	<form:form action="../mypage/imgChange?${_csrf.parameterName}=${_csrf.token}" name="fileFrm" method="post" 
               enctype="multipart/form-data" onsubmit="return checkImg();">
		<input type="hidden"  name="id"  value="${user_id }">
		<input type="hidden" name="flag" id="flag" value="${dto.flag }" />
		<c:choose>
			<c:when test="${not empty dto.image_path }">
			<img src="../resources/images/${dto.image_path }" alt="" />
			</c:when>
			<c:otherwise>
			<img src="../resources/images/anonymous-avatar.jpg" alt="" />
			</c:otherwise>
		</c:choose>
		<div class="mt-3 text-center">
			<input type="file" id="image_path" name="image_path"/>
		</div>
		<div class="mt-3 text-center">
			<button type="submit" class="btn btn-warning" >수정하기</button>
		</div>
	</form:form>
</div>
</body>
<script type="text/javascript">
function checkImg() {
	var f = document.fileFrm;
	if(!f.image_path.value){
		Swal.fire({
			icon : 'error',
			text : '이미지를 선택하고 등록해주세요'
		})
		return false;
	}
}
</script>
</html>
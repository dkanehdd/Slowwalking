<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지등록하기</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
</head>
<body>
<script type="text/javascript">
<c:choose>
	<c:when test="${empty sucOrFail}">
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${sucOrFail==1 }">
				alert('${message }');
			</c:when>
			<c:otherwise>
				alert('${message }');
				location.href="/slowwalking/";
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>
</script>

<div class="container">
	<h1>이미지 등록하기</h1>
	
	<form:form action="../member/imagepath?${_csrf.parameterName}=${_csrf.token}" name="fileFrm" method="post" 
               enctype="multipart/form-data" onsubmit="return checkImg();">
        <label for="image_path">이미지선택하기</label>
        <input type="hid`den" name="id" value="${id }" />
        <input type="hid`den" name="flag" id="flag" value="${flag }" />
        <input type="hid`den" name="mode" id="mode" value="${mode }" />
        <div><input type="file" id="image_path" name="image_path"/></div>
		
		<button type="submit">등록하기</button><button type="button" onclick="skip();">건너뛰기</button>
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

function skip(){
	alert('마이페이지에서 사진을 등록하실 수 있습니다.');
	var flag = document.getElementById("flag");
	var mode = document.getElementById("mode");
	if(mode.value=='join'){
		if(flag.value=='sitter'){
			location.href='../member/sitterjoin';
		}
		else if(flag.value=='parents'){
			alert('신청서를 작성해주세요');
			location.href='../member/mypage';
		}
		
	}
	else{
		location.href="../main/main";
	}
}
	
</script>
</html>

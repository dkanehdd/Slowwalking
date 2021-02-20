<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 변경</title>
<%@ include file="../links/linkOnly2dot.jsp"%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
</head>
<body>
<div class="ml-2">
<div class="section_title">
	<h3 class="mb-5"><strong>Profile Image</strong> 이미지 변경하기</h3>
</div>
</div>
<div class="container myPageBg"  data-aos="fade-up" data-aos-delay="400">
	<form:form action="../mypage/imgChange?${_csrf.parameterName}=${_csrf.token}" name="fileFrm" method="post" 
               enctype="multipart/form-data" onsubmit="return checkImg();">
		<input type="hidden"  name="id"  value="${user_id }">
		<input type="hidden" name="flag" id="flag" value="${dto.flag }" />
		<div class="input-group">
            <input type="file" id="image_path" name="image_path" class="upload" onchange="readURL(this);" class="form-control border-0">
            <div class="input-group-append" style="margin-left: auto; margin-right: auto;">
                <label for="image_path" class="btn btn-primary btnUp m-0 rounded-pill px-4">
                <span><i class="fa fa-cloud-upload mr-2 text-white"></i>이미지 수정</span></label>
            </div>
        </div>
		<c:choose>
			<c:when test="${not empty dto.image_path }">
			<div class="image-area mt-4">
	            <img id="imageResult" src="../resources/images/${dto.image_path }" alt="" 
	            class="img-fluid rounded shadow-sm mx-auto d-block">
            </div>
			</c:when>
			<c:otherwise>
			<div class="image-area mt-4">
	            <img id="imageResult" src="../resources/images/anonymous-avatar.jpg" alt="" 
	            class="img-fluid rounded shadow-sm mx-auto d-block">
            </div>
			</c:otherwise>
		</c:choose>
		<div class="btnBelow">
			<button type="button" onclick="location.href='../member/mypage'" class="btn btn-secondary btn-cc">취소하기</button>
			<button type="submit" class="btn btn-danger btn400w" style="background-color:var(--primary-color)">완료하기</button>
		</div>
	</form:form>
</div>
</body>
<%@ include file="../links/joinJs.jsp"%>
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
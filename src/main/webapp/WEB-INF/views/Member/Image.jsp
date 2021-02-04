<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지등록하기</title>
<%@ include file="../links/linkOnly2dot.jsp"%>
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
<!-- Top메뉴 -->
<%@ include file="../include/top.jsp"%>
<section class="section-padding" style="background-color: #eee;">
	<div class="container">
		<div class="section_title">
			<h1 class="mb-5"><strong>Profile Image</strong> 이미지 등록하기</h1>
		</div>
		<form:form
			action="../member/imagepath?${_csrf.parameterName}=${_csrf.token}"
			name="fileFrm" method="post" enctype="multipart/form-data"
			onsubmit="return checkImg();" data-aos="fade-up" data-aos-delay="400">
			
			
			 <!-- 이미지 인풋 -->
			<input type="hidden" name="id" value="${id }" />
			<input type="hidden" name="flag" id="flag" value="${flag }" />
			<input type="hidden" name="mode" id="mode" value="${mode }" />
            <div class="input-group">
                <input type="file" id="image_path" name="image_path" class="upload" onchange="readURL(this);" class="form-control border-0">
                <div class="input-group-append" style="margin-left: auto; margin-right: auto;">
                    <label for="image_path" class="btn btn-primary btnUp m-0 rounded-pill px-4">
                    <span><i class="fa fa-cloud-upload mr-2 text-white"></i>이미지 업로드</span></label>
                </div>
            </div>

            <!-- 이미지 미리보기 -->
            <div class="image-area mt-4">
	            <img id="imageResult" src="#" alt="" 
	            class="img-fluid rounded shadow-sm mx-auto d-block">
            </div>
			
			
			<div class="btnBelow">
				<button type="button" onclick="skip();" class="btn btn-secondary btn-cc">건너뛰기</button>
				<button type="submit" class="btn btn-danger">등록하기</button>
			</div>		
		</form:form>
	</div>
</section>
<!-- Footer메뉴 -->
<%@ include file="../include/footer.jsp"%>
</body>
<%@ include file="../links/joinJs.jsp"%>
</html>

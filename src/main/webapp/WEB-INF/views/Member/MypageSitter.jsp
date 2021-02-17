<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<%@ include file="../links/linkOnly2dot.jsp"%>
<title>느린걸음-마이페이지</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#innerPage").load("../mypage/interList");
		$("#profile").on("click", function() {
			$("#innerPage").load("../mypage/proEdit");
		});
		$("#image").on("click", function() {
			$("#innerPage").load("../mypage/getImage");
		});
		$("#interview").on("click", function() {
			$("#innerPage").load("../mypage/interList");
		});
		$("#calendar").on("click", function() {
			location.href = "../mypage/diaryCalendar";
		});
		$("#comment").on("click", function() {
			$("#innerPage").load("../mypage/myComment");
		});
		$("#membership").on("click", function() {
			$("#innerPage").load("../mypage/membership");
		});
		$("#license").on("click", function() {
			$("#innerPage").load("../mypage/license");
		});
		$("#sitterEdit").on("click", function() {
			$("#innerPage").load("../mypage/sitterEdit");
		});
		$("#premium").on("click", function() {
			$("#innerPage").load("../mypage/premium");
		});
	});
</script>
<style>
.box {
	position: relate;
}

.box img {
	width: 200px;
	height: 200px;
}

.in {
	position: absolute;
	top: 10px;
	left: 175px;
}

.in img {
	width: 30px;
}

.list-group-item:hover {
	cursor: pointer;
	background-color: #ffce7f;
}
</style>
</head>
<body>
	<%@ include file="../include/top.jsp"%>
	<%@ include file="../links/sitterMypage.jsp"%>
	<div class="container-fluid">
		<div class="row mt-5 ml-5">
			<div class="col-2">
				
				<div class="box">
					<c:choose>
						<c:when test="${not empty dto.image_path }">
							<img src="../resources/images/${dto.image_path }" />
						</c:when>
						<c:otherwise>
							<img src="../resources/images/anonymous-avatar.jpg"
								style="width: 200px;" />
						</c:otherwise>
					</c:choose>
				</div>
				<div class="in">
					<img src="../resources/images/photo-camera.png" id="image">
				</div>
				<div class="bg-dark text-light" style="width: 200px;">
					&nbsp;${dto.name}&nbsp;<small>님</small>
				</div>
				<div>
					리스트에 공개 
					<label class="switch">
					
					<c:choose>
						<c:when test="${sdto.advertise eq 'T'}">
							<input type="checkbox" onclick="togglechange(this);" checked="checked"> 
						</c:when>
						<c:otherwise>
							<input type="checkbox" onclick="togglechange(this);" > 
						</c:otherwise>
					</c:choose>
					<span
						class="slider round"></span>
					</label>
				</div>
				<ul class="list-group list-group-flush">
					<li class="list-group-item mt-2" id="profile">회원정보수정</li>
				</ul>
				<ul class="list-group list-group-flush">
					<li class="list-group-item" id="sitterEdit">내 신청서 수정</li>
					<li class="list-group-item" id="license">자격증 관리</li>
				</ul>
				<ul class="list-group list-group-flush">
					<li class="list-group-item" id="interview">내 구직현황</li>
					<li class="list-group-item" id="comment">후기관리</li>
				</ul>
				<ul class="list-group list-group-flush">
					<li class="list-group-item mt-2" id="membership">이용권</li>
					<li class="list-group-item"><img src="../resources/images/p.png" style="height:14px;"> ${dto.point}</li>
					<li class="list-group-item" id="premium">프리미엄권</li>
				</ul>
				<br />
				<br />
				<br />
				<br />
			</div>
			<div class="col-10">
				<div id="innerPage" class="ml-3 mt-3">
					<h3>마이페이지</h3>
					<div class="container">
						<div class="row">
							<div class="col-12"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../include/footer.jsp"%>
</body>
</html>
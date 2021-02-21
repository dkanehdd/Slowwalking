<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>느린걸음</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
	.myrate{margin: 25px auto; text-align:center;}
	.info{text-align:center;}
	.info i{color: var(--primary-color); font-size: 21px;}
	.firstTxt {font-size:20px; font-weight:700;}
	.secTxt {color:#777; font-size:14px;}
	.rateTxt {font-size:30px; color: var(--first-color);}
	.buttons {text-align:center;}
	.buttons button:hover{
		box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
		transition: all 0.3s ease 0s 
	}
	.btn_image1{
		width:248px;
		height:308px;
		border-radius:15px;
		border:none;
		background-image:url("../resources/images/receive_comment.png");
	}
	.btn_image2{
		width:248px;
		height:308px;
		background-image:url("../resources/images/send_comment.png");
	}
</style>
</head>
<body>
<div class="ml-2 myComment">
	<div class="section_title">
		<h3 class="mb-5"><strong>My Comment</strong> 나의 후기</h3>
	</div>
	</div>
	<div class="container mt-5 myPageBg"  data-aos="fade-up" data-aos-delay="400">
		<div class="info">
			<i class="fa fa-star mb-3" aria-hidden="true"></i>
			<div class="firstTxt">당신의 별점을 확인하세요</div>
			<div class="secTxt">나의 별점은 후기에서 작성되며
			<br/>후기 내용은 아래 버튼을 통해 확인하실 수 있습니다.</div>
		</div>
	<div class="row">
		<div class="myrate">
			<c:choose>
				<c:when test="${dto.starrate eq '0' }">
					등록된 별점이 아직 없어요.
				</c:when>
				<c:otherwise>
					<div class="rateTxt">${dto.starrate}점</div>
					<c:set var="x" value="${dto.starrate }"/>
					<fmt:parseNumber var="i" integerOnly="true" type="number" value="${x}"/>
					<c:forEach begin="1" end="${i}" step="1">
						<img src="../resources/images/star.png" alt="" />
					</c:forEach>
					<c:if test="${ i ne 5 }"></c:if>
						<c:forEach begin="1" end="${5-i }" step="1">
							<img src="../resources/images/b_star.png" alt="" />
						</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="buttons mb-5">
		<button class="btn btn_image1 mr-2" onClick="popReceive();"></button>
		<button class="btn btn_image2" onClick="popSend();"></button>
	</div>
</div>
<script type="text/javascript">
	function popReceive(){
		var popupX = (window.screen.width / 2) - (500 / 2);
		var popupY= (window.screen.height / 2) - (600 / 2);
		window.open("../mypage/commentList?mode=receive", "rece_comment", "width=500px, height=600px, toolbar=no, menubar=no, status=no, scrollbars=no, resizable=no, left="+ popupX + ", top="+ popupY);
	}
	function popSend(){
		var popupX = (window.screen.width / 2) - (500 / 2);
		var popupY= (window.screen.height / 2) - (600 / 2);
		window.open("../mypage/commentList?mode=send", "send_comment", "width=500px, height=600px, toolbar=no, menubar=no, status=no, scrollbars=no, resizable=no, left="+ popupX + ", top="+ popupY);
	}
</script>
</body>
</html>
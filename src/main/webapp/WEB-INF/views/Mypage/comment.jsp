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
</head>
<body>
<div class="contatiner ml-3 mt-3">
	<h3>나의 후기</h3>
</div>
<div class="container ml-3 mt-5">
	<div class="row info">
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
					<fmt:parseNumber var="i" integerOnly="true" 
					type="number" value="${x}"/>
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
		<button class="btn btn_image" onClick="popReceive();"><img src="../resources/images/receive_comment.png"></button>
		<button class="btn btn_image" onClick="popSend();"><img src="../resources/images/send_comment.png"></button>
	</div>
</div>
</body>
<style>
.myrate{margin: 25px auto; text-align:center;}
.info{background-color: #3C5059; width:530px; height:100px; margin:0 auto; padding:20px; border-radius:10px;}
.firstTxt {color: white; font-size:20px; font-weight:bold;}
.secTxt {color:#E6EAEE; font-size:12px;}
.rateTxt {font-size:30px; font-weight:bold;}
.buttons {text-align:center;}
</style>
<script type="text/javascript">
function popReceive(){
	window.open("../mypage/commentList?mode=receive", "rece_comment", "width=500px, height=600px");
}
function popSend(){
	window.open("../mypage/commentList?mode=send", "send_comment", "width=500px, height=600px");
}
</script>
</html>
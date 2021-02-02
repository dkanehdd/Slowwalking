<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RequestBoard_view</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<!-- css, js 파일링크 등 묶음-->
<%@ include file="../links/linkOnly2dot.jsp"%>
</head>
<body>
<%@ include file="../include/top.jsp"%>
<div class="container">
<div class="RequestBoardList" data-aos="fade-up" data-aos-delay="400">
<div class="container p-3 my-3 bg-muted">
<center>
	<img src="../resources/images/${dto.image }" class="media-object rounded-circle" style="width:200px; height:200px">
	<br/><br/>
	<h3 class="text-center">${dto.title }</h3>  
	<hr style="border: solid 3px #DBDBDB ">
	<h4>${dto.children_name }</smail>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<smail>no.${dto.idx }</smail>
	<div id="back"> 
		<div id="in">
			<span>장소: </span><i class='fas fa-map-marker-alt' style='font-size:20px; color: #F77B26;'></i><span style="color: #F77B26; ">${dto.region }</span>
		</div>
		<div id="in">
			<span>시급 : </span><i class='fas fa-won-sign' style='font-size:24px; color: #F77B26;'></i></i><span span style="color: #F77B26; ">${dto.pay }</span> 
		</div>
		<div id="in"> 
			<p style="color: #F77B26; font-size: 15px;">※가능한 날짜 색깔입니다.</p> 
			<button type="button" ${fn:contains(timeArray, '월') ? 'class="workday_off workday_on mr1p"' : 'class="workday_off mr1p"'}
				value="월">월</button>
			<button type="button" ${fn:contains(timeArray, '화') ? 'class="workday_off workday_on mr1p"' : 'class="workday_off mr1p"'}
				value="화">화</button>
			<button type="button" ${fn:contains(timeArray, '수') ? 'class="workday_off workday_on mr1p"' : 'class="workday_off mr1p"'}
				value="수">수</button>
			<button type="button" ${fn:contains(timeArray, '목') ? 'class="workday_off workday_on mr1p"' : 'class="workday_off mr1p"'}
				value="목">목</button>
			<button type="button" ${fn:contains(timeArray, '금') ? 'class="workday_off workday_on mr1p"' : 'class="workday_off mr1p"'}
				value="금">금</button>
			<button type="button" ${fn:contains(timeArray, '토') ? 'class="workday_off workday_on mr1p"' : 'class="workday_off mr1p"'} 
				value="토">토</button>
			<button type="button" ${fn:contains(timeArray, '일') ? 'class="workday_off workday_on mr1p"' : 'class="workday_off mr1p"'} 
			value="일">일</button> 
			<button type="button" ${fn:contains(timeArray, '협의 가능') ? 'class="workday_off workday_on mr1p"' : 'class="workday_off mr1p"'}
			value="협의가능" style="width: 60px">협의가능</button> 
		</div>
		<div id="in">
			<span>시간 : </span><span span style="color: #F77B26; " >${time }</span> 
		</div>
		<div id="in">
			<span>장애등급 : </span><span span style="color: #F77B26; " >${dto.disability_grade }</span> 
		</div>
		<div id="in">
			<span>주의사항 : </span><i class="fa fa-warning" style="font-size:24px; color: #DD143C"></i><span span style="color: #DD143C; " >${dto.warning }</span> 
		</div>
		<div id="in">
			<span>아이의 나이 : </span><span span style="color: #F77B26; " >${dto.age }</span> 
		</div>
		<div id="in">
			<span>시터 기간 : </span><span span style="color: #F77B26; " >${dto.regular_short }</span> 
		</div>
		<div id="in">
			<span>희망 시작 날짜 : </span><span span style="color: #F77B26; " >${dto.start_work }</span> 
		</div>
	</div>  
	 
</center>
<center>
	<c:if test="${flag eq 'sitter'}"> 
		<button class="btn btn-success">인터뷰 신청하기</button>
	</c:if>
	<c:if test="${dto.id eq sessionScope.user_id }">
		<button onClick="location.href='requestBoard_edit?idx=${dto.idx}&list_flag=${list_flag }'" class="btn btn-warning">수정하기</button>
		<button onClick="location.href='requestBoardAction_delete?idx=${dto.idx}&list_flag=${list_flag }'" class="btn btn-dark">삭제하기</button>
	</c:if>
</center>
	</div>
	</div>
</div>
<style>
#back{
	background-color: #DBDBDB;
	width: 500px;
}
#in{
	padding: 10px;
	margin: 10px;
	width: 650px;
	background-color: white;
}
.workday_off {
	border: 1px solid #e0e0e0;
	background: #fff;
	margin-top: 7px;
	width: calc(70%/ 8);
	color: #595757;
	padding: 6px 0;
	text-align: center;
	font-family: Noto Sans KR, sans-serif !important;
	font-size: 15px;
	font-weight: 400; 
}

.workday_on {
	background: #F77B26;
}
</style>
<!-- Footer메뉴 -->
<%@ include file="../include/footer.jsp"%>
<style>
#back{
	background-color: #DBDBDB;
	width: 700px;
}
</style>

</body>
</html>
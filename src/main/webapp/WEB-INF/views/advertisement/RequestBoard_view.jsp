<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name='viewport' content='width=device-width, initial-scale=1'>
<!-- css, js 파일링크 등 묶음-->
<%@ include file="../links/linkOnly2dot.jsp"%>
<script src="../resources/js/reqBdJs.js"></script>
<title>의뢰</title>
</head>
<body>
<!-- Top메뉴 -->
<%@ include file="../include/top.jsp"%>
<section class="section-padding" style="background-color: #eee;">
	<div class="container">
		<div class="section_title">
			<h1 class="mb-5"><strong>REQUEST</strong> 의뢰상세</h1>
		</div>
		<div class="RequestBoardList" data-aos="fade-up" data-aos-delay="400">
			<div class="p-3 my-3 bg-muted text-center form" style="width:100%;">
				<div class="upperReqView">
					<img src="../resources/images/${dto.image }"
						class="media-object rounded-circle mb-2"
						style="width: 200px; height: 200px; margin-left: auto; margin-right: auto;">
					<h3 class="text-center">${dto.title }</h3>
					<input type="hidden" id="idx" value="${dto.idx}" /> 
					<input type="hidden" id="id" value="${dto.id}" /> 
					<input type="hidden" id="request_time" value="${dto.request_time}" />
				</div>
				<div class="belowReqView">				
					<div id="back">
						<h4 class="float-left" style="width: 34%;">${dto.children_name }</h4><!-- <small class="ml-3">no.${dto.idx }</small> -->
						<div id="in" class="float-left" style="width:33%;">
							<span>장소: </span><i class='fas fa-map-marker-alt'
								style='font-size: 20px; color: #F77B26;'></i><span
								style="color: #F77B26;">${dto.region }</span>
						</div>
						<div id="in" class="float-right" style="width:33%;">
							<span>시급 : </span><i class='fas fa-won-sign'
								style='font-size: 24px; color: #F77B26;'></i><span 
								style="color: #F77B26;">${dto.pay }</span>
						</div>
						<div id="in" class="clear">
							<p style="color: #F77B26; font-size: 15px;">※가능한 날짜 색깔입니다.</p>
							<button type="button"
								${fn:contains(timeArray, '월') ? 'class="workday_off workday_on mr1p"' : 'class="workday_off mr1p"'}
								value="월">월</button>
							<button type="button"
								${fn:contains(timeArray, '화') ? 'class="workday_off workday_on mr1p"' : 'class="workday_off mr1p"'}
								value="화">화</button>
							<button type="button"
								${fn:contains(timeArray, '수') ? 'class="workday_off workday_on mr1p"' : 'class="workday_off mr1p"'}
								value="수">수</button>
							<button type="button"
								${fn:contains(timeArray, '목') ? 'class="workday_off workday_on mr1p"' : 'class="workday_off mr1p"'}
								value="목">목</button>
							<button type="button"
								${fn:contains(timeArray, '금') ? 'class="workday_off workday_on mr1p"' : 'class="workday_off mr1p"'}
								value="금">금</button>
							<button type="button"
								${fn:contains(timeArray, '토') ? 'class="workday_off workday_on mr1p"' : 'class="workday_off mr1p"'}
								value="토">토</button>
							<button type="button"
								${fn:contains(timeArray, '일') ? 'class="workday_off workday_on mr1p"' : 'class="workday_off mr1p"'}
								value="일">일</button>
							<button type="button"
								${fn:contains(timeArray, '협의 가능') ? 'class="workday_off workday_on mr1p"' : 'class="workday_off mr1p"'}
								value="협의가능">협의가능</button>
						</div>
						<div id="in">
							<span>시간 : </span><span span style="color: #F77B26;">${time }</span>
						</div>
						<div id="in">
							<span>장애등급 : </span><span span style="color: #F77B26;">${dto.disability_grade }</span>
						</div>
						<div id="in">
							<span>주의사항 : </span><i class="fa fa-warning"
								style="font-size: 24px; color: #DD143C"></i><span span
								style="color: #DD143C;">${dto.warning }</span>
						</div>
						<div id="in">
							<span>아이의 나이 : </span><span span style="color: #F77B26;">${dto.age }</span>
						</div>
						<div id="in">
							<span>시터 기간 : </span><span span style="color: #F77B26;">${dto.regular_short }</span>
						</div>
						<div id="in">
							<span>희망 시작 날짜 : </span><span span style="color: #F77B26;">${dto.start_work }</span>
						</div>
						<input type="hidden" id="addr" value="${dto.region }" />
						<div id="map" style="width: 600px; height: 400px;"></div>
					</div>
					<c:if test="${flag eq 'sitter'}">
						<button class="btn btn-success" id="submit">인터뷰 신청하기</button>
					</c:if>
					<c:if test="${dto.id eq sessionScope.user_id }">
						<button
							onClick="location.href='requestBoard_edit?idx=${dto.idx}&list_flag=${list_flag }'"
							class="btn btn-warning">수정하기</button>
						<button
							onClick="location.href='requestBoardAction_delete?idx=${dto.idx}&list_flag=${list_flag }'"
							class="btn btn-dark">삭제하기</button>
					</c:if>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Footer메뉴 -->
	<%@ include file="../include/footer.jsp"%>
</body>
</html>
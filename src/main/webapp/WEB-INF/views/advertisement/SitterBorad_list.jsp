<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<!-- css, js 파일링크 등 묶음-->
<%@ include file="../links/linkOnly2dot.jsp"%>
<script src="../resources/js/sitBdJs.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style type="text/css">
.btnSch{
	width:50%;
	height: 50px;
	margin: 10px auto 30px;
	background-color: var(--primary-color);
	border-color: var(--secondary-color)
}
.btnSch:hover{
	background-color: var(--secondary-color);
	border-color: var(--primary-color)
}
.btnSch:active{
	background-color: var(--primary-color);
	border-color: var(--secondary-color)
}
</style>
<title>느린걸음</title>
</head>

<body oncontextmenu='return false' onselectstart='return false' ondragstart='return false'>
<%@ include file="../include/top.jsp"%>
<section class="section-padding" style="background-color: #eee;">
	<div class="container reqDiv">
		<div class="section_title">
			<h1 class="mb-5"><strong>SITTER</strong> 시터리스트</h1>
		</div>
		<div class="RequestBoardList">
			<div class="container-1" data-aos="fade-down" data-aos-delay="400">
			<form action="../advertisement/SitterBoard_list?${_csrf.parameterName}=${_csrf.token}"
			method="post" class="form reqFrm" style="width:100%; margin-bottom: 20px;">
				<input type="hidden" name="search" value="search">
				<div class="text-center">				
					<div class="schArea">
						<p style="margin-bottom:0;"><small>※ 가능한 요일(다중 선택 가능)</small></p>
						<button type="button" class="workday_off mr1p" value="월">월</button>
						<button type="button" class="workday_off mr1p" value="화">화</button>
						<button type="button" class="workday_off mr1p" value="수">수</button>
						<button type="button" class="workday_off mr1p" value="목">목</button>
						<button type="button" class="workday_off mr1p" value="금">금</button>
						<button type="button" class="workday_off mr1p" value="토">토</button>
						<button type="button" class="workday_off" value="일">일</button>
						<button type="button" class="workday_off" id="consultation" value="협의가능">협의가능</button>
					</div>		
					<button type="submit" class="btn btn-danger btnSch">검색</button>
				</div>
				<!-- 더보기 버튼 -->
				<p class="clear drop dropMore dropClose">상세옵션 <i class="moreIco fa fa-chevron-down" aria-hidden="true"></i></p>
				<!-- 더보기 버튼 눌렀을 시 열리는 메뉴 -->
				<div class="dropMenu">	
				<input type="hidden" id="workday_name" name="request_time">
				<div class="schArea">
					<select id='sido' class="form-control float-left" style="width:33%;">
						<option value="">원하는 지역 시/도 선택</option>
						<option value="서울">서울</option>
						<option value="강원">강원</option>
						<option value="경기">경기</option>
						<option value="경남">경남</option>
						<option value="경북">경북</option>
						<option value="광주">광주</option>
						<option value="대구">대구</option>
						<option value="대전">대전</option>
						<option value="부산">부산</option>
						<option value="울산">울산</option>
						<option value="인천">인천</option>
						<option value="전남">전남</option>
						<option value="전북">전북</option>
						<option value="제주">제주</option>
						<option value="충남">충남</option>
						<option value="충북">충북</option>
					</select> 
					<span id="catetd1" class="area2ck float-left" style="width: 34%; position: unset; margin: 0"> 
						<select id="gugun" class="form-control">
								<option value="">-구/군-</option>
						</select>
					</span>					
					<input type="number" name="pay" min="8720"
					class="form-control float-left" style="width: 33%;"
					placeholder="※시급 최대치, 비워둘 시 전체 검색"/>
					<input type="hidden" name="region" id="region" />
					<p class="clear"></p>
				</div>
			</div>				
		</form>
		</div>
		</div>
		<!-- 시터 리스트 -->
		<c:forEach items="${lists }" var="row">
			<div class="container-1 border p-3 mb-2" data-aos="fade-up" data-aos-delay="400" style="background-color: #fff;">
				<div class="media">
					<div class="media-left ml-4 mr-5">
					<c:choose>
						<c:when test="${not empty row.image_path }">
							<img src="../resources/images/${row.image_path }"
							class="media-object mr-3" style="width: 100px; height: 100px; border-radius: 70%">
						</c:when>
						<c:otherwise>
							<img src="../resources/images/anonymous-avatar.jpg"
							class="media-object" style="width: 100px; height: 100px; border-radius: 70%"/>
						</c:otherwise>
					</c:choose>
						
					</div>
					<div class="media-body">
						<div class="profileInfo">
							<div class="contentRow"
								style="justify-content: space-between; margin-bottom: -2px;">
								<div class="contentRow">
									<a href="../advertisement/SitterBoard_view?id=${row.sitter_id }">
									<c:set var="name" value="${row.name}" />
									<div class="contentRow" style="height: 23px;">
									<c:set var="totalLength" value="${fn:length(name) }" />
									<c:set var="first" value="${fn:substring(name, 0, 1) }" />
									<c:set var="last" value="${fn:substring(name, 2, totalLength) }" />
									<c:out value="${first}○${last}"/></a>
								</div>
							</div>
								<div class="ReviewRate__Wrapper-sc-1mriui7-0 bEuJEW">
								<c:choose>
									<c:when test="${row.starrate eq '0' }">
									</c:when>
									<c:otherwise>
										<c:set var="x" value="${row.starrate }"/>
										<fmt:parseNumber var="i" integerOnly="true" type="number" value="${x}"/>
										<c:forEach begin="1" end="${i}" step="1">
											<img src="../resources/images/star.png" style="width:15px;">
										</c:forEach>
										<c:if test="${ i ne 5 }"></c:if>
											<c:forEach begin="1" end="${5-i }" step="1">
												<img src="../resources/images/b_star.png" style="width:15px;">
											</c:forEach>
									</c:otherwise>
								</c:choose>
								</div>
							</div>
							<div class="contentRow">
								<div class="locationBlock">
									<span class="locationItem">${row.residence1}</span>
									&nbsp;<span class="locationItem">${row.residence2}</span>
									&nbsp;<span class="locationItem">${row.residence3}</span>
								</div>
							</div>
							<div class="contentRow">
								<div class="userAge">${row.age }세</div>
								<div class="wantedPayment">희망시급 <fmt:formatNumber value="${row.pay }" type="number" />원</div>
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</section>
<!-- Footer메뉴 -->
<%@ include file="../include/footer.jsp"%>
</body>
</html>
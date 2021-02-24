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
<script type="text/javascript">
$(function() {
	$('table').slice(0, 3).show();
	$('#load').click(function(e) {
		e.preventDefault();
		if($('table:hidden').length==0){
			alert("더이상 게시물이 없습니다.");
		}
		$('table:hidden').slice(0, 3).show();
	});
});
</script>
</head>

<body oncontextmenu='return false' onselectstart='return false' ondragstart='return false'>
<%@ include file="../include/top.jsp"%>
<section class="section-padding" style="background-color: #eee;">
	<div class="container reqDiv">
		<div class="section_title">
			<h1 class="mb-5"><strong>SITTER</strong> 시터리스트</h1>
		</div>
		<div class="RequestBoardList">
		<div id="back">
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
					<select id='sido' class="form-control" style="width:20%; display:inline-block;">
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
					<span id="catetd1" class="area2ck" > 
						<select id="gugun" class="form-control" style="width: 25%; position: unset; margin: 0;  display:inline-block;">
								<option value="">-구/군-</option>
						</select>
					</span>		
					<select name="" id="" class="form-control" style="width:20%; display:inline-block;">
						<option value="">최소 연령 선택</option>
					</select>
					<select name="" id="" class="form-control" style="width:20%; display:inline-block;">
						<option value="">최대 연령 선택</option>
					</select><br>
								
					<input type="number" name="pay" min="8720"
					class="form-control mt-2" style="width: 33%; height: 50px; font-size: 17px; display:inline-block;"
					placeholder="※시급 최대치, 비워둘 시 전체 검색"/>
					<input type="hidden" name="region" id="region"/>
					<p class="clear"></p>
				</div>
			</div>				
		</form>
		</div>
		<!-- 시터 리스트 -->
		<c:forEach items="${lists }" var="row">
			<table class="table table-borderless" style="display:none;" data-aos="fade-up" data-aos-delay="400">
					<colgroup>
						<col width="20%"/>
						<col width="*"/>
					</colgroup>
			<tbody>
				<tr>
					<td>
						<c:choose>
							<c:when test="${not empty row.image_path }">
								<img src="../resources/images/${row.image_path }"
								class="media-object rounded-circle" style="width:100px; height:100px;"/>
							</c:when>
							<c:otherwise>
								<img src="../resources/images/anonymous-avatar.jpg"
								class="media-object rounded-circle" style="width:100px; height:100px;"/>
							</c:otherwise>
						</c:choose>
					</td>
					<td rowspan="2" class="rightcontent">
						<a id="title" style="display:block; width:100%; height: 100%;"
						href="../advertisement/SitterBoard_view?id=${row.sitter_id }">								
							<span id="childInfo" class="float-left p-1">${row.age }세 | <c:set var="name" value="${row.name}" />
									<c:set var="totalLength" value="${fn:length(name) }" />
									<c:set var="first" value="${fn:substring(name, 0, 1) }" />
									<c:set var="last" value="${fn:substring(name, 2, totalLength) }" />
									<c:out value="${first}○${last}"/></span><br/>
							<span style="width: 85%" class="clear float-left">선호지역 : &#91;${row.residence1} ${row.residence2} ${row.residence3} &#93;
							<br />선호시간 : ${row.activity_date } ${row.activity_time } 
							</span>
							<span class="float-right" 
							style="width: 15%; font-size: 14px; text-align:right;">
							희망시급 : <fmt:formatNumber value="${row.pay }" type="number" />원
							<br />ID: ${row.sitter_id } 
							
							<br/><c:choose>
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
								</c:choose></span>
							<span class="clear"></span>
						</a>									
					</td>
					</tr>
				</tbody>
			</table>
			</c:forEach>
		<div class="text-center"><button class="btn btn-danger" id="load">더보기</button></div>
		</div>
	</div>
</section>
<!-- Footer메뉴 -->
<%@ include file="../include/footer.jsp"%>
</body>
</html>
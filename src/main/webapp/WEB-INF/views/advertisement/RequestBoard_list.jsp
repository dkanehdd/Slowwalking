<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- css, js 파일링크 등 묶음-->
<%@ include file="../links/linkOnly2dot.jsp"%>
<script src="../resources/js/reqBdJs.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style type="text/css">
.btnSch{
	width:10%;
	height: 50px;
	float:right;
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
<style type="text/css">
table{
	display: none;
}
</style>
<title>느린걸음</title>
</head> 

<body oncontextmenu='return false' onselectstart='return false' ondragstart='return false'>
<c:if test="${list_flag ne 'mylist' }">
	<%@ include file="../include/top.jsp"%>
</c:if>
<section class="section-padding" style="background-color: #eee;">
	<div class="container reqDiv">
		<!-- Side메뉴 -->
		<%@ include file="../include/side.jsp"%>
		<div class="section_title">
			<h1 class="mb-5"><strong>REQUEST</strong> 의뢰리스트</h1>
		</div>
		<div class="RequestBoardList">	
			<div id="back">
			<c:if test="${list_flag ne 'mylist' }">
				<div class="container-1" data-aos="fade-down" data-aos-delay="400">
					<form action="../advertisement/requestBoard_list?${_csrf.parameterName}=${_csrf.token}"
					method="post"
					class="form reqFrm" style="width:100%; margin-bottom: 20px;">
						
						<div class="clear mb-3" style="text-align:center;">
							<label class="box-radio-input"> <input 
								type="radio" id="short" name="regular_short" value="short"><span>단기</span>
							</label> <label class="box-radio-input"> <input  class="box-radio-input"
								type="radio" id="regular" name="regular_short" value="regular"><span>정기</span>
							</label> <label class="box-radio-input"> <input
								type="radio" id="regular" name="regular_short" value=" "
								checked><span>근무유형 무관</span>
							</label>						
						</div>
						<input type="text" class="form-control" id="search" name="title" 
						placeholder="※ 찾으시는 키워드를 검색해주세요. 아무것도 검색하지 않으시면 제목으로는 검색되지 않습니다." />
						<button type="submit" class="btn btn-danger btnSch">
							<i class="fa fa-search" aria-hidden="true"></i> 검색</button>
						<!-- 검색시 선택한 태그들 -->
						<input type="hidden" readonly class="tagInp" name="search" value="search">
						<input type="hidden" readonly class="tagInp" id="workday_name" name="request_time">
						<input type="hidden" readonly class="tagInp" id="consultation" name="consultation" value="협의 가능">
						<input type="hidden" readonly class="tagInp" name="region" id="region"/>
						<!-- 더보기 버튼 -->
						<p class="clear drop dropMore dropClose">상세옵션 <i class="fa fa-chevron-down" aria-hidden="true"></i></p>
						<!-- 더보기 버튼 눌렀을 시 열리는 메뉴 -->
						<div class="dropMenu">
						
<!-- 							<p style="color: ##">※가능한 시간을 체크해주세요 체크하지 않으면 모든 시간이 검색됩니다.</p> -->
							<div class="schArea">
								<p style="margin-bottom:0;"><small>※ 가능한 요일(다중 선택 가능)</small></p>
								<button type="button" class="workday_off mr1p"
									value="월">월</button>
								<button type="button" class="workday_off mr1p"
									value="화">화</button>
								<button type="button" class="workday_off mr1p"
									value="수">수</button>
								<button type="button" class="workday_off mr1p"
									value="목">목</button>
								<button type="button" class="workday_off mr1p"
									value="금">금</button>
								<button type="button" class="workday_off mr1p" value="토">토</button>
								<button type="button" class="workday_off" value="일">일</button>
							</div>							
							
<!-- 							<p style="color: #FFC079">※단기를 원하시는지 정기적으로 일하시기를 원하시는지 알려주세요.</p> -->
						
<!-- 							<p style="color: #FFC079">※원하시는 지역을 선택해주세요. 선택하지 않으시면 전체 지역으로 검색됩니다.</p> -->
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
								
								<select class="form-control float-left" id="age" name="age" style="width: 33%;"> 
									<option>선호 연령대(무관)</option>
									<option>0</option>
									<option>1</option>
									<option>2</option>
									<option>3</option>
									<option>4</option>
									<option>5</option>
									<option>6</option>
									<option>7</option>
									<option>8</option>
									<option>9</option>
									<option>10</option>
									<option>11</option>
									<option>12</option>
									<option>13</option>
									<option>14</option>
									<option>15</option>
									<option>16</option>
									<option>17</option>
									<option>18</option>
									<option>19</option>
	<!-- 							  <option>연령대 무관</option> -->
	<!-- 						      <option>0~3(영아)</option> -->
	<!-- 						      <option>4~7(유아)</option> -->
	<!-- 						      <option>8~10(초등 저학년)</option> -->
	<!-- 						      <option>11~13(초등 고학년)</option> -->
	<!-- 						      <option>14~16(중등)</option> -->
	<!-- 						      <option>17~19(고등)</option>    -->
							    </select>
							    <p class="clear"></p>
							</div><!-- 폼이 들어가는 div(jquery로 숨길) container-1-->						
						</div>										
					</form><!-- 폼 -->					
				</div>					
			</c:if>				
				<!-- 의뢰서 리스트 -->
				<c:forEach items="${lists }" var="row">
					<table class="table table-borderless" style="display:none;" 
					 data-aos="fade-up" data-aos-delay="400">
						<colgroup>
							<col width="20%"/>
							<col width="*"/>
						</colgroup>
						<tbody>
							<tr>
								<td>
									<img src="../resources/images/${row.image }" class="media-object rounded-circle" style="width:100px; height:100px;">
								</td>
								<td rowspan="2" class="rightcontent">
									<a id="title" style="display:block; width:100%; height: 100%;"
									href="../advertisement/requestBoard_view?list_flag=${listflag }&idx=${row.idx}">								
										<span id="childInfo" class="float-left">${row.age}세 ∥ ${row.children_name }</span><br/>
										<span style="width: 85%" class="clear float-left">&#91;${row.region }&#93; ${row.title }
											<c:if test="${not empty row.warning }">
												<span id="warning" style="vertical-align:middle;">※ 주의사항 참고</span>
											</c:if>
										</span>
										<span class="float-right" 
										style="width: 15%; font-size: 14px; text-align:right;">
										희망시급 : ${row.pay }
										<br />ID: ${row.id }</span>
										<span class="clear"></span>
									</a>									
								</td>
							</tr>
						</tbody>
					</table>
				</c:forEach><!-- table(결과) -->
          <br/>
				<div class="text-center"><button class="btn btn-info">더보기</button></div>
			</div><!-- #back -->
		</div><!-- RequestBoardList -->
	</div><!-- reqDiv -->
</section>
<c:if test="${list_flag ne 'mylist' }">
	<!-- Footer메뉴 -->
	<%@ include file="../include/footer.jsp"%>
</c:if>
<script type="text/javascript">
$(function() {
	$('table').slice(0, 3).show();
	$('#load').click(function(e) {
		e.preventDefault();
		if($('table:none').length==0){
			alert("더이상 게시물이 없습니다.");
		}
		$('table:hidden').slice(0, 3).show();
	});
});
</script>
</body>
</html>

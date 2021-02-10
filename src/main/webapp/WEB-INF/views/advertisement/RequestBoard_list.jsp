<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- css, js 파일링크 등 묶음-->
<%@ include file="../links/linkOnly2dot.jsp"%>
<script src="../resources/js/reqBdJs.js"></script>
<title>느린걸음</title>
</head> 

<body>
<c:if test="${list_flag ne 'mylist' }">
	<%@ include file="../include/top.jsp"%>
</c:if>
<section class="section-padding" style="background-color: #eee;">
	<div class="container">
		<div class="section_title">
			<h1 class="mb-5"><strong>REQUEST</strong> 의뢰리스트</h1>
		</div>
		<div class="RequestBoardList">	
			<div id="back" >
			<c:if test="${list_flag ne 'mylist' }">
				<div class="container-1" data-aos="fade-up" data-aos-delay="400">
				<form action="../advertisement/requestBoard_list?${_csrf.parameterName}=${_csrf.token}"
				method="post" 
				class="form" style="width:100%;">
					<input type="hid den" name="search" value="search">
					<p style="color: #FFC079">※가능한 시간을 체크해주세요 체크하지 않으면 모든 시간이 검색됩니다.</p>
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
					<br/>
					<input type="hid den" id="workday_name" name="request_time">
					<input type="hid den" id="consultation" name="consultation" value="협의 가능">
					<br/><p style="color: #FFC079">※단기를 원하시는지 정기적으로 일하시기를 원하시는지 알려주세요.</p>
					<label class="box-radio-input"> <input
						type="radio" id="short"
						name="regular_short" value="short" ><span>단기</span>
					</label>
					<label class="box-radio-input"> <input
						type="radio" id="regular"
						name="regular_short" value="regular"><span>정기</span>
					</label>
					<label class="box-radio-input"> <input
						type="radio" id="regular"
						name="regular_short" value=" " checked><span>상관없음</span>
					</label>
					<br/>
					<br/>
					<p style="color: #FFC079">※찾으시는 제목을 검색해주세요. 아무것도 검색하지 않으시면 제목으로는 검색되지 않습니다.</p>
					<input type="text" class="form-control" id="search" name="title" placeholder="제목으로 검색합니다." />
					<br/>
					<p style="color: #FFC079">※원하시는 지역을 선택해주세요. 선택하지 않으시면 전체 지역으로 검색됩니다.</p>
					<select id='sido' class="form-control">
						<option value="">시/도 선택</option>
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
					</select> <span id="catetd1" class="area2ck"
						style="width: 30%; position: unset; margin: 0"> 
					<br/>	
					<select id="gugun" class="form-control">
							<option value="">-구/군-</option>
					</select></span><input type="hid`den" name="region"
						id="region" />
					<p style="color: #FFC079">※원하시는 아이의 연령을 선택해주세요. 선택하지않으시면 전체 연령으로 검색됩니다.</p>
					<select class="form-control" id="age" name="age">
					  <option>상관없음</option>
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
				    </select>
					<br/><br/>
					<button type="submit" class="btn btn-info btn-sm">검색</button>
			
					</form>
				</div>
				</c:if>
				<br/><br/>
				<!-- 의뢰서 리스트 -->
				<c:forEach items="${lists }" var="row">
				<table class="table table-borderless">
					<colgroup>
						<col width="20%"/>
						<col width="*"/>
					</colgroup>
					<tbody>
						<tr>
							<td>
								<img src="../resources/images/${row.image }" class="media-object rounded-circle" style="width:100px; height:100px;">
							</td>
							<td rowspan="2" class="rightcontent" style="vertical-align:middle;">
								<a id="title" href="../advertisement/requestBoard_view?list_flag=${listflag }&idx=${row.idx}">${row.title }</a>
								<br/>${row.id }
								<br/>${row.region }
								<br/>희망시급 : ${row.pay }
							</td>
						</tr>
						<tr>
							<td>	
								<span id="childInfo">${row.age}세 ∥ ${row.children_name }</span><br/>
									<c:if test="${not empty row.warning }">
										<span id="warning">※ 주의사항 참고</span>
									</c:if>
							</td>
						</tr>
					</tbody>
					</table>
				</c:forEach>
				<br/>
				</div>
		</div>
	</div>
</section>
<c:if test="${list_flag ne 'mylist' }">
	<!-- Footer메뉴 -->
	<%@ include file="../include/footer.jsp"%>
</c:if>
<script type="text/javascript">
$(function() {
	$('table').slice(0, 2).show();
	$('#load').click(function(e) {
		e.preventDefault();
		if($('table:hidden').length==0){
			alert("더이상 게시물이 없습니다.");
		}
		$('table:hidden').slice(0, 2).show();
	});
});
</script>
</body>
</html>


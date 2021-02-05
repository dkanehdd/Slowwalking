<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- css, js 파일링크 등 묶음-->
<%@ include file="../links/linkOnly2dot.jsp"%>

<title>느린걸음</title>

</head> 
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<body>
<c:if test="${list_flag ne 'mylist' }">
	<%@ include file="../include/top.jsp"%>
</c:if>

<script type="text/javascript">
	function deleteRow(idx) {
		if(confirm('삭제하시겠습니까?')){
			location.href='requestBoardAction_delete?idx='+idx;
		}
	}
</script>
<div class="container">
<div class="RequestBoardList" data-aos="fade-up" data-aos-delay="400">	
<div id="back" >
<c:if test="${list_flag ne 'mylist' }">
	<div class="container-1">
	<form action="../advertisement/requestBoard_list?${_csrf.parameterName}=${_csrf.token}"
	method="post">
		<input type="hid den" name="search" value="search">
		<p style="color: #FFC079">※가능한 시간을 체크해주세요 체크하지 않으면 모든 시간이 검색됩니다1111.</p>
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
		<br/><p style="color: #FFC079">※단기를 원하시는지 정기적으로 일하시기를 원하시는지 알려주세요.</p>
		<label class="box-radio-input"> <input
			type="radio" id="short"
			name="regular_short" value="short" checked><span>단기</span>
		</label>
		<label class="box-radio-input"> <input
			type="radio" id="regular"
			name="regular_short" value="regular"><span>정기적</span>
		</label>
		<label class="box-radio-input"> <input
			type="radio" id="regular"
			name="regular_short" value=" "><span>상관없음</span>
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
	      <option>17</option>
	      <option>18</option>
	      <option>19</option>
	      <option>20</option>
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
		<thead>
	      <tr>
			<a href="../advertisement/requestBoard_view?list_flag=${listflag }&idx=${row.idx}">${row.title }</h2></a>
		  </tr>
		</thead>
		<tbody>
			<tr>
			<img src="../resources/images/${row.image }" style="width:100px; height:100px">
			</tr>
			<tr>
				<td>
				<span style="font-size: 20px;">${row.age}살의${row.children_name }입니다</span>
				</td>
				<td>
				<span style="font-size: 20px; color: red;">${row.warning}</span>
				</td>
			</tr>
		</tbody>
		</table>
		<br/><br/><br/>
		
	</c:forEach>
	</div>
	
</div>
	
</div>
<c:if test="${list_flag ne 'mylist' }">
	<!-- Footer메뉴 -->
	<%@ include file="../include/footer.jsp"%>
</c:if>

<style>
div#back{
	width: 1000px;
	text-align: center;
}
div#search{
	background-color: white;
	width: 80%;
	margin: 50px auto 0;
	text-align: center;
}
.container-1 .icon{
  position: absolute;
  top: 55%;
  margin-left: 13px;
  margin-top: 18px;
  z-index: 1;
  color: #4f5b66;
}

.workday_off {
	border: 1px solid #e0e0e0;
	background: #fff;
	margin-top: 7px;
	width: calc(58%/ 7);
	color: #595757;
	padding: 6px 0;
	text-align: center;
	font-family: Noto Sans KR, sans-serif !important;
	font-size: 15px;
	font-weight: 400;
}

.workday_on {
	background: #FFC079;
}

.box-radio-input input[type="radio"]{
  display:none;
  padding: 50px;
  text-align: center;
}

.box-radio-input input[type="radio"] + span{
	border: 1px solid #e0e0e0;
	background: #fff;
	width: calc(58%/ 2);
	color: #595757;
	padding: 10px;
	text-align: center;
	font-family: Noto Sans KR, sans-serif !important;
	font-size: 15px;
	font-weight: 400;
  
}

.box-radio-input input[type="radio"]:checked + span{
  background: #FFC079;
}
</style>
<script>
$(function () {
	$('#sido').change(function() {
		$.ajax({
			url : "../zipcode/gugun",
			type : 'get',
			contentType : "text/html;charset:utf-8",
			data : {
				sido : $('#sido option:selected').val()
			},
			dataType : "json",
			success : function(d) {
				var optionStr = "";
				optionStr += "<option value=''>";
				optionStr += "-구/군-";
				optionStr += "</option>";
				//$.each()통해 반복되는 요소의 인덱스와 요소값을 매개변수로 받을수있다.
				$.each(d, function(index, data) {
					optionStr += '<option value="'+data+'">';
					optionStr += data;
					optionStr += '</option>';
				});
				$('#gugun').html(optionStr);
			},
			error : function(e) {
				alert("오류발생 : " + e.status + " : " + e.statue.Text);
			}
		});
		$('#gugun').change(
				function() {
					$('#region').val(
							$("#sido option:selected").val() + " "
									+ $("#gugun option:selected").val());
				})
		
	});
})
$(function() {
	$(".workday_off").click(function() {
		if ($(this).hasClass("workday_on") == false) {
			$(this).addClass("workday_on");
		} else {
			$(this).removeClass("workday_on");
		}
		workday_make()
	});
});
function workday_make() {
	var i = 0;
	var workday_tyle = "";
	$(".workday_off").each(function() {
		if ($(this).hasClass("workday_on") == true) {
			workdaytype = $(this).val();
			if (i != 0)
				workday_tyle += ",";
			workday_tyle += workdaytype;
			i++;
		}
	});
	workday_tyle += ",~,협의 가능"
	if (i == 0) {
		$("#workday_name").val("");
	} else {
		$("#workday_name").val(workday_tyle);
	}
}
</script>
<!-- 스크립트 -->
<script src="../resources/js/jquery.min.js"></script>
<script src="../resources/js/bootstrap.min.js"></script>
<script src="../resources/js/aos.js"></script>
<script src="../resources/js/owl.carousel.min.js"></script>
<script src="../resources/js/smoothscroll.js"></script>
<script src="../resources/js/custom.js"></script>
</body>
</html>

<!-- 작성자 본인에게만 수정/삭제 버튼 보임처리 
	<c:if test="${sessionScope.siteUserInfo.id eq row.id }">
		<button class="btn btn-primary" 
		onclick="location.href='advertisement/requestBoard_edit'">
		수정</button>
		<button class="btn btn-danger" 
		onclick="javascript:deleteRow();">
		삭제</button>
	 </c:if> -->
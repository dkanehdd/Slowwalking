<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html>
<head>
<!-- css, js 파일링크 등 묶음-->
<%@ include file="../links/linkOnly2dot.jsp"%>
<title>느린걸음</title>
<style type="text/css">
span.star-prototype, span.star-prototype > * {
    height: 16px; 
    background: url(http://i.imgur.com/YsyS5y8.png) 0 -16px repeat-x;
    width: 80px;
    display: inline-block;
}
 
span.star-prototype > * {
    background-position: 0 0;
    max-width:80px; 
}
</style>
</head>
<body>
	<%@ include file="../include/top.jsp"%>

	<div class="container">
		<div class="text-center">
		<br/><br/><br/>
			<form action="../advertisement/SitterBoard_list?${_csrf.parameterName}=${_csrf.token}"
				method="post">
				<input type="hid den" name="search" value="search">
				<p style="color: #FFC079">※가능한 시간을 체크해주세요 체크하지 않으면 모든 시간이 검색됩니다</p>
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
				<button type="button" class="workday_off" id="consultation" value="협의가능">협의가능</button>
				<br/>
				<input type="hid den" id="workday_name" name="request_time">
				<br/><br/>
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
					<br/><br/>	
					<p style="color: #FFC079">※최대 시급을 작성해 주세요 희망시급으로 검색됩니다. 작성하지 않으시면 전체 시급으로 검색됩니다.</p>
					<input type="number" name="pay" class="form-control" />
					<br/><br/>
					<button type="submit" class="btn btn-info btn-sm">검색</button>
			
		</form>
		</div>
		<c:forEach items="${lists }" var="row">
			<div class="border mt-2 mb-2">
				<div class="media">
					<div class="media-left mr-3">
						<img src="../resources/images/${row.image_path }"
							class="media-object" style="width: 100px; height: 100px; border-radius: 70%">
					</div>
					<div class="media-body">
						<div class="profileInfo">
							<div class="contentRow"
								style="justify-content: space-between; margin-bottom: -2px;">
								<div class="contentRow">
									<a href="../advertisement/SitterBoard_view?id=${row.sitter_id }">
									<c:set var="name" value="${row.name}" />
									<c:set var="totalLength" value="${fn:length(name) }" />
									<c:set var="first" value="${fn:substring(name, 0, 1) }" />
									<c:set var="last" value="${fn:substring(name, 2, totalLength) }" />
									<c:out value="${first}○${last}"/></a>
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
							<div class="contentRow" style="height: 23px;">
								<div class="ReviewRate__Wrapper-sc-1mriui7-0 bEuJEW">
									평점 : <span class="star-prototype">${row.starrate }</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
<script type="text/javascript">
	$.fn.generateStars = function() {
    return this.each(function(i,e){$(e).html($('<span/>').width($(e).text()*16));});
	};

// 숫자 평점을 별로 변환하도록 호출하는 함수
$('.star-prototype').generateStars();
</script>


	</div>
	<!-- Footer메뉴 -->
	<%@ include file="../include/footer.jsp"%>
</body>
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
			if($('#consultation').hasClass("workday_on") == true){
				//협의 가능이 눌러져있으면 아무것도 눌리지 않는다.
			}else{
				$(this).addClass("workday_on");
			}
		} else {
			$(this).removeClass("workday_on");
		}
		workday_make()
	});
	
	$('#consultation').click(
		function() {
			if ($(this).hasClass("workday_on") == true) {
				$("#workday_name").val('협의가능');
				$('.workday_off').removeClass("workday_on");
				$(this).addClass("workday_on");
				
			} else {
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
				if (i == 0) {
					$("#workday_name").val("");
				} else {
					$("#workday_name").val(workday_tyle);
				}
			}
		})
	
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
	if (i == 0) {
		$("#workday_name").val("");
	} else {
		$("#workday_name").val(workday_tyle);
	}
}
</script>
<style>
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
</style>
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
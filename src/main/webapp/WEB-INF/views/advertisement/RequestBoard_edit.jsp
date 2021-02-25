<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<!-- css, js 파일링크 등 묶음-->
<%@ include file="../links/linkOnly2dot.jsp"%>
<meta charset="UTF-8">
<title>느린걸음</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style type="text/css">
#free_open {
	display: none;
	text-align: center;
	border: 3px solid #fae100;
	background: #fff;
	font-family: Noto Sans KR, sans-serif !important;
	font-size: 15.5px;
	font-weight: 400;
	padding: 10px;
	line-height: 1.4;
	margin-top: 10px;
	width: 57%
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
	background: #fae100
}

.box-radio-input input[type="radio"]{
  display:none;
  padding: 10px;
  text-align: center;
}

.box-radio-input input[type="radio"] + span{
	border: 1px solid #e0e0e0;
	background: #fff;
	width: calc(58%/ 7);
	color: #595757;
	padding: 10px;
	text-align: center;
	font-family: Noto Sans KR, sans-serif !important;
	font-size: 15px;
	font-weight: 400;
  
}

.box-radio-input input[type="radio"]:checked + span{
  background: #fae100;
}
</style>
</head>
<script type="text/javascript">
function checkform() {
	var title = document.getElementsByName("title")[0];
	var children_name = document.getElementsByName("children_name")[0];
	var age = document.getElementsByName("age")[0];
	var pay = document.getElementsByName("pay")[0];
	var start_work = document.getElementsByName("start_work")[0];
	var region = document.getElementsByName("region")[0];
	console.log(region.value);
	 
	var result = true;
	
	if(title.value == ""){
		alert("제목을 입력해주세요");
		document.getElementsByName("title")[0].focus();
		result = false;
	}else if(children_name.value == ""){
		alert("아이의 이름을 입력해주세요");
		document.getElementsByName("children_name")[0].focus();
		result = false;
	}else if(age.value == ""){
		alert("아이의 나이를 입력해주세요");
		document.getElementsByName("age")[0].focus();
		result = false;
	}else if(pay.value == ""){
		alert("시터의 시급을 입력해주세요");
		document.getElementsByName("pay")[0].focus();
		result = false;
	}else if(region.value == ""){
		alert("지역을 알려주세요");
		document.getElementsByName("region")[0].focus();
		result = false;
	}else if(start_work.value == ""){
		alert("시터의 일 시작일을 작성해주세요");
		document.getElementsByName("start_work")[0].focus();
		result = false;
	}else if(content.value == ""){
		alert("일할 내용을 구체적으로 작성해주세요");
		document.getElementsByName("content")[0].focus();
		result = false;
	}
	
	return result;
}
</script>
<%@ include file="../include/top.jsp"%>
<body>
	<section class="section-padding" style="background-color: eee;">
		<div class="container">
			<div class="section_title">
				<h1 class="mb-5"><strong>Request Edit</strong> 구인의뢰 수정</h1>
			</div>
			<div class="RequestBoardList" data-aos="fade-up" data-aos-delay="400">
				<div class="text-center">					
					<form
						action="requestBoardAction_edit?${_csrf.parameterName}=${_csrf.token}"
						method="post" name="requestBoard" enctype="multipart/form-data"
						onsubmit="return checkform();">
						
						<input type="hidden" name="id" value="${user_id }" />
						<input type="hidden" name="idx" value="${dto.idx }">
						<input type="hidden" name="list_flag" value="${list_flag }">
						<table class="table form joinF">
							<colgroup>
								<col width="30%" />
								<col width="*" />
							</colgroup>
							<tbody>
								<tr>
									<th>의뢰서 보이기</th>
									<td><div class="custom-control custom-switch text-left">
										<input type="checkbox" class="custom-control-input mb-2" id="switch1"
											name="advertise" checked="${dto.advertise eq 'on' ? 'checked' : ''}"> <label class="custom-control-label"
											for="switch1"></label></div>
									</td>
								</tr>
								<tr>
									<th style="vertical-align: middle;">신청서 제목</th>
									<td><input type="text" class="form-control"
										style="width: 400px;" name="title" value="${dto.title }"/></td>
								</tr>
								<tr>
									<th style="vertical-align: middle;">아이의 이름</th>
									<td><input type="text" class="form-control"
										style="width: 400px;" name="children_name" value="${dto.children_name }"/></td>
								</tr>
								<tr>
									<th style="vertical-align: middle;">아이의 사진</th>
									<td>
									<c:choose>
										<c:when test="${not empty dto.image }">
											현재 사진이 있습니다 바꾸시려면 파일선택을 누르세요
										</c:when>
										<c:otherwise>
											사진이 아직 없습니다
										</c:otherwise>
									</c:choose>
									<input type="file" 
										style="width: 400px;" name="image"/></td>
								</tr>
								<tr>
									<th style="vertical-align: middle;">아이의 현재연령</th>
									<td><select class="form-control" id="age" name="age">
									     <option>선호 연령대(무관)</option>
							    		<option>0~3(영아)</option>
	 						      		<option>4~7(유아)</option> 
	 						      		<option>8~10(초등 저학년)</option> 
	 						      		<option>11~13(초등 고학년)</option> 
							      		<option>14~16(중등)</option> 
							      		<option>17~19(고등)</option>
								    </select>
								    </td>
								</tr>
								<tr>
									<th style="vertical-align: middle;">시터의 시급<br/>
										<small>※2021년 기준 최저시급 : 8,720원</small>
									</th>
									<td><input type="text" class="form-control"
										style="width: 400px;" name="pay" value="${dto.pay }"/></td>
								</tr>
								<tr>
									<th style="vertical-align: middle;">지역</th>
									<td><div id="area_box"  style="clear: both;">
										<select id='sido' class="pass form-control" style="width: 30%; display: inline-block;">
											<option value="">시/도 선택</option>
											<option value="서울" ${region_first eq '서울' ? 'selected="selected"' : ''}>서울</option>
											<option value="강원" ${region_first eq '강원' ? 'selected="selected"' : ''}>강원</option>
											<option value="경기" ${region_first eq '경기' ? 'selected="selected"' : ''}>경기</option>
											<option value="경남" ${region_first eq '경남' ? 'selected="selected"' : ''}>경남</option>
											<option value="경북" ${region_first eq '경북' ? 'selected="selected"' : ''}>경북</option>
											<option value="광주" ${region_first eq '광주' ? 'selected="selected"' : ''}>광주</option>
											<option value="대구" ${region_first eq '대구' ? 'selected="selected"' : ''}>대구</option>
											<option value="대전" ${region_first eq '대전' ? 'selected="selected"' : ''}>대전</option>
											<option value="부산" ${region_first eq '부산' ? 'selected="selected"' : ''}>부산</option>
											<option value="울산" ${region_first eq '울산' ? 'selected="selected"' : ''}>울산</option>
											<option value="인천" ${region_first eq '인천' ? 'selected="selected"' : ''}>인천</option>
											<option value="전남" ${region_first eq '전남' ? 'selected="selected"' : ''}>전남</option>
											<option value="전북" ${region_first eq '전북' ? 'selected="selected"' : ''}>전북</option>
											<option value="제주" ${region_first eq '제주' ? 'selected="selected"' : ''}>제주</option>
											<option value="충남" ${region_first eq '충남' ? 'selected="selected"' : ''}>충남</option>
											<option value="충북" ${region_first eq '충북' ? 'selected="selected"' : ''}>충북</option>
										</select> <span id="catetd1" class="area2ck"
											style="width: 30%; position: unset; margin: 0"> 
										<select id="gugun"  class="pass form-control" style="width: 30%; display: inline-block;">
												<option value="">-구/군-</option>
										</select></span><input type="hidden" name="region"
											id="region" />
									</div>
								</tr>
								<tr>
									<th style="vertical-align: middle;">근무시간</th>
									<td>
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
										<button type="button" ${fn:contains(timeArray, '협의가능') ? 'class="workday_off workday_on mr1p"' : 'class="workday_off mr1p"'}
											value="협의가능">협의 가능</button> 
												<input type="hid den" id="workday_name" name="request_time"
										value=""> <br /> 
										<select name='starttime' class="pass form-control"
										id='starttime1' style="width: 24%; margin-top: 10px; display:inline;">
											<optgroup label="오전">
												<option value="" ${time_first eq ' 협의 가능' ? 'selected="selected"' : ''}>시간선택</option>
												<option value="06:00" ${time_first eq '06:00' ? 'selected="selected"' : ''}>오전 6:00</option>
												<option value="07:00" ${time_first eq '07:00' ? 'selected="selected"' : ''}>오전 7:00</option>
												<option value="08:00" ${time_first eq '08:00' ? 'selected="selected"' : ''}>오전 8:00</option>
												<option value="09:00" ${time_first eq '09:00' ? 'selected="selected"' : ''}>오전 9:00</option>
												<option value="10:00" ${time_first eq '10:00' ? 'selected="selected"' : ''}>오전 10:00</option>
												<option value="11:00" ${time_first eq '11:00' ? 'selected="selected"' : ''}>오전 11:00</option>
											</optgroup>
											<optgroup label="오후">
												<option value="12:00" ${time_first eq '12:00' ? 'selected="selected"' : ''}>정오 12:00</option>
												<option value="13:00" ${time_first eq '13:00' ? 'selected="selected"' : ''}>오후 1:00</option>
												<option value="14:00" ${time_first eq '14:00' ? 'selected="selected"' : ''}>오후 2:00</option>
												<option value="15:00" ${time_first eq '15:00' ? 'selected="selected"' : ''}>오후 3:00</option>
												<option value="16:00" ${time_first eq '16:00' ? 'selected="selected"' : ''}>오후 4:00</option>
												<option value="17:00" ${time_first eq '17:00' ? 'selected="selected"' : ''}>오후 5:00</option>
												<option value="18:00" ${time_first eq '18:00' ? 'selected="selected"' : ''}>오후 6:00</option>
												<option value="19:00" ${time_first eq '19:00' ? 'selected="selected"' : ''}>오후 7:00</option>
												<option value="20:00" ${time_first eq '20:00' ? 'selected="selected"' : ''}>오후 8:00</option>
												<option value="21:00" ${time_first eq '21:00' ? 'selected="selected"' : ''}>오후 9:00</option>
												<option value="22:00" ${time_first eq '22:00' ? 'selected="selected"' : ''}>오후 10:00</option>
												<option value="23:00" ${time_first eq '23:00' ? 'selected="selected"' : ''}>오후 11:00</option>
												<option value="00:00" ${time_first eq '00:00' ? 'selected="selected"' : ''}>자정 12:00</option>
											</optgroup>
										</select> <span style="padding: 0 7px; position: relative;">~</span> 
										<select  class="pass form-control"
										id="endtime1" style="width: 24%; margin-top: 10px; display:inline;">
											<optgroup label="오전">
												<option value="" ${time_second eq '' ? 'selected="selected"' : ''}>시간선택</option>
												<option value="06:00" ${time_second eq '06:00' ? 'selected="selected"' : ''}>오전 6:00</option>
												<option value="07:00" ${time_second eq '07:00' ? 'selected="selected"' : ''}>오전 7:00</option>
												<option value="08:00" ${time_second eq '08:00' ? 'selected="selected"' : ''}>오전 8:00</option>
												<option value="09:00" ${time_second eq '09:00' ? 'selected="selected"' : ''}>오전 9:00</option>
												<option value="10:00" ${time_second eq '10:00' ? 'selected="selected"' : ''}>오전 10:00</option>
												<option value="11:00" ${time_second eq '11:00' ? 'selected="selected"' : ''}>오전 11:00</option>
											</optgroup>
											<optgroup label="오후">
												<option value="12:00" ${time_second eq '12:00' ? 'selected="selected"' : ''}>정오 12:00</option>
												<option value="13:00" ${time_second eq '13:00' ? 'selected="selected"' : ''}>오후 1:00</option>
												<option value="14:00" ${time_second eq '14:00' ? 'selected="selected"' : ''}>오후 2:00</option>
												<option value="15:00" ${time_second eq '15:00' ? 'selected="selected"' : ''}>오후 3:00</option>
												<option value="16:00" ${time_second eq '16:00' ? 'selected="selected"' : ''}>오후 4:00</option>
												<option value="17:00" ${time_second eq '17:00' ? 'selected="selected"' : ''}>오후 5:00</option>
												<option value="18:00" ${time_second eq '18:00' ? 'selected="selected"' : ''}>오후 6:00</option>
												<option value="19:00" ${time_second eq '19:00' ? 'selected="selected"' : ''}>오후 7:00</option>
												<option value="20:00" ${time_second eq '20:00' ? 'selected="selected"' : ''}>오후 8:00</option>
												<option value="21:00" ${time_second eq '21:00' ? 'selected="selected"' : ''}>오후 9:00</option>
												<option value="22:00" ${time_second eq '22:00' ? 'selected="selected"' : ''}>오후 10:00</option>
												<option value="23:00" ${time_second eq '23:00' ? 'selected="selected"' : ''}>오후 11:00</option>
												<option value="00:00" ${time_second eq '00:00' ? 'selected="selected"' : ''}>자정 12:00</option>
											</optgroup>
									</select> <br />
									</td>
								</tr>
								<tr>
									<th style="vertical-align: middle;">아이의 장애등급</th>
									<td>
										<!-- 중복선택 아닌 경우 radio로 할게요! -->
										<label><input
											type="radio" id="serious"
											name="disability_grade" value="serious" ${dto.disability_grade eq "serious" ? "checked" : ""}><span> 중증</span>
										</label>
										
										<label><input 
											type="radio"  id="slight"
											name="disability_grade" value="slight" ${dto.disability_grade eq "slight" ? "checked" : ""}><span> 경증</span>
										</label>
		
									</td>
								</tr>
								<tr>
									<th style="vertical-align: middle;">주의사항
									<br><small>※없을 경우 공란</small></th>
									<td><input type="text" class="form-control"
										style="width: 400px;" name="warning" value="${dto.warning }" /></td> 
								</tr>
								<tr>
									<th style="vertical-align: middle;">고용 형태</th>
									<td>
										<label ><input
											type="radio" id="short"
											name="regular_short" value="short" ${dto.regular_short eq "short" ? "checked" : ""}><span> 단기</span>
										</label>

										<label><input
											type="radio" id="regular"
											name="regular_short" value="regular" ${dto.regular_short eq "regular" ? "checked" : ""}><span> 정기적</span>
										</label>
									</td>
								</tr>
								<tr>
									<th style="vertical-align: middle;">시작일자</th>
									<td>
										<select class="mr-2" id="select_year" onchange="javascript:lastday();"></select> 
										<select class="mr-2" id="select_month" onchange="javascript:lastday();"></select> 
										<select id="select_day"></select>
										<input type="hidden" id="start_work" name="start_work"/>
									</td>
								</tr>
								<tr>
									<th style="vertical-align: middle;">근무 상세</th> 
									<td>
										<div class="form-group">
											<textarea  class="contents noresize" rows="5" id="content"
												name="content">${dto.content }</textarea>
										</div> 
									</td>
								</tr>
							</tbody>
						</table>
						<button type="submit" class="btn btn-primary">의뢰 수정하기</button>

					</form>
				</div>
			</div>
		</div>
	</section>

<script>
$(function () {
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
	workday_make()
	$(".workday_off").click(function() {
		if ($(this).hasClass("workday_on") == false) {
			$(this).addClass("workday_on");
		} else {
			$(this).removeClass("workday_on");
		}
		workday_make()
	});
	$('#starttime1').change(
			function() {
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
				workday_tyle += ","
						+ $("#starttime1 option:selected").val() + "~"
						+ $("#endtime1 option:selected").val();
				if ($("#time_type").is(":checked")) {
					workday_tyle +=
						",협의 가능";
				}
				if (i == 0) {
					$("#workday_name").val("");
				} else {
					$("#workday_name").val(workday_tyle);
				}
			});
	$('#endtime1').change(
			function() {
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
				workday_tyle += ","
						+ $("#starttime1 option:selected").val() + "~"
						+ $("#endtime1 option:selected").val();
				if ($("#time_type").is(":checked")) {
					workday_tyle +=
						",협의 가능";
				}
				if (i == 0) {
					$("#workday_name").val("");
				} else {
					$("#workday_name").val(workday_tyle);
				}
			});
	$('#time_type').change(
		function name() {
			if ($("#time_type").is(":checked")) {
				//$("#workday_name").val('협의가능');
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
				workday_tyle += ","
						+ $("#starttime1 option:selected").val()
						+ "~"
						+ $("#endtime1 option:selected").val()
						+ ",협의 가능";
				if (i == 0) {
					$("#workday_name").val("");
				} else {
					$("#workday_name").val(workday_tyle);
				}
			} 
		})
		
	$('#select_year').change(
		function() {
			var start_work =
				+ $("#select_year").val()
				+ "/"
				+ $("#select_month").val()
				+ "/"
				+ $("#select_day").val();
			$("#start_work").val(start_work);
		});
	$('#select_month').change(
		function() {
			var start_work =
				+ $("#select_year").val()
				+ "/"
				+ $("#select_month").val()
				+ "/"
				+ $("#select_day").val();
			$("#start_work").val(start_work);
		});
	$('#select_day').change(
		function() {
			var start_work =
				+ $("#select_year").val()
				+ "/"
				+ $("#select_month").val()
				+ "/"
				+ $("#select_day").val();
			$("#start_work").val(start_work);
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
	workday_tyle += "," + $("#starttime1 option:selected").val() + "~"
			+ $("#endtime1 option:selected").val();
	if ($("#time_type").is(":checked")) {
		workday_tyle +=
			",협의 가능";
	}
	if (i == 0) {
		$("#workday_name").val("");
	} else {
		$("#workday_name").val(workday_tyle);
	}
}
	<!-- 선택한 년과 월에 따라 마지막 일 구하기 --> 
 
	var start_year="2021";// 시작할 년도 
	var today = new Date(); 
	var index=0; 
	for(var y=start_year; y<="2030"; y++){ 
		//start_year ~ 현재 년도 
		document.getElementById('select_year').options[index] = new Option(y, y); 
		index++; 
	} 
	
	index=0; 
	for(var m=1; m<=12; m++){ 
		document.getElementById('select_month').options[index] = new Option(m, m); 
		index++; 
	} 
	
	lastday(); 
	function lastday(){ 
		//년과 월에 따라 마지막 일 구하기 
		var Year=document.getElementById('select_year').value; 
		var Month=document.getElementById('select_month').value; 
		var day=new Date(new Date(Year,Month,1)-86400000).getDate(); 
		var dayindex_len=document.getElementById('select_day').length; 
		
		if(day>dayindex_len){ 
			for(var i=(dayindex_len+1); i<=day; i++){ 
				document.getElementById('select_day').options[i-1] = new Option(i, i); 
			} 
		} else if(day<dayindex_len){ 
			for(var i=dayindex_len; i>=day; i--){ 
				document.getElementById('select_day').options[i]=null; 
			} 
		}
	} 
	
</script>

<!-- Footer메뉴 -->
<%@ include file="../include/footer.jsp"%>
<!-- 스크립트 -->
<script src="../resources/js/jquery.min.js"></script>
<script src="../resources/js/bootstrap.min.js"></script>
<script src="../resources/js/aos.js"></script>
<script src="../resources/js/owl.carousel.min.js"></script>
<script src="../resources/js/smoothscroll.js"></script>
<script src="../resources/js/custom.js"></script>
</body>
</html>
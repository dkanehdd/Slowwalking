<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<div class="container">
		<h2>시터회원 추가정보 입력</h2>
		<form:form method="post" name="payappform" id="payappform"
			action="../member/sitterjoinaction?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data">
			<input type="hid`den" value="${id }" name="sitter_id" />
			<table>
				<colgroup>
					<col style="width: 150px">
					<col>
				</colgroup>
				<tr>
					<th scope="row">장애영유아보육교사 자격증(필수)</th>
					<td><input type="file" name='license_check' /></td>
				</tr>
				<tr>
					<th scope="row">인성검사확인</th>
					<td><input type="file" name='personality_check' /></td>
				</tr>
				<tr>
					<th scope="row">활동가능지역</th>
					<td>

						<div id="area_box" style="clear: both;">
							<select id='sido1'>
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
								style="width: 30%; position: unset; margin: 0"> <select
								id="gugun1">
									<option value="">-구/군-</option>
							</select></span> <span>1순위 (필수)</span><input type="hid`den" name="residence1"
								id="residence1" />
						</div>
						<div id="area_box" style="clear: both;">
							<select name="sido" id='sido2'>
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
								style="width: 30%; position: unset; margin: 0"> <select
								id="gugun2">
									<option value="">-구/군-</option>
							</select></span> <span>2순위 (선택)</span><input type="hid`den" name="residence2"
								id="residence2" />
						</div>
						<div id="area_box" style="clear: both;">
							<select name="sido" id='sido3'>
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
								style="width: 30%; position: unset; margin: 0"> <select
								id="gugun3">
									<option value="">-구/군-</option>
							</select></span> <span>3순위 (선택)</span><input type="hid`den" name="residence3"
								id="residence3" />
						</div> <!--
						<div id="free_open">
			축하합니다~<br/>
			회원님의 희망근무지역은 시터등록만 하셔도<br/>
			채용정보의 연락처를 <span style="color:#ed6c00;font-size:18px;font-weight: bold;">무료</span>로 보실 수 있습니다.<br/>
			채용자도 광고 작성만 하면<br/>
			시터의 연락처를 무료로 보실 수 있습니다.
			</div>
			            -->
					</td>
				</tr>
				<tr>
					<th scope="row">희망요일/시간</th>
					<td>

						<button type="button" class="workday_off workday_on mr1p"
							value="월" id="focus5" tabindex="5">월</button>
						<button type="button" class="workday_off workday_on mr1p"
							value="화">화</button>
						<button type="button" class="workday_off workday_on mr1p"
							value="수">수</button>
						<button type="button" class="workday_off workday_on mr1p"
							value="목">목</button>
						<button type="button" class="workday_off workday_on mr1p"
							value="금">금</button>
						<button type="button" class="workday_off mr1p" value="토">토</button>
						<button type="button" class="workday_off" value="일">일</button> <input
						id="time_type" type="checkbox" name="time_type" value='Y'><label
						for="time_type"><span style="margin-left: 25px;">협의
								가능</span></label> <input type="hid den" id="workday_name" name="activity_time"
						value="월,화,수,목,금"> <br /> <select name='starttime'
						id='starttime1' style="width: 24%; margin-top: 10px">
							<optgroup label="오전">
								<option value="">시간선택</option>
								<option value="06:00">오전 6:00</option>
								<option value="07:00">오전 7:00</option>
								<option value="08:00">오전 8:00</option>
								<option value="09:00">오전 9:00</option>
								<option value="10:00">오전 10:00</option>
								<option value="11:00">오전 11:00</option>
							</optgroup>
							<optgroup label="오후">
								<option value="12:00">정오 12:00</option>
								<option value="13:00">오후 1:00</option>
								<option value="14:00">오후 2:00</option>
								<option value="15:00">오후 3:00</option>
								<option value="16:00">오후 4:00</option>
								<option value="17:00">오후 5:00</option>
								<option value="18:00">오후 6:00</option>
								<option value="19:00">오후 7:00</option>
								<option value="20:00">오후 8:00</option>
								<option value="21:00">오후 9:00</option>
								<option value="22:00">오후 10:00</option>
								<option value="23:00">오후 11:00</option>
								<option value="00:00">자정 12:00</option>
							</optgroup>
					</select> <span style="padding: 0 7px; position: relative;">~</span> <select
						id="endtime1" style="width: 24%; margin-top: 10px">
							<optgroup label="오전">
								<option value="">시간선택</option>
								<option value="06:00">오전 6:00</option>
								<option value="07:00">오전 7:00</option>
								<option value="08:00">오전 8:00</option>
								<option value="09:00">오전 9:00</option>
								<option value="10:00">오전 10:00</option>
								<option value="11:00">오전 11:00</option>
							</optgroup>
							<optgroup label="오후">
								<option value="12:00">정오 12:00</option>
								<option value="13:00">오후 1:00</option>
								<option value="14:00">오후 2:00</option>
								<option value="15:00">오후 3:00</option>
								<option value="16:00">오후 4:00</option>
								<option value="17:00">오후 5:00</option>
								<option value="18:00">오후 6:00</option>
								<option value="19:00">오후 7:00</option>
								<option value="20:00">오후 8:00</option>
								<option value="21:00">오후 9:00</option>
								<option value="22:00">오후 10:00</option>
								<option value="23:00">오후 11:00</option>
								<option value="00:00">자정 12:00</option>
							</optgroup>
					</select> <br />

					</td>
				</tr>
				<tr>
					<th scope="row">CCTV촬영 동의</th>
					<td>

						<button type="button" class="cctv_off cctv_on" value="true"
							id="focus6" tabindex="6">동의함</button>
						<button type="button" class="cctv_off" value="false"
							style="width: 100px;">동의안함</button> <input type="hid`den"
						id="cctv_name" name="cctv_agree" value="true">
					</td>
				</tr>
				<tr>
					<th scope="row">희망급여</th>
					<td><label for="paytype">※2021년 기준 최저시급 : 8,720원</label>
					<div>시급 : <input type="text" id="paytype" name="pay"
						value=""><span style="font-size: 0.8em; color: gray">※ 원
							단위로 입력해주세요.</span></div>
					</td>
				</tr>
				<tr>
					<th>자기소개</th>
					<td>

						<div id="sample_layer" style="display: none;"></div>
						<div id="content_table" style="display: none"></div>
						<div id="content_box">
							<textarea name="introduction" class="contents" id="contents"
								style="margin-top: 10px"></textarea>
						</div>
					</td>
				</tr>
			</table>
			<button type="submit">작성완료</button>
		</form:form>
	</div>
	<script>
		$(function() {
			$('#sido1').change(function() {
				$.ajax({
					url : "../zipcode/gugun",
					type : "get",
					contentType : "text/html;charset:utf-8",
					data : {
						sido : $("#sido1 option:selected").val()
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
						$('#gugun1').html(optionStr);
					},
					error : function(e) {
						alert("오류발생:" + e.status + ":" + e.statusText);
					}
				});
			});
			$('#sido2').change(function() {
				$.ajax({
					url : "../zipcode/gugun",
					type : "get",
					contentType : "text/html;charset:utf-8",
					data : {
						sido : $("#sido2 option:selected").val()
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
						$('#gugun2').html(optionStr);
					},
					error : function(e) {
						alert("오류발생:" + e.status + ":" + e.statusText);
					}
				});
			});
			$('#sido3').change(function() {
				$.ajax({
					url : "../zipcode/gugun",
					type : "get",
					contentType : "text/html;charset:utf-8",
					data : {
						sido : $("#sido3 option:selected").val()
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
						$('#gugun3').html(optionStr);
					},
					error : function(e) {
						alert("오류발생:" + e.status + ":" + e.statusText);
					}
				});
			});
			$('#gugun1').change(
					function() {
						$('#residence1').val(
								$("#sido1 option:selected").val() + " "
										+ $("#gugun1 option:selected").val());
					})
			$('#gugun2').change(
					function() {
						$('#residence2').val(
								$("#sido2 option:selected").val() + " "
										+ $("#gugun2 option:selected").val());
					})
			$('#gugun3').change(
					function() {
						$('#residence3').val(
								$("#sido3 option:selected").val() + " "
										+ $("#gugun3 option:selected").val());
					})
		})
	</script>
	<style>
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
</style>
	<script>
		$(function() {
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
						workday_tyle += " "
								+ $("#starttime1 option:selected").val() + "~"
								+ $("#endtime1 option:selected").val();
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
						workday_tyle += " "
								+ $("#starttime1 option:selected").val() + "~"
								+ $("#endtime1 option:selected").val();
						if (i == 0) {
							$("#workday_name").val("");
						} else {
							$("#workday_name").val(workday_tyle);
						}
					});
			$('#time_type').change(
					function name() {
						if ($("#time_type").is(":checked")) {
							$("#workday_name").val('협의가능');
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
							workday_tyle += " "
									+ $("#starttime1 option:selected").val()
									+ "~"
									+ $("#endtime1 option:selected").val();
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
			workday_tyle += " " + $("#starttime1 option:selected").val() + "~"
					+ $("#endtime1 option:selected").val();
			if (i == 0) {
				$("#workday_name").val("");
			} else {
				$("#workday_name").val(workday_tyle);
			}
		}
	</script>
	<style>
.cctv_off {
	border: 1px solid #e0e0e0;
	background: #fff;
	margin-top: 7px;
	width: 50px;
	color: #595757;
	padding: 6px 0;
	text-align: center;
	font-family: Noto Sans KR, sans-serif !important;
	font-size: 15px;
	font-weight: 400;
}

.cctv_on {
	background: #fae100
}
</style>
	<script>
		$(function() {
			$(".cctv_off").click(function() {
				$(".cctv_off").removeClass("cctv_on");
				$(this).addClass("cctv_on");
				var cctv_type = $(this).val();
				$("#cctv_name").val(cctv_type);
			});
		});
	</script>
	<style>
.contents {
	width: 86%;
	font-family: Noto Sans KR, sans-serif !important;
	font-size: 15px;
	font-weight: 400;
	color: #595757;
	border: 1px solid #ddd;
	padding: 8px;
	height: 300px;
}

#sample_layer {
	display: none;
	display: none;
	position: relative;
	width: 100%;
	height: 400px; /*overflow-y: scroll;*/
	background-color: #fff;
	right: 0;
	z-index: 1000;
	text-align: left;
	border: 0px solid #ddd;
	padding: 10px;
	padding-left: 0
}

#sample_layer h3 {
	margin-top: 10px;
	border-bottom: 1px solid #ddd;
	margin-bottom: 10px
}

#sample_layer ul {
	overflow: hidden;
}

#sample_layer ul li {
	float: left;
	padding: 10px 0
}

#sample_layer ul li label {
	line-height: 150%;
}

#btn_close_layer {
	border: 0;
	background: #ddd;
	color: #000;
	font-size: 13px;
	padding: 5px 16px;
	right: 10px;
	margin-bottom: 5px;
	position: absolute;
	font-family: Noto Sans KR, sans-serif !important;
}

#btn_sample_content {
	position: absolute;
	right: 1%;
	font-size: 13.4px;
	padding: 5px 10px;
	font-family: Noto Sans KR, sans-serif !important;
}
</style>
	<style>
.timegita_off {
	border: 1px solid #e0e0e0;
	background: #fff;
	margin-top: 10px;
	color: #595757;
	width: 20%;
	padding: 6px 0;
	text-align: center;
	font-family: Noto Sans KR, sans-serif !important;
	font-size: 15px;
	font-weight: 400;
}

.timegita_on {
	background: #fae100
}
</style>
	<script>
		$(function() {
			$(".timegita_off").click(function() {
				if ($(this).hasClass("timegita_on") == false) {
					$(this).addClass("timegita_on");
				} else {
					$(this).removeClass("timegita_on");
				}
				timegita_make()
			});
		});

		function timegita_make() {
			var i = 0;
			var timegita_type = "";
			$(".timegita_off").each(function() {
				if ($(this).hasClass("timegita_on") == true) {
					timegitatype = $(this).val();
					if (i != 0)
						timegita_type += ",";
					timegita_type += timegitatype;
					i++;
				}
			});
			if (i == 0) {
				$("#timegita_name").val("");
			} else {
				$("#timegita_name").val(timegita_type);
			}
		}
	</script>

</body>
</html>
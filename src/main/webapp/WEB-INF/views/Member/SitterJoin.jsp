<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시터회원 추가 정보 입력</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<%@ include file="../links/linkOnly2dot.jsp"%>
</head>
<!-- http://localhost:9090/slowwalking/member/sitterjoin -->
<body>
<%@ include file="../include/top.jsp"%>
	<section class="section-padding" style="background-color: #eee;">
		<div class="container">
			<div class="section_title">
				<h1 class="mb-5"><strong>시터회원</strong> 추가정보 입력</h1>
			</div>
			<form:form method="post" name="payappform" id="payappform"
				action="../member/sitterjoinaction?${_csrf.parameterName}=${_csrf.token}"
				enctype="multipart/form-data">
				<input type="hidden" value="${id }" name="sitter_id" />
				<table class="table form joinF">
					<colgroup>
						<col style="width: 20%">
						<col>
					</colgroup>
					<tr>
						<th scope="row">자격증(필수)<br>
						<small>&#42; 장애영유아보육교사</small></th>
						<td style="vertical-align:middle;"><input type="file" name='license_check' /></td>
					</tr>
					<tr>
						<th scope="row">인성검사확인</th>
						<td><input type="file" name='personality_check' /></td>
					</tr>
					<tr>
						<th scope="row">활동가능지역</th>
						<td>
							<div id="area_box" style="clear: both;">
								<select id='sido1' class="pass form-control">
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
									id="gugun1" class="pass form-control">
										<option value="">-구/군-</option>
								</select></span> <small style="vertical-align:sub;">1순위 (필수)</small><input type="hidden" name="residence1"
									id="residence1" />
							</div>
							<div id="area_box" style="clear: both;">
								<select name="sido" id='sido2' class="pass form-control">
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
									id="gugun2" class="pass form-control">
										<option value="">-구/군-</option>
								</select></span> <small style="vertical-align:sub;">2순위 (선택)</small><input type="hidden" name="residence2"
									id="residence2" />
							</div>
							<div id="area_box" style="clear: both;">
								<select name="sido" id='sido3' class="pass form-control">
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
									id="gugun3" class="pass form-control">
										<option value="">-구/군-</option>
								</select></span> <small style="vertical-align:sub;">3순위 (선택)</small><input type="hidden" name="residence3"
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
							<button type="button" class="workday_off" value="일">일</button>
							<input type="checkbox" id="time_type" style="visibility:hidden;" name="time_type" value='Y'><label
							for="time_type" class="workday_off" style="vertical-align: top; width: 110px;">협의가능</label> <input type="hidden" id="workday_name" name="activity_time"
							value="월,화,수,목,금"> <br /> <select name='starttime'
							id='starttime1' style="width: 24%; margin-top: 10px"
							class="pass form-control">
								<optgroup label="오전">
									<option value="">시작 시각</option>
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
						</select> 
						
						<select
							id="endtime1" style="width: 24%; margin-top: 10px"
							class="pass form-control">
								<optgroup label="오전">
									<option value="">종료 시각</option>
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
							<button type="button" class="cctv_off cctv_on" style="width:110px;" value="true"
								id="focus6" tabindex="6">동의함</button>
							<button type="button" class="cctv_off" value="false"
								style="width: 110px;">동의안함</button> <input type="hidden"
							id="cctv_name" name="cctv_agree" value="true">
						</td>
					</tr>
					<tr>
						<th scope="row" style="vertical-align:middle;">희망급여
						<br><small>&#42; 원 단위로 입력해주세요.</small></th>
						<td>
							<div>
								시급 : <input type="text" id="paytype" name="pay" value="" placeholder="※2021년 기준 최저시급 : 8,720원"; style="vertical-align:middle;">
							</div></td>
					</tr>
					<tr>
						<th>자기소개</th>
						<td>

							<div id="sample_layer" style="display: none;"></div>
							<div id="content_table" style="display: none"></div>
							<div id="content_box">
								<textarea name="introduction" class="contents noresize" id="contents"
									style="margin-top: 10px; height:300px;"></textarea>
							</div>
						</td>
					</tr>
				</table>
				<div class="btnBelow">
					<button type="submit" class="btn btn-danger">작성완료</button>
				</div>
			</form:form>
		</div>
	</section>
	<%@ include file="../include/footer.jsp"%>
</body>
<%@ include file="../links/sitterjoinscript.jsp"%>	
</html>
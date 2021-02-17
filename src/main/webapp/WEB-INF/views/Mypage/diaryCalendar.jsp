<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fri" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<head>
<meta charset="UTF-8" />
<!-- css, js 파일링크 등 묶음-->
<%@ include file="../links/linkOnly2dot.jsp"%>
<title>느린걸음</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script >

<style TYPE="text/css">
	body {
	background-color: #EEEEEE;
	scrollbar-face-color: #F6F6F6;
	scrollbar-highlight-color: #bbbbbb;
	scrollbar-3dlight-color: #FFFFFF;
	scrollbar-shadow-color: #bbbbbb;
	scrollbar-darkshadow-color: #FFFFFF;
	scrollbar-track-color: #FFFFFF;
	scrollbar-arrow-color: #bbbbbb;
	margin-left:"0px"; margin-right:"0px"; margin-top:"0px"; margin-bottom:"0px";
	}

	td { font-size: 9pt; color:#595959;}
	th { font-size: 9pt; color:#FFFFFF;}
	select { font-size: 9pt; color:#595959;}

	A {color:#343A40; }
	A:hover {color: #DC5C05;}
	.divDotText {
	overflow:hidden;
	text-overflow:ellipsis;
	}
	.day{
		width:100px; 
		height:30px;
		font-weight: bold;
		font-size:15px;
		font-weight:bold;
		text-align: center;
	}
	.sat{
		color:#529dbc;
	}
	.sun{
		color:red;
	}
	.today_button_div{
		float: right;
	}
	.today_button{
		width: 100px; 
		height:30px;
	}
	.calendar{
		width:80%;
		margin:auto;
	}
	.navigation{
		margin-top:100px;
		margin-bottom:30px;
		text-align: center;
		font-size: 25px;
		vertical-align: middle;
	}
	.calendar_body{
		width:100%;
		height:20%;
		background-color: #FFFFFF;
		border:1px solid white;
		margin-bottom: 50px;
		border-collapse: collapse;
	}

	.calendar_body .date{
		font-weight: bold;
		font-size: 15px;
		padding-left: 3px;
		padding-top: 3px;
	}
	.calendar_body .sat_day{
		border:1px solid #EFEFEF;
		height:120px;
		background-color: white;
		text-align:left;
		vertical-align: top;
	}
	.calendar_body .sat_day .sat{
		color: #529dbc; 
		font-weight: bold;
		font-size: 15px;
		padding-left: 3px;
		padding-top: 3px;
	}
	.calendar_body .sun_day{
		border:1px solid white;
		height:120px;
		background-color:#EFEFEF;
		text-align: left;
		vertical-align: top;
	}
	.calendar_body .sun_day .sun{
		color: red; 
		font-weight: bold;
		font-size: 15px;
		padding-left: 3px;
		padding-top: 3px;
	}
	.calendar_body .normal_day{
		border:1px solid white;
		height:10px;
		background-color:#EFEFEF;
		vertical-align: top;
		text-align: left;
	}
	.this_month{
		margin: 10px;
	}
	#diaryBar {background-color: #DC5C05; color:white;}
</style>
</head>
<body>
<%@ include file="../include/top.jsp"%>
	<form name="calendarFrm" id="calendarFrm" action="" method="GET">
	<input type="hidden" id="year" value="${today.year }"/>
	<input type="hidden" id="month" value="${today.month }"/>
	<input type="hidden" id="yearIdx" value="0" />
	<div class="calendar" >

	<!--날짜 네비게이션  -->
	<div class="navigation">
		<!-- 이전해 -->
		<a href="../mypage/openCalendar?year=${today.year}&month=${today.month}&yearIdx=0&idx=${idx}">
			<i class="fa fa-angle-double-left" aria-hidden="true"></i>
			
		</a> 
		<!-- 이전달 -->
		<a href="../mypage/openCalendar?year=${today.year}&month=${today.month}&monthIdx=0&idx=${idx}">
			<i class="fa fa-angle-left" aria-hidden="true"></i>
		</a> 
		<span class="this_month">
			&nbsp;${today.year}.${today.month+1}
		</span>
		<!-- 다음달 -->
		<a href="../mypage/openCalendar?year=${today.year}&month=${today.month}&monthIdx=1&idx=${idx}">
			<i class="fa fa-angle-right" aria-hidden="true"></i>
		</a> 
		<!-- 다음해 -->
		<a href="../mypage/openCalendar?year=${today.year}&month=${today.month}&yearIdx=1&idx=${idx}">
			<i class="fa fa-angle-double-right" aria-hidden="true"></i>
		</a>
	</div>
	<c:if test="${flag eq 'sitter' }">
		<div class="mb-2" style="text-align:right;">
			<button type="button" class="btn btn-danger btn-sm" onClick="popOpen()">알림장 작성</button>
		</div>
	</c:if>


	<table class="calendar_body">
		<thead>
			<tr bgcolor="#3C5059">
				<th class="day sun" >
					일
				</th>
				<th class="day" >
					월
				</th>
				<th class="day" >
					화
				</th>
				<th class="day" >
					수
				</th>
				<th class="day" >
					목
				</th>
				<th class="day" >
					금
				</th>
				<th class="day sat" >
					토
				</th>
			</tr>
		</thead>
		<tbody>
		<c:set var="count" value="0" />
			<tr>
			<c:forEach begin="1" end="${today.start-1 }" var="i">
			<c:set var="count" value="${count + 1}" />
				<td class="sat_day">
					<div class="sat">
						&nbsp;
					</div>
				</td>
			</c:forEach>
			<c:forEach begin="${today.startDay }" end="${today.endDay }"  var="i">
			<c:set var="count" value="${count + 1}" />	
				<td class="sat_day">
					<div class="sat">
						${i }
						<c:forEach items="${diaryList }" var="row">
							<c:set var="date" value="${today.year }-${today.month+1 }-${i }"/>
							<c:if test="${row.regidate eq date}">
								<div id="diaryBar" class="mb-1" onclick="diaryOpen(${row.its_idx});">오늘의 알림장</div>
							</c:if>
						</c:forEach>
					</div>
				</td>
			<c:if test="${count%7 == 0 || i<endDate}">
			</tr>
			</c:if>
			</c:forEach>
			<c:forEach begin="${count }" end="${count < 35 ? 34: 41 }" var="i">
			<td class="sat_day">
					<div class="sat">
						&nbsp;
					</div>
				</td>
			</c:forEach>
			
		</tbody>
	</table>
	
	<input type="hidden" id="idx" value="${idx }"/>
	
	
	</div>
	</form>

<%@ include file="../include/footer.jsp"%>
</body>
<script type="text/javascript">
var popupX = (window.screen.width / 2) - (500 / 2);
var popupY= (window.screen.height / 2) - (500 / 2);
function popOpen(){
	var idx = document.getElementById("idx").value;	
	window.open("../mypage/openDiary?idx="+idx, "알림장쓰기", 
	"width=500, height=500, toolbar=no, menubar=no, status=no, scrollbars=no, resizable=no, left="+ popupX + ", top="+ popupY);
}

function diaryOpen(its_idx){	
	window.open("../mypage/openDiaryView?its_idx="+its_idx, "알림장보기", 
	"width=500, height=400, toolbar=no, menubar=no, status=no, scrollbars=no, resizable=no, left="+ popupX + ", top="+ popupY);
}
</script>
</html>

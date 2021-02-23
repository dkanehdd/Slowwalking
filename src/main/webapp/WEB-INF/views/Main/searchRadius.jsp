<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- css, js 파일링크 등 묶음-->
<%@ include file="../links/linkOnly2dot.jsp"%>
<title>느린걸음</title>
<script src="../resources/js/hospital.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<c:choose>
	<c:when test="${param.distance eq 1 }">
		<c:set var="zoomLevel" value="15" />
	</c:when>
	<c:when test="${param.distance eq 5 }">
		<c:set var="zoomLevel" value="14" />
	</c:when>
	<c:when test="${param.distance eq 10 }">
		<c:set var="zoomLevel" value="13" />
	</c:when>
	<c:otherwise>
		<c:set var="zoomLevel" value="12" />
	</c:otherwise>
</c:choose>
</head>
<body>
<%@ include file="../include/top.jsp"%>
<section class="section-padding" style="background-color:#eee;">
	<div class="container">
		<div class="section_title subPimgBg hospitalImg">
			<h1 class="mb-5"><strong>우리 동네</strong> 소아과 찾기</h1>
		</div>
		
		<fieldset>		
			<form name="searchFrm">
				<!-- 현재위치 위경도 입력상자 -->
				<input type="hidden" id="latTxt" name="latTxt" />
				<input type="hidden" id="lngTxt" name="lngTxt" />
				<table class="table table-bordered">
					<colgroup>
						<col width="30%"/>
						<col width="*"/>
					</colgroup>
					<tbody>
						
						<tr>
							<th colspan="2">
								<span id="result" style="color:grey; font-size:1em;"></span>
								<div class="mt-2">우리 동네
									<select name="distance" id="distance" class="distanceBox-m">
										<option value="1" <c:if test="${param.distance==1 }">selected</c:if>>1Km</option>
										<option value="5" <c:if test="${param.distance==5 }">selected</c:if>>5Km</option>
										<option value="10" <c:if test="${param.distance==10 }">selected</c:if>>10Km</option>
										<option value="20" <c:if test="${param.distance==20 }">selected</c:if>>20Km</option>
										<option value="30" <c:if test="${param.distance==30 }">selected</c:if>>30Km</option>
										<option value="40" <c:if test="${param.distance==40 }">selected</c:if>>40Km</option>
									</select>
									이내 소아과			 
									<button type="submit" class="btn btn-danger" >재검색</button>
								</div>
							</th>
						</tr>
						<tr>
							<td style="height:10px;"><legend>${resultCount }</legend></td>
							<td rowspan="2">
								<div id="map" style="width:100%; height:700px;"></div>
								<script async defer src="https://maps.googleapis.com/maps/api/js?key=${apiKey }"></script>
							</td>
						</tr>
						<tr>
							<td id="hospitalInfo">이곳에 정보가 뜹니다.</td>
						</tr>
					</tbody>
				</table> 
			</form>
		</fieldset>
			
		<!-- <fieldset>
			<legend>현재위치 - 위도, 경도</legend>
			<span id="result" style="color:red; font-size:1.5em; font-weight:bold;"></span>
		</fieldset> -->
		
		
		
	</div>
</section>
<%@ include file="../include/footer.jsp"%>
</body>
<script type="text/javascript">
var span;
window.onload = function(){
	span = document.getElementById("result");
	
	if(navigator.geolocation){
		span.innerHTML = "Geolocation API를 지원합니다.";
		
		var options = {	
			enableHighAccurcy:true, 
			timeout:5000,
			maximumAge:3000
		};
		navigator.geolocation.getCurrentPosition(showPosition,showError,options);
	}
	else{
		span.innerHTML = "이 브라우저는 Geolocation API를 지원하지 않습니다.";
	}	
}

var showPosition = function(position){
	//위도를 가져오는 부분
	var latitude = position.coords.latitude;
	//경도를 가져오는 부분
	var longitude = position.coords.longitude;
	span.innerHTML = "<img src='../resources/images/badge.png' style='width:20px;'/>"+" 현재 위치 확인 완료";
	
	////////////////////////////////////////////////////////////////////////
	//위경도를 text input에 입력
	document.getElementById("latTxt").value = latitude;
	document.getElementById("lngTxt").value = longitude;
	////////////////////////////////////////////////////////////////////////
	
		
	//위경도를 가져온후 지도 표시
	initMap(latitude, longitude) ;
}

function initMap(latVar, lngVar) {				
	var uluru = {lat: latVar, lng: lngVar};
	var map = new google.maps.Map(document.getElementById('map'), {
		zoom: ${zoomLevel},
		center: uluru
	});
	//현재 내 위치를 맵에 표시
	var marker = new google.maps.Marker({
		position: uluru,
		map: map,
		/////////////////////////////////////////////////////////////////////
		//내위치 아이콘 변경
		icon: '../resources/images/icon_me.png'
		/////////////////////////////////////////////////////////////////////
	});
	
	//////////////////////////////////////////////////////////////////////////
	//다중마커s
	var infowindow = new google.maps.InfoWindow();
	
 	//시설을 맵에 표시
	var locations = [		
		/* ['명동', 37.563576, 126.983431],
		['가로수길', 37.520300, 127.023008],
		['광화문', 37.575268, 126.976896],
		['남산', 37.550925, 126.990945],
		['이태원', 37.540223, 126.994005] */
		<c:forEach items="${searchLists }" var="row">
			['${row.hp_name }', '${row.hp_latitude}', '${row.hp_longitude}', '${row.hp_tel}', '${row.hp_addr}', '${row.hp_explain}'], 
		</c:forEach>
	];
	
 	var marker, i;
 	var info = document.getElementById("hospitalInfo");

	for (i=0; i<locations.length; i++) {  
		marker = new google.maps.Marker({
			id:i,
			position: new google.maps.LatLng(locations[i][1], locations[i][2]),
			map: map,
			icon: '../resources/images/icon_facil.png'
		});
	
		google.maps.event.addListener(marker, 'click', (function(marker, i) {
			return function() {
				//정보창에 HTML코드가 들어갈 수 있음.
				infowindow.setContent(locations[i][0]);
				infowindow.open(map, marker);
				info.innerHTML=locations[i][0]+"<br/>"+locations[i][3]+"<br/>"+locations[i][4]+"<br/>"+locations[i][5];
				
			}
		})(marker, i));
	
		if(marker)
		{
			marker.addListener('click', function() {
				map.setZoom(16);
				map.setCenter(this.getPosition());
			});
		}
	}
	//다중마커s
	//////////////////////////////////////////////////////////////////////////
}

var showError = function(error){
	switch(error.code){
		case error.UNKNOWN_ERROR:
			span.innerHTML = "알수없는오류발생";break;
		case error.PERMISSION_DENIED:
			span.innerHTML = "권한이 없습니다";break;
		case error.POSITION_UNAVAILABLE:
			span.innerHTML = "위치 확인불가";break;
		case error.TIMEOUT:
			span.innerHTML = "시간초과";break;
	}
}
</script>
</html>
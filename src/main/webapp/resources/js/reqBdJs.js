/* 메뉴 숨김/열림 처리 hjkosmo*/
$(document).ready(function(){
	$('.dropMore').click(function(){
		if($('.dropMore').hasClass('dropMore')){
			$('.dropMore').addClass('dropClose').removeClass('dropMore');
			$('.dropMenu').css('display', 'block');
			$('.moreIco').addClass('fa-chevron-up').removeClass('fa-chevron-down');
		}
		else if($('.dropClose').hasClass('dropClose')){
			$('.dropClose').addClass('dropMore').removeClass('dropClose');
			$('.dropMenu').css('display', 'none');
			$('.moreIco').addClass('fa-chevron-down').removeClass('fa-chevron-up');
		}
	});
});
//끝

function deleteRow(idx) {
    if(confirm('삭제하시겠습니까?')){
        location.href='requestBoardAction_delete?idx='+idx;
    }
}
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
	workday_tyle += ",~"
	if (i == 0) {
		$("#workday_name").val("");
	} else {
		$("#workday_name").val(workday_tyle);
	}
}
//작성자 본인에게만 수정/삭제 버튼 보임처리 
//<c:if test="${sessionScope.siteUserInfo.id eq row.id }">
//	<button class="btn btn-primary" 
//	onclick="location.href='advertisement/requestBoard_edit'">
//	수정</button>
//	<button class="btn btn-danger" 
//	onclick="javascript:deleteRow();">
//	삭제</button>
//</c:if>

//RequestBoard_view.jsp와 연결되는 JS(의뢰 상세)
$(function(){
	$('#submit').on("click", function(){
		$.ajax({
			url : "../mypage/addList?${_csrf.parameterName}=${_csrf.token}",
			type : "GET",
			data : { 
				idx : $('#idx').val(),
				id : $('#id').val(),
				request_time : $('#request_time').val()
			},
			dataType : "json", 
			contentType : "text/html;charset:utf-8;",
			success : function(data){
				if(data.message=='success'){
					alert("인터뷰 요청이 성공했습니다.\n ( 남은 티켓은 "+data.count+"개입니다. )");
				}
				else{
					alert("보유하신 이용권이 없습니다.");
					location.href="../multiBoard/product";
				}
				
			},
			error : function(){
				alert("다시 시도해 주세요.");
			}
			
		});
	});

});

//주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

var addr = document.getElementById('addr').value;
//주소로 좌표를 검색합니다
geocoder.addressSearch(addr, function(result, status) {

	// 정상적으로 검색이 완료됐으면 
	if (status === kakao.maps.services.Status.OK) {

		var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(result[0].y, result[0].x), // 지도의 중심좌표
			level : 5
		// 지도의 확대 레벨
		};
		

		var circle = new kakao.maps.Circle({
			center : new kakao.maps.LatLng(result[0].y, result[0].x), // 원의 중심좌표 입니다 
			radius : 200, // 미터 단위의 원의 반지름입니다 
			strokeWeight : 5, // 선의 두께입니다 
			strokeColor : '#75B8FA', // 선의 색깔입니다
			strokeOpacity : 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
			strokeStyle : 'dashed', // 선의 스타일 입니다
			fillColor : '#CFE7FF', // 채우기 색깔입니다
			fillOpacity : 0.7
		// 채우기 불투명도 입니다   
		});
		// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		circle.setMap(map);
		var map = new kakao.maps.StaticMap(mapContainer, mapOption);
	}
});
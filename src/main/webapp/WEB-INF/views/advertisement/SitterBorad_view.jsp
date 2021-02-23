<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SitterBoard_view.jsp</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e1bfbd13b698ee8d3ecba1e269ed3918&libraries=services"></script>
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<!-- css, js 파일링크 등 묶음-->
<%@ include file="../links/linkOnly2dot.jsp"%>
<style type="text/css">
/* 화면 아래에 인터뷰 신청하기 div css */
._1nW60 {
	min-height: 50px;
	-ms-flex-direction: row;
	flex-direction: row;
	-ms-flex-pack: justify;
	justify-content: space-between;
	padding: 10px 18px;
	background-color: #fff;
	-ms-flex-align: stretch;
	align-items: stretch;
	-webkit-box-shadow: 0 -2px 3px 0 hsl(0deg 0% 64%/ 50%);
	box-shadow: 0 -2px 3px 0 hsl(0deg 0% 64%/ 50%);
	position: fixed;
	left: 400px;
	right : 400px;
	bottom: 0;
	width: 100%;
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
	z-index: 14;
	margin: 0 auto;
}
.container {
	padding: 0;
}
.comment{
	width: 70%;
	margin: 5px auto;
	border-radius: 50px 50px 50px 0;
	border: #ddd;
}
</style>
</head>
<body>
<%@ include file="../include/top.jsp"%>
<section class="section-padding" style="background-color: #eee; text-align:center;">
	<div class="container noPdForm" data-aos="fade-up" data-aos-delay="400">
		<div>
			<div style="padding:100px;">
				<!-- 별점 -->
				<div class="row ml-0" style="display:inline-block;">
					<c:choose>
						<c:when test="${dto.starrate eq '0' }"></c:when>
						<c:otherwise>
							<c:set var="x" value="${dto.starrate }"/>
							<fmt:parseNumber var="i" integerOnly="true" type="number" value="${x}"/>
							<c:forEach begin="1" end="${i}" step="1">
								<img src="../resources/images/star.png" style="width:20px; margin-right:3px;"/>
							</c:forEach>
							<c:if test="${ i ne 5 }"></c:if>
								<c:forEach begin="1" end="${5-i }" step="1">
									<img src="../resources/images/b_star.png" style="width:20px; margin-right:3px;"/>
								</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
				<table class="table joinF">
					<tbody class="text-center">
						<tr><!-- 프로필이미지 -->
							<c:choose>
							    <c:when test="${not empty row.image_path }">
							        <td colspan="2" style="border:none !important;"><img
									src="../resources/images/${dto.image_path }"
									style="width: 200px; height: 200px"></td>
							    </c:when>
							    <c:otherwise>
							        <td colspan="2" style="border:none !important;"><img
									src="../resources/images/anonymous-avatar.jpg"
									style="width: 200px; height: 200px"></td>
							    </c:otherwise>
							</c:choose>
						</tr>						
						<tr><!-- 본문 -->				
							<td colspan="2"
								style="text-align: center; border-top:none; font-size: 1.5em; font-weight: bold;">
								<c:set var="name" value="${dto.name}" /> <c:set
									var="totalLength" value="${fn:length(name) }" /> <c:set
									var="first" value="${fn:substring(name, 0, 1) }" /> <c:set
									var="last" value="${fn:substring(name, 2, totalLength) }" /> <c:out
									value="${first}○${last}" />(${dto.age }세 , ${dto.gender })&nbsp;&nbsp;&nbsp;
								<c:choose>
									<c:when test="${dto.cctv_agree eq 'true' }">
										<span style="color: #FF7000"><i class='fas fa-video'></i>
											CCTV 동의함</span>
									</c:when>
									<c:otherwise>
										<span><i class='fa fa-video-camera'></i> CCTV 동의 안함</span>
									</c:otherwise>
								</c:choose>
								
							</td>
						</tr>
						<tr>
							<th>본인 인증 완료</th>
							<td>고객안전관리팀에서 실명 / 생년월일 / 연락처를 확인하였습니다.</td>
						</tr>
						<tr>
							<th>핵심인증</th>
							<td><c:choose>
									<c:when test="${empty dto.license_check }">
								자격증 등록이 안되어있습니다.
							</c:when>
									<c:otherwise>
								고객안전관리팀이 장애영유아보육교사 자격증을 확인하였습니다.
							</c:otherwise>
								</c:choose></td>
						</tr>
						<tr>
							<th rowspan="3">활동 가능 지역</th>
							<td>1순위 ${dto.residence1 }</td>
						</tr>
						<tr>
							<td style="text-align: left">2순위 ${dto.residence2 }</td>
						</tr>
						<tr>
							<td style="text-align: left">3순위 ${dto.residence3 }</td>
						</tr>
						<tr>
							<th>활동 가능 시간</th>
							<td>${dto.activity_date} ${dto.activity_time }</td>
						</tr>
						<tr>
							<th>간단 자기소개</th>
							<td colspan="1">${dto.introduction }</td>
						</tr>
						<tr>
							<th style="border-bottom: 2px solid #dee2e6;">선호 지역</th>
							<input type="hidden" id="addr" value="${dto.residence1 }" />
							<td colspan="1">
								<div id="map" style="width: 100%; height: 400px;"></div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- 후기 -->
			<div class="container p-3 pb-5" style="background-color:#eee;">
				<h3 style="text-align: center;" class="mt-3">
					<strong>후기</strong> comment
				</h3>
				<br />
				<c:choose>
					<c:when test="${empty lists}">
						<div class="card">등록된 후기가 없습니다.</div>
					</c:when>
					<c:otherwise>
						<c:forEach items="${lists }" var="row">
							<div class="media border p-5  comment" style="background-color: #fff;" data-aos="fade-up" data-aos-delay="400">
								<div class="float-left mr-3" style="width:20%; height:100%;">
									<c:choose>
									    <c:when test="${not empty row.image_path }">
									        <img src="../resources/images/${row.image_path }" class="media-object mr-3" 
									        style="width: 80px; height: 80px; border-radius: 70%">
									    </c:when>
									    <c:otherwise>
									        <img src="../resources/images/anonymous-avatar.jpg"
									        class="media-object" style="width: 80px; height: 80px; border-radius: 70%">
									    </c:otherwise>
									</c:choose>	
									<p class="info">${row.send_id }</p>
									<span style="display:inline-block; color: #ccc; font-size: 12px; postion: absolute; right:0; bottom: 10px;">${row.regidate }	</span>						
								</div>
								<div class="rightcontent" style="width:80%; height:100%;">																								
									<div class="media-body">
										
										<div class="float-left" style="width: 100%; height: 100px; text-align:left !important;">
											${row.content }	
											
										</div>
										<!-- 별점 -->
										<div class="mt-1 mb-1 float-right">
											<c:choose>
												<c:when test="${row.starrate eq '0' }"></c:when>
												<c:otherwise>
													<c:set var="x" value="${row.starrate }"/>
													<fmt:parseNumber var="i" integerOnly="true" type="number" value="${x}"/>
													<c:forEach begin="1" end="${i}" step="1">
														<img src="../resources/images/star.png" style="width:15px;"/>
													</c:forEach>
													<c:if test="${ i ne 5 }"></c:if>
														<c:forEach begin="1" end="${5-i }" step="1">
															<img src="../resources/images/b_star.png" style="width:15px;"/>
														</c:forEach>
												</c:otherwise>
											</c:choose>										
										</div><!-- 별점 끝 -->
										<span class="clear"></span>
									</div>
									
								</div>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
		</div><!-- 후기 끝 -->
		<span class="clear"></span>
		
	</div>
	<c:if test="${sessionScope.flag eq 'parents' }">
		<div class="_1nW60 container">
			    <div class="_2KQBU">
			        <div class="_1Lb4l">
			            <div class="_26pci">
			                <c:out value="${first}○${last}" />
			                (${dto.age }세 , ${dto.gender })
			            </div>
			        </div>
			        <div class="_2RUNH">희망시급 :<fmt:formatNumber value="${dto.pay }" type="number" />원</div>
			        <div style="color: rgba(0, 0, 0, 0.87); background-color: rgb(255, 255, 255); transition: all 450ms cubic-bezier(0.23, 1, 0.32, 1) 0ms; box-sizing: border-box; font-family: &amp; amp; amp; quot; Noto Sans KR&amp;amp; amp; quot; , sans-serif; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); box-shadow: rgba(0, 0, 0, 0.12) 0px 1px 6px, rgba(0, 0, 0, 0.12) 0px 1px 4px; border-radius: 2px; display: inline-block; min-width: 88px; height: 50px;">
		            <button tabindex="0" type="button"
		                style="border: 10px; box-sizing: border-box; display: inline-block; font-family: &amp; amp; amp; quot; Noto Sans KR&amp;amp; amp; quot; , sans-serif; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); cursor: pointer; text-decoration: none; margin: 0px; padding: 0px; outline: none; font-size: inherit; font-weight: inherit; position: relative; z-index: 1; height: 50px; width: 100%; border-radius: 2px; transition: all 450ms cubic-bezier(0.23, 1, 0.32, 1) 0ms; background-color: rgb(255, 112, 0); text-align: center;">
		                <div>
		                    <div style="height: 50px; border-radius: 2px; transition: all 450ms cubic-bezier(0.23, 1, 0.32, 1) 0ms; top: 0px;">
		                        <span style="position: relative; opacity: 1; font-size: 14px; letter-spacing: 0px; text-transform: uppercase; font-weight: 500; margin: 0px; user-select: none; padding-left: 16px; padding-right: 16px; color: rgb(255, 255, 255); line-height: 50px;"
		                            onClick="applyInter();">인터뷰 신청하기</span>
		                    </div>
		                </div>
		            </button>
		        </div>
		    </div>
		</div>
	</c:if>
	<input type="hid`den" id="sitter_id" value="${dto.sitter_id }"/>
	<input type="hidden" id="activity_time" value="${dto.activity_time }"/>		
</section>
<!-- Footer메뉴 -->
<%@ include file="../include/footer.jsp"%>
</body>
<script type="text/javascript">
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
	
	function applyInter(){
		$.ajax({
			url : "../mypage/addList?${_csrf.parameterName}=${_csrf.token}",
			type : "GET",
			data : { 
				sitterBoard_id : $('#sitter_id').val(),
				request_time : $('#activity_time').val()
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
	}
</script>
</html>
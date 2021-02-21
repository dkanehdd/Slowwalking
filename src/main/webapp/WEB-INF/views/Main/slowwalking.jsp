<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<title>느린걸음</title>
<!-- css, js 파일링크 등 묶음-->
<%@ include file="../links/linkOnly2dot.jsp"%>
<script type="text/javascript">
    var span;
    window.onload = function(){
        confirm = document.getElementById("result");


        if(navigator.geolocation){
            confirm.innerHTML = "Geolocation API를 지원합니다.";

            var options = {
                enableHighAcuurcy : true, /* 정확도설정 */
                timeout : 5000, /* 대기시간 */
                maximumAge : 3000 /* 캐시된 위치값을 반환받을 시간. 0으로 지정하면
                                    항상 최신의 현재위치를 수집한다. */
            };
            /*
            getCurrentPosition() : 현재 위치값을 얻어오는 함수
                사용법 : getCurrentPosition(
                            위치얻기에 성공했을 때 호출할 콜백메소드,
                            위치얻기에 실패했을 때 호출할 콜백메소드,
                            옵션(위치파악시간, 대기시간, 위치의정확도));  
            */
            navigator.geolocation.getCurrentPosition(showPosition, showError, options);
        }
        else{
        	confirm.innerHTML = "이 브라우저는 Geolocation API를 지원하지 않습니다.";
        }
    }

    //성공 시 호출할 콜백메소드
    var showPosition = function(position){
        //위도를 가져옴
        var latitude = position.coords.latitude;
        //경도를 가져옴
        var longitude = position.coords.longitude;
        //위,경도를 화면에 출력
        confirm.innerHTML  = "현재 위치가 확인되었습니다!"
        
		////////////////////////////////////////////////////////////////////////
    	//위경도를 text input에 입력
    	document.getElementById("latTxt").value = latitude;
    	document.getElementById("lngTxt").value = longitude;
    	////////////////////////////////////////////////////////////////////////
    	
    }
    //실패 시 호출할 콜백메소드
    var showError = function(error){
        switch(error.code){
            case error.UNKNOWN_ERROR:
            	confirm.innerHTML = "알수없는오류발생";break;
            case error.PERMISSION_DENIED:
            	confirm.innerHTML = "권한이 없습니다";break;
            case error.POSITION_UNABAILABLE:
            	confirm.innerHTML = "위치 확인 불가";break;
            case error.TIMEOUT:
            	confirm.innerHTML = "시간초과";break;
        }
    }
</script>
</head>
<body style="user-select: none;">
	<!-- Top메뉴 -->
	<%@ include file="../include/top.jsp"%>

	<div id="video-container">
		<div class="video-overlay"></div>
		<div class="video-content">
			<div class="inner">
				<h1>
					<em>아이와 발 맞춰</em> 느린걸음
				</h1>
				<p>90%의 부모님이 2시간 안에<br>시터를 구하고 있습니다</p>
			</div>
		</div>
		<video autoplay loop muted>
			<source src="../resources/video/vid.mp4" type="video/mp4" />
		</video>
	</div>
	
	<div class="location">
		<div class="container">
			<p id="result"></p>
			<fieldset>	
				<form name="searchFrm" action="../main/searchRadius">
					<h2>우리 동네
					<!-- 현재위치 위경도 입력상자 -->
					<input type="hidden" id="latTxt" name="latTxt" />
					<input type="hidden" id="lngTxt" name="lngTxt" />
					 
					<select name="distance" id="distance" class="distanceBox">
						<option value="1" <c:if test="${param.distance==1 }">selected</c:if>>1Km</option>
						<option value="5" <c:if test="${param.distance==5 }">selected</c:if>>5Km</option>
						<option value="10" <c:if test="${param.distance==10 }">selected</c:if>>10Km</option>
						<option value="20" <c:if test="${param.distance==20 }">selected</c:if>>20Km</option>
						<option value="30" <c:if test="${param.distance==30 }">selected</c:if>>30Km</option>
						<option value="40" <c:if test="${param.distance==40 }">selected</c:if>>40Km</option>
					</select>
					이내 병원 검색하기  <button type="submit" class="btn btn-lg btn-danger">검색</button></h2>
					
				</form>
			<script async defer src="https://maps.googleapis.com/maps/api/js?key=${apiKey }"></script>
			</fieldset>
		</div>	
	</div>
		
	<!-- ABOUT -->
	<section class="about section-padding pb-0" id="about">
		<div class="container">
			<div class="row">
				<div class="col-lg-7 mx-auto col-md-10 col-12">
					<div class="about-info">

						<h2 class="mb-4" data-aos="fade-up">
							<strong>특별한 우리 아이</strong><br/>어떤 시터님에게 맡겨야 할까요?
						</h2>

						<p class="mb-0" data-aos="fade-up">
							느린걸음은 '장애영유아보육교사' 자격증을 갖춘 전문 시터님들로 구성되어 있습니다.
							<br/>걱정 없이 아이를 맡길 수 있어요!
						</p>
					</div>

					<div class="about-image" data-aos="fade-up" data-aos-delay="200">

						<img src="../resources/images/main-kids.gif" class="img-fluid">
					</div>
				</div>

			</div>
		</div>
	</section>
	
	<!-- PROJECT -->
	<section class="project section-padding" id="project">
		<div class="container-fluid">
			<div class="row">

				<div class="col-lg-12 col-12">

					<h2 class="mb-5 text-center" data-aos="fade-up">
						생생 <strong>돌봄 후기</strong>
					</h2>

					<div class="owl-carousel owl-theme" id="project-slide">
						<c:forEach var="row" items="${lists }" begin="0" end="5" step="1">
							<div class="item project-wrapper" data-aos="fade-up" data-aos-delay="100">	
								<table class="table form JoinF" style="width:400px; height:300px;">
									<tr>
								 		<td style="text-align:left;">${fn:substring(row.send_id,0,2)}
							 			<c:forEach begin="3" end="${fn:length(row.send_id)}" step="1">*</c:forEach>
										</td>
									</tr>
									<tr style="height:200px;">
										<td style="text-align:left;">
											<div class="row ml-0 mb-2">
												<c:set var="x" value="${row.starrate }"/>
												<fmt:parseNumber var="i" integerOnly="true" type="number" value="${x}"/>
												<c:forEach begin="1" end="${i}" step="1">
													<img src="../resources/images/star.png" style="width:20px; text-align:right;"/>
												</c:forEach>
												<c:if test="${ i ne 5 }">
													<c:forEach begin="1" end="${5-i }" step="1">
														<img src="../resources/images/b_star.png" style="width:20px;"/>
													</c:forEach>
												</c:if>
											</div>
											<c:choose>
												<c:when test="${fn:length(row.content) > 100}">
													${fn:substring(row.content,0,99)}...
												</c:when>
												<c:otherwise>
													${row.content }
												</c:otherwise> 
								          	</c:choose>
										</td>
									</tr>
									<tr>
										<td style="text-align:left;">
											<div class="row ml-1">
												<img src="../resources/images/heart.png" style="width:25px; margin-right:8px;">
												<img src="../resources/images/chat-bubble.png" style="width:25px;">
											</div>
										</td>
									</tr>
								</table>
							</div>
						</c:forEach>
					</div>
				</div>

			</div>
		</div>
	</section>
	
	<!-- 추가섹션 -->
	<section class="section" id="about2">
        <div class="container">
            <div class="row">
                <div class="left-text col-lg-5 col-md-12 col-sm-12 mobile-bottom-fix">
                    <div class="left-heading">
                        <h5><strong>느린걸음</strong>은요</h5>
                    </div>
                    <ul>
                        <li>
                            <img src="../resources/images/main-user.png" >
                            <div class="text">
                                <h6>철저한 개인 정보 확인</h6>
                                <p>부모님은 물론 시터님의 신원 정보를 철저히 검증하여 믿을 수 있는 정보만을 게시합니다.</p>
                            </div>
                        </li>
                        <li>
                            <img src="../resources/images/main-certification.png">
                            <div class="text">
                                <h6>검증된 자격 조건</h6>
                                <p>타 사이트들과는 달리 '장애 영유아 보육교사' 자격증과 인적성 검사 확인서를 통해 신뢰할 수 있는 시터님들과 매칭이 가능합니다.</p>
                            </div>
                        </li>
                        <li>
                            <img src="../resources/images/main-rate.png" alt="">
                            <div class="text">
                                <h6>믿고 보는 후기</h6>
                                <p>부모님과 시터님 모두 서로에게 별점과 함께 후기를 남길 수 있어요! 후기를 통해 나에게 맞는 시터님(부모님)을 찾으시길 바랍니다.</p>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="right-image col-lg-7 col-md-12 col-sm-12 mobile-bottom-fix-big" data-scroll-reveal="enter right move 30px over 0.6s after 0.4s">
                    <img src="../resources/images/main-accept.gif" class="rounded img-fluid d-block mx-auto" alt="App">
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Features Big Item End ***** -->

	<!-- TESTIMONIAL -->
	<section class="testimonial section-padding" style="background-color:var(--project-bg);">
		<div class="container">
			<div class="row">
				<div class="col-lg-6 col-md-5 col-12">
					<div class="contact-image" data-aos="fade-up">

						<img src="../resources/images/Motherhood-bro.png" class="img-fluid"
							alt="website">
					</div>
				</div>

				<div class="col-lg-6 col-md-7 col-12">
					<h4 class="my-5 pt-3" data-aos="fade-up" data-aos-delay="100">ABOUT
						</h4>

					<div class="quote" data-aos="fade-up" data-aos-delay="200"></div>

					<h2 class="mb-4" data-aos="fade-up" data-aos-delay="300" style="line-height:1.4em;">

					방문 베이비 시터 서비스들은 많으나 시터들의 전공이나 경력이 단순히 아이를 좋아하는 대학생, 일반보육교사인 경우가 많습니다.
					장애가 있는 아이인 경우 보다 전문적인 지식을 가진 사람들, 아이가 문제가 생겼을 때 대처를 할 수 있는 보호자가 필요합니다.
					느린걸음은 믿을 수 있는 사람에게 우리 아이들을 맡길 수 있기를 바라는 마음으로 시작되었습니다.</h2>

					<p data-aos="fade-up" data-aos-delay="400">
						<strong>○○○</strong> <span class="mx-1">/</span> <small>느린걸음 대표</small>
					</p>
				</div>

			</div>
		</div>
	</section>

	<!-- Footer메뉴 -->
	<%@ include file="../include/footer.jsp"%>
	
	<!-- 스크립트 
	<script src="./resources/js/jquery.min.js"></script>
	<script src="./resources/js/bootstrap.min.js"></script>
	<script src="./resources/js/aos.js"></script>
	<script src="./resources/js/owl.carousel.min.js"></script>
	<script src="./resources/js/smoothscroll.js"></script>
	<script src="./resources/js/custom.js"></script>-->
</body>
</html>

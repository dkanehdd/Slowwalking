<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<!-- css, js 파일링크 등 묶음-->
<%@ include file="../links/linkOnly2dot.jsp"%>
<title>느린걸음</title>
</head>
<body>
	<!-- Top메뉴 -->
	<%@ include file="../include/top.jsp"%>

	<div id="video-container">
		<div class="video-overlay"></div>
		<div class="video-content">
			<div class="inner">
				<h1>
					<em>아이와 발 맞춰</em> 느린 걸음
				</h1>
				<p>90%의 부모님이 2시간 안에<br>시터를 구하고 있습니다</p>
			</div>
		</div>
		<video autoplay loop muted>
			<source src="../resources/video/vid.mp4" type="video/mp4" />
		</video>
	</div>

	<!-- ABOUT -->
	<section class="about section-padding pb-0" id="about">
		<div class="container">
			<div class="row">

				<div class="col-lg-7 mx-auto col-md-10 col-12">
					<div class="about-info">

						<h2 class="mb-4" data-aos="fade-up">
							최고의 <strong>시터 구인/구직 사이트</strong>를 둘러보세요
						</h2>

						<p class="mb-0" data-aos="fade-up">
							내용 입니다 내용 입니다 내용 입니다내용 입니다
						</p>
					</div>

					<div class="about-image" data-aos="fade-up" data-aos-delay="200">

						<img src="../resources/images/working-girl.png" class="img-fluid"
							alt="office">
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
						왜 <strong>느린걸음</strong> 인가
					</h2>

					<div class="owl-carousel owl-theme" id="project-slide">
						<div class="item project-wrapper" data-aos="fade-up"
							data-aos-delay="100">
							<img src="../resources/images/project/project-image01.jpg"
								class="img-fluid" alt="project image">

							<div class="project-info">
								<small>제목입니다</small>

								<h3>
									<a href="project-detail.html"> <span>내용입니다</span>
										<i class="fa fa-angle-right project-icon"></i>
									</a>
								</h3>
							</div>
						</div>

						<div class="item project-wrapper" data-aos="fade-up">
							<img src="../resources/images/project/project-image02.jpg"
								class="img-fluid" alt="project image">

							<div class="project-info">
								<small>제목입니다</small>

								<h3>
									<a href="project-detail.html"> <span>내용입니다</span> <i
										class="fa fa-angle-right project-icon"></i>
									</a>
								</h3>
							</div>
						</div>

						<div class="item project-wrapper" data-aos="fade-up">
							<img src="../resources/images/project/project-image03.jpg"
								class="img-fluid" alt="project image">

							<div class="project-info">
								<small>별점을 달고</small>

								<h3>
									<a href="project-detail.html"> <span>우수 후기 제목?(연동없음)</span> <i
										class="fa fa-angle-right project-icon"></i>
									</a>
								</h3>
							</div>
						</div>

						<div class="item project-wrapper" data-aos="fade-up">
							<img src="../resources/images/project/project-image04.jpg"
								class="img-fluid" alt="project image">

							<div class="project-info">
								<small>소제목입니다</small>

								<h3>
									<a href="project-detail.html"> <span>제목</span> <i
										class="fa fa-angle-right project-icon"></i>
									</a>
								</h3>
							</div>
						</div>

						<div class="item project-wrapper" data-aos="fade-up">
							<img src="../resources/images/project/project-image05.jpg"
								class="img-fluid" alt="project image">

							<div class="project-info">
								<small>소제목입니다</small>

								<h3>
									<a href="project-detail.html"> <span>제목</span> <i class="fa fa-angle-right project-icon"></i>
									</a>
								</h3>
							</div>
						</div>
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
                        <h5>느린 걸음의 철학</h5>
                    </div>
                    <p>내용입니다 내용입니다 내용입니다</p>
                    <ul>
                        <li>
                            <img src="../resources/images/icon/about-icon-01.png" alt="">
                            <div class="text">
                                <h6>제목입니다1</h6>
                                <p>내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다</p>
                            </div>
                        </li>
                        <li>
                            <img src="../resources/images/icon/about-icon-02.png" alt="">
                            <div class="text">
                                <h6>제목입니다1</h6>
                                <p>내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다</p>
                            </div>
                        </li>
                        <li>
                            <img src="../resources/images/icon/about-icon-03.png" alt="">
                            <div class="text">
                                <h6>제목입니다1</h6>
                                <p>내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다</p>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="right-image col-lg-7 col-md-12 col-sm-12 mobile-bottom-fix-big" data-scroll-reveal="enter right move 30px over 0.6s after 0.4s">
                    <img src="../resources/images/icon/right-image.png" class="rounded img-fluid d-block mx-auto" alt="App">
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

						<img src="../resources/images/female-avatar.png" class="img-fluid"
							alt="website">
					</div>
				</div>

				<div class="col-lg-6 col-md-7 col-12">
					<h4 class="my-5 pt-3" data-aos="fade-up" data-aos-delay="100">ABOUT
						</h4>

					<div class="quote" data-aos="fade-up" data-aos-delay="200"></div>

					<h2 class="mb-4" data-aos="fade-up" data-aos-delay="300" style="line-height:1.4em;">

					방문 베이비 시터 서비스들은 많으나 시터들의 전공이나 경력이 단순히 아이를 좋아하는 대학생, 일반보육교사인 경우가 많습니다.
					장애가 있는 아이인경우 보다 전문적인 지식을 가진 사람들, 아이가 문제가 생겼을때 대처를 할 수 있는 보호자가 필요합니다.
					느린걸음은 믿을 수 있는 사람에게 우리 아이들을 맡길 수 있기를 바라는 마음으로 시작되었습니다.s</h2>

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

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- css, js 파일링크 등 묶음-->
<%@ include file="../links/linkOnly2dot.jsp"%>
<meta charset="UTF-8">
<title>느린걸음</title>
</head>
<%@ include file="../include/top.jsp"%>
<body>
	<section class="testimonial section-padding"
		style="background-color: var(- -project-bg);">
		<div class="container">
			<div class="RequestBoardList" data-aos="fade-up" data-aos-delay="400">
				<div class="text-center">
					<h2>구직 신청 의뢰서를 작성해주세요.</h2>
					<form
						action="requestBoardAction_write?${_csrf.parameterName}=${_csrf.token}"
						method="post" name="requestBoard" enctype="multipart/form-data">
						<div class="custom-control custom-switch">
							<input type="checkbox" class="custom-control-input" id="switch1"
								name="advertise"> <label class="custom-control-label"
								for="switch1">의뢰서 보이기</label>
						</div>

						<div class="text-center">

							<table class="table table-bordered">
								<colgroup>
									<col width="40%" />
									<col width="*" />
								</colgroup>
								<input type="hid-den" name="id" value="${user_id }" />
								<tbody>
									<tr>
										<th class="text-center" style="vertical-align: middle;">신청서의
											제목을 작성해주세요</th>
										<td><input type="text" class="form-control"
											style="width: 400px;" name="title" /></td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">아이의
											이쁜 이름을 적어주세요</th>
										<td><input type="text" class="form-control"
											style="width: 400px;" name="children_name" /></td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">이쁜
											아이의 사진도 함께 넣어주세요</th>
										<td><input type="file" class="form-control"
											style="width: 400px;" name="image" /></td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">아이의
											현재연령을 알려주세요</th>
										<td><input type="text" class="form-control"
											style="width: 400px;" name="age" /></td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">시터에게
											줄수있는 시급을 적어주세요</th>
										<td><input type="text" class="form-control"
											style="width: 400px;" name="pay" /></td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">지역구를
											적어주세요</th>
										<td><input type="text" class="form-control"
											placeholder="oo시 oo구" style="width: 400px;" name="region" />
										</td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">시터가
											일하는 시간을 알려주세요</th>
										<td><input type="text" class="form-control"
											placeholder="최대한 구체적으로 작성해주세요!" style="width: 400px;"
											name="request_time" /></td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">아이의
											장애등급을 알려주세요.</th>
										<td>
											<div class="form-check-inline">
												<label class="form-check-label" for="radio1"> <input
													type="radio" class="form-check-input" id="serious"
													name="disability_grade" value="serious" checked>중증
												</label>
											</div>
											<div class="form-check-inline">
												<label class="form-check-label" for="radio2"> <input
													type="radio" class="form-check-input" id="slight"
													name="disability_grade" value="slight">경증
												</label>
											</div>
										</td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">아이를
											볼때 주의사항을 적어주세요!</th>
										<td><input type="text" class="form-control"
											style="width: 400px;" name="warning" /></td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">단기
											시터를 원하시나요? 정기적인 시터를 원하시나요?</th>
										<td>
											<div class="form-check-inline">
												<label class="form-check-label" for="radio1"> <input
													type="radio" class="form-check-input" id="short"
													name="regular_short" value="short" checked>단기
												</label>
											</div>
											<div class="form-check-inline">
												<label class="form-check-label" for="radio2"> <input
													type="radio" class="form-check-input" id="regular"
													name="regular_short" value="regular">정기적
												</label>
											</div>
										</td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">시터가
											일을 시작했으면 하는 날짜를 적어주세요</th>
										<td><input type="text" class="form-control"
											placeholder="2021-03-01" style="width: 400px;" name="start_work" />
										</td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">일할
											내용을 구체적으로 작성해주세요</th>
										<td>
											<div class="form-group">
												<textarea class="form-control" rows="5" id="content"
													name="content"></textarea>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
							<button type="submit" class="btn btn-primary">의뢰 신청하기</button>

						</div>
					</form>
				</div>
			</div>

		</div>
	</section>


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
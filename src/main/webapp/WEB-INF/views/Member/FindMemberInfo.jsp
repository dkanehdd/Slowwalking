<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디/비밀번호 찾기</title>
<%@ include file="../links/linkOnly2dot.jsp"%>

</head>
<body>
<!-- Top메뉴 -->
	<%@ include file="../include/top.jsp"%>
	<section class="section-padding" style="background-color:#eee;">
		<div class="container">
			<div class="area_inputs wow fadeIn">
				<div class="sub_title font-weight-bold text-white">
					<h3>아이디/비밀번호 찾기</h3>
				</div>
				<div style="margin-bottom: 10px;"
					class="custom-control custom-radio custom-control-inline">
					<input type="radio" class="custom-control-input" id="search_1" name="search_total" onclick="search_check(1)" checked="checked">
					<label class="custom-control-label font-weight-bold text-white"	for="search_1">아이디 찾기</label>
				</div>
				<div class="custom-control custom-radio custom-control-inline">
					<input type="radio" class="custom-control-input" id="search_2" name="search_total" onclick="search_check(2)"> 
					<label class="custom-control-label font-weight-bold text-white" for="search_2">비밀번호 찾기</label>
				</div>
				<div id="searchI">
					<div class="form-group">
						<label class="font-weight-bold text-white" for="iptName1">이름</label>
						<div>
							<input type="text" class="form-control" id="iptName1" name="iptName1" placeholder="ex) 갓민수">
						</div>
					</div>
					<div class="form-group">
						<label class="font-weight-bold text-white" for="iptPhone1">휴대폰번호</label>
						<div>
							<input type="text" class="form-control" id="iptPhone1" name="iptPhone1" placeholder="ex) 01077779999">
						</div>
					</div>
					<div class="form-group">
						<button id="searchBtn" type="button" onclick="idSearch_click()" class="btn btn-primary btn-block">확인</button>
					<a class="btn btn-danger btn-block"	href="${pageContext.request.contextPath}">취소</a>
					</div>
				</div>
				<div id="searchP" style="display: none;">
					<div class="form-group">
						<label class="font-weight-bold text-white" for="iptId2">아이디</label>
						<div>
							<input type="text" class="form-control" id="iptId2" name="iptId2" placeholder="ex) godmisu">
						</div>
					</div>
					<div class="form-group">
						<label class="font-weight-bold text-white" for="iptPhone2">휴대폰번호</label>
						<div>
							<input type="email" class="form-control" id="iptPhone2"	name="inputEmail_2" placeholder="ex) E-mail@gmail.com">
						</div>
					</div>
					<div class="form-group">
						<button id="searchBtn2" type="button" class="btn btn-primary btn-block">확인</button>
					<a class="btn btn-danger btn-block"	href="${pageContext.request.contextPath}">취소</a>
				</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Footer메뉴 -->
	<%@ include file="../include/footer.jsp"%>
</body>
</html>
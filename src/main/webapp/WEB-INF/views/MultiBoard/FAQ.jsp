<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ.jsp</title>
<%@ include file="../links/linkOnly2dot.jsp"%>
<script type="text/javascript">

$(document).ready(
	function() {
	// 열려 있을 때 마이너스 기호 -
	$(".collapse.show").each(
		function() {
			$(this).prev(".card-header").find(".fa").addClass(
					"fa-minus").removeClass("fa-plus");
		});
	// 닫혀 있을 때 때 플러스 기호 +
	$(".collapse").on(
			'show.bs.collapse',
		function() {
			$(this).prev(".card-header").find(".fa")
					.removeClass("fa-plus")
					.addClass("fa-minus");
		}).on(
		'hide.bs.collapse',
		function() {
			$(this).prev(".card-header").find(".fa")
					.removeClass("fa-minus")
					.addClass("fa-plus");
		});
	});
</script>
</head>
<body>
	<!-- Top메뉴 -->
	<%@ include file="../include/top.jsp"%>
	<section class="section-padding" style="background-color:#eee;">
		<div class="container">
			<div class="section_title subPimgBg faqImg">
				<h1 class="mb-5"><strong>FAQ</strong> 자주 묻는 질문</h1>
			</div>
			<div id="accordion" data-aos="fade-up" data-aos-delay="400">
				<div class="card">
					<div class="card-header">
						<a class="card-link subPTitle" data-toggle="collapse" href="#collapseOne">
							질문 #1 <button id="btnCollapse"
								class="btn btn-link collapsed float-right" type="button"
								data-toggle="collapse" data-target="#collapseOne"
								aria-expanded="false" aria-controls="collapseOne">
								<i class="fa fa-plus"></i></button></a>
					</div>
					<div id="collapseOne" class="collapse show" data-parent="#accordion">
						<div class="card-body">내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 </div>
					</div>
				</div>
	
				<div class="card">
					<div class="card-header">
						<a class="collapsed card-link subPTitle" data-toggle="collapse"
							href="#collapseTwo"> 질문 #2 <button id="btnCollapse"
								class="btn btn-link collapsed float-right" type="button"
								data-toggle="collapse" data-target="#collapseTwo"
								aria-expanded="false" aria-controls="collapseTwo">
								<i class="fa fa-plus"></i>
							</button></a>
					</div>
					<div id="collapseTwo" class="collapse" data-parent="#accordion">
						<div class="card-body">내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 </div>
					</div>
				</div>
	
				<div class="card">
					<div class="card-header">
						<a class="collapsed card-link subPTitle" data-toggle="collapse"
							href="#collapseThree"> 질문 #3 <button id="btnCollapse"
								class="btn btn-link collapsed float-right" type="button"
								data-toggle="collapse" data-target="#collapseThree"
								aria-expanded="false" aria-controls="collapseThree">
								<i class="fa fa-plus"></i>
							</button></a>
					</div>
					<div id="collapseThree" class="collapse" data-parent="#accordion">
						<div class="card-body">내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 </div>
					</div>
				</div>
	
				<div class="card">
					<div class="card-header">
						<a class="collapsed card-link subPTitle" data-toggle="collapse"
							href="#collapseFour"> 질문 #4 <button id="btnCollapse"
								class="btn btn-link collapsed float-right" type="button"
								data-toggle="collapse" data-target="#collapseFour"
								aria-expanded="false" aria-controls="collapseFour">
								<i class="fa fa-plus"></i></button></a>
					</div>
					<div id="collapseFour" class="collapse" data-parent="#accordion">
						<div class="card-body">내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 </div>
					</div>
				</div>
	
				<div class="card">
					<div class="card-header">
						<a class="collapsed card-link subPTitle" data-toggle="collapse"
							href="#collapseFive"> 질문 #5 <button id="btnCollapse"
								class="btn btn-link collapsed float-right" type="button"
								data-toggle="collapse" data-target="#collapseFive"
								aria-expanded="false" aria-controls="collapseFive">
								<i class="fa fa-plus"></i></button></a>
					</div>
					<div id="collapseFive" class="collapse" data-parent="#accordion">
						<div class="card-body">내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 </div>
					</div>
				</div>
	
				<div class="card">
					<div class="card-header">
						<a class="collapsed card-link subPTitle" data-toggle="collapse"
							href="#collapseSix"> 질문 #6 <button id="btnCollapse"
								class="btn btn-link collapsed float-right" type="button"
								data-toggle="collapse" data-target="#collapseSix"
								aria-expanded="false" aria-controls="collapseSix">
								<i class="fa fa-plus"></i></button></a>
					</div>
					<div id="collapseSix" class="collapse" data-parent="#accordion">
						<div class="card-body">내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 내용입니다 </div>
					</div>
				</div>
	
			</div>
		</div>
	</section>

	<!-- Footer메뉴 -->
	<%@ include file="../include/footer.jsp"%>
</body>
</html>
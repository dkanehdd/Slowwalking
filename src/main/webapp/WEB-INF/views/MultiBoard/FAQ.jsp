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
							Q1. 돌봄 비용은 어떻게 지급해야 하나요? <button id="btnCollapse"
								class="btn btn-link collapsed float-right" type="button"
								data-toggle="collapse" data-target="#collapseOne"
								aria-expanded="false" aria-controls="collapseOne">
								<i class="fa fa-plus"></i></button></a>
					</div>
					<div id="collapseOne" class="collapse show" data-parent="#accordion">
						<div class="card-body">	부모님과 시터님의 협의 내용에 따라 활동 내용이 변경될 수 있어 비용은 상호 합의 후 지급 방식을 결정할 수 있습니다.
						<br/>	거래 내역을 추후 확인할 수 있도록 계좌송금을 추천드리며 현금으로 지급할 경우 메신저 상으로 관련 대화를 기록해 놓거나 사진을 남겨놓는 것을 권유드립니다.
						<br/>	(지급 방식의 예: 선지급/후지급, 일급/주급/월급)</div>
					</div>
				</div>
	
				<div class="card">
					<div class="card-header">
						<a class="collapsed card-link subPTitle" data-toggle="collapse"
							href="#collapseTwo">Q2. 이용권(프리미엄권)을 환불할 수 있나요?<button id="btnCollapse"
								class="btn btn-link collapsed float-right" type="button"
								data-toggle="collapse" data-target="#collapseTwo"
								aria-expanded="false" aria-controls="collapseTwo">
								<i class="fa fa-plus"></i>
							</button></a>
					</div>
					<div id="collapseTwo" class="collapse" data-parent="#accordion">
						<div class="card-body">	이용권과 프리미엄권은 환불이 불가능합니다.
						<br/>	이용권의 경우 사용된 티켓 또한 환불이 불가하기 때문에 인터뷰 신청을 하시기 전에 
						<br/>	시터님(부모님)의 정보와 후기를 꼼꼼히 확인하시고 신청 여부를 결정하셔야 합니다.</div>
					</div>
				</div>
	
				<div class="card">
					<div class="card-header">
						<a class="collapsed card-link subPTitle" data-toggle="collapse"
							href="#collapseThree">Q3. 알림장은 수정이 불가능한가요? <button id="btnCollapse"
								class="btn btn-link collapsed float-right" type="button"
								data-toggle="collapse" data-target="#collapseThree"
								aria-expanded="false" aria-controls="collapseThree">
								<i class="fa fa-plus"></i>
							</button></a>
					</div>
					<div id="collapseThree" class="collapse" data-parent="#accordion">
						<div class="card-body">알림장을 전송하고 난 뒤에는 수정이 불가능합니다.
						<br/>수정할 경우에는 이전 내용을 확인할 수 없기 때문에 추후 중요한 돌봄 기록이 누락되었을 경우 불미스러운 일이 일어나는 것을 방지하고자 합니다.
						<br/>시터님은 알림장을 작성하실 때 특별히 아이의 건강과 관련하여 전달 사항이 빠지지 않았는지 확인 부탁드리며,
						<br/>부모님도 돌봄이 끝난 후 해당일에 알림장을 열람하시어 중요 사항을 확인하시기를 권유드립니다.</div>
					</div>
				</div>
	
				<div class="card">
					<div class="card-header">
						<a class="collapsed card-link subPTitle" data-toggle="collapse"
							href="#collapseFour">Q4. 후기를 작성하지 않아도 되나요?<button id="btnCollapse"
								class="btn btn-link collapsed float-right" type="button"
								data-toggle="collapse" data-target="#collapseFour"
								aria-expanded="false" aria-controls="collapseFour">
								<i class="fa fa-plus"></i></button></a>
					</div>
					<div id="collapseFour" class="collapse" data-parent="#accordion">
						<div class="card-body"> 후기 작성은 선택사항이며 웹페이지 및 앱 사용에 영향을 끼치지 않습니다.
						<br/> 다만 후기를 작성하시면 이용권 구매에 사용 가능한 포인트가 50점이 지급되니 많은 참여 부탁드립니다.</div>
					</div>
				</div>
	
				<div class="card">
					<div class="card-header">
						<a class="collapsed card-link subPTitle" data-toggle="collapse"
							href="#collapseFive">Q5. [시터회원] 제 정보가 시터리스트에 뜨지 않아요.<button id="btnCollapse"
								class="btn btn-link collapsed float-right" type="button"
								data-toggle="collapse" data-target="#collapseFive"
								aria-expanded="false" aria-controls="collapseFive">
								<i class="fa fa-plus"></i></button></a>
					</div>
					<div id="collapseFive" class="collapse" data-parent="#accordion">
						<div class="card-body"> 시터리스트에 공개되는 정보들은 철저한 검증 후 게시되기 때문에 확인되기 전까지 1~2일(주말 및 공휴일 제외)이 소요될 수 있습니다.
						<br/> 3일 이내로 정보가 게시되지 않을 시에는 1:1 채팅 및 고객센터로 문의 부탁드립니다.</div>
					</div>
				</div>
	
				<div class="card">
					<div class="card-header">
						<a class="collapsed card-link subPTitle" data-toggle="collapse"
							href="#collapseSix">Q6. [부모회원] 시터님들의 인증은 어떻게 이루어지나요?<button id="btnCollapse"
								class="btn btn-link collapsed float-right" type="button"
								data-toggle="collapse" data-target="#collapseSix"
								aria-expanded="false" aria-controls="collapseSix">
								<i class="fa fa-plus"></i></button></a>
					</div>
					<div id="collapseSix" class="collapse" data-parent="#accordion">
						<div class="card-body"> 시터회원으로 가입 시 부모회원과 마찬가지로 기본적인 인적사항을 필수로 기록하도록 하고 있으며
						<br/> 고객안전관리팀에서 '장애영유아보육교사' 자격증과 인적성 검사서를 철저히 확인하여 검증된 시터님의 정보만이 게시될 수 있게 관리하고 있습니다.
						<br/> 또한 부모님과 시터님 모두 응답률이 저조하거나 돌봄 활동이 원활히 이루어지지 않도록 협조하지 않을 경우
						<br/> 사실 관계 확인 후 빠르게 적절한 조치를 취할 것을 약속드립니다. 
						</div>
					</div>
				</div>
	
			</div>
		</div>
	</section>

	<!-- Footer메뉴 -->
	<%@ include file="../include/footer.jsp"%>
</body>
</html>
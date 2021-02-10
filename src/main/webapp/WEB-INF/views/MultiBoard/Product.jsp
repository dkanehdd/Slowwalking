<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product.jsp</title>
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<%@ include file="../links/linkOnly2dot.jsp"%>
<style type="text/css">
.num {
    font-size: 49px;
    color: #DC5C05;
    font-weight: 900;
}
</style>
<script type="text/javascript">
function changeModal(product_idx) {
	$.ajax({
		url : "./productModal", //요청할 경로
		type : "get", //전송방식
		//post방식일때의 컨텐츠 타입
		contentType : "text/html;charset:utf-8;",
		data : {
			idx : product_idx
		},
		dataType : "json", //콜백데이터의 형식
		success : function(d) { //콜백메소드
			$('#saleprice').html(d.dto.price);
			$('#idx').val(d.dto.idx);
			$('#point').html(d.member.point);
			console.log(d.member.point);
		},
		error : function(e) {
			alert("실패"+e);
		}
	});
}
function on_pay(pay_flag) {
	var f = document.order_form;
	f.flag.value = pay_flag;
	
	var saleprice = document.getElementById("saleprice").innerHTML;
	document.getElementById("price").value = saleprice;
	
	
	f.submit();
}


$(function(){
	$('#panel').hide();
	//문서의 로드가 끝난후 내용부분을 숨김처리
	$('.content').hide();
	//제목부분의 스타일을 변경
	$('.title').css('fontSize','1.5em').css('cursor','pointer');
	$('#sum').css('fontSize','1.5em').css('cursor','pointer');
	/*
	slideToggle(시간) : 해당 시간만큼 슬라이드 업/다운이
		토글되면서 적용
	slideUp(시간) : 해당 시간만큼 패널이 닫히는 효과
	slideDown(시간) : 해당 시간만큼 패널이 열리는 효과
	*/
	$('.title').click(function(){
		$(this).next().slideToggle(1000);
	});
		
// 	$('.s_down').click(function(){
// 		$('#panel').toggle('fast');
// 	});	
});


</script>

<script>
		var showSum = function(){
			console.log(1);
			var num1 = document.getElementById("saleprice").innerHTML;
			var num2 = document.getElementById("usepoint").value;
			var num3 = document.getElementById("point").innerHTML;
			if(num2==""){
				alert("포인트를 입력해주세요");
				return;
			}
			var result = parseInt(num1) - parseInt(num2);
			if(result <0){
				alert("금액이 포인트이상 일수는 없습니다");
				return;
			}		
			var result2 = parseInt(num3) - parseInt(num2);
			if(result2 <0){
				alert("포인트가 금액 이상 일수는 없습니다");
				return;
			}
			document.getElementById("point").innerHTML=result2;
			document.getElementById("saleprice").innerHTML=result;
			
		}
	</script>
<style>
	
</style>
</head>
<body>
	<!-- Top메뉴 -->
	<%@ include file="../include/top.jsp"%>
	<section class="section-padding" style="background-color: #eee;">
		<div class="container">
			<div class="section_title subPimgBg noticeImg">
				<h1 class="mb-5">
					<strong>PASSES</strong> 이용권구매
				</h1>
			</div>
			<table class="table mt-3 mb-5"  data-aos="fade-up" data-aos-delay="400">
				<c:forEach var="row" items="${lists }">
					<tbody>
						<tr>
							<td>
								<div class="card">
									<div class="card-body">${row.product_name }
										${row.price }
										<button type="button" class="btn btn-primary"
									data-toggle="modal" data-target="#modal_layer" onclick="changeModal('${row.idx}')">구매하기</button>
									</div>
								</div>
							</td>
						</tr>
					</tbody>
				</c:forEach>
			</table>
		</div>
		<div id="modal_layer" class="modal fade" tabindex="-1" style="display: none;" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content pl-5 pt-5" id="modal-content">
					<div id="modal_layer_html"
						style="font-family: 'NanumSquare', '맑은 고딕', 'Apple SD Gothic Neo', sans-serif;">
						<script type="text/javascript">
						</script>
						<form name="order_form" method="post" action="../multiBoard/order?${_csrf.parameterName}=${_csrf.token}">
							<button type="button" class="closs btn float-right"
								data-dismiss="modal" aria-label="Close">&times;</button>
							<div class="payment-point">
								<ul class="payment-list">
									<li class="payment-item">
										<div class="payment-total">
											<h3>결제금액</h3>
										</div>
										<div class="payment-pay">
											<div class="price">
												<span class="num" id="saleprice"></span>원
											</div>
										</div>
									</li>
									<li class="payment-item">
									<br />
									<div class="title w3-pagination w3-white w3-border-bottom">
										적립된포인트 보기
									</div>
									<div class="content" style="font-size: 1.5em">
										(보유포인트):
										<span class="num" id="point"></span>포인트</br>
										
												<span class="s_down">
													<input type="text" id="usepoint" name="usepoint" value="" size="20" style="height: 38px" placeholder="포인트를 입력해주세요"/>
													<span id="sum" onclick="showSum()">
														<button type="button" class="btn btn-info">적용</button>
													</span>
													 </div>
													
												
													
										
									</div>
<!-- 									<h3>결제수단을 선택하세요</h3> -->
										
										<div class="row">
<!-- 											<div class="col-3 mr-2"> -->
<!-- 												<button onclick="on_pay('html5_inicis');" class="btn rounded-lg"> -->
<!-- 												<img src="../img/card.png" alt="" style="width: 110px; height: 50px "/></button> -->
<!-- 											</div> -->
											<div class="modal-footer">
												<button class="btn rounded-lg btn-light" 
													onclick="on_pay('kakaopay');">
													<img src="../img/card.png" alt="" style="width: 60px; height: 50px;" />카드결제</button>																							
											</div>
											
										</div>
									</li>
								</ul>
							</div>
							<input type="hidden" id="price" name="price" value="" siez="5">
							<input type="hidden" name="flag" value="" siez="5">
							<input type="hidden" name="idx" id="idx" value="" size="5"> 
							<div>
							
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Footer메뉴 -->
	<%@ include file="../include/footer.jsp"%>
</body>
</html>
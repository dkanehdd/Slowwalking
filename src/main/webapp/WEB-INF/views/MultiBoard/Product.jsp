<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product.jsp</title>
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<%@ include file="../links/linkOnly2dot.jsp"%>
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
			var price = String(d.dto.price);
			price = price.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
			$('#saleprice').html(price);
			$('#idx').val(d.dto.idx);
			var point = String(d.member.point);
			point = point.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
			$('#point').html(point);
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
	document.getElementById("price").value = saleprice.replace(/[^\d]+/g, '');;
	
	
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
			num1 = num1.replace(/[^\d]+/g, '');
			var num2 = document.getElementById("usepoint").value;
			var num3 = document.getElementById("point").innerHTML;
			num3 = num3.replace(/[^\d]+/g, '');
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
				alert("포인트가 부족합니다");
				return;
			}
			result2 = String(result2).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
			result = String(result).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
			document.getElementById("point").innerHTML=result2
			document.getElementById("saleprice").innerHTML=result.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
			
		}
	</script>
<style>
    .info{text-align:center;}
	.info i{color: var(--primary-color); font-size: 21px;}
	.firstTxt {font-size:20px; font-weight:700;}
	.secTxt {color:#777; font-size:14px;}
	.rateTxt {font-size:30px; color: var(--first-color);}
	.buttons {text-align:center;}
	.buttons button:hover{
		box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
		transition: all 0.3s ease 0s 
	}
	.btnCredit{
		background-color: #444;
		color: white;
		width:120px;
	}
	.pay-title{
		font-size: 16px;
		color:#444;
	}
	.btn_image{
		width:248px;
		height:308px;
		border-radius:15px;
		border:none;
		background-image:url("../resources/img/prBg.png");
		background-size:248px;
	}
	.btnGroup{
		text-align:center;
	}
	.prcard{
		background-color:none;
		display:block;
		vertical-align:top;	
	}
	.cardTitle{
		font-size:16px;
		font-weight: 500;
	}
	.cardPrice{
		font-size: 25px;
		font-weight:900;
	}
	#price{
		text-align: right;
		font-size:55px;
	}
	.closeIco{
		position:absolute;
		color: red;
		top: 15px;
		right: 15px;
	}
</style>
</head>
<body>
<!-- Top메뉴 -->
<%@ include file="../include/top.jsp"%>
<section class="section-padding" style="background-color: #eee;">
	<div class="container">
		<div class="section_title subPimgBg marketImg">
			<h1 class="mb-5">
				<strong>PASSES</strong> 이용권구매
			</h1>
		</div>
		<div class="form mt-3 mb-5" style="width: 100% !important;" data-aos="fade-up" data-aos-delay="400">
			<c:forEach var="row" items="${lists }">					
				<div class="btnGroup" style="display:inline;">
					<button class="buttons btn btn_image mr-2" data-toggle="modal" data-target="#modal_layer" onclick="changeModal('${row.idx}')">
						<div style="position:relative; top: -75px;">
							<span class="cardTitle prcard" style="postion:relative; top: -83px;">${row.product_name }</span>
							<span class="cardPrice prcard"><fmt:formatNumber value="${row.price }" type="number" />원</span>
						</div>
					</button>
				</div>						
			</c:forEach>
		</div>
	</div>
	
	<!-- 모달 -->
	<div id="modal_layer" class="modal fade" tabindex="-1" style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content pl-5 pt-5" id="modal-content">
				<div id="modal_layer_html">
					<form name="order_form" method="post" action="../multiBoard/order?${_csrf.parameterName}=${_csrf.token}">
						<button type="button" class="closeIco btn float-right"
							data-dismiss="modal" aria-label="Close"><i class="fa fa-times" aria-hidden="true"></i></button>
						<div class="payment-point">
							<div class="payment-item">
								<div class="payment-total">
									<p class="pay-title">결제금액</p>
									<p style="display:inline-block; width: 84%" class="num" id="saleprice"></p>
									<span style="color: #444; font-weight: 700; display:inline-block; width: 15%; text-align: right; font-size: 30px;">&#8361;</span>
								</div>										
							</div>
							<div class="payment-item">
							<br />
							<div class="title btn rounded-lg btn-light">
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
							</div>
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
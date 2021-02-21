<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<%@ include file="../links/linkOnly2dot.jsp"%>
<script type="text/javascript">
function changeModal(product_idx) {
	$.ajax({
		url : "../multiBoard/productModal", //요청할 경로
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
			$('#price').html(price);
			$('#totalprice').val(d.dto.price);
			$('#idx').val(d.dto.idx)
		},
		error : function(e) {
			alert("실패"+e);
		}
	});
}
function on_pay(pay_flag) {
	var f = document.order_form;
	f.flag.value = pay_flag;
	
	f.submit();
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
<div class="ml-2 premium">
<div class="section_title">
	<h3 class="mb-5"><strong>My Membership</strong> 프리미엄권</h3>
</div>
</div>
    <div class="container mt-5 myPageBg" style="padding-bottom:80px;" data-aos="fade-up" data-aos-delay="400">
		<div class="info">
			<img class="ticket" src="../resources/images/primium.png" style="width: 100px; height: 100px;" />
			<div class="firstTxt">남은날짜 ${dto.premium} 일</div>
			<div class="secTxt">
				<ul>
					<li>프리미엄권을 구매하면 시터목록에 상단에 위치하게 됩니다</li>
					<li>이미 구매한 이용권은 환불이 불가능합니다</li>						
					<li>잔여 이용 기간이 있을 시 추가 구매가 불가합니다</li>
				</ul>
			</div>
		</div>
		<c:choose>
			<c:when test="${dto.premium eq 0 }">
				<div class="buttons text-center">
					<h3 class="mb-5" style="color: #FF7000; font-size: 20px; font-weight: bold;">프리미엄권 구매</h3>
					<c:forEach var="row" items="${lists }">
						<div class="btnGroup" style="display:inline;">
							<button class="buttons btn btn_image mr-2" data-toggle="modal" data-target="#modal_layer" onclick="changeModal('${row.idx}')">
								<div style="position:relative; top: -75px;">
									<span class="cardTitle prcard" style="postion:relative; top: -83px;">${row.product_name }</span>
									<span class="cardPrice prcard"><fmt:formatNumber value="${row.price }" type="number" />원</span>
								</div>
							</button>
							<span class="clear" style="clear:both;"></span>					
						</div>
						<span class="clear" style="clear:both;"></span>	
					</c:forEach>
				</div>
			</c:when>
			<c:otherwise>
			</c:otherwise>
		</c:choose>	
		<span class="clear" style="clear:both;"></span>	
	</div>
	<span class="clear" style="clear:both;"></span>	
	
	<!-- 모달 -->
	<div id="modal_layer" class="modal fade clear" tabindex="-1"
			style="display: none;" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content p-5" id="modal-content">
					<div id="modal_layer_html" >
					<form name="order_form" method="post" action="../multiBoard/order?${_csrf.parameterName}=${_csrf.token}">
						<button type="button" class="closeIco btn float-right"
							data-dismiss="modal" aria-label="Close"><i class="fa fa-times" aria-hidden="true"></i></button>
						<div class="payment-point">
							<div class="payment-total">
								<p class="pay-title">결제금액</p>
								<p style="display:inline-block; width: 84%" class="num" id="price"></p>
								<span style="color: #444; font-weight: 700; display:inline-block; width: 15%; text-align: right; font-size: 30px;">&#8361;</span>
							</div>
							<p class="pay-title">결제수단을 선택하세요</p>
							<button class="btnCredit btn rounded-lg btn-light mr-2"  onclick="on_pay('card');"><i class="fa fa-credit-card-alt" aria-hidden="true"></i>  카드결제</button>
						</div>
						<input type="hidden" name="idx" id="idx" value=""> 
						<input type="hidden" name="flag"  value=""> 
						<input type="hidden" name="price" id="totalprice" value="" />
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
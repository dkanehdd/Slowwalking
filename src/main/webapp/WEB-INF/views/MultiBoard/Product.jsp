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
			$('#price').html(d.dto.price);
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
			<table class="table table-hover" data-aos="fade-up"
				data-aos-delay="400">
				<colgroup>
					<col style="width: 5%">
					<col style="">
					<col style="width: 17%">
					<col style="width: 11%">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">상품의 일련번호</th>
						<th scope="col">상품의 이름</th>
						<th scope="col">상품의 가격</th>
						<th scope="col">상품의 정보</th>
						<th scope="col">상품 이미지</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${lists }" var="row">
						<tr>
							<th>${row.idx }</th>
							<!-- 아래있는 요청명 이랑 controller에 있는 @requestMapping 이랑 같아야해요 -->
							<th><a href="../multiBoard/product_view?idx=${row.idx }">${row.product_name }</a>
							</th>
							<th>${row.price }</th>
							<th>${row.content }</th>
							<th>${row.image }</th>
							<td><button type="button" class="btn btn-primary"
									data-toggle="modal" data-target="#modal_layer" onclick="changeModal('${row.idx}')">구매하기</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div id="modal_layer" class="modal fade" tabindex="-1"
			style="display: none;" aria-hidden="true">
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
												<span class="num" id="price"></span>원
											</div>
										</div>
									</li>
									<li class="payment-item">
									<br />
									<h3>결제수단을 선택하세요</h3>
										<div class="row">
<!-- 											<div class="col-3 mr-2"> -->
<!-- 												<button onclick="on_pay('html5_inicis');" class="btn rounded-lg"> -->
<!-- 												<img src="../img/card.png" alt="" style="width: 110px; height: 50px "/></button> -->
<!-- 											</div> -->
											<div class="col-3 ml-2">
												<button class="btn rounded-lg btn-light" 
													onclick="on_pay('kakaopay');">
													<img src="../img/card.png" alt="" style="width: 60px; height: 50px;" />카드결제</button>
											</div>
										</div>
									</li>
								</ul>
							</div>
							<input type="hid`den" name="idx" id="idx" value=""> 
							<input type="hid`den" name="flag"  value=""> 
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
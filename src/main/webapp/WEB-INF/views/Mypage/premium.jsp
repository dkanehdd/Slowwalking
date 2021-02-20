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
table {
	border-bottom: 1px solid #DEE2E6;
}
th {
	font-size: 15px;
}
span {
	color: #FF7000;
	font-size: 20px;
	font-weight: bold;
}
div .text {
	text-align: left;
	font-size: 12px;
}
.purchaseList {
	font-weight: bold;
}
.ticket {
	width: 100px;
	background-color: #FFE6E2;
	border-radius: 20px;
}
.conatiner {
	width: 20px;
}
.num {
    font-size: 49px;
    color: #DC5C05;
    font-weight: 900;
}
</style>
</head>
<body>
<div class="ml-2">
<div class="section_title">
	<h3 class="mb-5"><strong>My Membership</strong> 프리미엄권</h3>
</div>
</div>
	<div class="container ml-4 mt-5">
		<table class="table">
			<colgroup>
				<col width="20%" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<td><img class="ticket" src="../resources/images/primium.png" /></td>
					<td>남은날짜 <span>${dto.premium}</span> 일
						<div class="text mt-2">· 프리미엄권을 구매하면 시터목록에 상단에 위치하게 됩니다.</div>
						<div class="text">· 이미 구매한 이용권은 환불이 불가능합니다.</div>
						<div class="text">· 잔여 이용 기간이 있을 시 추가 구매가 불가합니다.</div>
					</td>
				</tr>
			</tbody>
		</table>
		<c:choose>
			<c:when test="${dto.premium eq 0 }">
				<div class="row mt-5">
					<span class="purchaseList">프리미엄권 구매</span>
					<table class="table mt-3 mb-5">
						<c:forEach var="row" items="${lists }">
							<tbody>
								<tr>
									<td>
										<div class="card">
											<div class="card-body d-flex justify-content-between">
											<span class="display-4">${row.product_name }</span>
											<span class="display-4"><fmt:formatNumber value="${row.price }" type="number" />원</span>
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
			</c:when>
			<c:otherwise>
			</c:otherwise>
		</c:choose>

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
								<div class="payment-total">
									<h3>결제금액</h3>
								</div>
								<div class="payment-pay">
									<div class="price">
										<span class="num" id="price"></span>원
									</div>
								</div>
							<br />
							<h3>결제수단을 선택하세요</h3>
								<div class="row">
									<div class="col-3 ml-2">
										<button class="btn rounded-lg btn-light" 
											onclick="on_pay('card');">
											<img src="../img/card.png" alt="" style="width: 60px; height: 50px;" />카드결제</button>
									</div>
								</div>
							</div>
							<input type="hid`den" name="idx" id="idx" value=""> 
							<input type="hid`den" name="flag"  value=""> 
							<input type="hid den" name="price" id="totalprice" value="" />
						</form>
					</div>
				</div>
			</div>
		</div>
</body>
</html>
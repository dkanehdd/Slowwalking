<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>느린걸음</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="contatiner ml-3 mt-3">
	<h3>이용권</h3>
</div>
<div class="container ml-4 mt-5">
	<table class="table">
		<colgroup>
			<col width="20%"/>
			<col width="*"/>
		</colgroup>
		<tbody>
		<tr>
			<td><img class="ticket" src="../resources/images/ticket.png" /></td>
			<td>
				보유티켓 <span>${dto.ticket}</span> 개
				<div class="text mt-2">· 인터뷰 신청 클릭 시 1회씩 차감됩니다.</div>
				<div class="text">· 이미 사용한 티켓은 취소가 불가능합니다.</div>
				<div class="text">· 인터뷰에 성공한 목록은 구인/구직현황을 통해 확인 가능합니다.</div>
			</td>
		</tr>
		</tbody>
	</table>
	
	<div class="row mt-5">
		<span class="purchaseList">구매내역</span>
			<table class="table mt-3 mb-5">
				<colgroup>
					<col width="20%"/>
					<col width="*"/>
					<col width="20%"/>
					<col width="20%"/>
				</colgroup>
				<thead>
				<tr>
					<th>결제일</th>
					<th>쿠폰명</th>
					<th>티켓 수</th>
					<th>결제금액</th>
				</tr>
				</thead>
				<c:forEach var="row" items="${lists }">
				<tbody>
					<td>${row.regidate }</td>
					<td>${row.content }</td>
					<td>${row.product_name }회</td>
					<td>${row.total_price}</td>
				</tbody>
			</c:forEach>
		</table>
	</div>
</div>
</body>
<style>
table{border-bottom:1px solid #DEE2E6;}
th{font-size: 15px;}
span {color:#FF7000; font-size:20px; font-weight: bold;}
div .text{text-align:left; font-size:12px;}
.purchaseList{font-weight: bold;}
.ticket {width:100px;}
.conatiner{width:20px;}
</style>
</html>
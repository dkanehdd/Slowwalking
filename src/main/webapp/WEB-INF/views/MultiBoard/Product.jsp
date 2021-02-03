<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product.jsp</title>
<%@ include file="../links/linkOnly2dot.jsp"%>
</head>
<body>
	<!-- Top메뉴 -->
	<%@ include file="../include/top.jsp"%>
	<section class="section-padding" style="background-color: #eee;">
		<div class="container">
			<div class="section_title subPimgBg noticeImg">
				<h1 class="mb-5">
					<strong>PRODUCT</strong> 상품
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
							<th>${row.idx }</th><!-- 아래있는 요청명 이랑 controller에 있는 @requestMapping 이랑 같아야해요 -->
							<th><a href="../multiBoard/product_view?idx=${row.idx }">${row.product_name }</a>
							</th>
							<th>${row.price }</th>
							<th>${row.content }</th>
							<th>${row.image }</th>
						</tr>
					</c:forEach>


				</tbody>
			</table>
		</div>
	</section>

	<!-- Footer메뉴 -->
	<%@ include file="../include/footer.jsp"%>
</body>
</html>
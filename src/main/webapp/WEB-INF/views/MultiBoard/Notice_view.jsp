<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice_view.jsp</title>
<%@ include file="../links/linkOnly2dot.jsp"%>
</head>
<body>
	<%@ include file="../include/top.jsp"%>
	<section class="section-padding" style="background-color: #eee;">
		<div class="container">
			<div class="section_title subPimgBg noticeImg">
				<h1 class="mb-5">
					<strong>NOTICE</strong> 공지사항
				</h1>
			</div>
			<input type="hidden" name="idx" value="${dto.idx }" />
			<div data-aos="fade-up" data-aos-delay="400">
				<table class="table table-hover">
					<tr>
						<th class="text-center align-middle">작성자</th>
						<td>${dto.id }</td>
						<th class="text-center align-middle">작성일</th>
						<td>${dto.postdate }</td>
						<th class="text-center align-middle">조회수</th>
						<td>${dto.visitcount }</td>
					</tr>
					<tr>
						<th colspan="6" class="text-left" 
						style="padding-left:50px; padding-right:50px;">
						<i class="fa fa-arrow-circle-right" aria-hidden="true"></i> ${dto.title }</th>
					</tr>
					<tr>
						<td colspan="6" class="text-left" style="height: 200px; padding-left:50px; padding-right:50px;">
							${dto.content }</td>
					</tr>
				</table>
				<!-- 아래 버튼은 임시로 만들어 두었습니다. 페이징처리, 목록보기 등의 기능 필요합니다. hjkosmo-->
				<button onclick="javascript:history.go(-1)" class="btn btn-danger float-right"
				style="background-color:var(--primary-color); color:var(--white-color);">목록보기</button>			
			</div>
		</div>
	</section>
	<!-- Footer메뉴 -->
	<%@ include file="../include/footer.jsp"%>
</body>
</html>
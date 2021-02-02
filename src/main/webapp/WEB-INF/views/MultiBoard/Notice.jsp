<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice.jsp</title>
<%@ include file="../links/linkOnly2dot.jsp"%>
</head>
<body>
	<!-- Top메뉴 -->
	<%@ include file="../include/top.jsp"%>
	<section class="section-padding" style="background-color:#eee;">
		<div class="container">
			<!-- Side메뉴 -->
			<%@ include file="../include/side.jsp"%>
			<div class="section_title subPimgBg noticeImg">
				<h1 class="mb-5"><strong>NOTICE</strong> 공지사항</h1>
			</div>
			<table class="table table-hover" data-aos="fade-up" data-aos-delay="400">
				<colgroup>
					<col style="width: 5%">
					<col style="">
					<col style="width: 17%">
					<col style="width: 11%">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">No</th>
						<th scope="col">제목</th>
						<th scope="col">작성시간</th>
						<th scope="col">첨부파일</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>1</th>
						<td><a href="#">[제목입니다] 제목입니다 제목입니다 제목입니다 3</a></td>
						<td>2021-01-31 11:17 PM</td>
						<td><i class="fa fa-paperclip" aria-hidden="true"></i></td>
					</tr>
					<tr>
						<td>2</th>
						<td><a href="#">[제목입니다] 제목입니다 제목입니다 제목입니다 2</a></td>
						<td>2021-01-30 10:17 PM</td>
						<td><i class="fa fa-paperclip" aria-hidden="false"></td>
					</tr>
					<tr>
						<td>3</th>
						<td><a href="#">[제목입니다] 제목입니다 제목입니다 제목입니다 1</a></td>
						<td>2021-01-11 09:10 AM</td>
						<td><i class="fa fa-paperclip" aria-hidden="true"></i></td>
					</tr>
				</tbody>
			</table>
		</div>
	</section>
	
	<!-- Footer메뉴 -->
	<%@ include file="../include/footer.jsp"%>
</body>
</html>
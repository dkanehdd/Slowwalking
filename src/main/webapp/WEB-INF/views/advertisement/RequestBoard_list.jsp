<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- css, js 파일링크 등 묶음-->
<%@ include file="../links/linkOnly2dot.jsp"%>
<title>느린걸음</title>

</head> 
<body>
	<%@ include file="../include/top.jsp"%>

<script type="text/javascript">
	function deleteRow(idx) {
		if(confirm('삭제하시겠습니까?')){
			location.href='requestBoardAction_delete?idx='+idx;
		}
	}
</script>
<section class="testimonial section-padding"
		style="background-color: var(- -project-bg);">
<div class="container">
	<div class="RequestBoardList" data-aos="fade-up" data-aos-delay="400">	
	<div class="text-center">
	<form method="get">
		<select name="searchField">
			<option value="contents">내용</option>
			<option value="name">작성자</option>
		</select>
		<input type="text" name="searchTxt" />
		<input type="submit" value="검색" />
	</form>
	</div>
	<div class="d-flex flex-column">
	<c:forEach items="${lists }" var="row">		
		<div id="back" class="text-center">
			<div>
				<img src="../resources/images/${row.image }" class="media-object rounded-circle" style="width:100px; height:100px">
			</div>
			<div>
				<h2><a href="requestBoard_view?idx=${row.idx }&list_flag=${list_flag}">${row.title }</a></h4>
				<p>아이 이름 : ${row.children_name }</p> 
				<p>돌봄 시간 : ${row.request_time }</p>  
			</div>	  
		</div> 
		<br/><br/><br/>
	</c:forEach>
	</div>
	</div>
	
	
</div>
</section>
<!-- Footer메뉴 -->
<%@ include file="../include/footer.jsp"%>

<!-- 스크립트 -->
<script src="../resources/js/jquery.min.js"></script>
<script src="../resources/js/bootstrap.min.js"></script>
<script src="../resources/js/aos.js"></script>
<script src="../resources/js/owl.carousel.min.js"></script>
<script src="../resources/js/smoothscroll.js"></script>
<script src="../resources/js/custom.js"></script>
</body>
</html>
<style>
#back{
	background: #ffe4d6;
	width: 500px;
	text-align: center;
} 
</style>


<!-- 작성자 본인에게만 수정/삭제 버튼 보임처리 
	<c:if test="${sessionScope.siteUserInfo.id eq row.id }">
		<button class="btn btn-primary" 
		onclick="location.href='advertisement/requestBoard_edit'">
		수정</button>
		<button class="btn btn-danger" 
		onclick="javascript:deleteRow();">
		삭제</button>
	 </c:if> -->
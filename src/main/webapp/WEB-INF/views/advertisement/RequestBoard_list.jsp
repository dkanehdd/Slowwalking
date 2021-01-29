<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RequestBoard.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script >
</head>
<body>
<script type="text/javascript">
	function deleteRow(idx) {
		if(confirm('삭제하시겠습니까?')){
			location.href='requestBoardAction_delete?idx='+idx;
		}
	}
</script>
<div class="container">
	<h2>구직의뢰서를 시터에게 보여주는 페이지</h2>
	
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
	<c:forEach items="${lists }" var="row">		
		<div class="border mt-2 mb-2">
			<div class="media">
				<div class="media-left mr-3">
					<img src="../images/${row.image }" class="media-object" style="width:300px; height:300px">
				</div>
				<div class="media-body">
					<h4 class="media-heading"><a href="requestBoard_view?idx=${row.idx }">제목 : ${row.title }</a></h4>
					<p>아이 이름 : ${row.children_name }</p>
					<p>돌봄 시간 : ${row.request_time }</p>
					<p>지역 : ${row.region }</p>
					<p>시급 : ${row.pay }</p>
				</div>	  
				<!--  수정,삭제버튼 -->
				<div class="media-right">
						<button class="btn btn-primary" 
						onclick="location.href='requestBoard_edit?idx=${row.idx}'">
						수정</button>
						<button class="btn btn-danger" 
						onclick="javascript:deleteRow(${row.idx});">
						삭제</button>
				</div>
			</div>
		</div>
	</c:forEach>
	
	
	
</div>
</body>
</html>


<!-- 작성자 본인에게만 수정/삭제 버튼 보임처리 
	<c:if test="${sessionScope.siteUserInfo.id eq row.id }">
		<button class="btn btn-primary" 
		onclick="location.href='advertisement/requestBoard_edit'">
		수정</button>
		<button class="btn btn-danger" 
		onclick="javascript:deleteRow();">
		삭제</button>
	 </c:if> -->
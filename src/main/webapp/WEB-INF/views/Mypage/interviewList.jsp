<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
.container input {width:20px;}
</style>
</head>
<body>
<div class="ml-2">
	<c:choose>
	<c:when test="${flag eq 'sitter' }"><h3>내 구직현황</h3></c:when>
	<c:otherwise><h3>내 구인현황</h3></c:otherwise>
	</c:choose>
</div>
<div class="container">
	<c:choose>
		<c:when test="${empty lists}">
			<div>등록된 인터뷰가 없습니다.</div>
		</c:when>
		<c:otherwise>
			<table class="table table-hover">
				<thead>
					<th>이름(ID)</th>
					<th>연락처</th>
					<th>근무 시간</th>
					<th>내용</th>
					<th colspan="2">프로세스</th>
				</thead>
				<tbody>
				<c:forEach var="row" items="${lists}">
					<tr id="box">		
					<c:choose>
						<c:when test="${flag eq 'sitter'}"><td>${dto.name}(${row.parents_id})</td></c:when>
						<c:otherwise><td id="sitter_id">${dto.name}(${row.sitter_id})</td></c:otherwise>
					</c:choose>
						<td>${dto.phone}</td>
						<td>
							${row.request_time }
							<input type="hid-den" id="request_idx" value="${row.request_idx}" /> <!-- 상세보기를 위한 request_idx -->
							<input type="hid-den" id="idx" value="${row.idx}" />
							<c:choose>
								<c:when test="${flag eq 'sitter' }"><input type="hid-den" id="agree" value="${row.sitter_agree}" /></c:when>
								<c:otherwise><input type="hid-den" id="agree" value="${row.parents_agree}" /></c:otherwise>
							</c:choose>
						</td>
						<td><button type="button" class="btn btn-warning" onclick="moveView();">자세히</button></td>
						<c:choose>
							<c:when test="${!(row.sitter_agree eq 'T' and row.parents_agree eq 'T')}">
								<c:choose>
									<c:when test="${row.sitter_agree eq 'T' && row.parents_agree eq 'T' }">
										<td><button type="button" class="btn btn-basic " >대기</button></td>
									</c:when>
									<c:otherwise>
										<td><button type="button" class="btn btn-dark " id="accept">수락</button></td>
									</c:otherwise>
								</c:choose>
								<td><button type="button" class="btn btn-dark" id="refuse">취소</button></td>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${empty check }">
										<td><button type="button" class="btn btn-info" id="diary" onClick="javascript:openCalendar();">알림장</button></td>
										<td><button type="button" class="btn btn-secondary" >진행</button></td>
									</c:when>
									<c:otherwise>
										<td><button type="button" class="btn btn-basic" >알림장</button></td>
										<td><button type="button" class="btn btn-basic">완료</button></td>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
				</tbody>
					
			</table>
		</c:otherwise>
	</c:choose>

</div>
</body>
<script type="text/javascript">
function moveView(){
	var idx = document.getElementById("request_idx").value;	
	location.href="../advertisement/requestBoard_view?idx="+idx;
}
function openCalendar(){
	var idx = document.getElementById("idx").value;	
	location.href="../mypage/openCalendar?idx="+idx;
}
$(function(){
	$('#accept').on("click", function(){
		$.ajax({
			url : "../mypage/agreeAction",
			type : "GET",
			data : { 
				idx : $('#idx').val()
			},
			dataType : "json", 
			contentType : "text/html;charset:utf-8;",
			success : function(data){
				$('#agree').val('T');
				$('#accept').html('대기');
				alert(data.message);
			},
			error : function(){
				alert("다시 시도해 주세요.");
			}
			
		});
	});
	$('#refuse').on("click", function(){
		var cfm = confirm('목록에서 삭제하시겠습니까?');
		if(cfm){
		$.ajax({
			url : "../mypage/deleteAction",
			type : "GET",
			data : { 
				idx : $('#idx').val(),
				parents_id : $('#parents_id').val(),
				sitter_id : $('#sitter_id').val()
			},
			dataType : "json", 
			contentType : "text/html;charset:utf-8;",
			success : function(data){
				$('#box').empty();
				alert(data.message);
				
			},
			error : function(){
				alert("다시 시도해 주세요.");
			}
			
		});
		}
		else{
			return;
		}
	});

});
</script>
</html>
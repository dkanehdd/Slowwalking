<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RequestBoard_view</title>
<!-- css, js 파일링크 등 묶음-->
<%@ include file="../links/linkOnly2dot.jsp"%>
</head>
<body>
<%@ include file="../include/top.jsp"%>
<div class="container">
<div class="container p-3 my-3 bg-muted">
	<h3 class="text-center">${dto.title }</h3>
	<input type="hid-den" id="idx" value="${dto.idx}"/>
	<input type="hid-den" id="id" value="${dto.id}" />
	<input type="hid-den" id="request_time" value="${dto.request_time}" />
	<table class="table table-bordered">
		<tbody class="text-center">
			<tr>
				<td rowspan="10">
					<img src="../resources/images/${dto.image }" style="width:200px; height:200px">
				</td>
			</tr>
			<tr>
				<td>
					부모님 이름 
				</td>
				<td>
					${dto.name }
				</td>
			</tr>
			<tr>
				<td>
					지역
				</td>
				<td>
					${dto.region }
				</td>
			</tr>
			<tr>
				<td>
					일하는 시간
				</td>
				<td>
					${dto.request_time }/${dto.regular_short }
				</td>
			</tr>
			<tr>
				<td>
					아이 이름
				</td>
				<td>
					${dto.children_name }
				</td>
			</tr>
			<tr>
				<td>
					아이 장애 등급
				</td>
				<td>
					${dto.disability_grade }
				</td>
			</tr>
			<tr>
				<td>
					주의 사항
				</td>
				<td>
					${dto.warning }
				</td>
			</tr>
			<tr>
				<td>
					아이 나이
				</td>
				<td>
					${dto.age }살
				</td>
			</tr>
			<tr>
				<td>
					시작 날짜
				</td>
				<td>
					${dto.start_work }
				</td>
			</tr>
			<tr>
				<td>
					내용
				</td>
				<td colspan="2">
					${dto.content }
				</td>
			</tr>
		</tbody>
	</table>
	<button type="button" class="btn btn-success" id="submit" >인터뷰 신청하기</button>
	</div>
</div>
<!-- Footer메뉴 -->
<%@ include file="../include/footer.jsp"%>
</body>
<script>
$(function(){
	$('#submit').on("click", function(){
		$.ajax({
			url : "../mypage/addList?${_csrf.parameterName}=${_csrf.token}",
			type : "GET",
			data : { 
				idx : $('#idx').val(),
				id : $('#id').val(),
				request_time : $('#request_time').val()
			},
			dataType : "json", 
			contentType : "text/html;charset:utf-8;",
			success : function(data){
				alert(data.message);
			},
			error : function(){
				alert("다시 시도해 주세요.");
			}
			
		});
	});

});
</script>
</html>
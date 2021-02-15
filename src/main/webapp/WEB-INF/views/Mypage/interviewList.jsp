<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>느린걸음</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
.container input {width:20px;}
</style>
</head>
<body>
<div class="ml-2">
	<c:choose>
		<c:when test="${flag eq 'sitter' }">
			<div class="ml-3 mt-3"> 
			<h3>내 구직현황</h3>
			</div>
		</c:when>
		<c:otherwise>
			<div class="ml-3 mt-3">
			<h3>내 구인현황</h3>
			</div> 
		</c:otherwise>
	</c:choose>
</div>
<div class="container mt-5">
	<c:choose>
		<c:when test="${empty lists}">
			<div>등록된 인터뷰가 없습니다.</div>
		</c:when>
		<c:otherwise>
			<table class="table form joinF">
				<thead>
					<th>아이디</th>
					<th>근무 시간</th>
					<th>내용</th>
					<th colspan="2">프로세스</th>
				</thead>
				<tbody>
				<c:forEach var="row" items="${lists}">
				<tr id="box_${row.idx}">		
				<c:choose>
					<c:when test="${flag eq 'sitter'}">
						<td>${row.parents_id} <img src="../resources/images/phone.png" class="media-object rounded-circle" 
							onclick="javascript:popInfo('${row.parents_id}')"/></td>
					</c:when>
					<c:otherwise>
						<td id="sitter_id">${row.sitter_id} <img src="../resources/images/phone.png" class="media-object rounded-circle" 
							onclick="javascript:popInfo('${row.sitter_id}')"/></td>
					</c:otherwise>
				</c:choose>
					<td style="text-align:center;">
						${row.request_time}
						<input type="hidden" id="idx" value="${row.request_idx}"/>
						<input type="hidden" id="id" value="${row.sitter_id}"/>
						<input type="hidden" id="id" value="${row.sitter_id}"/>
						
						<c:choose>
							<c:when test="${flag eq 'sitter' }"><input type="hidden" id="agree_${row.idx }" value="${row.sitter_agree}" /></c:when>
							<c:otherwise><input type="hidden" id="agree_${row.idx }" value="${row.parents_agree}" /></c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${flag eq 'sitter' }">
								<c:choose>
									<c:when test="${row.request_idx eq 0}">
										<button type="button" class="btn btn-sm btn-basic">받은 요청</button>
									</c:when>
									<c:otherwise>
										<button type="button" class="btn btn-secondary" onClick="parentsView(${row.request_idx});">자세히</button>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise> 
								<c:choose>
									<c:when test="${row.request_idx eq 0 }">
										<button type="button" class="btn btn-secondary" onClick="sitterView('${row.sitter_id}')">자세히</button>
									</c:when>
									<c:otherwise>
										<button type="button" class="btn btn-sm btn-basic">받은 요청</button>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>				
					</td>
					<c:choose>
						<c:when test="${!(row.sitter_agree eq 'T' and row.parents_agree eq 'T')}">
						<c:choose>
							<c:when test="${(flag eq 'sitter' && row.sitter_agree eq 'T' && row.parents_agree eq 'F') || (flag eq 'parents' && row.parents_agree eq 'T' && row.sitter_agree eq 'F')}">
								<td><button type="button" class="btn btn-basic " >대기</button></td>
							</c:when>
							<c:otherwise>
								<td><button type="button" class="btn btn-secondary" id="accept_${row.idx }" onClick="javascript:acceptThis(${row.idx});">수락</button></td>	
							</c:otherwise>
							</c:choose>
								<td><button type="button" class="btn btn-secondary" id="delete" onClick="javascript:deleteThis(${row.idx});">취소</button></td>
							</c:when>
						<c:otherwise>
							<td><button type="button" class="btn btn-danger" id="diary" onClick="javascript:openCalendar(${row.idx});">알림장</button></td>
							<td><button type="button" class="btn btn-danger" onClick="javacript:openComment(${row.idx});">후기</button></td>
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
function parentsView(idx){
	location.href="../advertisement/requestBoard_view?idx="+idx;
}

function sitterView(id) {
	location.href="../advertisement/SitterBoard_view?id="+id;
}
function openCalendar(idx_c){
	location.href="../mypage/openCalendar?idx="+idx_c;
}
function openComment(idx_c){
	var popupX = (window.screen.width / 2) - (500 / 2);
	var popupY= (window.screen.height / 2) - (500 / 2);
	window.open("../mypage/openComment?idx="+idx_c, "후기", 
	"width=500, height=500, toolbar=no, menubar=no, status=no, scrollbars=no, resizable=no, left="+ popupX + ", top="+ popupY);
}
function popInfo(id){
	var popupX = (window.screen.width / 2) - (300 / 2);
	var popupY= (window.screen.height / 2) - (300 / 2);
	window.open("../mypage/popInfo?id="+id, "개인정보", 
	"width=300, height=300, toolbar=no, menubar=no, status=no, scrollbars=no, resizable=no, left="+ popupX + ", top="+ popupY);
}
function deleteThis(idx_c){
	var cfm = confirm('목록에서 삭제하시겠습니까?');
	if(cfm){
		$.ajax({
			url : "../mypage/deleteAction",
			type : "GET",
			data : { 
				idx : idx_c,
				parents_id : $('#parents_id').val(),
				sitter_id : $('#sitter_id').val()
			},
			dataType : "json", 
			contentType : "text/html;charset:utf-8;",
			success : function(data){
				$('#box_'+idx_c).empty();
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
}
function acceptThis(idx_c){
	$.ajax({
		url : "../mypage/agreeAction",
		type : "GET",
		data : { 
			idx : idx_c
		},
		dataType : "json", 
		contentType : "text/html;charset:utf-8;",
		success : function(data){
			$('#agree_'+idx_c).val('T');
			$('#accept_'+idx_c).html('대기');
			alert(data.message);
		},
		error : function(){
			alert("다시 시도해 주세요.");
		}
	});
}
</script>
</html>
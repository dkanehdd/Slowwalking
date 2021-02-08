<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../links/linkOnly2dot.jsp"%>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script>
//아이디검색 추가 hjkosmo
$(function(){
	$('#id').click(function() {
		$.ajax({
			url : "./checkId", //요청할 경로
			type : "get", //전송방식
			//post방식일때의 컨텐츠 타입
			contentType : "text/html;charset:utf-8;",
			data : { //서버로 전송할 파라미터(JSON타입)
				phone : $('#phone').val()
			},
			dataType : "json", //콜백데이터의 형식
			success : function(d) { //콜백메소드
				if(d.ckeck==1){//중복일 때
					alert(d.message)
				}
				else{//사용가능
					alert(d.message)
				}
			},
			error : function(e) {
				alert("실패"+e);
			}
		});	
	});
}
</script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>느린걸음</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<%@ include file="../links/linkOnly2dot.jsp"%>
<style>
	body{
		background:#ddd url("../resources/images/diary.png") no-repeat 360px 15px;
		background-size:120px;
	}
	p {font-size: 14px;}
	.container {display:flex; flex-direction:column; justify-content:center; align-itmes:center;}
	.item {background:white; border-radius:10px; width:450px; height:100px; padding:15px; margin:5px 10px;}
	.noresize {resize:none; box-sizing: border-box; width:420px; margin-top:3px;
				border:1px solid #c0c0c0; border-radius: 10px;}
	.s-font { font-size: 12px; }
	#sitter{height:50px;}
	#textarea{height: 230px; border:none;}
	textarea:focus { outline:none !important;}	
	.itemT {border-radius:10px; width:450px; height:100px; padding:15px; margin:5px 10px; text-align:center;}
</style>
</head>
<body>
<div class="container">
	<input type="hidden" id="parents_id" value="${dto.parents_id }"/>
	<input type="hidden" id="sitter_id" value="${dto.sitter_id }"/>
	<input type="hidden" id="idx" value="${dto.idx }"/>
	<div class="itemT mt-5" style="text-align:left;">
		<h3 style="font-weight:700;">알림장</h3>
		<p class="s-font">${dto.parents_name } 님께 보내는 우리 아이의 하루<p>
	</div>
	<div class="item" id="sitter">
		<p>오늘의 선생님 : ${dto.sitter_name }</p>
	</div>
	<div class="item" id="textarea">
		<textarea class="noresize" rows="7" id="content" placeholder="내용을 입력해 주세요(최대 1000자)" style=" border:none;"></textarea></div>
	
	<!-- 버튼만들기 -->
	<div class="text-center mt-3">
		<button class="btn btn-secondary">취소하기</button>
		<button class="btn btn-danger" id="send" style="width: 200px;">보내기</button>
	</div>
</div>
</body>
<script>
$(function(){
	$('#content').on('keyup', function(){
	if($(this).val().length>1000){
		$(this).val($(this).val().substring(0,1000));
	}
	});
	$('#send').on('click', function(){
		var cfm = confirm('전송 후에는 수정이 불가합니다.');
		if(cfm){
		$.ajax({
			url: "../mypage/sendDiary",
			type: "GET",
			data : {
				idx : $('#idx').val(),
				parents_id : $('#parents_id').val(),
				sitter_id : $('#sitter_id').val(),
				content : $('#content').val()
			},
			dataType: "json",
			contentType : "text/html;charset:utf-8;",
			success : function(data){
				alert(data.message);
				 window.open("about:blank","_self").close();
			},
			error : function(){
				alert("다시 시도해 주세요.");
			}
		});
		}
		else{
			return;
		}
	})
});
</script>
</html>
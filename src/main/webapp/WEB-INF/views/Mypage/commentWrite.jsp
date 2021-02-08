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
</head>
<body>
<div class="container">
	<input type="hidden" id="parents_id" value="${dto.parents_id }"/>
	<input type="hidden" id="sitter_id" value="${dto.sitter_id }"/>
	<input type="hidden" id="idx" value="${dto.idx }"/>
	<input type="hidden" id="flag" value="${flag }"/>
	<input type="hidden" id="newrate" />
	<div class="item">
		<h3>후기 작성</h3>
		<c:choose>
			<c:when test="${flag eq 'sitter' }">
				<p class="s-font">${dto.parents_id } 님에 대한 후기를 작성해 보세요.<p>
			</c:when>
			<c:otherwise>
				<p class="s-font">${dto.sitter_id } 님에 대한 후기를 작성해 보세요.<p>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="i_item">
		<div class="starRev">
		  <span class="starR on" value="1"></span>
		  <span class="starR" value="2"></span>
		  <span class="starR" value="3"></span>
		  <span class="starR" value="4"></span>
		  <span class="starR" value="5"></span>
		</div>
	</div>
	<div class="item" id="textarea">
		<textarea class="noresize" rows="7" id="content" placeholder="내용을 입력해 주세요(최대 1000자)"></textarea></div>
	
	<!-- 버튼만들기 -->
	<div class="text-center mt-3">
		<button class="btn btn-warning" id="send">보내기</button>
		<button class="btn btn-secondary" onclick="javascript:self.close();">취소하기</button>
	</div>
</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	$('.starRev span').click(function(){
		  $(this).parent().children('span').removeClass('on');
		  $(this).addClass('on').prevAll('span').addClass('on');

		  var rate = $(this).attr("value");
		  $('#newrate').val(rate);
		  return false;
		});
});
$(function(){
	$('#send').on('click', function(){
		var cfm = confirm('작성을 완료하시겠습니까?');
		if(cfm){
		$.ajax({
			url: "../mypage/writeComment",
			type: "GET",
			data : {
				idx : $('#idx').val(),
				parents_id : $('#parents_id').val(),
				sitter_id : $('#sitter_id').val(),
				content : $('#content').val(),
				newrate : $('#newrate').val()
			},
			dataType: "json",
			contentType : "text/html;charset:utf-8;",
			success : function(){
				alert("작성이 완료되었습니다.");
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
	});
});
</script>
<style>
body{background:url(../resources/images/diary_back2.jpg)}
p {font-size: 14px;}
#sitter{height:50px;}
#textarea{height: 230px;}
.starR{
  background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
  background-size: auto 100%;
  width: 30px;
  height: 30px;
  display: inline-block;
  text-indent: -9999px;
  cursor: pointer;
}
.starR.on{background-position:0 0;}
.container {display:flex; flex-direction:column; justify-content:center; align-itmes:center;}
.item {background:white; border-radius:10px; width:450px; height:100px; padding:15px; margin:5px 10px;}
.i_item {background:white; border-radius:10px; width:450px; height:60px; padding:15px; margin:5px 10px;}
.noresize {resize:none; box-sizing: border-box; width:420px; margin-top:3px;
			border:1px solid #c0c0c0; border-radius: 10px;}
.s-font { font-size: 12px; }
</style>
</html>
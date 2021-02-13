<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1대화 닉네임 설정</title>
<%@ include file="../links/linkOnly2dot.jsp"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<link rel="stylesheet" href="../resources/webChat.js" />
</head>
<body>
<div class="container">
	<script>
	function chatWin(){
		var id = document.getElementById("chat_id");
		if(id.value==''){
			alert('채팅 닉네임을 입력후 채팅창을 열어주세요');
			id.focus();
			return;
		}
		var room = document.getElementById("chat_room");		
		window.open("webChatUI?chat_id="+id.value+"&chat_room="+room.value, 
				room.value+"-"+id.value,"width=350,height=490");
	
	}
	</script>
	<h2>1:1 채팅 문의</h2>
	<table border=1 cellpadding="10" cellspacing="0">
		<tr>
			<td>채팅방</td>
			<td>
				<select id="chat_room">
					<option value="myRoom1">느린하루 1:1 문의</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>회원아이디</td>
			<td>
				<input type="text" id="chat_id" placeholder="본인의 닉네임을 쓰세요" />
			</td>
		</tr>
		<tr>
			<td colspan="2" style="text-align:center;">
				<button type="button" onclick="chatWin();" class="btn btn-primary">채팅 시작</button>				
			</td>
		</tr>
	</table>

</div>
</body>
</html>
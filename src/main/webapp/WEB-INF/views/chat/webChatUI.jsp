<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 대화</title>
<%@ include file="../links/linkOnly2dot.jsp"%>
<link rel="stylesheet" href="../resources/css/chat_ui.css" />
<script src="../resources/js/webChat.js"></script>
<script type="text/javascript">


//webChatUI.jsp
var messageWindow;
var inputMessage;
var chat_id;
var WebSocket;
var logWindow;
var room;
var flag;
window.onload = function() {
	messageWindow = document.getElementById("messageWindow");
	messageWindow.scrollTop = messageWindow.scrollHeight;
	inputMessage = document.getElementById('inputMessage');
	chat_id = document.getElementById('chat_id').value;
	logWindow = document.getElementById('logWindow');
	room = document.getElementById('chat_room').value;
	
	//관리자이면 특정 회원에게 문의 응답을 할 수 있도록  하기 위해 flag을 가져옴
	$.ajax({
		url: "../member/getFlag",
		type: "GET",
		data: {
			id : $('#chat_id').val()
		},
		dataType: "json",
		contentType: "text/html;charset:utf-8",
		success: function(d){
			flag = d.flag;
			$('#flag').val(flag);
		},
		error: function(){
			alert("에러"+e);
		}
	});
	
	
	//	localhost:9090 포트번호는 맞춰서 수정 필요
	WebSocket = new WebSocket('ws://localhost:8080/slowwalking/EchoServer.do/' + room);
	WebSocket.onopen = function(event) {
		wsOpen(event);
	};
	WebSocket.onmessage = function(event) {
		wsMessage(event); 
	};
	WebSocket.onclose = function(event) {
		wsClose(event);
	};
	WebSocket.onerror = function(event) {
		wsError(event);
	};
}
function wsOpen(event) {
	writeResponse("연결성공");
}
function wsMessage(event) {
	var message = event.data.split("|");
	var sender = message[0];
	var msg;
	var flag = document.getElementById("flag");
	
	console.log(flag);
	//만약 보내는 사람이 admin이 아니라면 관리자에게만 문의가 갈수 있도록 한다.
	if(flag != "admin"){
		var content = "/kosmo" + message[1];
	}
	else{//만약 admin이라면 선택해서 보낼 수 있도록 한다.
		var content = message[1];
	}
	
	contentfirst = content.substr(0, 1);
	console.log("contentfirst : " + contentfirst);
	
	writeResponse(event.data);
	
	console.log("content : " + content);

	if (content == "/kosmo" || sender == "대화방에 연결 되었습니다.") {
		//날아온 내용이 없으므로 아무것도 하지않는다.
	}
	else {
		//내용에 / 가 있다면 귓속말이므로...
		if (contentfirst.match("/")) {
			if (content.match(("/kosmo"))){
				var temp = content.replace(("/kosmo"), "[문의]");
				
				//메세지에 UI를 적용하는 부분
				msg = makeBalloon(sender, temp);
				messageWindow.innerHTML += msg;

				//대화영역의 스크롤바를 항상 아래로 내려준다. 
				messageWindow.scrollTop = messageWindow.scrollHeight;
			}
			//해당 아이디(닉네임) 에게만 디스플레이 한다.
			else if (content.match(("/"))) {
				console.log("/kosmo로 들어옴? chat_id : " + chat_id);
				var temp = content.replace(("/" + chat_id), "[답변]");
				//메세지에 UI를 적용하는 부분
				msg = makeBalloon(sender, temp);
				messageWindow.innerHTML += msg;

				//대화영역의 스크롤바를 항상 아래로 내려준다. 
				messageWindow.scrollTop = messageWindow.scrollHeight;
			}
		}
		else {
			//귓속말이 아니면 모두에게 디스플레이 한다.
			msg = makeBalloon(sender, content);
			messageWindow.innerHTML += msg;
			//스크롤바 처리
			messageWindow.scrollTop = messageWindow.scrollHeight;
		}
	}
}
function wsClose(event) {
	writeResponse("대화 종료");
}
function wsError(event) {
	writeResponse("에러 발생");
	writeResponse(event.data);
}

//상대방이 보낸 메세지를 출력하기 위한 부분
function makeBalloon(id, cont) {
	var time = nowTime();
	var msg = '';
	msg =
		"<div class='othertalk' style='margin-top:10px;'>" +
		"<div class=\"profile_image\" style=\"background: url(../resources/img/profile_image.png) no-repeat;\">\n" +
		"</div>\n" +
		"<div class=\"box\">\n" +
		"<div class=\"profile_name\">33\n" +
		id + "\n" +
		"</div>\n" +
		"<div class=\"a\">\n" +
		"</div>\n" +
		"<div class=\"b\" style='padding:6px 8px 0px 5px;'>\n" +
		cont + "\n" +
		"</div>\n" +
		"<div class=\"time\">\n" +
		time + "\n" +
		"</div>\n" +
		"</div>\n" +
		"</div>\n";

	return msg;
}
function sendMessage() {
	//웹소켓 서버로 대화내용을 전송한다.  
	WebSocket.send(chat_id + '|' + inputMessage.value);

	//내가 보낸 내용에 UI를 적용한다. 
	var msg = '';
	var time = nowTime();
	//msg += '<div style="text-align:right;">'+inputMessage.value+'</div>';
	msg =
		"<div class='mytalk' style='margin-top:10px;'>" +
		"<div class=\"b\">\n" +
		"</div>\n" +
		"<div class=\"a\"  style='padding:6px 8px 0px 5px;'>\n" +
		inputMessage.value + "\n" +
		"</div>\n" +
		"<div class=\"time\">\n" +
		time + "\n" +
		"</div>\n" +
		"</div>\n";

	messageWindow.innerHTML += msg;
	inputMessage.value = "";

	//대화영역의 스크롤바를 항상 아래로 내려준다. 
	messageWindow.scrollTop = messageWindow.scrollHeight;
}
function enterkey() {
	/*
	키보드를 눌렀다가 땠을때 호출되며, 눌려진 키보드의 
	키코드가 13일때, 즉 엔터키일때 아래 함수를 즉시 호출한다. 
	*/
	if (window.event.keyCode == 13) {
		sendMessage();
	}
}
function writeResponse(text) {
	logWindow.innerHTML += "<br/>" + text;
}
function nowTime() {
	var d = new Date();
	var ampm = (d.getHours() >= 12 ? "PM" : "AM");
	var h = (d.getHours() > 12 ? d.getHours() - 12 : d.getHours());
	var m = d.getMinutes();

	return ampm + " " + h + ":" + m;
}
////webChatUI.jsp 끝

//webSocket.jsp
function chatWin() {
	var id = document.getElementById("chat_id");
	if (id.value == '') {
		alert('채팅 닉네임을 입력후 채팅창을 열어주세요');
		id.focus();
		return;
	}
	room = document.getElementById("chat_room");
	window.open("webChatUI?chat_id=" + id.value + "&chat_room=" + room.value,
		room.value + "-" + id.value, "width=350,height=490");

}
////webSocket.jsp끝
</script>
</head>
<body>
<input type="hid den" id="chat_id" value="${param.chat_id }" />
<input type="hid den" id="chat_room" value="${param.chat_room }" />
<input type="hid den" id="flag"/>
<div class="chat_ui" id="chat_ui_test" style="width: 320px; height: 480px;">
	<div class="msg" id="messageWindow"></div>
	<div class="sendmsg">
		<!-- 채팅창 -->
	    <textarea class="textarea" id="inputMessage" onkeyup="enterkey();"></textarea>
	    <!-- 버튼 -->
	    <div class="button" onclick="sendMessage();">
	 	   <p>전송</p>
	    </div>
	    <div class="clear"></div>
	</div>	
</div>
<div id="logWindow" class="fab" style="height:130px; overflow:auto;"></div> 
</body>
</html>
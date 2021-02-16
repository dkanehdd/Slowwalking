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
	var now = new Date();	// 현재 날짜 및 시간
	var date = now.getDate();	// 일
	console.log("일 : ", date);
	var hours = now.getHours();	// 시간
	console.log("시간 : ", hours);
	var minutes = now.getMinutes();	// 분
	console.log("분 : ", minutes);
	var milliseconds = now.getMilliseconds();	// 밀리초
	console.log("초 : ", milliseconds);
	if(chat_id == ""){
		console.log("시간으로 비회원에게 아이디 부여하는 로직");
		chat_id = date + ":" + hours + ":" + minutes + ":" + milliseconds;
		console.log("chat_id : " + chat_id);
	}
	
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
	
	//포트번호는 맞춰서 수정 필요
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
	var sender_flag;
	
	//관리자이면 특정 회원에게 문의 응답을 할 수 있도록  하기 위해 flag을 가져옴
	$.ajax({
		url: "../member/getFlag",
		async:false,//전역변수 저장을 위한 코드
		type: "GET",
		data: {
			id : sender
		},
		dataType: "json",
		contentType: "text/html;charset:utf-8",
		success: function(d){
			sender_flag=d.flag;
			console.log("첫번째 sender_flag : " + sender_flag);
		},
		error: function(){
			alert("에러"+e);
		}
	});
	
	console.log(flag);
	//만약 보내는 사람이 admin이 아니라면 관리자에게만 문의가 갈수 있도록 한다.
	if(flag != "admin"){
		if(sender_flag == "admin"){
			var content = message[1];
		}else{
			var content = "/kosmo" + message[1];
		}
	}
	else{//admin은 kosmo가 안붙은 상태로 전달받음
		var content = message[1];
	}
	
	contentfirst = content.substr(0, 1); //아이디 부분
	console.log("contentfirst : " + contentfirst);
	
	writeResponse(event.data);
	
	console.log("content : " + content);
	console.log("chat_id : " + chat_id);
	
	if (content == "/kosmo" || sender == "대화방에 연결 되었습니다.") {
		//날아온 내용이 없으므로 아무것도 하지않는다.
	}
	else {
		//내용에 / 가 있다면 귓속말이므로...
		if (contentfirst.match("/")) {
			//해당 아이디(닉네임) 에게만 디스플레이 한다.
			if (content.match(("/" + chat_id))) {
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
	console.log("id" + id);
	msg =
		"<div class='othertalk' style='margin-top:10px;'>" +
		"<div class=\"profile_image\" style=\"background: url(../resources/img/profile_image.png) no-repeat;\">\n" +
		"</div>\n" +
		"<div class=\"box\">\n" +
		"<div class=\"profile_name\">\n" +
		id + "\n" +
		"</div>\n" +
		"<div class=\"a\">\n" +
		"</div>\n" +
		"<div class=\"b\" style='padding:6px;'>\n" +
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
		"<div class=\"a\"  style='padding:6px;'>\n" +
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
		room.value + "-" + id.value, "width=350,height=490,toolbar=no,scrollbars=no,resizable=no");

}
////webSocket.jsp끝
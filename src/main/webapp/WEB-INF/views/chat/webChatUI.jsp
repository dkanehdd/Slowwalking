<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 상담</title>
<%@ include file="../links/linkOnly2dot.jsp"%>
<link rel="stylesheet" href="../resources/css/chat_ui.css" />
<script src="../resources/js/webChat.js"></script>
</head>
<body>
<!-- 전역 1:1 상담(관리자 <-> 유저(비회원, 회원) -->
<input type="hidden" id="chat_id" value="${param.chat_id }" />
<input type="hidden" id="chat_room" value="${param.chat_room }" />
<input type="hidden" id="flag"/>

<div class="chat_ui" id="chat_ui_test" style="width: 320px; height: 480px;">
	<div class="msg" id="messageWindow"></div>
	<div class="sendmsg">
		<!-- 채팅창 -->
	    <textarea class="textarea" id="inputMessage" onkeyup="enterkey();"></textarea>
	    <div class="button" onclick="sendMessage();">
	 	   <i class="fa fa-paper-plane" aria-hidden="true"></i>
	    </div>
	    <div class="clear"></div>
	</div>	
</div>
<div id="logWindow" class="fab" style="display:none;"></div> 
<c:if test="${flag eq 'admin' }">
	<p>특정 유저에게 답장할 시 유저명 앞에 '/'를 붙여 "/유저명 내용" 방식으로 메시지를 보냅니다. </p>
</c:if>
<!-- <script type="text/javascript"> -->
<!-- var logtxt; -->
<!-- // 모든 텍스트의 변경에 반응 -->
<!-- $("#logWindow").on("propertychange change keyup paste input", function() {   -->
<!-- 	// 현재 변경된 데이터 셋팅 -->
<!-- 	logtxt = document.getElementById('logWindow').value; -->
<!-- 	document.getElementById("logtxt").innerText = logtxt; -->
<!-- }); -->
<!-- </script> -->
</body>
</html>
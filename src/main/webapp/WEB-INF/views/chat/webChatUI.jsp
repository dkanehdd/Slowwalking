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
</head>
<body>
<input type="hidden" id="chat_id" value="${param.chat_id }" />
<input type="hidden" id="chat_room" value="${param.chat_room }" />
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
<div id="logWindow" class="border border-danger" style="height:130px; overflow:auto;"></div> 
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="../resources/css/chat_ui.css" />
<script src="../resources/js/webChat.js"></script>
<script>
    $(function() {        
        
        $("#topBtn").click(function() {
            $('html, body').animate({
                scrollTop : 0
            }, 400);
            return false;
        });
    });
</script>
<nav class="floating-menu">
	<ul class="main-menu">
		<li><a href="../advertisement/SitterBoard_list" class="ripple"><i class="fa fa-search" aria-hidden="true"></i><span>시터</span></a></li>
		<li><a href="../advertisement/requestBoard_list" class="ripple"><i class="fa fa-address-card" aria-hidden="true"></i><span>의뢰</span></a></li>
		<li><a href="../multiBoard/notice" class="ripple"><i class="fa fa-list" aria-hidden="true"></i><span>공지</span></a></li>
		<li><a href="../multiBoard/product" class="ripple"><i class="fa fa-ticket" aria-hidden="true"></i><span>이용권</span></a></li>
		<li><a href="../chat/websocket" onclick="window.open('../chat/websocket','1:1채팅','width=430,height=500'); return false;" class="ripple"><i class="fa fa-comments" aria-hidden="true"></i><span>1:1</span></a></li>
		<li><a id="topBtn" href="#" class="ripple"><i class="fa fa-arrow-up" aria-hidden="true"></i><span>TOP</span></a></li>
	</ul>
	<div class="menu-bg"></div>
</nav>
<a href="../chat/websocket" class="ripple fab"><i class="fa fa-comments" aria-hidden="true"></i></a>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.chatIcoContainer button{
		padding:0;
	}	
	.chatIcoContainer .chatIco{
		background-color: rgba(255, 127, 39, 0.7);
		border:none;
		border-radius: 50%;
		color: white;
		font-size: 30px;
		width: 50px;
		height: 50px;
		top: 90%;
	}
	.chatIcoContainer .chatIco:hover{
		transition: all ease 0.5s 0s;
		background-color: var(--secondary-color);
	}
	.chatIcoContainer .chatIco:active{
		transition: all ease 0.5s 0s;
		background-color: var(--primary-color);
	}
</style>
<script>
//chatStart()
  function chatStart() {

  	var id = document.getElementById("id").value;
  	console.log("chatWidget에서 감지한 id : " + id);
  	window.open("../chat/webchatui?chat_id="+id+"&chat_room=ask"
  	, id+"-문의" 
  	, "width=322,height=482, resizable=no, scrollbars=no, status=no, titlebar=no, toolbar=no");
  }
</script>
<!-- 채팅버튼 -->
<input type="hidden" value="${sessionScope.user_id }" id="id"/>
<div class="chatIcoContainer">
	<button href="#" class="floating-menu chatIco" onclick="chatStart()">
		<i class="fa fa-comments" aria-hidden="true"></i>
	</button>
</div>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%> 
<style>
#alert{
padding: 1px;
border-radius: 200px;
}
</style>
<!-- 알람 확인 -->
<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
		url : "../mypage/countInterview",
		type : "GET",
		dataType : "json",  
		contentType : "text/html;charset:utf-8;",
		success : function(data){
			if(data.interviewCount != 0){
				$('#alert').text(data.interviewCount);
				$('#alert').css('border', 'solid 3px red');
			}
		},
		error : function(){

		}
	});
})
</script>
<nav class="navbar navbar-expand-lg" style="user-select: none;">
   <div class="container">
      <a class="navbar-brand nonHover" href="../main/main" style="font-weight:700">
       <i class="fa fa-slideshare" aria-hidden="false" style="visibility: visible !important;"></i>&nbsp;느린걸음
      </a>
		<!--  <span class="icoSW"></span>&nbsp; -->
      <button class="navbar-toggler" type="button" data-toggle="collapse"
         data-target="#navbarNav" aria-controls="navbarNav"
         aria-expanded="false" aria-label="Toggle navigation">
         <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarNav">
         <ul class="navbar-nav ml-auto">
            <li class="nav-item"><a href="../advertisement/SitterBoard_list"
               class="nav-link smoothScroll">시터리스트</a></li>
            <li class="nav-item"><a href="../advertisement/requestBoard_list"
               class="nav-link smoothScroll">의뢰리스트</a></li>
            <li class="nav-item"><a href="../multiBoard/notice"
               class="nav-link">공지사항</a></li>
            <li class="nav-item"><a href="../multiBoard/product" class="nav-link">이용권</a>
            </li>
            <li class="nav-item"><a href="../multiBoard/FAQ" class="nav-link">FAQ</a>
            </li>
            <c:choose>
               <c:when test="${not empty sessionScope.user_id }">
                  <li class="nav-item"><a href="../member/mypage"
                  class="nav-link mypgBtn"><i class="fa fa-user" aria-hidden="true"></i>&nbsp; ${sessionScope.user_name }님의 마이페이지</a><div id="alert"></div></li>
                  <li class="nav-item"><a href="../member/logout"
                  class="nav-link contact ml-2">로그아웃</a></li>
               </c:when>
               <c:otherwise>
               		<li class="nav-item"><a href="../member/join"
                  class="nav-link mypgBtn"><i class="fa fa-user-plus" aria-hidden="true"></i>&nbsp; 회원가입</a></li>
                  <li class="nav-item"><a href="../member/login"
                     class="nav-link contact ml-2">로그인</a></li>
               </c:otherwise>
            </c:choose>
         </ul>
      </div>
	<!-- Side메뉴, 채팅 -->
	<%@ include file="../include/side.jsp"%>
	<%@ include file="../chat/chatWidget.jsp"%>
   </div>
</nav>
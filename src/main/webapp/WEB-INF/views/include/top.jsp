<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%> 
<style>
#alert{
	margin-left: 7px;
	width: 20px;
	height: 20px;
	border-radius: 50%;
	display: inline-block;
	background-color: #fff36d;
	color: var(--primary-color);
	text-align:center;
	font-size: 14px;
	font-weight: 600;
    -webkit-animation:blink .5s ease-in-out infinite alternate;
    -moz-animation:blink .5s ease-in-out infinite alternate;
    animation:blink .5s ease-in-out infinite alternate;
    }
    @-webkit-keyframes blink{
        0% {opacity:0;}
        100% {opacity:1;}
    }
    @-moz-keyframes blink{
        0% {opacity:0;}
        100% {opacity:1;}
    }
    @keyframes blink{
        0% {opacity:0;}
        100% {opacity:1;}
    }
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
				$("#alert").removeAttr("hidden");
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
                  class="nav-link mypgBtn"><i class="fa fa-user" aria-hidden="true">
                  </i>
                  <c:choose>
                  	<c:when test="${flag eq 'admin' }">
                  		&nbsp;관리자 페이지
                  	</c:when>
                  	<c:otherwise>
                  		&nbsp;${sessionScope.user_name }님의 마이페이지<span id="alert" class="ml-2" hidden></span>
                  	</c:otherwise>
                  </c:choose>
                  	</a></li>
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
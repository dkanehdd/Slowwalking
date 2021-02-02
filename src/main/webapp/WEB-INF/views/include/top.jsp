<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg">
   <div class="container">
      <a class="navbar-brand nonHover" href="../main/main"> <i
         class="fa fa-slideshare"></i> 느린걸음
      </a>

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
            <li class="nav-item"><a href="../multiBoard/FAQ" class="nav-link">FAQ</a>
            </li>
            <c:choose>
               <c:when test="${not empty sessionScope.user_id }">
                  <li class="nav-item"><a href="../member/mypage"
                  class="nav-link contact">${sessionScope.user_id }님의 마이페이지</a></li>
                  <li class="nav-item"><a href="../member/logout"
                  class="nav-link contact">로그아웃</a></li>
               </c:when>
               <c:otherwise>
                  <li class="nav-item"><a href="../member/login"
                     class="nav-link contact">로그인</a></li>
               </c:otherwise>
            </c:choose>
         </ul>
      </div>
   </div>
</nav>
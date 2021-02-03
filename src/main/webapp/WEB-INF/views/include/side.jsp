<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<li><a href="#" class="ripple"><i class="fa fa-cart-plus" aria-hidden="true"></i><span>샵</span></a></li>
		<li><a href="../" class="ripple"><i class="fa fa-comments" aria-hidden="true"></i><span>1:1</span></a></li>
		<li><a id="topBtn" href="#" class="ripple"><i class="fa fa-arrow-up" aria-hidden="true"></i><span>TOP</span></a></li>
	</ul>
	<div class="menu-bg"></div>
</nav>

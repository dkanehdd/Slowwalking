<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<%@ include file="../links/linkOnly2dot.jsp"%>
</head>
<body>
	<!-- Top메뉴 -->
	<%@ include file="../include/top.jsp"%>
	<section class="section-padding" style="background-color:#eee;">
		<div class="container"  data-aos="fade-up" data-aos-delay="400">
			<div class="form" style="width: 60%">				
			<div class="section_title">
				<h1 class="mb-5"><strong>Temporary Password</strong><br />임시 비밀번호 발급</h1>
			</div>
				<div>
					<input class='w50p' type="text" id="id" name="id" value="" 
					placeholder="아이디를 입력해주세요" title="아이디를 입력해주세요" required="required" autofocus>
					<input class='w50p' type="text" id="email" name="email" value=""
					pattern="/^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/" required="required" title="형식 : OOOO@OOOO.OOO"
					placeholder="이메일 주소를 입력해주세요">					
<!-- 					<label for="tempPwTxt">임시발급 비밀번호</label><div id="tempPwTxt" name="tempPwTxt" style="height:20px"></div> -->
				</div>
				<div class="btnBelow">
					<button type="button" class="btn btn-secondary btn-cc" onclick="location.href = '../main/main';">취소</button>
					<button type="button" id='tempPwBtn' class="btn btn-danger btn400w" style="width:200px; margin-left:5px;">임시 비밀번호 발급</button>
				</div>
			</div>
		</div>
	</section>
	<!-- Footer메뉴 -->
	<%@ include file="../include/footer.jsp"%>
	<script type="text/javascript">
	function checkIT() {
		var d=document.regiform;
		
		if(!d.id.value){ alert("아이디를 입력하세요"); d.id.focus();return false;}
		if(!d.email.value) { alert('이메일주소를 입력하세요'); d.email.focus();return false; }
	}
	$(function(){
		$('#tempPwBtn').on("click", function(){
			$.ajax({
				url: "../member/tempPwAction",
				type: "GET",
				data: {
					id : $('#id').val(),
					email : $('#email').val()
				},
				dataType: "json",
				contentType: "text/html;charset:utf-8",
				success: function(d){
					if(d.pw==null){
						alert("정보가 일치하는 계정이 없습니다.\n입력란을 확인해주세요");
					}
					else{
						var result=confirm("임시 비밀번호가 발급되었습니다. "+$('#email').val()+" 메일을 확인해주세요\n확인 버튼을 누르시면 로그인 페이지로 이동합니다.");
						if(result){ //alert창 확인버튼
							document.location = '../member/login';
						}
						else{ //alert창 취소버튼
							alert("다시 시도해주세요");
						}
					}
				},
				error: function(){
					alert("에러"+e);
				}
			});
		});
	});
	
	
	</script>
</body>
</html>
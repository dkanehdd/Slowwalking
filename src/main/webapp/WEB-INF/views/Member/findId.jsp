<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<style>
	#findBtn{
		background-color:var(--primary-color);
		border-color: var(--secondary-color);
	}
	#findBtn:hover{
		background-color:var(--secondary-color);
		border-color: var(--primary-color);
	}
</style>
<%@ include file="../links/linkOnly2dot.jsp"%>
</head>
<body>
	<!-- Top메뉴 -->
	<%@ include file="../include/top.jsp"%>
	<section class="section-padding" style="background-color:#eee;">
		<div class="container" data-aos="fade-up" data-aos-delay="400">
			<div class="form" style="width: 60%">				
			<div class="section_title">
				<h1 class="mb-5"><strong>Find ID</strong> 아이디 찾기</h1>
			</div>
				<div>
					<input class='w50p' type="text" id="name" name="name" value="" 
					placeholder="이름을 입력해주세요" required autofocus>
					<input class='w50p' type="text" id="phone" name="phone" value=""
					maxlength='11' pattern="(010)\d{3,4}\d{4}" title="형식  01000000000"
					placeholder="휴대폰번호를 입력해주세요" required>
				</div>
				<div class="btnBelow">
					<button type="button" class="btn btn-secondary btn-cc" onclick="location.href = '../main/main';">취소</button>
					<button type="button" id='findBtn' class="btn btn-danger btn400w" style="width:200px; margin-left:5px;">아이디 찾기</button>
				</div>
			</div>
		</div>
	</section>
	<!-- Footer메뉴 -->
	<%@ include file="../include/footer.jsp"%>
	<script type="text/javascript">
	$(function(){
		$('#findBtn').on("click", function(){
			$.ajax({
				url: "../member/findIdAction",
				type: "GET",
				data: {
					name : $('#name').val(),
					phone : $('#phone').val()
				},
				dataType: "json",
				contentType: "text/html;charset:utf-8",
				success: function(d){
					if(d.id!=null){
						confirm("회원님의 ID는 [ "+d.id+" ] 입니다");
						document.location = '../member/temppw';
					}
					else{
						alert("ID를 찾지 못했습니다.")
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.joinFrm{
   padding:25px;
}
.joinFrm button{
   height:160px;
   border: 0px;
   border-radius:5px;
   background-color:var(--primary-color);
   color:var(--white-color);
   display:block;
}

.joinFrm button:hover{
   color:var(--white-color);
   text-decoration:none;
   background-color:var(--secondary-color);
}
.joinFrm button i{
   margin-bottom:10px;
   font-size:4em;
   display:block;
   margin-bottom:20px;
}
.joinFrm button span{
   font-size:1.1em;
}


</style>

<script type="text/javascript">
function kakaoaction(flag) {
   var f = document.regiform;
   f.flag.value = flag;
   f.submit();
}

</script>
<%@ include file="../links/linkOnly2dot.jsp"%>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<title>회원가입 선택</title>
</head>
<body>
	<!-- Top메뉴 -->
	<%@ include file="../include/top.jsp"%>
	<section class="section-padding" style="background-color:#eee;">
		<div class="container">
			<div class="section_title">
				<h1 class="mb-5"> <img alt="" src="https://upload.wikimedia.org/wikipedia/commons/thumb/d/de/Kakao_CI_yellow.svg/1200px-Kakao_CI_yellow.svg.png"
				width="200px" height="70px">&nbsp;가입하기</h1>
				
				<c:url value="/member/joinAction" var="joinURL" />
				<form:form action="${joinURL }" name="regiform" method="post"
				onsubmit="return checkIT();"  data-aos="fade-up" data-aos-delay="400">
				<table class="table form joinF">
					<colgroup>
						<col style="width: 20%">
						<col style="">
					</colgroup>
					<input type="hidden" id="smsck" value="" />
					<input type='hidden' name='flag' id='idchktype' value="${flag }">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
					<input type="hid-den" name="id" value="${memberDTO.id }" />
					<input type="hid-den" name="email" value="${memberDTO.email }" />
					<input type="hid-den" name="pw" value="slowwalking!@#$" />
						
						<p>추가정보를 입력해주세요<p>
											
					<tr>
						<th scope="row" style="vertical-align:middle;">휴대폰</th>
						<td><input type="text" name="phone" id='phone' value=""
							maxlength='11' class='w50p' placeholder="휴대폰번호"> <input
							type="hidden" name="hpyn" value="Y" id="hpyn1" checked>
							<div style='display: inline-block;'>
							<button type="button" id='sendPhoneNumber' class="btn btn-primary" style="margin-left:5px;">본인인증</button>
							</div>

							<div style='display: none;' id="phonecheck">
								<input type="text" name="userida" id='inputCertifiedNumber'
									maxlength="6" value="">
								<button type="button" id='checkBtn' class="btn btn-primary" style="margin-left:5px;">확인</button>
							</div></td>
					</tr>
						<th scope="row" style="vertical-align:middle;">이름</th>
						<td><input type="text" name="name" id="name" value="">
							<div style="display:inline; margin-left: 5px;">
								<label for="radio-1">남</label> <input type="radio" name="gender"
								id="radio-1" value="남" checked> <label for="radio-2">여</label>
								<input type="radio" name="gender" id="radio-2" value="여">
							</div>
						</td>
					</tr>
					<input type="hidden" name="email" id="email" value="" />
					<tr>
						<th style="vertical-align:middle;">생년월일</th>
						<td><input type="text" name="birthday" id="birthday" value="" />
						</td>
					</tr>					
				</table>
			</form:form>
				
				
				
				
				
				
				
			</div>
			<div class="input-group mb-3" data-aos="fade-up" data-aos-delay="400">
				<div class="form joinFrm">
					<button class="float-left" style="width: 200px" onclick="kakaoaction('parents');"><i class="fa fa-users" aria-hidden="true"></i>부모회원으로 가입하기</button>
					<button class="float-right" style="width: 200px" onclick="kakaoaction('sitter');"><i class="fa fa-address-card" aria-hidden="true"></i>시터회원으로 가입하기</button>

					
					
				</div>
			</div>
		</div>
	</section>

	<!-- Footer메뉴 -->
	<%@ include file="../include/footer.jsp"%>
</body>
<%@ include file="../links/joinJs.jsp"%> 
</html>
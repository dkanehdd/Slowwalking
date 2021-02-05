<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<%@ include file="../links/linkOnly2dot.jsp"%>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script type="text/javascript">
//네이버 로그인 추가 (민우)
function naveraction(flag) {
	var f = document.regiform;
	f.flag.value = flag;
	f.submit();
}
</script>
<style type="text/css">
.joinFrm{
	padding:25px;
}
.joinFrm button{
	height:160px;
	border:0;
	border-radius:5px;
	background-color:var(--primary-color);
	color:var(--white-color);
	display:inline;
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
</head>
<body>
<!-- Top메뉴 -->
	<%@ include file="../include/top.jsp"%>
	<section class="section-padding" style="background-color: #eee;">
		<div class="container">
			<div class="section_title">
				<h1 class="mb-5"><img src="https://mblogthumb-phinf.pstatic.net/20130923_269/afi2007_1379907753497OcgVN_PNG/naver.png?type=w2" alt="" /> 추가정보입력</h1>
			</div>
			<c:url value="/member/joinAction" var="joinURL" />
			<form:form action="${joinURL }" name="regiform" method="post"
				 data-aos="fade-up" data-aos-delay="400">
				<table class="table form joinF">
					<colgroup>
						<col style="width: 20%">
						<col style="">
					</colgroup>
					<input type='hid`den' name='flag' id='idchktype' value="">
					<input type="hid`den" name="id"  value="${dto.id }" />
					<input type="hid`den" name="pw"  value="${dto.pw }" />
					<input type="hid`den" name="gender"  value="${dto.gender }" />
					<input type="hid`den" name="name"  value="${dto.name }" />
					<input type="hid`den" name="phone"  value="${dto.phone }" />
					<input type="hid`den" name="email"  value="${dto.email }" />
					<tr>
						<th style="vertical-align:middle;">생년월일</th>
						<td><input type="text" name="birthday" id="birthday" value="" />
						</td>
					</tr>
				</table>
				<div class="input-group mb-3" data-aos="fade-up" data-aos-delay="400">
					<div class="form joinFrm">
						<button class="float-left" style="width: 200px" onclick="naveraction('parents');"><i class="fa fa-users" aria-hidden="true"></i>부모회원으로 가입하기</button>
						<button class="float-right" style="width: 200px" onclick="naveraction('sitter');"><i class="fa fa-address-card" aria-hidden="true"></i>시터회원으로 가입하기</button>
					</div>
				</div>
			</form:form>
		</div>
	</section>
	<%@ include file="../include/footer.jsp"%>
</body>
<%@ include file="../links/joinJs.jsp"%> 
</html>
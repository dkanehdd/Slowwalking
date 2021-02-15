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
</head>
<body>
<!-- Top메뉴 -->
	<%@ include file="../include/top.jsp"%>
	<section class="section-padding" style="background-color: #eee;">
		<div class="container">
			<div class="section_title">
				<h1 class="mb-5"><strong>JOIN</strong> 회원가입</h1>
			</div>
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
					<tr>
						<th scope="row" style="vertical-align:middle;">아이디</th>
						<td><input type="text" name="id" id='id' value=""
							 class='w50p' placeholder="아이디"
							 pattern="^([a-z0-9_]){4,12}" required="required" 
							 title="4자 이상 12자 이내의 영문/숫자 조합">
							<div style="display: none;" id="idCheck" >
							</div></td>
					</tr>
					<tr>
						<th scope="row" style="vertical-align:middle;">이름</th>
						<td><input type="text" name="name" id="name" value=""
							>
							<div style="display:inline; margin-left: 5px;">
								<label for="radio-1">남</label> <input type="radio" name="gender"
								id="radio-1" value="남" checked> <label for="radio-2">여</label>
								<input type="radio" name="gender" id="radio-2" value="여">
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row" style="vertical-align:middle;">비밀번호</th>
						<td><input type="password" name="pw" id='pw'
							onblur="checkPw(this.value);" pattern="^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*()_-+=[]{}~?:;`|/]).{4,12}$" required="required" title="4자 이상 12자 이내의 영문/숫자/특수문자 조합" >&nbsp;&nbsp;<span id="pw1">*
								4자 이상 12자 이내의 영문/숫자/특수문자 조합</span></td>
					</tr>
					<tr>
						<th style="vertical-align:middle;">비밀번호 확인</th>
						<td><input type="password" name="pass2" value=""
							class="join_input" onblur="checkPw2(this.value);" />&nbsp;&nbsp;<span
							id="pw2" hidden>* 비밀번호가 일치하지 않습니다.</span></td>
					</tr>
					<tr>
						<th style="vertical-align:middle;">이메일</th>
						<td><input type="text" name="email1" id="email1" value=""/> @ 
						<input type="text" name="email2" id="email2"
							value="" style="width:150px;"/> <select name="last_email_check2"
							onChange="emailSelect(this);" 
							style="width:150px; margin-left:5px; display:inline-block;" 
							class="pass form-control flaot-right" id="last_email_check2">
								<option selected="" value="">선택해주세요</option>
								<option value="gmail.com">gmail.com</option>
								<option value="hanmail.net">hanmail.net</option>
								<option value="naver.com">naver.com</option>
								<option value="hotmail.com">hotmail.com</option>
								<option value="">직접입력</option>
						</select>
						<button type="button" id='emailChk' class="btn btn-primary" style="margin-left:5px; vertical-align: top;">중복확인</button>
						</td>
					</tr>
					<input type="hidden" name="email" id="email" value="" />
					<tr>
						<th style="vertical-align:middle;">생년월일</th>
						<td><input type="text" name="birthday" id="birthday" value="" />
						</td>
					</tr>
					<tr>
						<th style="vertical-align:middle;">약관</th>
						<td>
							<div class="form-group">
								<form action="" id="joinForm">
									<input class="checkbox" type="checkbox" name="chkAll" id="chkAll">
									<label for="chkAll">전체동의</label><br>
									
									<div class="termsBox">
										<div>
											<input class="checkbox" type="checkbox" name="chk1" id="chk1">
											<label for="chk1">이용 약관(필수)</label><br>
											<textarea class="form-control noresize" name="" id="">이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. 이용 약관 입니다. </textarea><br>
										</div>
										<div>
											<input class="checkbox" type="checkbox" name="chk2" id="chk2">
											<label for="chk2">개인정보 수집 및 이용에 대한 안내(필수)</label><br>
					       					<textarea class="form-control noresize" name="" id="">개인정보 수집 및 이용에 대한 안내 입니다. 개인정보 수집 및 이용에 대한 안내 입니다. 개인정보 수집 및 이용에 대한 안내 입니다. 개인정보 수집 및 이용에 대한 안내 입니다. 개인정보 수집 및 이용에 대한 안내 입니다. 개인정보 수집 및 이용에 대한 안내 입니다. 개인정보 수집 및 이용에 대한 안내 입니다. 개인정보 수집 및 이용에 대한 안내 입니다. 개인정보 수집 및 이용에 대한 안내 입니다. 개인정보 수집 및 이용에 대한 안내 입니다. 개인정보 수집 및 이용에 대한 안내 입니다. 개인정보 수집 및 이용에 대한 안내 입니다. 개인정보 수집 및 이용에 대한 안내 입니다. 개인정보 수집 및 이용에 대한 안내 입니다. 개인정보 수집 및 이용에 대한 안내 입니다. 개인정보 수집 및 이용에 대한 안내 입니다. 개인정보 수집 및 이용에 대한 안내 입니다. 개인정보 수집 및 이용에 대한 안내 입니다. 개인정보 수집 및 이용에 대한 안내 입니다. 개인정보 수집 및 이용에 대한 안내 입니다. 개인정보 수집 및 이용에 대한 안내 입니다. 개인정보 수집 및 이용에 대한 안내 입니다. 개인정보 수집 및 이용에 대한 안내 입니다. 개인정보 수집 및 이용에 대한 안내 입니다. </textarea>
										</div>
									</div>
								</form>
							</div>
						</td>
					</tr>
				</table>
				<div class="btnBelow">
					<button type="button" class="btn btn-secondary btn-cc" onclick="location.href = '../main/main';">취소</button>
					<button type="submit" id="submitBtn" class="btn btn-danger">회원가입</button>
				</div>
			</form:form>
		</div>
	</section>
	<%@ include file="../include/footer.jsp"%>
</body>
<%@ include file="../links/joinJs.jsp"%> 
</html>
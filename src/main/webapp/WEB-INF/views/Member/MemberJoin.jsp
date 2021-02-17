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
							pattern="([^가-힣])">
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
											<textarea class="form-control noresize" name="" id="">서비스 이용 약관&#10;제 1조 (목적)&#10; 이 약관은 (주)느린걸음(이하 "회사")이 운영하는 느린걸음 사이트 및 어플리케이션(이하 "사이트"를 통하여 제공하는 돌봄 서비스(이하 "서비스")와 관련하여 회사와 회원간의 권리와 의무, 책임, 서비스 이용 절차 및 기타 필요한 사항을 규정함을 목적으로 합니다. &#10;제 2조(약관의 명시와 설명 및 개정)&#10; 1. 회사는 「약관의 규제 등에 관한 법률」, 「전자거래 기본법」, 「전자서명법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」, 「전자상거래 등에서의 소비자보호에 관한 법률」, 「소비자기본법」 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.&#10; 2. 회사가 약관을 개정할 경우에는 사이트의 메인화면에 최소 적용 일자 7일 전부터 이 사실을 공지합니다. &#10; 3. 이 약관에서 장하지 아니한 사항과 이 약관의 해석에 관하여는 정부가 제정한 전자거래소비자보호지침 및 관계법령 또는 일반상관례에 따릅니다.&#10;제 3조 (회원 탈퇴 및 자격 상실)&#10; 1. 회원은 언제든지 탈퇴가 가능하며 요청된 즉시 서비스가 종료됩니다.&#10; 2. 회원이 다음 각호의 사유에 해당하는 경우 회사는 회원자격을 제한 및 정지시킬 수 있습니다.&#10;  (1) 가입 신청 시에 허위 내용을 등록한 경우&#10;  (2) 서비스 이용료 등 서비스의 이용과 관련하여 부담하는 채무를 기일에 지급하지 않는 경우&#10;  (3) 다른 사람의 서비스 이용을 방해하는 등의 경우&#10;  (4) 서비스를 이용하여 법령 또는 공서양속에 반하는 행위를 하는 경우&#10;  (5) 본 약관을 준수하지 않는 경우&#10;  (6) 회원이 회원가입 시 기재한 전화번호를 통하여 확정된 서비스 일시에 연락을 시도하였음에도 불구하고 일체의 응대가 진행되지 않아 정상적인 서비스 이용계약의 이행이 불가한 상태가 발생한 경우&#10; 3. 부모 회원이 다음 각 호의 사유로 회사의 영업을 방해할 경우 회사는 회원 자격을 제한 및 정지시킬 수 있습니다.&#10;  (1) 매칭된 서비스에 동석한 양육자 및 보호자가 시터에게 반말을 하거나 무례하게 행동한 경우가 3회 이상 보고된 경우&#10;  (2) 양육자 및 보호자가 시터에게 가사 업무나 학습 등 계약된 내용을 벗어난 업무를 요구한 경우가 3회 이상 보고된 경우&#10; 4. 시터 회원이 다음 각 호의 사유로 회사의 영업을 방해할 경우 회사는 회원 자격을 제한 및 정지시킬 수 있습니다.&#10;  (1) 이미 매칭된 계약을 파기한 건이 3회 이상 지속될 경우&#10;  (2) 계약한 서비스 시간에 사전 고지 없이 방문하지 않은 경우</textarea><br>
										</div>
										<div>
											<input class="checkbox" type="checkbox" name="chk2" id="chk2">
											<label for="chk2">개인정보 수집 및 이용에 대한 안내(필수)</label><br>
					       					<textarea class="form-control noresize" name="" id="">개인정보의 수집 및 이용 동의서&#10; (주)느린걸음은 개인 정보 보호 정책에 의거하여 개인 정보를 보호하기 위해 최선을 다할 것을 약속드립니다. 이하 내용은 "개인정보 보호법" 및 "정보통신망 이용 촉진 및 정보 보호 등에 관한 법률" 등 개인 정보 보호에 관한 규정들을 준수합니다. 사용자가 제공한 모든 정보는 다음의 목적을 위해 활용하며, 하기 목적 이외의 용도로는 사용되지 않습니다.&#10; ① 개인정보 수집 항목 및 수집·이용 목적&#10; 가) 수집 항목&#10; (필수항목)성명(국문), 주민등록번호, 전화번호(휴대전화), 사진, 이메일, 나이, 생년월일, 구직의뢰서 혹은 신청서에 기재된 정보 또는 웹/앱 내의 회원이 제공한 모든 정보&#10; 나) 수집 및 이용 목적&#10; 본인 식별 및 본인 의사 확인, 회원제 서비스 관리, 웹사이트 및 앱 서비스 제공&#10; ② 개인정보 보유 및 이용기간&#10; 수집·이용 동의일로부터 회원 탈퇴시까지&#10; ③ 동의거부관리&#10; 귀하께서는 본 안내에 따른 개인정보 수집, 이용에 대하여 동의를 거부하실 권리가 있습니다. 다만, 귀하가 개인정보의 수집 및 이용에 동의하는 것을 거부하시는 경우 '느린걸음' 사이트 혹은 어플리케이션 이용이 불가함을 알려드립니다. (개인 정보 보호법 제 15조 제 2항 4호)</textarea>
										</div>
									</div>
								</form>
							</div>
						</td>
					</tr>
				</table>
				<div class="btnBelow">
					<button type="button" class="btn btn-secondary btn-cc" onclick="location.href = '../main/main';">취소</button>
					<button type="submit" id="submitBtn" class="btn btn-danger btn400w">회원가입</button>
				</div>
			</form:form>
		</div>
	</section>
	<%@ include file="../include/footer.jsp"%>
</body>
<%@ include file="../links/joinJs.jsp"%> 
</html>
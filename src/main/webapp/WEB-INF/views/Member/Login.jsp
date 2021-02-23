<%@page import="java.math.BigInteger"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
 <%
    String clientId = "MMNYqKIa7wxHjRIOOA6z";//애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://localhost:8080/slowwalking/naver/callback", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL ="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=MMNYqKIa7wxHjRIOOA6z&redirect_uri=";
    apiURL += redirectURI;
    apiURL += "&state="+state;
    session.setAttribute("state", state);
 %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<%@ include file="../links/linkOnly2dot.jsp"%>
<script src="${contextPath}/resources/js/js.cookie.js"></script>
<title>Login.jsp</title>

</head>
<body>
	<!-- Top메뉴 -->
	<%@ include file="../include/top.jsp"%>

	<section class="section-padding" style="background-color:#eee;">
		<div class="container">
			<c:url value="/loginAction" var="loginUrl" />
			<form:form name="loginFrm" action="${loginUrl}" method="post">
				<div class="loginContainer input-group mb-3" data-aos="fade-up" data-aos-delay="400">
					<div class="form" style="padding: 60px 100px 100px 100px;">
						<div class="lct_logo">
							<i class="fa fa-slideshare" style="margin:0; padding:0;"></i>
							<span style="color:var(--primary-color); font-size:20px; display:block; font-weight:700;">느린걸음</span>
						</div>				
						<div class="lc_top">							
							<c:if test="${param.error != null }">
								<p class="errTxt">아이디 또는 패스워드가 잘못되었습니다.</p>
							</c:if>
							<c:if test="${param.login != null }">
								<p>로그아웃 하였습니다.</p>
							</c:if>
						</div>		
						<input type="text" class="form-control" id="id" name="id" value="" placeholder="아이디" /> 
						<input type="password" class="form-control" name="pass" value="" placeholder="비밀번호"/>
						<button type="submit" class="btn btn-danger">로그인</button><br>
						<div class="form-check labelInpAlign">
							<input type="checkbox" id="idSave" name="idSave" class="clear form-check-input"/>
							<label for="idSave" class="form-check-label" style="position: relative; top:-2.5px;	">아이디 저장</label>
						</div>
					<ul>
						<li><a href="../member/findid" id="findId" name="findId" >아이디 찾기</a></li>
	                    <li><a href="../member/temppw" id="findPw" name="findPw" >비밀번호 찾기</a></li>
	                    <li class="non-af"><a href="../member/join" id="signUp" name="signUp">회원가입</a></li> 
					</ul>
					<a href="<%=apiURL%>"><img src="../img/naverlogin.png" style="width:100%; margin-bottom:5px;"/></a>
					<a href="https://kauth.kakao.com/oauth/authorize?client_id=e1bfbd13b698ee8d3ecba1e269ed3918&redirect_uri=http://localhost:8080/slowwalking/kakao/callback&response_type=code">
						<img alt="" src="../img/kakao.png" style="width:100%;"><!-- "height:60px; width:256px " -->
						</a>
					</div>
				</div>
				
			</form:form>
		</div>
	</section>	
	<!-- Js -->
	<script type="text/javascript">	
    $(document).ready(function(){
        var userInputId = getCookie("userInputId");//저장된 쿠기값 가져오기
        $("input[name='id']").val(userInputId); 
         
        if($("input[name='id']").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩
                                               // 아이디 저장하기 체크되어있을 시,
            $("#idSave").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
        }
         
        $("#idSave").change(function(){ // 체크박스에 변화가 발생시
            if($("#idSave").is(":checked")){ // ID 저장하기 체크했을 때,
                var userInputId = $("input[name='id']").val();
                setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
            }else{ // ID 저장하기 체크 해제 시,
                deleteCookie("userInputId");
            }
        });
         
        // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
        $("input[name='id']").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
            if($("#idSave").is(":checked")){ // ID 저장하기를 체크한 상태라면,
                var userInputId = $("input[name='id']").val();
                setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
            }
        });
    });
     
    function setCookie(cookieName, value, exdays){
        var exdate = new Date();
        exdate.setDate(exdate.getDate() + exdays);
        var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
        document.cookie = cookieName + "=" + cookieValue;
    }
     
    function deleteCookie(cookieName){
        var expireDate = new Date();
        expireDate.setDate(expireDate.getDate() - 1);
        document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
    }
     
    function getCookie(cookieName) {
        cookieName = cookieName + '=';
        var cookieData = document.cookie;
        var start = cookieData.indexOf(cookieName);
        var cookieValue = '';
        if(start != -1){
            start += cookieName.length;
            var end = cookieData.indexOf(';', start);
            if(end == -1)end = cookieData.length;
            cookieValue = cookieData.substring(start, end);
        }
        return unescape(cookieValue);
    }
	</script>
	<!-- Footer메뉴 -->
	<%@ include file="../include/footer.jsp"%>
</body>
</html>
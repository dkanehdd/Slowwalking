<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script>
//현재 비밀번호 확인
function pwValidate(fn){
	
	var pw = "${dto.pw}";
	
	if(fn.oriPw.value!=pw){
		alert("비밀번호가 일치하지 않습니다.");
		fn.oriPw.focus();
		return false;
	}
}
function emailSelect(obj) {
	var email1 = document.getElementById("email1");
    var domain = document.getElementById("email2");
    if (obj.value == "") {
        domain.readOnly = false;
        domain.value = "";
        domain.focus();
    } else {
        domain.readOnly = true;
        domain.value = obj[obj.selectedIndex].value;
        $('#email').val(email1.value+'@'+domain.value);
    }
}
//비밀번호 확인 
function checkPw2(pw) {
    var f = document.editFrm;
    var pw1 = f.pw.value;
    var pw2 = document.getElementById("pw2");
    if (pw1 != pw) {
        pw2.hidden = false;
        pw2.style.color = "red";
        return true;
    } else {
        pw2.hidden = "hidden";
        return false;
    }
}

function checkPw(pw) {
    var pw1 = document.getElementById("pw1");
    var f1 = true,
        f2 = true,
        f3 = true;
    if (pw.length >= 4 && pw.length <= 12) {
        for (var i = 0; i < pw.length; i++) {
            if (pw.charCodeAt(i) >= 48 && pw.charCodeAt(i) <= 57) {
                f1 = false;
            } else if ((pw.charCodeAt(i) >= 65 && pw.charCodeAt(i) <= 90) ||
                (pw.charCodeAt(i) >= 97 && pw.charCodeAt(i) <= 122)) {
                f2 = false;
            } else {
                switch (pw.charCodeAt(i)) {
                    case 33:
                    case 63:
                    case 42:
                    case 35:
                    case 64:
                    case 36:
                    case 37:
                    case 94:
                    case 38: {
                        f3 = false;
                        break;
                    }
                    default:
                        f3 = true;
                }
            }
//             console.log(i);
        }
        if (f1 == false && f2 == false && f3 == false) {
            isN = false;
        } else {
            isN = true;
        }
    } else {
        isN = true;
    }
    if (isN) {
        pw1.style.color = "red";
        return true;
    } else {
    	pw1.style.color = "#A59683";
        return false;
    }
}
$(function(){
	
	$("input[type=radio]").checkboxradio({
        icon: false
    });
	$('#sendPhoneNumber').click(function() {
		var phoneNumber = $('#phone').val();
		if(phoneNumber.length<11){
			Swal.fire('메세지 전송 실패','휴대폰번호를 정확히 입력해주세요','error');
			return;
		}
		Swal.fire('인증번호 발송 완료!');
		$.ajax({
			type : "GET",
			url : "../check/sendSMS",
			data : {
				"phoneNumber" : phoneNumber
			},
			success : function(res) {
				$('#phonecheck').css('display','block');
				$('#checkBtn').click(function() {
					if ($.trim(res) == $('#inputCertifiedNumber').val()) {
						Swal.fire('인증성공!', '휴대폰 인증이 정상적으로 완료되었습니다.', 'success');
						$('#phonecheck').css('display','none');
						$('#phone').attr("readonly",true);
						// 인증성공후 요청명 기입
						//location.href='regiform'
					} else {
						Swal.fire({
							icon : 'error',
							title : '인증오류',
							text : '인증번호가 올바르지 않습니다!',
						})
					}
				})

			},
			error : function(e) {
				Swal.fire('메세지 전송 실패',e,'error');
			}
		})
	});
	$("#phone").keyup(function (event) {
		regexp = /[^0-9]/gi;
		v = $(this).val();
			if (regexp.test(v)) {
				alert("숫자만 입력가능 합니다.\n-(하이픈)을 제외한 숫자만 입력하여 주세요.");
				$(this).val(v.replace(regexp, ''));
	        }
	    }
	);
	$("#phone").on('keydown', function(e){
	var trans_num = $(this).val().replace(/-/gi,'');
	var k = e.keyCode;						
		if(trans_num.length >= 11 && ((k >= 48 && k <=126) || (k >= 12592 && k <= 12687 || k==32 || k==229 || (k>=45032 && k<=55203)) )){
			e.preventDefault();
		}
	}).on('blur', function(){
		if($(this).val() == '') return;
		var trans_num = $(this).val().replace(/-/gi,'');
		if(trans_num != null && trans_num != ''){
			if(trans_num.length==11 || trans_num.length==10) {   
				var regExp_ctn = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/;
				if(regExp_ctn.test(trans_num)){
					trans_num = trans_num.replace(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/, "$1$2$3");                  
					$(this).val(trans_num);
				}
				else{
					alert("유효하지 않은 휴대폰번호 입니다.");
					$(this).val("");
					$(this).focus();
				}
			}
			else {
				alert("유효하지 않은 휴대폰번호 입니다.");
				$(this).val("");
				$(this).focus();
			}
	  	}
  	});  
	
});


</script>
</head>
<body>
<div class="col-10">
<h3>회원정보수정</h3>
</div>
<div class="container">
<form action="./proEditAction" method="post" name="editFrm" onsubmit="return pwValidate(this);"
	enctype="multipart/form-data">
<table class="table">
	<tbody>
		<tr>
			<th>이름</th>
			<td><input type="text" id="${dto.name }" value="${dto.name }" readonly/></td>
		</tr>
		<tr>
			<th>현재 비밀번호</td>
			<td><input type="password" name="oriPw"/></td>
		</tr>
		<tr>
			<th>새 비밀번호</th>
			<td><input type="password" name="newPw1" id="pw" onblur="checkPw(this.value);" >&nbsp;&nbsp;<span id="pw1">* 4자 이상 12자 이내의 영문/숫자/특수문자 조합</span></td>
		</tr>
		<tr>
			<th>비밀번호 확인</th>
			<td><input type="password" name="newPw2" value="" class="join_input" onblur="checkPw2(this.value);" />&nbsp;&nbsp;<span id="pw2" hidden>* 비밀번호가 일치하지 않습니다.</span></td>
		</tr>
		<tr>
			<th scope="row">휴대폰</th>
			<td><input type="text" name="phone" id='phone' value=""
				maxlength='11' class='w50p' placeholder="휴대폰번호"> <input
				type="hidden" name="hpyn" value="Y" id="hpyn1" checked>
				<div style='display: inline-block;'>
					<button type="button" id='sendPhoneNumber'>본인인증</button>
				</div>
				<div style='display: none;' id="phonecheck" >
				<input  type="text" name="userida" id='inputCertifiedNumber' maxlength="4" value=""><button type="button" id='checkBtn'>확인</button></div>
			</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>		
				<input type="text" name="email1" id="email1"  value="" id="eamil1"/> @ 
				<input type="text" name="email2" id="email2"  value="" />
				<select name="last_email_check2" onChange="emailSelect(this);" class="pass" id="last_email_check2" >
					<option selected="" value="">선택해주세요</option>
					<option value="" >직접입력</option>
					<option value="dreamwiz.com" >dreamwiz.com</option>
					<option value="empal.com" >empal.com</option>
					<option value="empas.com" >empas.com</option>
					<option value="freechal.com" >freechal.com</option>
					<option value="hanafos.com" >hanafos.com</option>
					<option value="hanmail.net" >hanmail.net</option>
					<option value="hotmail.com" >hotmail.com</option>
					<option value="intizen.com" >intizen.com</option>
					<option value="korea.com" >korea.com</option>
					<option value="kornet.net" >kornet.net</option>
					<option value="msn.co.kr" >msn.co.kr</option>
					<option value="nate.com" >nate.com</option>
					<option value="naver.com" >naver.com</option>
					<option value="netian.com" >netian.com</option>
					<option value="orgio.co.kr" >orgio.co.kr</option>
					<option value="paran.com" >paran.com</option>
					<option value="sayclub.com" >sayclub.com</option>
					<option value="yahoo.co.kr" >yahoo.co.kr</option>
					<option value="yahoo.com" >yahoo.com</option>
				</select>
			</td>
		</tr>
		<input type="hid`den" name="email" id="email" value=""/>
	</tbody>
</table>
<div class="container text-center">
	<button type="submit" class="btn btn-info">수정하기</button>
	<button type="button" class="btn btn-dark">취소하기</button>
</div>
</form>
</div>
</body>
</html>
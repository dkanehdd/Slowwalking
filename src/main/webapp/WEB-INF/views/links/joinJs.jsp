<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../links/linkOnly2dot.jsp"%>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script>
$(function(){
	$("input[type=radio]").checkboxradio({
        icon: false
    });
	 $("#birthday").datepicker({
         showOn: "both", // 버튼과 텍스트 필드 모두 캘린더를 보여준다.
         buttonImage: "../resources/pick.jpg", // 버튼 이미지
         buttonImageOnly: true, // 버튼에 있는 이미지만 표시한다.
         changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
         changeYear: true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
         minDate: '-100y', // 현재날짜로부터 100년이전까지 년을 표시한다.
         nextText: '다음 달', // next 아이콘의 툴팁.
         prevText: '이전 달', // prev 아이콘의 툴팁.
         numberOfMonths: [1,1], // 한번에 얼마나 많은 월을 표시할것인가. [2,3] 일 경우, 2(행) x 3(열) = 6개의 월을 표시한다.
         stepMonths: 1, // next, prev 버튼을 클릭했을때 얼마나 많은 월을 이동하여 표시하는가. 
         yearRange: 'c-100:c+10', // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할것인가.
         dateFormat: "yy-mm-dd", // 텍스트 필드에 입력되는 날짜 형식.
         showAnim: "slide", //애니메이션을 적용한다.  
         showMonthAfterYear: true , // 월, 년순의 셀렉트 박스를 년,월 순으로 바꿔준다. 
         dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], // 요일의 한글 형식.
         monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] // 월의 한글 형식.
    });  
	 
	$('#id').keyup(function() {
		$.ajax({
			url : "./checkId", //요청할 경로
			type : "get", //전송방식
			//post방식일때의 컨텐츠 타입
			contentType : "text/html;charset:utf-8;",
			data : { //서버로 전송할 파라미터(JSON타입)
				id : $('#id').val()
			},
			dataType : "json", //콜백데이터의 형식
			success : function(d) { //콜백메소드
				if(d.ckeck==1){
					$('#submitBtn').attr("disabled", true); //submit 버튼 안눌리게-추가 hjkosmo-동작안함..
					$('#idCheck').html(d.message);
					$('#idCheck').css('display','inline');
					$('#idCheck').css('color','#ff0000');
					
				}
				else{
					$('#submitBtn').attr("disabled", false); //submit 버튼 눌리게-추가 hjkosmo
					$('#idCheck').html(d.message);
					$('#idCheck').css('display','inline');
					$('#idCheck').css('color','#00ff00');
					
				}
			},
			error : function(e) {
				alert("실패"+e);
			}
		});
	});
	
	//이메일 중복 체크 추가 hjkosmo -- 작동안됨..
	$('#email').keyup(function() {
		$.ajax({
			url : "./checkEmail", //요청할 경로
			type : "get", //전송방식
			//post방식일때의 컨텐츠 타입
			contentType : "text/html;charset:utf-8;",
			data : { //서버로 전송할 파라미터(JSON타입)
				email : $('#email').val()
			},
			dataType : "json", //콜백데이터의 형식
			success : function(d) { //콜백메소드
				if(d.ckeck==1){
					$('#emailCheck').css('display','inline').css('color','#ff0000');
					$('#emailCheck').html(d.message)
				}
				else{
					$('#emailCheck').css('display','inline').css('color','#00ff00');
					$('#emailCheck').html(d.message);
				}
			},
			error : function(e) {
				alert("실패"+e);
			}
		});
	});
	//한글만 입력 가능하도록 처리 하는 부분
    $("#name").keyup(function (event) {
	regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
    v = $(this).val();
		if (regexp.test(v)) {
			alert("실명을 입력하여 주세요\n한글만 입력가능 합니다.");
			$(this).val(v.replace(regexp, ''));
        }
    });
	
	//아이디에 한글, 특수문자 입력금지(hjkosmo 추가)
    $("#id").keyup(function (event) {
	regexp = /[\ㄱ-ㅎㅏ-ㅣ가-힣|\s~!@\#$%^&*\()\-=+_'\;<>\/.\`:\"\\,\[\]?|{}]/g;
    v = $(this).val();
		if (regexp.test(v)) {
			alert("한글, 공백, 특수문자는 입력이 불가능합니다.");
			$(this).val("");
			$(this).focus();
        }
		
    });
	
	//이메일에 한글, 특수문자입력금지
    $("#email").keyup(function (event) {
	regexp = /[\ㄱ-ㅎㅏ-ㅣ가-힣|\s~!\#$%^&*\()\-=+_'\;<>\/.\`:\"\\,\[\]?|{}]/g;
    v = $(this).val();
		if (regexp.test(v)) {
			alert("한글, 공백, 특수문자는 입력이 불가능합니다.");
			$(this).val("");
			$(this).focus();
        }
    });
	//인증번호 발송하기
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
						$('#smsck').val('1');
						// 인증성공후 요청명 기입
						//location.href='regiform'
					} else {
						Swal.fire({
							icon : 'error',
							title : '인증오류',
							text : '인증번호가 올바르지 않습니다!'
						})
					}
				})
			},
			error : function(e) {
				Swal.fire('메세지 전송 실패',e,'error');
			}
		})
	});
	//핸드폰번호에 숫자외 다른문자 금지
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
	
	/////약관체크 JS(hjkosmo추가)/////
	//전체동의
	$(".form-group").on("click", "#chkAll", function () {
		var checked = $(this).is(":checked");
		
		if(checked){
			$(this).parents(".form-group").find('input').prop("checked", true);
		} 
		else {
			$(this).parents(".form-group").find('input').prop("checked", false);
		}
	});
	////약관 JS 끝
});
function checkIT() {
	var d=document.regiform;
	
	if(!d.smsck.value) { alert('본인인증을 해 주세요.'); d.phone.focus();return false; }	
	if(!d.id.value){ alert("아이디를 입력하세요"); d.id.focus();return false;}
	if(!d.name.value) { alert('성함을 입력하세요'); d.name.focus();return false; }
	if(!d.pw.value) { alert('비밀번호를 입력하세요'); d.pw.focus();return false; }
	if(!d.email.value||!d.email2.value) { alert('이메일을 입력하세요'); d.email.focus();return false; }
	//약관 검증
	if(!d.chk1.checked||!d.chk2.checked){alert('약정 동의가 필요합니다');d.chkAll.focus(); return false;}
	
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
    var f = document.regiform;
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

function checkImg() {
	var f = document.fileFrm;
	if(!f.image_path.value){
		Swal.fire({
			icon : 'error',
			text : '이미지를 선택하고 등록해주세요'
		})
		return false;
	}
}

function skip(){
	alert('마이페이지에서 사진을 등록하실 수 있습니다.');
	var flag = document.getElementById("flag");
	var mode = document.getElementById("mode");
	if(mode.value=='join'){
		if(flag.value=='sitter'){
			location.href='../member/sitterjoin';
		}
		else if(flag.value=='parents'){
			alert('신청서를 작성해주세요');
			location.href='../member/mypage';
		}
		
	}
	else{
		location.href="../main/main";
	}
}

/*  ==========================================
    이미지 업로드(hjkosmo)
* ========================================== */

function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#imageResult')
                .attr('src', e.target.result);
        };
        reader.readAsDataURL(input.files[0]);
    }
}

$(function () {
    $('#upload').on('change', function () {
        readURL(input);
    });
});

var input = document.getElementById( 'upload' );
var infoArea = document.getElementById( 'upload-label' );
input.addEventListener( 'change', showFileName );
function showFileName( event ) {
	var input = event.srcElement;
	var fileName = input.files[0].name;
	infoArea.textContent = 'File name: ' + fileName;
}


</script>
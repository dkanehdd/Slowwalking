<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header"	content="${_csrf.headerName}" />
<script type="text/javascript"	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript"	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
	<script>
   $(function(){
	   var token = $("meta[name='_csrf']").attr("content");
	   var header = $("meta[name='_csrf_header']").attr("content");
       var IMP = window.IMP; // 생략가능
       IMP.init('imp61347257'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
       var msg;
       
       IMP.request_pay({
           pg : 'html5_inicis',
           pay_method : 'card',
           merchant_uid : 'merchant_' + new Date().getTime(),
           name : '테스트',
           amount : '${dto.price }',
           buyer_email : '${memberDTO.email}',
           buyer_name : '${memberDTO.name}',
           buyer_tel : '${memberDTO.phone}',
       }, function(rsp) {
           if ( rsp.success ) {
               //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
               $.ajax({
                   url: "../multiBoard/order_complete", //cross-domain error가 발생하지 않도록 주의해주세요
                   type: 'POST',
                   dataType: 'json',
                   contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                   beforeSend: function(xhr){
                       xhr.setRequestHeader(header, token);
                   },
                   data: {
                       imp_uid : rsp.imp_uid,
                       id : '${memberDTO.id}',
                       idx : '${dto.idx }',
                       payment : '${flag }',
                       price : '${dto.price }'
                   },
                   success: function(res) {
                       console.log(res);
                       if(res.suc==1){
                    	   msg = '결제가 완료되었습니다.';
                           msg += '\n고유ID : ' + rsp.imp_uid;
                           msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                           msg += '\결제 금액 : ' + rsp.paid_amount;
                           msg += '카드 승인번호 : ' + rsp.apply_num;
                           alert(msg);
                           location.href="../main/main";
                       }
                   },
                   error : function(e) {
       				  alert("디비저장 실패"+e);
       				}
               });
           } else {
               msg = '결제에 실패하였습니다.';
               msg += '에러내용 : ' + rsp.error_msg;
			   alert(msg);
               //실패시 이동할 페이지
			   location.href="../main/main";
			}
		});
	});
</script>

</body>
</html>
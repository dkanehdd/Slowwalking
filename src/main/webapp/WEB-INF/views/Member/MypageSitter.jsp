<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<%@ include file="../links/linkOnly2dot.jsp"%>
<title>MyPage.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script >
<script type="text/javascript">
$(function(){
	$("#profile").on("click",function(){
		$("#ihateiframes").load("../mypage/proEdit");
		window.alert("출력1");
	});
});


</script>
<style>
.box { position:relate;}
.in { position:absolute; top:0; left:175px;}
.in img {width:40px;}
</style>
</head>
<body>
<%@ include file="../include/top.jsp"%>
 <div class="container-fluid">
    <div class="row mt-5 ml-5">
      <div class="col-2" id="menu">
		<div class="box">
		<img src="../resources/images/img_avatar5.png" style="width:200px;">
		</div>
		<div class="in">
			<img src="../resources/images/female-avatar.png" onclick="window.open('../mypage/getImage', 'rm', 'width=400, height=400, location=no, status=no,scrollbars=yes')">
		</div>
		<div class="bg-dark text-light" style="width:200px;">
          	&nbsp;${dto.sitter_id}&nbsp;<small>님</small>
		</div>
		<ul class="list-group list-group-flush">
         	<li class="list-group-item mt-2" id="profile">
          	프로필 수정
       		</li>
          	<li class="list-group-item" id="2">임시</li>
        </ul>
        <ul class="list-group list-group-flush">
         	<li class="list-group-item mt-2">신청서 수정</li>
          	<li class="list-group-item" id="2">내 구인현황</li>
          	<li class="list-group-item" id="2">후기관리</li>
        </ul>
        <ul class="list-group list-group-flush">
         	<li class="list-group-item mt-2">이용권</li>
          	<li class="list-group-item" id="2">포인트</li>
        </ul>
      </div>
      <div class="col-10">
      <div id="ihateiframes">
        <h3>마이페이지</h3>

          <div class="container">
            <div class="row">
              <div class="col-12">
                </div>
              </div>
            </div>
          </div>
      </div>
    </div>
</div>
</body>
</html>
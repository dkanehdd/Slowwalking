<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<%@ include file="../links/linkOnly2dot.jsp"%>
<title>느린걸음</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script >
<script type="text/javascript">
$(function(){
	$("#profile").on("click",function(){
		$("#innerPage").load("../mypage/proEdit");
	});
	$("#image").on("click",function(){
		$("#innerPage").load("../mypage/getImage"); 
	});
	$("#interview").on("click",function(){
		$("#innerPage").load("../mypage/interList");
	});
	$("#myrequest").on("click",function(){
		$("#innerPage").load("../advertisement/requestBoard_list?list_flag=mylist");
	});
	$("#writerequest").on("click",function(){ 
		$("#innerPage").load("../advertisement/requestBoard_write");
	});
	$("#comment").on("click",function(){
		$("#innerPage").load("../mypage/myComment");
	});
	$("#membership").on("click",function(){
		$("#innerPage").load("../mypage/membership");
	});
});
</script>
<style>
.box { position:relate;}
.box img {width:200px; height:200px;}
.in { position:absolute; top:10px; left:175px;}
.in img {width:30px;}
</style>
</head>
<body>
<%@ include file="../include/top.jsp"%>
 <div class="container-fluid">
    <div class="row mt-5 ml-5">
      <div class="col-2">
		<div class="box">
			<c:choose>
				<c:when test="${not empty dto.image_path }">
					<img src="../resources/images/${dto.image_path }"/>
				</c:when>
				<c:otherwise>
					<img src="../resources/images/anonymous-avatar.jpg" style="width:200px;"/>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="in">
			<img src="../resources/images/photo-camera.png" id="image">
		</div>
		<div class="bg-dark text-light" style="width:200px;">
          	&nbsp;${dto.name}&nbsp;<small>님</small>
		</div>
		<ul class="list-group list-group-flush">
         	<li class="list-group-item mt-2" id="profile">
          	회원정보수정
       		</li>
        </ul>
        <ul class="list-group list-group-flush">
         	<li class="list-group-item mt-2" id="writerequest">의뢰서 작성</li>
         	<li class="list-group-item" id="myrequest">내 의뢰서 보기</li>
          	<li class="list-group-item" id="interview">내 구인현황</li>
          	<li class="list-group-item" id="comment">후기관리</li>
        </ul>
        <ul class="list-group list-group-flush">
         	<li class="list-group-item mt-2" id="membership">이용권</li>
          	<li class="list-group-item" >포인트</li>
        </ul>
        <br/><br/><br/><br/>
      </div>
      
      <div class="col-10">
      <div id="innerPage" class="ml-3 mt-3">
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
<%@ include file="../include/footer.jsp"%>
</body>
</html>

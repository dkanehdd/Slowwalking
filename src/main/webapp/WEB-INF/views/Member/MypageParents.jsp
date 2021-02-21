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
	$("#innerPage").load("../mypage/interList");
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
</head>
<body>
<%@ include file="../include/top.jsp"%>
<section class="section-padding" style="background-color: #eee;">
 <div class="container mypage">
      <div class="float-left pageSide"><!-- 왼쪽 -->
		<div class="imgBox">
			<c:choose>
				<c:when test="${not empty dto.image_path }">
					<img src="../resources/images/${dto.image_path }"/>
				</c:when>
				<c:otherwise>
					<img src="../resources/images/anonymous-avatar.jpg" style="width:200px;"/>
				</c:otherwise>
			</c:choose>
	      	<div class="in"><!-- 사진변경 아이콘 -->
				<img src="../resources/images/imgChange.png" id="image">
			</div>
		</div>
		
		<div class="bg-dark text-light" style="width:200px;">
          	&nbsp;${dto.name}&nbsp;<small>님</small>
		</div>
        <ul class="list-group list-group-flush">
         	<li class="list-group-item" id="profile">회원정보수정</li>
         	<li class="list-group-item" id="writerequest">의뢰서 작성</li>
         	<li class="list-group-item" id="myrequest">내 의뢰서 보기</li>
          	<li class="list-group-item" id="interview">내 구인현황</li>
          	<li class="list-group-item" id="comment">후기관리</li>
         	<li class="list-group-item" id="membership">이용권</li>
        </ul>
        <p style="padding: 12px 20px;"><img src="../resources/images/p.png" style="height:14px;"> ${dto.point}</p>
      </div>
      
      <div class="float-right pageSideRight"><!-- 오른쪽 -->
      	<div id="innerPage" class="w100">
        <h3>마이페이지</h3>
          <div class="container">
            <div class="row">
              <div class="">
                </div>
              </div>
            </div>
          </div>
      </div>
      <p class="clear"></p><!-- 상단에 쓰여진 float속성을 이 태그 이후로 적용되지 않게 해주는 class입니다 내용 없습니다. -->
</div>
</section>
<%@ include file="../include/footer.jsp"%>
</body>
</html>

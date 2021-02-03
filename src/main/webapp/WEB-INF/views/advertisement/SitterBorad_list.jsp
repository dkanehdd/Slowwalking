<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<!-- css, js 파일링크 등 묶음-->
<%@ include file="../links/linkOnly2dot.jsp"%>
<title>느린걸음</title>
<style type="text/css">
span.star-prototype, span.star-prototype > * {
    height: 16px; 
    background: url(http://i.imgur.com/YsyS5y8.png) 0 -16px repeat-x;
    width: 80px;
    display: inline-block;
}
 
span.star-prototype > * {
    background-position: 0 0;
    max-width:80px; 
}
</style>
</head>
<body>
	<%@ include file="../include/top.jsp"%>

	<div class="container">


		<div class="text-center">
			<form method="get">
				<select name="searchField">
					<option value="contents">지역</option>
					<option value="name">이름</option>
				</select> <input type="text" name="searchTxt" /> <input type="submit"
					value="검색" />
			</form>
		</div>
		<c:forEach items="${lists }" var="row">
			<div class="border mt-2 mb-2">
				<div class="media">
					<div class="media-left mr-3">
						<img src="../resources/images/${row.image_path }"
							class="media-object" style="width: 100px; height: 100px">
					</div>
					<div class="media-body">
						<div class="profileInfo">
							<div class="contentRow"
								style="justify-content: space-between; margin-bottom: -2px;">
								<div class="contentRow">
									<div class="userName">${row.name }</div>
								</div>
							</div>
							<div class="contentRow">
								<div class="locationBlock">
									<span class="locationItem">${row.residence1}</span>
									&nbsp;<span class="locationItem">${row.residence2}</span>
									&nbsp;<span class="locationItem">${row.residence3}</span>
								</div>
							</div>
							<div class="contentRow">
								<div class="userAge">${row.age }세</div>
								<div class="wantedPayment">희망시급 ${row.pay }원</div>
							</div>
							<div class="contentRow" style="height: 23px;">
								<div class="ReviewRate__Wrapper-sc-1mriui7-0 bEuJEW">
									평점 : <span class="star-prototype">${row.starrate }</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
<script type="text/javascript">
	$.fn.generateStars = function() {
    return this.each(function(i,e){$(e).html($('<span/>').width($(e).text()*16));});
	};

// 숫자 평점을 별로 변환하도록 호출하는 함수
$('.star-prototype').generateStars();
</script>


	</div>
	<!-- Footer메뉴 -->
	<%@ include file="../include/footer.jsp"%>
</body>
</html>


<!-- 작성자 본인에게만 수정/삭제 버튼 보임처리 
   <c:if test="${sessionScope.siteUserInfo.id eq row.id }">
      <button class="btn btn-primary" 
      onclick="location.href='advertisement/requestBoard_edit'">
      수정</button>
      <button class="btn btn-danger" 
      onclick="javascript:deleteRow();">
      삭제</button>
    </c:if> -->
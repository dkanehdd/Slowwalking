function deleteRow(idx) {
    if(confirm('삭제하시겠습니까?')){
        location.href='requestBoardAction_delete?idx='+idx;
    }
}
$(function () {
	$('#sido').change(function() {
		$.ajax({
			url : "../zipcode/gugun",
			type : 'get',
			contentType : "text/html;charset:utf-8",
			data : {
				sido : $('#sido option:selected').val()
			},
			dataType : "json",
			success : function(d) {
				var optionStr = "";
				optionStr += "<option value=''>";
				optionStr += "-구/군-";
				optionStr += "</option>";
				//$.each()통해 반복되는 요소의 인덱스와 요소값을 매개변수로 받을수있다.
				$.each(d, function(index, data) {
					optionStr += '<option value="'+data+'">';
					optionStr += data;
					optionStr += '</option>';
				});
				$('#gugun').html(optionStr);
			},
			error : function(e) {
				alert("오류발생 : " + e.status + " : " + e.statue.Text);
			}
		});
		$('#gugun').change(
				function() {
					$('#region').val(
							$("#sido option:selected").val() + " "
									+ $("#gugun option:selected").val());
				})
		
	});
})
$(function() {
	$(".workday_off").click(function() {
		if ($(this).hasClass("workday_on") == false) {
			$(this).addClass("workday_on");
		} else {
			$(this).removeClass("workday_on");
		}
		workday_make()
	});
});
function workday_make() {
	var i = 0;
	var workday_tyle = "";
	$(".workday_off").each(function() {
		if ($(this).hasClass("workday_on") == true) {
			workdaytype = $(this).val();
			if (i != 0)
				workday_tyle += ",";
			workday_tyle += workdaytype;
			i++;
		}
	});
	workday_tyle += ",~"
	if (i == 0) {
		$("#workday_name").val("");
	} else {
		$("#workday_name").val(workday_tyle);
	}
}
//작성자 본인에게만 수정/삭제 버튼 보임처리 
//<c:if test="${sessionScope.siteUserInfo.id eq row.id }">
//	<button class="btn btn-primary" 
//	onclick="location.href='advertisement/requestBoard_edit'">
//	수정</button>
//	<button class="btn btn-danger" 
//	onclick="javascript:deleteRow();">
//	삭제</button>
//</c:if>
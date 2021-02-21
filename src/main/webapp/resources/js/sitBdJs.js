/* 메뉴 숨김/열림 처리 hjkosmo*/
$(document).ready(function(){
	$('.dropMore').click(function(){
		if($('.dropMore').hasClass('dropMore')){
			$('.dropMore').addClass('dropClose').removeClass('dropMore');
			$('.dropMenu').css('display', 'block');
			$('.moreIco').addClass('fa-chevron-up').removeClass('fa-chevron-down');
		}
		else if($('.dropClose').hasClass('dropClose')){
			$('.dropClose').addClass('dropMore').removeClass('dropClose');
			$('.dropMenu').css('display', 'none');
			$('.moreIco').addClass('fa-chevron-down').removeClass('fa-chevron-up');
		}
	});
});
//끝

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
			if($('#consultation').hasClass("workday_on") == true){
				//협의 가능이 눌러져있으면 아무것도 눌리지 않는다.
			}else{
				$(this).addClass("workday_on");
			}
		} else {
			$(this).removeClass("workday_on");
		}
		workday_make()
	});
	
	$('#consultation').click(
		function() {
			if ($(this).hasClass("workday_on") == true) {
				$("#workday_name").val('협의가능');
				$('.workday_off').removeClass("workday_on");
				$(this).addClass("workday_on");
				
			} else {
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
				if (i == 0) {
					$("#workday_name").val("");
				} else {
					$("#workday_name").val(workday_tyle);
				}
			}
		})
	
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
	if (i == 0) {
		$("#workday_name").val("");
	} else {
		$("#workday_name").val(workday_tyle);
	}
}
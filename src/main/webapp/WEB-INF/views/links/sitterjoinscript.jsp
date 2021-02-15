<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
		$(function() {
			$('#sido1').change(function() {
				$.ajax({
					url : "../zipcode/gugun",
					type : "get",
					contentType : "text/html;charset:utf-8",
					data : {
						sido : $("#sido1 option:selected").val()
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
						$('#gugun1').html(optionStr);
					},
					error : function(e) {
						alert("오류발생:" + e.status + ":" + e.statusText);
					}
				});
			});
			$('#sido2').change(function() {
				$.ajax({
					url : "../zipcode/gugun",
					type : "get",
					contentType : "text/html;charset:utf-8",
					data : {
						sido : $("#sido2 option:selected").val()
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
						$('#gugun2').html(optionStr);
					},
					error : function(e) {
						alert("오류발생:" + e.status + ":" + e.statusText);
					}
				});
			});
			$('#sido3').change(function() {
				$.ajax({
					url : "../zipcode/gugun",
					type : "get",
					contentType : "text/html;charset:utf-8",
					data : {
						sido : $("#sido3 option:selected").val()
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
						$('#gugun3').html(optionStr);
					},
					error : function(e) {
						alert("오류발생:" + e.status + ":" + e.statusText);
					}
				});
			});
			$('#gugun1').change(
					function() {
						$('#residence1').val(
								$("#sido1 option:selected").val() + " "
										+ $("#gugun1 option:selected").val());
					})
			$('#gugun2').change(
					function() {
						$('#residence2').val(
								$("#sido2 option:selected").val() + " "
										+ $("#gugun2 option:selected").val());
					})
			$('#gugun3').change(
					function() {
						$('#residence3').val(
								$("#sido3 option:selected").val() + " "
										+ $("#gugun3 option:selected").val());
					})
		})
		
	/* 폼체크 추가 hjkosmo */
	function chkSitter(){
		var d=document.payappform;
		if(!d.license_check.value){
			alert('자격증 사진을 업로드해주세요');
			return false;
		}
		if(!d.personality_check.value){
			alert('인적성 검사증을 등록해주세요');
			return false;
		}
		if(!d.residence1.value){
			alert('1순위 희망 지역을 선택해 주세요');
			return false;
		}
		if(!d.activity_time.value){
			alert('희망 근무요일을 선택해 주세요')
			return false;
		}
		if(!d.pay.value){
			alert('희망 급여를 지정해 주세요')
			return false;
		}
	}
	</script>
	<style>
#free_open {
	display: none;
	text-align: center;
	border: 3px solid #fae100;
	background: #fff;
	font-family: Noto Sans KR, sans-serif !important;
	font-size: 15.5px;
	font-weight: 400;
	padding: 10px;
	line-height: 1.4;
	margin-top: 10px;
	width: 57%
}

.workday_off {
	border: 1px solid #e0e0e0;
	background: #fff;
/* 	margin-top: 7px; */
/* 	width: calc(58%/ 7); */
	width: 50px;
	color: #595757;
	padding: 6px 0;
	text-align: center;
	font-family: Noto Sans KR, sans-serif !important;
	font-size: 15px;
	font-weight: 400;
}

.workday_on {
	background: #fae100
}
</style>
	<script>
		$(function() {
			$(".workday_off").click(function() {
				if ($(this).hasClass("workday_on") == false) {
					$(this).addClass("workday_on");
				} else {
					$(this).removeClass("workday_on");
				}
				workday_make()
			});
			$('#starttime1').change(
					function() {
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
						workday_tyle += " "
								+ $("#starttime1 option:selected").val() + "~"
								+ $("#endtime1 option:selected").val();
						if (i == 0) {
							$("#workday_name").val("");
						} else {
							$("#workday_name").val(workday_tyle);
						}
					});
			$('#endtime1').change(
					function() {
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
						workday_tyle += " "
								+ $("#starttime1 option:selected").val() + "~"
								+ $("#endtime1 option:selected").val();
						if (i == 0) {
							$("#workday_name").val("");
						} else {
							$("#workday_name").val(workday_tyle);
						}
					});
			$('#time_type').change(
					function name() {
						if ($("#time_type").is(":checked")) {
							$("#workday_name").val('협의가능');
							
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
							workday_tyle += " "
									+ $("#starttime1 option:selected").val()
									+ "~"
									+ $("#endtime1 option:selected").val();
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
			workday_tyle += " " + $("#starttime1 option:selected").val() + "~"
					+ $("#endtime1 option:selected").val();
			if (i == 0) {
				$("#workday_name").val("");
			} else {
				$("#workday_name").val(workday_tyle);
			}
		}
	</script>
	<style>
.cctv_off {
	border: 1px solid #e0e0e0;
	background: #fff;
	margin-top: 7px;
	width: 50px;
	color: #595757;
	padding: 6px 0;
	text-align: center;
	font-family: Noto Sans KR, sans-serif !important;
	font-size: 15px;
	font-weight: 400;
}

.cctv_on {
	background: #fae100
}
</style>
	<script>
		$(function() {
			$(".cctv_off").click(function() {
				$(".cctv_off").removeClass("cctv_on");
				$(this).addClass("cctv_on");
				var cctv_type = $(this).val();
				$("#cctv_name").val(cctv_type);
			});
		});
	</script>
	<style>
.contents {
	width: 86%;
	font-family: Noto Sans KR, sans-serif !important;
	font-size: 15px;
	font-weight: 400;
	color: #595757;
	border: 1px solid #ddd;
	padding: 8px;
	height: 300px;
}

#sample_layer {
	display: none;
	display: none;
	position: relative;
	width: 100%;
	height: 400px; /*overflow-y: scroll;*/
	background-color: #fff;
	right: 0;
	z-index: 1000;
	text-align: left;
	border: 0px solid #ddd;
	padding: 10px;
	padding-left: 0
}

#sample_layer h3 {
	margin-top: 10px;
	border-bottom: 1px solid #ddd;
	margin-bottom: 10px
}

#sample_layer ul {
	overflow: hidden;
}

#sample_layer ul li {
	float: left;
	padding: 10px 0
}

#sample_layer ul li label {
	line-height: 150%;
}

#btn_close_layer {
	border: 0;
	background: #ddd;
	color: #000;
	font-size: 13px;
	padding: 5px 16px;
	right: 10px;
	margin-bottom: 5px;
	position: absolute;
	font-family: Noto Sans KR, sans-serif !important;
}

#btn_sample_content {
	position: absolute;
	right: 1%;
	font-size: 13.4px;
	padding: 5px 10px;
	font-family: Noto Sans KR, sans-serif !important;
}
</style>
	<style>
.timegita_off {
	border: 1px solid #e0e0e0;
	background: #fff;
	margin-top: 10px;
	color: #595757;
	width: 20%;
	padding: 6px 0;
	text-align: center;
	font-family: Noto Sans KR, sans-serif !important;
	font-size: 15px;
	font-weight: 400;
}

.timegita_on {
	background: #fae100
}
</style>
	<script>
		$(function() {
			$(".timegita_off").click(function() {
				if ($(this).hasClass("timegita_on") == false) {
					$(this).addClass("timegita_on");
				} else {
					$(this).removeClass("timegita_on");
				}
				timegita_make()
			});
		});

		function timegita_make() {
			var i = 0;
			var timegita_type = "";
			$(".timegita_off").each(function() {
				if ($(this).hasClass("timegita_on") == true) {
					timegitatype = $(this).val();
					if (i != 0)
						timegita_type += ",";
					timegita_type += timegitatype;
					i++;
				}
			});
			if (i == 0) {
				$("#timegita_name").val("");
			} else {
				$("#timegita_name").val(timegita_type);
			}
		}
	</script>
</html>
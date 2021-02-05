<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../links/linkOnly2dot.jsp"%>    
<script>
	function search_check(num) {
		if (num == '1') {
			document.getElementById("searchP").style.display = "none";
			document.getElementById("searchI").style.display = "";	
		} else {
			document.getElementById("searchI").style.display = "none";
			document.getElementById("searchP").style.display = "";
		}
	}
	
	$(document).ready(function() {
		
		$('#searchBtn').click(function() {
			$('#background_modal').show();
		});
		
		$('.close').on('click', function() {
			$('#background_modal').hide();
		});
		
		$(window).on('click', function() {
			if (event.target == $('#background_modal').get(0)) {
	            $('#background_modal').hide();
	         }
		});
	});
	
	var idV = "";
	var pwV = "";
	
	var idSearch_click = function(){
		$.ajax({
			type:"POST",
			url:"${pageContext.request.contextPath}/member/FindMemberInfo?iptName1="
					+$('#iptName1').val()+"&iptName1="+$('#iptPhone1').val(),
			success:function(data){
				if(data == 0){
					$('#id_value').text("회원 정보를 확인해주세요");	
				} 
				else {
					$('#id_value').text(data);
					idV = data;
				}
			}
		});
	}
	
	var pwSearch_click = function(){
		$.ajax({
			type:"POST",
			url:"${pageContext.request.contextPath}/member/FindMemberInfo?iptId2="
					+$('#iptId2').val()+"&iptId2="+$('#iptPhone2').val(),
			success:function(data){
				if(data == 0){
					$('#pw_value').text("회원 정보를 확인해주세요");	
				} 
				else {
					$('#pw_value').text(data);
					pwV = data;
				}
			}
		});
	}
</script>

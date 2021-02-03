<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="center-text">
	<h2>1:1채팅</h2>
	<p>운영시간은 9:00-18:00 입니다</p>
</div>
<div id="body">

	<div class="chat-box">
		<div class="chat-box-header">
			관리자 <span class="chat-box-toggle"><i
				class="material-icons">close</i></span>
		</div>
		<div class="chat-box-body">
			<div class="chat-box-overlay"></div>
			<div class="chat-logs"></div>
			<!--chat-log -->
		</div>
		<div class="chat-input">
			<form>
				<input type="text" id="chat-input" placeholder="Send a message..." />
				<button type="submit" class="chat-submit" id="chat-submit">
					<i class="material-icons">send</i>
				</button>
			</form>
		</div>
	</div>
</div>
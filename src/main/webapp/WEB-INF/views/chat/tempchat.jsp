<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
<link rel="stylesheet" href="../css/temp_chat_ui.css">
<script src="../js/temp_index.js"></script>

    <div class="fabs">
        <div class="chat">            
            <div id="chat_converse" class="chat_conversion chat_converse">
                <span class="chat_msg_item chat_msg_item_admin">
                    <div class="chat_avatar">
                        <img src="https://image.freepik.com/free-vector/call-center-avatar-wearing-headset-screen-laptop-with-buble-message_37225-31.jpg" />
                    </div>안녕하세요? 느린걸음 고객상담을 시작합니다.
                </span>
                <span class="chat_msg_item chat_msg_item_user">
                    안녕하세요</span>
                <span class="status">20분 전</span>
                <span class="chat_msg_item chat_msg_item_admin">
                    <div class="chat_avatar">
                        <img src="https://image.freepik.com/free-vector/call-center-avatar-wearing-headset-screen-laptop-with-buble-message_37225-31.jpg" />
                    </div>어떤 것이 궁금하신가요?
                </span>
                <span class="chat_msg_item chat_msg_item_user">
                    이용권 환불하는 방법 알려주세요</span>
                <span class="status2">방금 전</span>
            </div>
            
            <div class="fab_field">
                <a id="fab_camera" class="fab"><i class="zmdi zmdi-camera"></i></a>
                <a id="fab_send" class="fab"><i class="zmdi zmdi-mail-send"></i></a>
                <textarea id="chatSend" name="chat_message" placeholder="Send a message"
                    class="chat_field chat_message"></textarea>
            </div>
        </div>
        <!-- 버튼 -->
        <a id="prime" class="fab"><i class="prime zmdi zmdi-comment-outline"></i></a>
    </div>
    <script src='http://code.jquery.com/jquery-1.11.3.min.js'></script>
    <script src="js/index.js"></script>

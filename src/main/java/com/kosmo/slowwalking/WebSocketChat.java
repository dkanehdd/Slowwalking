 package com.kosmo.slowwalking;

import java.util.ArrayList;
import java.util.List;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

@Controller
@ServerEndpoint("/EchoServer.do")
public class WebSocketChat {

	private static final List<Session> sessionList=new ArrayList<Session>();
	private static final Logger logger = LoggerFactory.getLogger(WebSocketChat.class); 
	
	public WebSocketChat() {
		System.out.println("웹소켓(서버) 객체생성");
	} 

	
	@OnOpen 
	public void onOpen(Session session) {
		logger.info("Open session id:"+session.getId()); 
		try {
			final Basic basic=session.getBasicRemote();
			basic.sendText("대화방에 연결 되었습니다.");
		}
		catch (Exception e) { 
			System.out.println(e.getMessage());
		}
		
		sessionList.add(session);
	} 	
	
	
	private void sendAllSessionToMessage(Session self, String message) { 
		try { 
			for(Session session : WebSocketChat.sessionList) {
				if(!self.getId().equals(session.getId())) {
					session.getBasicRemote().sendText(message);
				}
			}
		}catch (Exception e) { 
			System.out.println(e.getMessage());
		}
	}
	
	@OnMessage 
	public void onMessage(String message, Session session) {
		//String sender = message.split(",")[1];//
		//message = message.split(",")[0];//
		logger.info("Message From : "+message); 
		try {
			final Basic basic=session.getBasicRemote();
			//basic.sendText(message);// 주석되어있던 부분 해제
		}
		catch (Exception e) {
			System.out.println(e.getMessage());
		}
		sendAllSessionToMessage(session, message);
	}
	
	@OnError 
	public void onError(Throwable e,Session session) {}
	
	@OnClose 
	public void onClose(Session session) {
		logger.info("Session "+session.getId()+" has ended");
		sessionList.remove(session);
	} 	
}

 package com.kosmo.slowwalking;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import member.MultiBoardImpl;
import mutiBoard.ChattingDTO;

@Controller
@ServerEndpoint("/EchoServer.do/{room}")
public class WebSocketChat {

	
	private static final List<Session> sessionList=new ArrayList<Session>();
	private static final Logger logger = LoggerFactory.getLogger(WebSocketChat.class); 
	private static final Map<String, String> roomlist = new HashMap<String, String>();
	public WebSocketChat() {
		System.out.println("웹소켓(서버) 객체생성");
	} 

	
	@OnOpen 
	public void onOpen(Session session, @PathParam("room") String room) {
		logger.info("Open session id:"+session.getId()); 
		System.out.println(room);
		try {
			final Basic basic=session.getBasicRemote();
			basic.sendText("대화방에 연결 되었습니다.");
		}
		catch (Exception e) { 
			System.out.println(e.getMessage());
		}
		roomlist.put(session.getId(), room);
		sessionList.add(session);
		
	} 	
	
	
	private void sendAllSessionToMessage(Session self, String message) { 
		try { 
			
			for(Session session : WebSocketChat.sessionList) {
				if(!self.getId().equals(session.getId())) {
					if(roomlist.get(session.getId()).equals(roomlist.get(self.getId()))){
						System.err.println(message+"*****");
						session.getBasicRemote().sendText(message); 
						
						
					}
				}
			}
		}catch (Exception e) { 
			e.printStackTrace();
		}
	}
	
	@OnMessage 
	public void onMessage(String message, Session session) {
		//String sender = message.split(",")[1];
		//message = message.split(",")[0];
		logger.info("Message From : "+message); 
		try {
			final Basic basic=session.getBasicRemote();
			//basic.sendText(message);
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

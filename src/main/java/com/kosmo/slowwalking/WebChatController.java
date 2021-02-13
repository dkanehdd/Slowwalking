package com.kosmo.slowwalking;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class WebChatController {
	
	//웹소켓채팅	
	@RequestMapping(value="/chat/websocket", method=RequestMethod.GET)
	public String webSocket() {
		
		return "chat/webSocket";
	}
	@RequestMapping(value="/chat/webChatUI", method=RequestMethod.GET)
	public String webChatUI() {
		
		return "chat/webChatUI";
	}
}

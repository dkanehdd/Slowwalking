package com.kosmo.slowwalking;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class WebChatController {
	

	@Autowired
	public SqlSession sqlSession; 

	//웹소켓채팅	
	@RequestMapping(value="/chat/websocket", method=RequestMethod.GET)
	public String webSocket() {
		
		return "chat/webSocket";
	}
	@RequestMapping(value="/chat/webchatui", method=RequestMethod.GET)
	public String webChatUI() {
		
		return "chat/webChatUI";
	}
	@RequestMapping(value="/chat/chatui", method=RequestMethod.GET)
   public String ChatUI(Model model, HttpServletRequest req) {
      
      ChattingDTO dto = new ChattingDTO();
      int result = sqlSession.getMapper(MultiBoardImpl.class).chatlist(dto);
      
      return "chat/ChatUI";
   }
}

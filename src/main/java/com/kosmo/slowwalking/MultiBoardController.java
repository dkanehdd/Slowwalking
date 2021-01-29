package com.kosmo.slowwalking;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MultiBoardController {

	@Autowired
	public SqlSession sqlSession;
	
	//공지사항으로 이동하는 요청명(메소드)
	@RequestMapping("/multiBoard/notice")
	public String Notice() {
		
		
		return "MultiBoard/Notice";
	}
	
	//FAQ로 이동하는 요청명(메소드)
	@RequestMapping("/multiBoard/FAQ")
	public String FAQ() {
		return "MultiBoard/FAQ";
	}

}

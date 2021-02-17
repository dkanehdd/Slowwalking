package com.kosmo.slowwalking;

import java.security.Principal;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import member.MypageImpl;
import mutiBoard.DiaryDTO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	SqlSession sqlSession;
	
	@RequestMapping("/main/main")
	public String home(HttpSession session, Model model) {
		
		ArrayList<DiaryDTO> lists = sqlSession.getMapper(MypageImpl.class).mainComment();
		
		//게시물의 줄바꿈 처리
		for(DiaryDTO diary : lists) {
			String temp = diary.getContent().replace("\r\n", "<br/>");
			diary.setContent(temp);
		}
				
		model.addAttribute("lists", lists);
		
		
		return "Main/slowwalking";
	}
	
}

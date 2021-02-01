package com.kosmo.slowwalking;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import member.MemberImpl;

@Controller
public class ZipcodeController {

	@Autowired
	SqlSession sqlSession;
	
	@RequestMapping("/zipcode/gugun")
	@ResponseBody
	public ArrayList<String> getSido(HttpServletRequest req){
		
		String sido = req.getParameter("sido");
		
		
		ArrayList<String> lists = sqlSession.getMapper(MemberImpl.class).getGu(sido);
		
		
		return lists;
	}
}

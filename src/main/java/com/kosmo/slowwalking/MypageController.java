package com.kosmo.slowwalking;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MypageController {
	
	
	@Autowired
	public SqlSession sqlSession;
	
	//회원정보수정
	@RequestMapping("/mypage/proEdit.do")
	public String profileEdit() {
		return "Mypage/proEdit";
	}
}

package com.kosmo.slowwalking;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


import member.MemberDTO;
import member.MypageImpl;

@Controller
public class MypageController {
	
	
	@Autowired
	public SqlSession sqlSession;
	
	//회원정보수정 페이지로 이동
	@RequestMapping("/mypage/proEdit")
	public String profileEdit(Principal principal, Model model) {
		
		System.out.println("회원정보수정");
		System.out.println(principal.getName());
		
		MemberDTO dto = sqlSession.getMapper(MypageImpl.class).profile(principal.getName());
		model.addAttribute("dto", dto);
		
		return "Mypage/proEdit";
	}
	
	//프로필 사진 가져오기
	@RequestMapping("/mypage/getImage")
	public String getImage(Model model, Principal principal){
		
		String image_path = sqlSession.getMapper(MypageImpl.class).imgChange(principal.getName());
		System.out.println(image_path);
		
		model.addAttribute("image_path", image_path);
		return "Mypage/imgChange";
	}
	
	//프로필 사진 수정하기
	@RequestMapping(value="mypage/imgChange", method=RequestMethod.POST)
	public String imgChange(Model model, MultipartHttpServletRequest req, MultipartFile file) {
		return "";
	}
	
	public static String getUuid() {
		String uuid = UUID.randomUUID().toString();
		System.out.println("생성된UUID-1:"+uuid);
		uuid = uuid.replaceAll("-", "");
		System.out.println("생성된UUID-2:"+uuid);
		return uuid;
	}
	
	//회원정보수정 
	@RequestMapping("/mypage/proEditAction")
	public String profileEditAction(MemberDTO memberDTO) {
		
		int result = sqlSession.getMapper(MypageImpl.class).proEdit(memberDTO);
		System.out.println("수정처리:"+result);
		
		return "Mypage/proEdit";
	}
}

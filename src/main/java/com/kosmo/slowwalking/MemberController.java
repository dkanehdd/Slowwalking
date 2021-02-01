package com.kosmo.slowwalking;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import member.MemberDTO;
import member.MemberImpl;
import member.SitterMemberDTO;
import mms.certificationService;

@Controller
public class MemberController {

	@Autowired
	public SqlSession sqlSession;
	
	@RequestMapping("/member/list")
	public String MemberList(Model model) {
		
		ArrayList<MemberDTO> lists = sqlSession.getMapper(MemberImpl.class).list();
		
		model.addAttribute("lists", lists);
		
		return "Member/list";
	}
	
	//회원가입 페이지로 이동하는 요청명(메소드)
	@RequestMapping("/member/join")
	public String MemberJoin() {
		return "Member/Join";
	}
	
	//회원가입 처리후 마이페이지로 이동하는 요청명(메소드)
	/*
	회원가입 한 후 바로 로그인이 된 상태로 처리할지 아님 한번더 로그인을 할지 결정 한후 어떤 페이지로 이동할지 다시 결정
	 */
	@RequestMapping("/member/joinAction")
	public String MemberJoinAction(MemberDTO memberDTO) {
		
		
		return "Member/MyPage";
	}
	
	//로그인 페이지로 이동하는 요청명(메소드)
	@RequestMapping("/member/login")
	public String Login() {
		return "Member/Login";
	}
	
	//로그인 처리후 마이페이지로 이동하는 요청명(메소드)
   @RequestMapping("/member/LoginAction")
   public ModelAndView MemberLoginAction(Principal principal, Model model) {
      
      System.out.println("로그인액션");
      String user_id = principal.getName();
      String flag = sqlSession.getMapper(MemberImpl.class).flagValidate(user_id);
      
      System.out.println(flag);
      
      ModelAndView mv = new ModelAndView();
      
      if(flag.equals("sitter")) {
         System.out.println("시터회원 인증완료");
         SitterMemberDTO dto = sqlSession.getMapper(MemberImpl.class).sitMem(user_id);
         
         System.out.println(dto);
         model.addAttribute("dto", dto);
         
         mv.setViewName("Member/MypageSitter");
      }
      else if(flag.equals("parents")) {
         
         mv.setViewName("Member/MypageParents");
      }
      
      return mv;
   }
	//시터회원가입
	@RequestMapping("/member/sitterjoin")
	public String SitterJoin(Model model) {
		
		model.addAttribute("flag", "sitter");
		
		return "Member/SitterJoin";
	}
	//부모회원가입
	@RequestMapping("/member/parentsjoin")
	public String ParentsJoin(Model model) {
		
		model.addAttribute("flag", "parents");
		
		return "Member/ParentsJoin";
	}
	
	@RequestMapping("/member/checkId")
	@ResponseBody
	public Map<String, Object> CheckId(HttpServletRequest req){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int check = sqlSession.getMapper(MemberImpl.class).checkId(req.getParameter("id"));
		
		if(check==1) {
			map.put("check", check);
			map.put("message", "중복된 아이디가 있습니다.");
		}
		else {
			map.put("check", check);
			map.put("message", "사용가능한 아이디 입니다.");
		}
		return map;
	}
	
	//휴대폰 인증 
	@RequestMapping("/check/sendSMS")
	@ResponseBody  
	public String sendSMS(HttpServletRequest req) {
		
		String phoneNumber = req.getParameter("phoneNumber");
        Random rand  = new Random();
        String numStr = "";
        for(int i=0; i<6; i++) {
            String ran = Integer.toString(rand.nextInt(10));
            numStr+=ran;
        }

        System.out.println("수신자 번호 : " + phoneNumber);
        System.out.println("인증번호 : " + numStr);
        certificationService.certifiedPhoneNumber(phoneNumber,numStr);
        return numStr;
    }
	
	
}

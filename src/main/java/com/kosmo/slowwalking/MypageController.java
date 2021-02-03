package com.kosmo.slowwalking;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import advertisement.InterviewDTO;
import advertisement.RequestBoardDTO;

import member.MemberDTO;
import member.MemberImpl;
import member.MypageImpl;
import mutiBoard.DiaryDTO;

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
	public String getImage(Model model, Principal principal, MemberDTO memberDTO){

		String user_id = principal.getName();
		MemberDTO dto = sqlSession.getMapper(MypageImpl.class).getImage(user_id);
		System.out.println(dto);
		System.out.println("이미지가져오기");
		model.addAttribute("id", user_id);
		model.addAttribute("dto", dto);
		return "Mypage/imgChange";
	}
	
	//프로필 사진 수정하기
	@RequestMapping(value="/mypage/imgChange", method=RequestMethod.POST)
	public String imgChange(Model model, MultipartHttpServletRequest req) {
		
		String view = "";
		String user_id = req.getParameter("id");
		
	    //서버의 물리적경로 얻어오기
  		String path = req.getSession().getServletContext().getRealPath("/resources/images");
  		System.out.println(path);
  		//폼값과 파일명을 저장후 view로 전달하기 위한 맵컬렉션
  		try {
  			//업로드폼의 file속성의 필드를 가져온다.(여기서는 2개임)
  			Iterator itr = req.getFileNames();
  			//파일을 받을수있는 객체
  			MultipartFile mfile = null;
  			String fileName = "";
  			
  			/*
  			물리적경로를 기반으로 File객체를 생성한 후 지정된 디렉토리가
  			있는지 확인한다. 만약 없다면 mkdirs()로 생성한다.
  			*/
  			File directory = new File(path);
  			if(!directory.isDirectory()) {
  				directory.mkdirs();
  			}
  			//업로드폼의 file필드 갯수만큼 반복
  			while(itr.hasNext()) {
  				//전송된 파일의 이름을 읽어온다.
  				fileName = (String)itr.next();
  				mfile = req.getFile(fileName);
  				System.out.println("mfile="+mfile);
  				
  				//한글깨짐방지 처리후 전송된 파일명을 가져옴
  				String originalName = 
  					new String(mfile.getOriginalFilename().getBytes(),"UTF-8");
  				//서버로 전송된 파일이 없다면 while문의 처음으로 돌아간다.
  				if("".equals(originalName)) {
  					continue;
  				}
  				
  				//파일명에서 확장자를 가져옴.
  				String ext = originalName.substring(originalName.lastIndexOf('.'));
  				String saveFileName = getUuid() + ext;
  				File serverFullName = 
  					new File(path + File.separator + saveFileName);
  				
  				mfile.transferTo(serverFullName);
  				
  				String image = sqlSession.getMapper(MemberImpl.class).getImage(user_id);
  				//이미 등록된 사진이 있는경우 원래있던 파일 삭제
  				if(image!=null) {
  					File f = new File(path+ File.separator+ image);
  					if(f.exists()) {
  						f.delete();
  					}
  				}
  				sqlSession.getMapper(MemberImpl.class).insertImage(user_id, saveFileName);
  			}
  		}
  		catch (IOException e) {
  			e.printStackTrace();
  		}
  		catch (Exception e) {
  			e.printStackTrace();
  		}
  		System.out.println("수정");
  		return "redirect:/member/mypage";
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
	@ResponseBody
	public Map<String, Object> profileEditAction(Model model, HttpServletRequest req, HttpSession session) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		System.out.println(req.getParameter("pw"));
		System.out.println(req.getParameter("phone"));
		
		MemberDTO dto = new MemberDTO();
		dto.setPw(req.getParameter("pw"));
		dto.setPhone(req.getParameter("phone"));
		dto.setEmail(req.getParameter("email"));
		dto.setId(req.getParameter("id"));
		
		int result = sqlSession.getMapper(MypageImpl.class).proEdit(dto);
		System.out.println("수정처리:"+result);
		model.addAttribute("dto", dto);

		
		return map;
	}
	
	//인터뷰 목록 추가
	@RequestMapping("/mypage/addList")
	@ResponseBody
	public Map<String, Object> addInterviewList(HttpServletRequest req, HttpSession session){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			int idx = Integer.parseInt(req.getParameter("idx"));
			String id = req.getParameter("id");
			String flag = (String)session.getAttribute("flag");
			
			
			System.out.println("idx:"+idx);
			System.out.println("id:"+id);
			System.out.println("flag:"+flag);
			System.out.println("sitter id = "+ (String)session.getAttribute("user_id")); //이거 맞죠??? 넴
		
			
			if(flag.equals("sitter")) {
				int result = sqlSession.getMapper(MypageImpl.class).addInterList(idx, id, 
						(String)session.getAttribute("user_id"), req.getParameter("request_time"));
				System.out.println("result:"+result);
				
				map.put("message", "인터뷰 요청이 성공했습니다.");
		}
		else {
			int result = sqlSession.getMapper(MypageImpl.class).addInterList(idx,
					(String)session.getAttribute("user_id"), id, req.getParameter("request_time"));
			
			System.out.println("result:"+result);
			map.put("message", "인터뷰 요청이 성공했습니다.");
		}	
		}catch(NumberFormatException e) {
			e.printStackTrace();
		}
		
		catch(Exception e) {
			e.printStackTrace();
		}

		
		return map;
	
	//인터뷰 목록 리스트
	@RequestMapping("/mypage/interList")
	public String interviewList(HttpSession session, Model model){
		
		String flag = (String)session.getAttribute("flag");
		String id = (String)session.getAttribute("user_id");
		
		System.out.println("flag:"+flag+" id:"+id);
		
		if(flag.equals("sitter")) {
			ArrayList<InterviewDTO> lists = sqlSession.getMapper(MypageImpl.class).sitInterList(id);
			model.addAttribute("lists", lists);
			
			System.out.println("lists:"+lists);
		}
		else {
			ArrayList<InterviewDTO> lists = sqlSession.getMapper(MypageImpl.class).parInterList(id);
			model.addAttribute("lists", lists);
		}
		
		return "Mypage/interviewList";
	}
	
	//인터뷰 목록에서 삭제하기
	@RequestMapping("mypage/deleteAction")
	@ResponseBody
	public Map<String, Object> deleteInterList(HttpServletRequest req, HttpSession session) {
		
		int idx = Integer.parseInt(req.getParameter("idx"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int result = sqlSession.getMapper(MypageImpl.class).delInterList(idx);
		System.out.println("result:"+result);
		map.put("message", "목록에서 삭제되었습니다.");
		
		return map;
	}
	
	//수락 상태 변경하기
	@RequestMapping("/mypage/agreeAction")
	@ResponseBody
	public Map<String, Object> agreeAction(HttpServletRequest req, HttpSession session) {
		
		System.out.println("수락 상태 변경 시도");
		
		int idx = Integer.parseInt(req.getParameter("idx"));
		String flag = (String)session.getAttribute("flag");
		
		System.out.println("idx:"+idx);
		System.out.println("flag:"+flag);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(flag.equals("sitter")) {
			int result = sqlSession.getMapper(MypageImpl.class).sitAgree(idx);
			System.out.println("result:"+result);
			
			map.put("message", "수락 상태가 변경되었습니다.");

		}
		else {
			int result = sqlSession.getMapper(MypageImpl.class).parAgree(idx);
			System.out.println("result:"+result);
			
			map.put("message", "수락 상태가 변경되었습니다.");
		}
		
		
		return map;
	}
	
	@RequestMapping("/mypage/openDiary")
	public String openDiary(HttpServletRequest req, Model model) {
		System.out.println("openDiary");
		
		int idx = Integer.parseInt(req.getParameter("idx"));
		
		System.out.println("idx:"+idx);
		
		InterviewDTO dto = sqlSession.getMapper(MypageImpl.class).interList(idx);
		model.addAttribute("dto", dto);

		return "Mypage/diary";
	}
	
	//수정중
//	@RequestMapping("/mypage/exchangeDiary")
//	public Model sendDiary(HttpServletRequest req, HttpSession session, Model model) {
//		
//		System.out.println("sendDiary");
//		
//		String flag = (String)session.getAttribute("flag");
//		String parents_id = req.getParameter("parents_id");
//		String sitter_id = req.getParameter("sitter_id");
//		String content = req.getParameter("content");
//		int idx = Integer.parseInt(req.getParameter("idx"));
//		
//		System.out.println("parents_id:"+parents_id);
//		System.out.println("sitter_id:"+sitter_id);
//		System.out.println("content:"+content);
//		
//		if(flag.equals("sitter")) {
//			int result = sqlSession.getMapper(MypageImpl.class).addDiary(idx, parents_id, sitter_id, content);
//		
//			System.out.println("result:"+result);
//			model.addAttribute("check", "check");
//		}
//		else {
//			DiaryDTO dto = sqlSession.getMapper(MypageImpl.class).viewDiary(idx);
//		
//			System.out.println("dto:"+dto);
//			model.addAttribute("check", "check");
//		}
//		
//		return model;
//		
//		
//	}
	
}

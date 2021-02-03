package com.kosmo.slowwalking;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import member.MemberDTO;
import member.MemberImpl;
import member.ParentsMemberDTO;
import member.SitterImpl;
import member.SitterMemberDTO;
import mms.certificationService;

@Controller
public class MemberController {

	@Autowired
	public SqlSession sqlSession;

	// 테스트용 멤버리스트 가져오기
	@RequestMapping("/member/list")
	public String MemberList(Model model) {

		ArrayList<MemberDTO> lists = sqlSession.getMapper(MemberImpl.class).list();

		model.addAttribute("lists", lists);

		return "Member/list";
	}

	// 회원가입 페이지로 이동하는 요청명(메소드)
	@RequestMapping("/member/join")
	public String MemberJoin() {
		return "Member/Join";
	}

	/*
	 * 회원가입 한 후 바로 로그인이 된 상태로 처리할지 아님 한번더 로그인을 할지 결정 한후 어떤 페이지로 이동할지 다시 결정
	 */
	@RequestMapping(value = "/member/joinAction", method = RequestMethod.POST)
	public String MemberJoinAction(Model model, MemberDTO memberDTO, HttpSession session) {

		System.out.println(memberDTO.getName());
		System.out.println(memberDTO.getEmail());
		System.out.println(memberDTO.getPw());
		System.out.println(memberDTO.getId());

		int sucOrFail = sqlSession.getMapper(MemberImpl.class).insertMember(memberDTO);
		// 모델객체에 맵? 컬렉션을 저장한 후 뷰로 전달
		if (sucOrFail == 1) {
			model.addAttribute("id", memberDTO.getId());
			model.addAttribute("sucOrFail", sucOrFail);
			model.addAttribute("mode", "join");
			model.addAttribute("flag", memberDTO.getFlag());
			model.addAttribute("message", "회원가입이 완료되었습니다. \n추가 정보를 작성해주세요.");
			session.setAttribute("user_id", memberDTO.getId());
		} else {
			model.addAttribute("id", memberDTO.getFlag());
			model.addAttribute("sucOrFail", sucOrFail);
			model.addAttribute("message", "회원가입이 취소되었습니다.");
		}
		// 회원가입 완료후 이미지 등록
		return "Member/Image";
	}

	public static String getUuid() {
		String uuid = UUID.randomUUID().toString();
		System.out.println("생성된UUID-1:" + uuid);
		uuid = uuid.replaceAll("-", "");
		System.out.println("생성된UUID-2:" + uuid);
		return uuid;
	}

	// 로그인 페이지로 이동하는 요청명(메소드)
	@RequestMapping("/member/login")
	public String Login() {
		return "Member/Login";
	}


	@RequestMapping("/member/logout")
	public String Logout(HttpSession session) {
		
		session.setAttribute("user_id", null);
		return "redirect:../main/main";
	}

	@RequestMapping("/member/LoginAction")
	public ModelAndView MemberLoginAction(Principal principal, Model model, HttpSession session) {

		System.out.println("로그인액션");
		String user_id = principal.getName();
		String flag = sqlSession.getMapper(MemberImpl.class).flagValidate(user_id);

		System.out.println(flag);

		ModelAndView mv = new ModelAndView();

		if (flag.equals("sitter")) {
			System.out.println("시터회원 인증완료");
			SitterMemberDTO dto = sqlSession.getMapper(MemberImpl.class).sitMem(user_id);

			System.out.println(dto);
			model.addAttribute("dto", dto);

			mv.setViewName("Member/MypageSitter");
		} else if (flag.equals("parents")) {
			System.out.println("부모회원 인증완료");
          		ParentsMemberDTO dto = sqlSession.getMapper(MemberImpl.class).parMem(user_id);
          
        		System.out.println(dto);
          		model.addAttribute("dto", dto);

			mv.setViewName("Member/MypageParents");
		} else if (flag.equals("admin")) {

			mv.setViewName("redirect:../admin/index");
		}
		session.setAttribute("user_id", user_id);
		session.setAttribute("flag", flag);

		return mv;

	}

	// 기본정보입력 회원가입
	@RequestMapping("/member/memberjoin")
	public String MemberJoin(HttpServletRequest req, Model model) {

		String flag = req.getParameter("flag");

		model.addAttribute("flag", flag);

		return "Member/MemberJoin";
	}

	// 시터회원가입
	@RequestMapping("/member/sitterjoin")
	public String SitterJoin(Principal principal, Model model) {
		String user_id = principal.getName();


		model.addAttribute("id", user_id);

		return "Member/SitterJoin";
	}

	// 부모회원가입
	@RequestMapping("/member/parentsjoin")
	public String ParentsJoin(Model model) {

		model.addAttribute("flag", "parents");

		return "Member/ParentsJoin";
	}

	// 아이디중복확인
	@RequestMapping("/member/checkId")
	@ResponseBody
	public Map<String, Object> CheckId(HttpServletRequest req) {

		Map<String, Object> map = new HashMap<String, Object>();

		int check = sqlSession.getMapper(MemberImpl.class).checkId(req.getParameter("id"));

		if (check == 1) {
			map.put("check", check);
			map.put("message", "중복된 아이디가 있습니다.");
		} else {
			map.put("check", check);
			map.put("message", "사용가능한 아이디 입니다.");
		}
		return map;
	}

	// 휴대폰 인증
	@RequestMapping("/check/sendSMS")
	@ResponseBody
	public String sendSMS(HttpServletRequest req) {

		String phoneNumber = req.getParameter("phoneNumber");
		Random rand = new Random();
		String numStr = "";
		for (int i = 0; i < 6; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			numStr += ran;
		}

		System.out.println("수신자 번호 : " + phoneNumber);
		System.out.println("인증번호 : " + numStr);
		certificationService.certifiedPhoneNumber(phoneNumber, numStr);
		return numStr;
	}

	// 마이페이지 진입
	@RequestMapping("/member/mypage")
	public String Mypage(Principal principal, Model model) {

		String view = "";
		String user_id = principal.getName();
	    String flag = sqlSession.getMapper(MemberImpl.class).flagValidate(user_id);
		
	    if(flag.equals("sitter")) {
	    	System.out.println("시터회원 인증완료");
	    	SitterMemberDTO dto = sqlSession.getMapper(MemberImpl.class).sitMem(user_id);
	    	String image_path = sqlSession.getMapper(MemberImpl.class).getImage(user_id);
         
	    	System.out.println(dto);
			model.addAttribute("image_path", image_path);
	    	model.addAttribute("dto", dto);
         
            view = "Member/MypageSitter";
        }
        else if(flag.equals("parents")) {
         
        	view = "Member/MypageParents";
        }
    
		return view;
	}

	// 이미지 등록하기 페이지 진입
	@RequestMapping("/member/image")
	public String Image(Principal principal, Model model) {
		String view = "";
		String user_id = principal.getName();

		model.addAttribute("mode", "edit");
		model.addAttribute("id", user_id);

		return "/Member/Image";
	}

	// 이미지 등록하기
	@RequestMapping(value = "/member/imagepath", method = RequestMethod.POST)
	public String ImagePath(Model model, MultipartHttpServletRequest req) {

		String view = "";
		String user_id = req.getParameter("id");

		// 서버의 물리적경로 얻어오기
		String path = req.getSession().getServletContext().getRealPath("/resources/images");
		System.out.println(path);
		// 폼값과 파일명을 저장후 view로 전달하기 위한 맵컬렉션
		try {
			// 업로드폼의 file속성의 필드를 가져온다.(여기서는 2개임)
			Iterator itr = req.getFileNames();
			// 파일을 받을수있는 객체
			MultipartFile mfile = null;
			String fileName = "";

			/*
			 * 물리적경로를 기반으로 File객체를 생성한 후 지정된 디렉토리가 있는지 확인한다. 만약 없다면 mkdirs()로 생성한다.
			 */
			File directory = new File(path);
			if (!directory.isDirectory()) {
				directory.mkdirs();
			}
			// 업로드폼의 file필드 갯수만큼 반복
			while (itr.hasNext()) {
				// 전송된 파일의 이름을 읽어온다.
				fileName = (String) itr.next();
				mfile = req.getFile(fileName);
				System.out.println("mfile=" + mfile);

				// 한글깨짐방지 처리후 전송된 파일명을 가져옴
				String originalName = new String(mfile.getOriginalFilename().getBytes(), "UTF-8");
				// 서버로 전송된 파일이 없다면 while문의 처음으로 돌아간다.
				if ("".equals(originalName)) {
					continue;
				}

				// 파일명에서 확장자를 가져옴.
				String ext = originalName.substring(originalName.lastIndexOf('.'));
				String saveFileName = getUuid() + ext;
				File serverFullName = new File(path + File.separator + saveFileName);

				mfile.transferTo(serverFullName);

				String image = sqlSession.getMapper(MemberImpl.class).getImage(user_id);
				// 이미 등록된 사진이 있는경우 원래있던 파일 삭제
				if (image != null) {
					File f = new File(path + File.separator + image);
					if (f.exists()) {
						f.delete();
					}
				}
				sqlSession.getMapper(MemberImpl.class).insertImage(user_id, saveFileName);
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (req.getParameter("mode").equals("join")) {
			if (req.getParameter("flag").equals("sitter")) {
				model.addAttribute("id", user_id);

				view = "Member/SitterJoin";
			} else {
				view = "redirect:/member/mypage";
			}
		} else {
			view = "redirect:../main/main";
		}
		return view;
	}

	@RequestMapping(value = "/member/sitterjoinaction", method = RequestMethod.POST)
	public String InsertSitter(Model model, MultipartHttpServletRequest req) {

		String view = "";
		SitterMemberDTO sitterMemberDTO = new SitterMemberDTO();
		sitterMemberDTO.setSitter_id(req.getParameter("sitter_id"));
		sitterMemberDTO.setCctv_agree(req.getParameter("cctv_agree"));
		sitterMemberDTO.setIntroduction(req.getParameter("introduction"));
		sitterMemberDTO.setActivity_time(req.getParameter("activity_time"));
		sitterMemberDTO.setResidence1(req.getParameter("residence1"));
		sitterMemberDTO.setResidence2(req.getParameter("residence2"));
		sitterMemberDTO.setResidence3(req.getParameter("residence3"));
		sitterMemberDTO.setPay(req.getParameter("pay"));
		System.out.println(req.getParameter("sitter_id") + " " + req.getParameter("pay"));
		// 서버의 물리적경로 얻어오기
		String path = req.getSession().getServletContext().getRealPath("/resources/upload");
		System.out.println(path);
		try {
			Iterator itr = req.getFileNames();
			MultipartFile mfile = null;
			String fileName = "";
			File directory = new File(path);
			if (!directory.isDirectory()) {
				directory.mkdirs();
			}
			while (itr.hasNext()) {
				// 전송된 파일의 이름을 읽어온다.
				fileName = (String) itr.next();
				mfile = req.getFile(fileName);
				System.out.println("mfile=" + mfile);

				// 한글깨짐방지 처리후 전송된 파일명을 가져옴
				String originalName = new String(mfile.getOriginalFilename().getBytes(), "UTF-8");

				// 서버로 전송된 파일이 없다면 while문의 처음으로 돌아간다.
				if ("".equals(originalName)) {
					continue;
				}
				File serverFullName = new File(path + File.separator + originalName);

				mfile.transferTo(serverFullName);
				if (itr.hasNext()) {
					sitterMemberDTO.setLicense_check(originalName);
				} else {
					sitterMemberDTO.setPersonality_check(originalName);
				}
			}
			int sitter = sqlSession.getMapper(SitterImpl.class).insertSitter(sitterMemberDTO);
			System.out.println(sitter);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:../main/main";
	}

}

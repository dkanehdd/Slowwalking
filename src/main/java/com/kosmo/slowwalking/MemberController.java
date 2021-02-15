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

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
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
import member.MypageImpl;
import member.SitterImpl;
import member.SitterMemberDTO;
import mms.certificationService;

@Controller
public class MemberController {

	@Autowired
	public SqlSession sqlSession;
	@Autowired
	private JavaMailSender mailSender;
	
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
	

	@RequestMapping(value = "/member/joinAction", method=RequestMethod.POST)
	public String MemberJoinAction(Model model, MemberDTO memberDTO, HttpSession session) {
		System.out.println(memberDTO.getName());
		System.out.println(memberDTO.getEmail());
		System.out.println(memberDTO.getPw());
		System.out.println(memberDTO.getId());

		int sucOrFail = sqlSession.getMapper(MemberImpl.class).insertMember(memberDTO);
		//모델객체에 맵? 컬렉션을 저장한 후 뷰로 전달
		if(sucOrFail==1) {

			model.addAttribute("id", memberDTO.getId());
			model.addAttribute("sucOrFail", sucOrFail);
			model.addAttribute("mode", "join");
			model.addAttribute("flag", memberDTO.getFlag());
			model.addAttribute("message", "회원가입이 완료되었습니다. \n추가 정보를 작성해주세요.");
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
	
	//로그인 페이지로 이동하는 요청명(메소드)
	@RequestMapping("/member/login")
	public String Login() {
		
		return "Member/Login";
	}
	//로그인폼 거치지 않고 바로 로그인(소셜 로그인)
	@RequestMapping("/member/loginWithoutForm")
	public String loginWithoutForm(HttpServletRequest req, Model model, HttpSession session) {
		List<GrantedAuthority> roles = new ArrayList<>(1);//ROLE 권한 설정 컬렉션 
		String userId = req.getParameter("id");
		String flag = sqlSession.getMapper(MemberImpl.class).flagValidate(userId);//플레그얻어오기
		String roleStr = flag.equals("admin") ? "ROLE_admin" : "ROLE_"+flag;
		roles.add(new SimpleGrantedAuthority(roleStr));//권한 설정해주기
	  
		User user = new User(userId, "", roles);//시큐리티에있는 User객체 생성
	  
		Authentication auth = new UsernamePasswordAuthenticationToken(user, null, roles);//Authentication 객체 생성
		SecurityContextHolder.getContext().setAuthentication(auth);//시큐리티에 저장 
		MemberDTO dto = new MemberDTO();
		String view = "";
		if (flag.equals("sitter")) {
			System.out.println("시터회원 인증완료");
			dto = sqlSession.getMapper(MypageImpl.class).profile(userId);
			int premium = sqlSession.getMapper(SitterImpl.class).updatePremium(userId);
			
			SitterMemberDTO sdto = sqlSession.getMapper(SitterImpl.class).selectSitter(userId);
			model.addAttribute("sdto", sdto);
			System.out.println(dto);
			model.addAttribute("dto", dto);

			view = "Member/MypageSitter";
		} else if (flag.equals("parents")) {
			System.out.println("부모회원 인증완료");
			dto = sqlSession.getMapper(MypageImpl.class).profile(userId);
    		System.out.println(dto);
      		model.addAttribute("dto", dto);

			view = "Member/MypageParents";
		}
		session.setAttribute("user_name", dto.getName());
		session.setAttribute("user_id", userId);
		session.setAttribute("flag", flag);
		return view;
	}

	
	//로그아웃
	@RequestMapping("/member/logout")
	public String Logout(HttpSession session) {
		session.invalidate();
		return "redirect:../main/main";
	}
	

	@RequestMapping("/member/LoginAction")
	public ModelAndView MemberLoginAction(Principal principal, Model model, HttpSession session) {

		System.out.println("로그인액션");
		String user_id = principal.getName();
		String flag = sqlSession.getMapper(MemberImpl.class).flagValidate(user_id);
		
		System.out.println(flag);
		MemberDTO dto = new MemberDTO();
		ModelAndView mv = new ModelAndView();
		
		if (flag.equals("sitter")) {
			System.out.println("시터회원 인증완료");
			
			dto = sqlSession.getMapper(MypageImpl.class).profile(user_id); 
			System.out.println(dto);
			model.addAttribute("dto", dto);
			int premium = sqlSession.getMapper(SitterImpl.class).updatePremium(user_id);
			SitterMemberDTO sdto = sqlSession.getMapper(SitterImpl.class).selectSitter(user_id);
			if(sdto!=null) {
				if(sdto.getPremium()==null || Integer.parseInt(sdto.getPremium())<=0) {
					sqlSession.getMapper(SitterImpl.class).resetPremium(user_id);
					System.out.println("프리미엄 초기화 완료");
				}
				model.addAttribute("sdto", sdto);
				mv.setViewName("Member/MypageSitter");
			}
			else {
				mv.setViewName("redirect:../member/sitterjoin");
			}
		} else if (flag.equals("parents")) {
			System.out.println("부모회원 인증완료");

			dto = sqlSession.getMapper(MypageImpl.class).profile(user_id); 
			System.out.println(dto);
          	model.addAttribute("dto", dto);

			mv.setViewName("Member/MypageParents");
		} else if (flag.equals("admin")) {

			mv.setViewName("redirect:../admin/index");
		}
		session.setAttribute("user_name", dto.getName());
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
		}
		else {
			map.put("check", check);
			map.put("message", "사용 가능한 아이디 입니다.");
		}
		return map;
	}
	
	// 이메일 중복확인(hjkosmo 추가)
	@RequestMapping("/member/checkEmail")
	@ResponseBody
	public Map<String, Object> CheckEmail(HttpServletRequest req) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int check = sqlSession.getMapper(MemberImpl.class).checkEmail(req.getParameter("email"));
		
		if (check == 1) {
			map.put("check", check);
			map.put("message", "중복된 이메일이 있습니다.");
		}
		else {
			map.put("check", check);
			map.put("message", "사용 가능한 이메일 입니다.");
		}
		return map;
	}

	// 아이디 찾기 페이지(hjkosmo 추가)
	@RequestMapping("/member/findid")
	public String FindIdPage() {
		
		return "Member/findId";
	}
	
	
	//sqlSession 쿼리문 통해 DB에서 자동주입
	// 아이디 찾기(hjkosmo)
	//HttpServletRequest req로 파라미터 가져오기
	@RequestMapping("/member/findIdAction")
	@ResponseBody
	public Map<String, Object> userIdSearch(HttpServletRequest req){
	
		//map -> {키, 값}, view로 가서 map.키-> value 불러올 수 있음
		Map<String, Object> map=new HashMap<String, Object>(); //Object는 id
	
		
		String userName=req.getParameter("name");
		String userPhone=req.getParameter("phone");
		String userId=sqlSession.getMapper(MemberImpl.class).findId(userName, userPhone);
		System.out.println("넘어온 userName: "+userName);
		System.out.println("넘어온 userPhone: "+userPhone);
		System.out.println("검색된 userId: "+userId);
		
		map.put("id", userId);		
		
		return map;
		//(HttpServletRequest req, Model model) 로 하는 경우
		//model("id", userId);로, jstl로 내보낼수 있음 위 방식은 ajax를 쓸 때 사용
	}
	
	// 비밀번호 찾기 페이지(hjkosmo 추가)
	@RequestMapping("/member/temppw")
	public String FindPwPage() {
		
		return "Member/tempPw";
	}
	
	// 임시 비밀번호 발급(hjkosmo)
	@RequestMapping("/member/tempPwAction")
	@ResponseBody
	public Map<String, Object> userPwSearch(HttpServletRequest req){
		
		Map<String, Object> map=new HashMap<String, Object>();		
		
		String userId=req.getParameter("id");
		String userEmail=req.getParameter("email");
		sqlSession.getMapper(MemberImpl.class).tempPw(userId, userEmail);
		String updatePw=sqlSession.getMapper(MemberImpl.class).updatePw(userId, userEmail);
		System.out.println("넘어온 userId: "+userId);
		System.out.println("넘어온 userEmail: "+userEmail);
		System.out.println("유저에게 전달할 updatePw: "+updatePw);//sql에서 난수생성
		
		MimeMessage mail = mailSender.createMimeMessage();
		String htmlStr = 
		"<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css'>"+
		"<style>"+
	    "@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap');"+
	    "div{font-family: 'Noto Sans KR', sans-serif;}"+
		"</style>"+
		"<div class='container'>"+
		    "<div class='text-center' style='test-align:center; border: 20px solid #d45d14; padding:20px;'>"+
		        "<h2>안녕하세요 "+userId+" 님</h2><br>"+
		        "<p>비밀번호 찾기를 신청해주셔서 임시 비밀번호를 발급해드렸습니다.</p>"+
		        "<p>임시로 발급 드린 비밀번호 <h2 style='color : orange'>"+updatePw+"</h2><br>로그인 후 마이페이지에서 비밀번호를 변경해주세요.</p>"+
		    "</div>"+
	    "</div>";
		try {
			mail.setSubject("[느린걸음] "+userId+" 님의 "+"임시 비밀번호가 발급되었습니다", "utf-8");
			mail.setText(htmlStr, "utf-8", "html");
			mail.addRecipient(RecipientType.TO, new InternetAddress(userEmail));
			mailSender.send(mail);
		} 
		catch (MessagingException e) { 
			e.printStackTrace();
		}	
		map.put("pw", updatePw);
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
		certificationService.certifiedPhoneNumber(phoneNumber, numStr, "join");
		return numStr;
	}

	//마이페이지 진입
   @RequestMapping("/member/mypage")
   public String Mypage(Principal principal, Model model, HttpSession session) {
      
		String view = "";
		String user_id = principal.getName();
		String flag = (String) session.getAttribute("flag");
  
		if(flag.equals("sitter")) {
			
			System.out.println("시터회원 인증완료");
			
			MemberDTO dto = sqlSession.getMapper(MypageImpl.class).profile(user_id); 
			System.out.println(dto);
			
			model.addAttribute("dto", dto);
			SitterMemberDTO sdto = sqlSession.getMapper(SitterImpl.class).selectSitter(user_id);
			model.addAttribute("sdto", sdto);
			
		    view = "Member/MypageSitter";
		}
		else if(flag.equals("parents")) {
			
			System.out.println("부모회원 인증완료");

			MemberDTO dto = sqlSession.getMapper(MypageImpl.class).profile(user_id); 
			System.out.println(dto);
			
			model.addAttribute("dto", dto);
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
				view = "redirect:../main/main";
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
		
		String time = req.getParameter("activity_time");
		
		String timeArray[] = time.split(" ");
		
		if(timeArray[0] != null) {
			sitterMemberDTO.setActivity_date(timeArray[0]);
		}
		if(timeArray.length > 1) {
			sitterMemberDTO.setActivity_time(timeArray[1]);
		}else {
			sitterMemberDTO.setActivity_time("");
		}
		for(int i=0; i<timeArray.length; i++) {
			System.out.println("timArray : " + timeArray[i]);
		}
		
		//sitterMemberDTO.setActivity_time(req.getParameter("activity_time"));
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

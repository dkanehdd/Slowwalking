package admin;

import java.util.ArrayList;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import member.MemberDTO;
import member.MemberImpl;
import mutiBoard.MultiBoardDTO;
import member.AdminMemberImpl;

@Controller
public class AdminController {
	
	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	public SqlSession sqlSession;

	@RequestMapping("/admin")
	public String AdminIndex() {
		return "admin/login";
	}

	@RequestMapping("/admin/index")
	public String Index() {
		return "admin/index";
	}

	// admin 회원 목록 처리
	@RequestMapping("/admin/charts")
	public String List(Model model, HttpServletRequest req) {
		MemberDTO memberDTO = new MemberDTO();

		//Mapper 호출
		ArrayList<MemberDTO> lists =
			sqlSession.getMapper(MemberImpl.class)
				.list();
		
		model.addAttribute("lists", lists);
		return "admin/charts";
	}
	
	//수정 페이지  
		@RequestMapping("/admin/chartsmodify")
		public String modify(Model model, HttpServletRequest req,
				HttpSession session)
		{
			
			//Mapper쪽으로 전달할 파라미터를 저장할 용도의 DTO객체 생성
			MemberDTO memberDTO = new MemberDTO();
			memberDTO.setId(req.getParameter("id"));//일련번호
			
			//Mapper호출시 DTO객체를 파라미터로 전달
			MemberDTO dto = 
					sqlSession.getMapper(AdminMemberImpl.class)
						.view(memberDTO);

			model.addAttribute("dto", dto);
			return "admin/chartsmodify";
		}
		
		//수정처리
		@RequestMapping("/admin/modifyAction")
		public String modifyAction(HttpSession session,	MemberDTO memberDTO)
		{		
			
			//수정폼에서 전송한 모든 폼값을 한꺼번에 저장한 커맨드객체를 사용한다. 
			int applyRow = sqlSession.getMapper(AdminMemberImpl.class)
					.modify(memberDTO);
			System.out.println("수정처리된 레코드수:"+ applyRow);
			
		
			return "redirect:../admin/charts";
		}
		//삭제처리
		@RequestMapping("/admin/delete")
		public String delete(HttpServletRequest req)
		{
			
			sqlSession.getMapper(AdminMemberImpl.class)
			.delete(req.getParameter("id"));

			return "redirect:./charts";
		}
		
		@RequestMapping("/admin/denided")
		public String denided() {
			return "admin/denided";
		}
		
		///어드민 회원 메일발송 리스트
		@RequestMapping("/admin/memberEmail")
		public String memberList(Model model, HttpServletRequest req) {
			MemberDTO memberDTO = new MemberDTO();

			//Mapper 호출
			ArrayList<MemberDTO> lists =
				sqlSession.getMapper(MemberImpl.class)
					.list();
			
			model.addAttribute("lists", lists);
			return "admin/memberEmail";
		}
		
		// 어드민 회원 메일발송 보내기
		@RequestMapping("/admin/emailsubmit")
		public String contentview(Model model, HttpServletRequest req) {
			
			String email = req.getParameter("email");
			
			model.addAttribute("email",email);


			return "admin/emailsubmit";
		}
		
		@RequestMapping(value = "/admin/emailAction")
		  public String mailSending(HttpServletRequest request, ModelMap mo) throws AddressException, MessagingException {
			final String username = "cysik92@naver.com"; //네이버 아이디를 입력해주세요. @nave.com은 입력하지 마시구요. 
			final String password = "asqw1246"; //네이버 이메일 비밀번호를 입력해주세요.

			String host = "smtp.naver.com";

			
		    String setfrom = "cysik92@naver.com";         
		    String tomail  = request.getParameter("tomail");  
		    String[] tomailarr = tomail.split(",");
		    String titles   = request.getParameter("titles");      // 제목
		    String contents = request.getParameter("contents");    // 내용
		    int port=465; //포트번호
		    
		    System.out.println(setfrom);
		    System.out.println(tomail);
		    System.out.println(titles);
		    System.out.println(contents);
		    
		    
		    Properties props = System.getProperties();

		    props.put("mail.smtp.host", host); 
		    props.put("mail.smtp.port", port); 
		    props.put("mail.smtp.auth", "true"); 
		    props.put("mail.smtp.ssl.enable", "true"); 
		    props.put("mail.smtp.ssl.trust", host);
		    
		    Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() { 
		    	String un=username; 
		    	String pw=password; 
		    	protected javax.mail.PasswordAuthentication getPasswordAuthentication() { 
		    		return new javax.mail.PasswordAuthentication(un, pw); 
		    	} 
		    	}); 
		    session.setDebug(true); 
		    //for debug 
		    for(int i=0 ; i<tomailarr.length ; i++) {
		    	System.out.println(tomailarr[i]);
		    }
		    for(int i=0 ; i<tomailarr.length ; i++) {
		    	
			    Message mimeMessage = new MimeMessage(session); 
			    //MimeMessage 생성 
			    mimeMessage.setFrom(new InternetAddress("cysik92@naver.com")); //발신자 셋팅 , 보내는 사람의 이메일주소를 한번 더 입력합니다. 이때는 이메일 풀 주소를 다 작성해주세요. 
			    mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(tomailarr[i])); //수신자셋팅 //.TO 외에 .CC(참조) .BCC(숨은참조) 도 있음 
			    mimeMessage.setSubject(titles); //제목셋팅 
			    mimeMessage.setText(contents); //내용셋팅 
			    Transport.send(mimeMessage); //javax.mail.Transport.send() 이용
		    }   
		    return "redirect:/admin/memberEmail";
		  }
		
}

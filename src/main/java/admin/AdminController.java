package admin;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import member.MemberDTO;
import member.MemberImpl;
import member.AdminMemberImpl;




@Controller
public class AdminController {
	
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
	
	//admin 회원 목록 처리
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

}

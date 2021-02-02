package admin;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import member.AdminMemberImpl;
import member.AdminSitterImpl;
import member.MemberDTO;
import member.MemberImpl;
import member.SitterImpl;
import member.SitterMemberDTO;

@Controller
public class AdminSitter {

	@Autowired
	public SqlSession sqlSession;
	
	//admin 회원 목록 처리
		@RequestMapping("/admin/member")
		public String List(Model model, HttpServletRequest req) {

			//Mapper 호출
			ArrayList<SitterMemberDTO> lists =
				sqlSession.getMapper(SitterImpl.class)
					.list();
			
			model.addAttribute("lists", lists);
			return "admin/member";
		}
	
	
	
}

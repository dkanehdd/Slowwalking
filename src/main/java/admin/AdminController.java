package admin;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import member.MemberDTO;
import member.MemberImpl;



@Controller
public class AdminController {
	
	@Autowired
	public SqlSession sqlSession;
	

	@RequestMapping("/admin1")
	public String AdminIndex() {
		return "admin/index";
	}
	
	@RequestMapping("/charts")
	public String List(Model model, HttpServletRequest req) {
		
		MemberDTO memberDTO = new MemberDTO();

		//Mapper 호출
		ArrayList<MemberDTO> lists =
			sqlSession.getMapper(MemberImpl.class)
				.list();
		
		
		//MyBatis 기본쿼리출력
		String sql = sqlSession.getConfiguration()
				.getMappedStatement("list")
					.getBoundSql(memberDTO).getSql();
		System.out.println("sql="+sql);
		
		
		model.addAttribute("lists", lists);
		
		
		
		return "admin/charts";
	}
		


}

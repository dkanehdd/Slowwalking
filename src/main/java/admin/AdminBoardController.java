package admin;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import member.MemberDTO;
import member.MemberImpl;
import mutiBoard.MultiBoardDTO;

@Controller
public class AdminBoardController {

	@Autowired
	public SqlSession sqlSession;

	// 리스트
	@RequestMapping("/admin/adminnotice")
	public String Boardlist(Model model, HttpServletRequest req) {

		// 파라미터 저장을 위한 DTO객체 생성
		MemberDTO memberDTO = new MemberDTO();

		int totalRecordCount = sqlSession.getMapper(MemberImpl.class).getTotalCount(memberDTO);
		// Mapper 호출
		ArrayList<MultiBoardDTO> lists = sqlSession.getMapper(MemberImpl.class).listPage(memberDTO);

		// MyBatis 기본쿼리출력
		String sql = sqlSession.getConfiguration().getMappedStatement("listPage").getBoundSql(memberDTO).getSql();
		System.out.println("sql=" + sql);

		model.addAttribute("lists", lists);

		return "admin/adminnotice";
	}

	// 공지사항 내용보기
	@RequestMapping("/admin/adminnoticeview")
	public String contentview(Model model, HttpServletRequest req) {
		int idx = Integer.parseInt(req.getParameter("idx"));
		// 파라미터 저장을 위한 DTO객체 생성
		// MemberDTO memberDTO = new MemberDTO();

		MultiBoardDTO multiBoardDTO = new MultiBoardDTO();
		// Mapper 호출
		multiBoardDTO = sqlSession.getMapper(MemberImpl.class).contentPage(idx);

		// 조횟수 증가
		multiBoardDTO = sqlSession.getMapper(MemberImpl.class).contentCount(idx);

		model.addAttribute("dto", multiBoardDTO);

		return "admin/adminnoticeview";
	}

}

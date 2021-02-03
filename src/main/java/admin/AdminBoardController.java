package admin;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.apache.velocity.texen.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import advertisement.RequestBoardDTO;
import advertisement.RequestBoardImpl;
import member.MemberDTO;
import member.AdminMemberImpl;
import mutiBoard.MultiBoardDTO;
import mutiBoard.OrderDTO;
import mutiBoard.ProductImpl;


@Controller
public class AdminBoardController {

	@Autowired
	public SqlSession sqlSession;

	// 방명록 리스트
	@RequestMapping("/admin/adminnotice")
	public String Boardlist(Model model, HttpServletRequest req) {

		// 파라미터 저장을 위한 DTO객체 생성
		MemberDTO memberDTO = new MemberDTO();

		int totalRecordCount = sqlSession.getMapper(AdminMemberImpl.class).getTotalCount(memberDTO);
		// Mapper 호출
		ArrayList<MultiBoardDTO> lists = sqlSession.getMapper(AdminMemberImpl.class).listPage(memberDTO);

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
		multiBoardDTO = sqlSession.getMapper(AdminMemberImpl.class).contentPage(idx);


		model.addAttribute("dto", multiBoardDTO);

		return "admin/adminnoticeview";
	}

	// 공지사항 글쓰기보기
	@RequestMapping("/admin/adminnoticewrite")
	public String Adminnoticewriteviiew() {
		return "admin/adminnoticewrite";
	}

	// 공지사항 글쓰기 처리
	@RequestMapping(value = "/admin/adminWriteAction", method = { RequestMethod.POST, RequestMethod.GET })
	public String writeAction(Model model, HttpServletRequest req, MultiBoardDTO multiBoardDTO) {

		System.out.println(multiBoardDTO.getContent());
		System.out.println(multiBoardDTO.getTitle());
		System.out.println(multiBoardDTO.getId());
		System.out.println(multiBoardDTO.getFlag());

		int result = sqlSession.getMapper(AdminMemberImpl.class).write(multiBoardDTO);
		System.out.println("입력결과:" + result);

		return "redirect:adminnotice";
	}

	// 공지사항 수정페이지
	@RequestMapping("/admin/adminnoticemodify")
	public String noticemodify(Model model, HttpServletRequest req, HttpSession session) {

		// Mapper쪽으로 전달할 파라미터를 저장할 용도의 DTO객체 생성
		MultiBoardDTO multiBoardDTO = new MultiBoardDTO();

		int setIdx = Integer.parseInt(req.getParameter("idx"));

		multiBoardDTO.setIdx(setIdx);// 일련번호

		// Mapper호출시 DTO객체를 파라미터로 전달
		multiBoardDTO = sqlSession.getMapper(AdminMemberImpl.class).noticeview(multiBoardDTO);

		model.addAttribute("dto", multiBoardDTO);
		return "admin/adminnoticemodify";
	}

	// 공지사항 수정처리
	@RequestMapping("/admin/adminmodifyAction")
	public String modifyAction(Model model, MultiBoardDTO multiboardDTO) {

		// 수정폼에서 전송한 모든 폼값을 한꺼번에 저장한 커맨드객체를 사용한다.
		int applyRow = sqlSession.getMapper(AdminMemberImpl.class).noticemodify(multiboardDTO);
		System.out.println("수정처리된 레코드수:" + applyRow);

		model.addAttribute("idx", multiboardDTO.getIdx());
		return "redirect:../admin/adminnoticeview";
	}

	// 공지사항 삭제처리
	@RequestMapping("/admin/adminnoticedelete")
	public String noticedelete(HttpServletRequest req) {
		int setIdx = Integer.parseInt(req.getParameter("idx"));

		sqlSession.getMapper(AdminMemberImpl.class).noticedelete(setIdx);

		return "redirect:../admin/adminnotice";
	}
	
	
	//어드민 의뢰견적 신청서
	@RequestMapping("/admin/requestBoard")
	public String requestBoardList(Model model, HttpServletRequest req) {
		RequestBoardDTO requestBoardDTO = new RequestBoardDTO();

		//Mapper 호출
		ArrayList<RequestBoardDTO> lists =
			sqlSession.getMapper(RequestBoardImpl.class)
				.requestBoard();
		
		model.addAttribute("lists", lists);
		return "admin/requestBoard";
	}

	
	// 의뢰서 내용보기
			@RequestMapping("/admin/requestBoardView")
			public String requestBoardView(Model model, HttpServletRequest req) {
				int idx = Integer.parseInt(req.getParameter("idx"));
				// 파라미터 저장을 위한 DTO객체 생성
				// MemberDTO memberDTO = new MemberDTO();

				RequestBoardDTO requestBoardDTO = new RequestBoardDTO();
				// Mapper 호출
				requestBoardDTO= sqlSession.getMapper(RequestBoardImpl.class).requestBoardView(idx);


				// MyBatis 기본쿼리출력
				String sql = sqlSession.getConfiguration().getMappedStatement("requestBoardView").getBoundSql(requestBoardDTO)
						.getSql();
				// 조횟수 증가
//					sql = sqlSession.getConfiguration()
//							.getMappedStatement("contentCount")
//							.getBoundSql(multiBoardDTO).getSql();

				System.out.println("sql=" + sql);

				model.addAttribute("dto", requestBoardDTO);

				return "admin/requestBoardView";
			}
			
			// 의뢰서 삭제처리
			@RequestMapping("/admin/requestBoardDelete")
			public String requestBoardDelete(HttpServletRequest req) {
				int setIdx = Integer.parseInt(req.getParameter("idx"));

				sqlSession.getMapper(RequestBoardImpl.class).requestBoardDelete(setIdx);

				return "admin/requestBoard";
			}
}

package android;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import advertisement.InterviewDTO;
import advertisement.RequestBoardImpl;
import member.MemberDTO;
import member.MypageImpl;

@Controller
public class AndroidInterviewController {

	@Autowired
	SqlSession sqlSession;
	
	//인터뷰 목록 리스트
	@RequestMapping("/android/interList")
	@ResponseBody
	public Map<String, Object> interviewList(HttpSession session, HttpServletRequest req){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		String flag = req.getParameter("flag");
		String id = req.getParameter("id");
		
		System.out.println("flag:"+flag+" id:"+id);
		
//		MemberDTO dto = sqlSession.getMapper(MypageImpl.class).profile(id);
//		model.addAttribute("dto", dto);
	
		if(flag.equals("sitter")) {
			ArrayList<InterviewDTO> lists = sqlSession.getMapper(MypageImpl.class).andsitInterList(id);
			map.put("lists", lists);
			
			System.out.println("lists:"+lists);
		}
		else {
			ArrayList<InterviewDTO> lists = sqlSession.getMapper(MypageImpl.class).andparInterList(id);
			map.put("lists", lists);
		}
		
		return map;
	}
	
	//수락 상태 변경하기
	@RequestMapping("/android/agreeAction")
	@ResponseBody
	public Map<String, Object> agreeAction(HttpServletRequest req, HttpSession session) {
		
		System.out.println("수락 상태 변경 시도");
		
		int idx = Integer.parseInt(req.getParameter("idx"));
		String flag = req.getParameter("flag");
		
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
		
		InterviewDTO dto = sqlSession.getMapper(MypageImpl.class).getAgree(idx);
		System.out.println(dto.getSitter_agree()+"&&"+dto.getParents_agree());
		if(dto.getSitter_agree().equals("T")&&dto.getParents_agree().equals("T")) {
			int delete = sqlSession.getMapper(RequestBoardImpl.class).invisibleBoard(dto.getRequest_idx());
			System.out.println("삭제됬나용?"+ delete);
		}
		map.put("mode", "agree");
		return map;
	}
	
	//인터뷰 목록에서 삭제하기
	@RequestMapping("/android/deleteAction")
	@ResponseBody
	public Map<String, Object> deleteInterList(HttpServletRequest req, HttpSession session) {
		
		int idx = Integer.parseInt(req.getParameter("idx"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int result = sqlSession.getMapper(MypageImpl.class).delInterList(idx);
		System.out.println("result:"+result);
		map.put("mode", "delete");
		map.put("message", "목록에서 삭제되었습니다.");
		
		return map;
	}
	
	
	//알림장 쓸 목록 가져오기
	@RequestMapping("/android/diaryList")
	@ResponseBody
	public Map<String, Object> diaryList(HttpSession session, HttpServletRequest req){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		String flag = req.getParameter("flag");
		String id = req.getParameter("id");
		
		System.out.println("flag:"+flag+" id:"+id);
		
//			MemberDTO dto = sqlSession.getMapper(MypageImpl.class).profile(id);
//			model.addAttribute("dto", dto);
	
		if(flag.equals("sitter")) {
			ArrayList<InterviewDTO> lists = sqlSession.getMapper(MypageImpl.class).andsitDiaryList(id);
			map.put("lists", lists);
			
			System.out.println("lists:"+lists);
		}
		else {
			ArrayList<InterviewDTO> lists = sqlSession.getMapper(MypageImpl.class).andparInterList(id);
			map.put("lists", lists);
		}
		
		return map;
	}
	
	
}

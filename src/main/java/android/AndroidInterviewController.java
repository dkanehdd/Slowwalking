package android;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
import member.MemberImpl;
import member.MypageImpl;
import mutiBoard.CalendarDTO;
import mutiBoard.DiaryDTO;

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
			System.out.println("lists:"+lists);
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
	
	@RequestMapping("/android/openCalendar")
	@ResponseBody
	public Map<String, Object> openCalendar(HttpServletRequest req, HttpSession session, CalendarDTO calendarDTO) {
		
		//사용자가 부모회원인지 시터회원인지 구별하고 모달에 알림장 데이터를 저장한다.
		
		String user_id = req.getParameter("id");
		ArrayList<DiaryDTO> diaryList = new ArrayList<>();
		
		diaryList = sqlSession.getMapper(MypageImpl.class).anddiaryList(user_id);
		//날짜를 맞는 형식으로 검색해 날짜에 맞게 출력하기 위해 날짜 형식을 바꿔준다.
		for(DiaryDTO dto : diaryList) {
			System.out.println("변경전 시간 : " + dto.getRegidate());
			String regidate = dto.getRegidate();
			regidate = regidate.substring(0,10);
			dto.setRegidate(regidate);
			System.out.println("regidate의 5번째 문자열 : " + regidate.charAt(5));
			if('0' == regidate.charAt(5)) {
				regidate = regidate.substring(0,5) + regidate.substring(6);
				System.out.println("regidate의 7번째 문자열 : " + regidate.charAt(7));
				if('0' == regidate.charAt(7)) {
					regidate = regidate.substring(0,7) + regidate.substring(8);
				}
			}else if('0' == regidate.charAt(8)){
				regidate = regidate.substring(0,8) + regidate.substring(9);
			}
			
			//데이터가 어떻게 출력되는지 확인
			System.out.println("변경된 후 시간 : " + regidate);
			
			dto.setRegidate(regidate);
		}
		
		Map<String, Object> today_data = new HashMap<String, Object>();
		
		today_data.put("lists", diaryList);
		return today_data;
	
	}
	
	//알림장 보내기
	@RequestMapping("/android/sendDiary")
	@ResponseBody
	public Map<String, Object> sendDiary(HttpServletRequest req, HttpSession session, Model model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		System.out.println("sendDiary");
		
		String content = req.getParameter("content");
		int idx = Integer.parseInt(req.getParameter("idx"));
		InterviewDTO dto = sqlSession.getMapper(MypageImpl.class).interList(idx);
		
		System.out.println(dto.getSitter_id());
		System.out.println(dto.getParents_id());
		System.out.println("content:"+content);
		

		int result = sqlSession.getMapper(MypageImpl.class).sendDiary(idx, dto.getSitter_id(), dto.getParents_id(), content);
		map.put("message", "발송 완료되었습니다.");
	
		System.out.println("result:"+result);

		
		return map;
		
		
	}
	
}
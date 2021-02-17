package com.kosmo.slowwalking;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.databind.type.ArrayType;

import advertisement.InterviewDTO;
import member.MemberDTO;
import member.MemberImpl;
import member.MypageImpl;
import member.SitterImpl;
import member.SitterMemberDTO;
import mms.certificationService;
import mutiBoard.CalendarDTO;
import mutiBoard.DiaryDTO;
import mutiBoard.OrderDTO;
import mutiBoard.ProductDTO;
import mutiBoard.ProductImpl;
import util.PagingUtil;

@Controller
public class MypageController {
	
	
	@Autowired
	public SqlSession sqlSession;
	
	//회원정보수정 페이지로 이동
	@RequestMapping("/mypage/proEdit")
	public String profileEdit(Principal principal, Model model) {
		
		System.out.println("회원정보수정");
		System.out.println(principal.getName());
		
		MemberDTO dto = sqlSession.getMapper(MypageImpl.class).profile(principal.getName());
		
		
		model.addAttribute("dto", dto);

		
		return "Mypage/proEdit";
	}
	
	//프로필 사진 가져오기
	@RequestMapping("/mypage/getImage")
	public String getImage(Model model, Principal principal, MemberDTO memberDTO){

		String user_id = principal.getName();
		MemberDTO dto = sqlSession.getMapper(MypageImpl.class).getImage(user_id);
		System.out.println(dto);
		System.out.println("이미지가져오기");
		model.addAttribute("id", user_id);
		model.addAttribute("dto", dto);
		return "Mypage/imgChange";
	}
	
	//프로필 사진 수정하기
	@RequestMapping(value="/mypage/imgChange", method=RequestMethod.POST)
	public String imgChange(Model model, MultipartHttpServletRequest req) {
		
		String view = "";
		String user_id = req.getParameter("id");
		
	    //서버의 물리적경로 얻어오기
  		String path = req.getSession().getServletContext().getRealPath("/resources/images");
  		System.out.println(path);
  		//폼값과 파일명을 저장후 view로 전달하기 위한 맵컬렉션
  		try {
  			//업로드폼의 file속성의 필드를 가져온다.(여기서는 2개임)
  			Iterator itr = req.getFileNames();
  			//파일을 받을수있는 객체
  			MultipartFile mfile = null;
  			String fileName = "";
  			
  			/*
  			물리적경로를 기반으로 File객체를 생성한 후 지정된 디렉토리가
  			있는지 확인한다. 만약 없다면 mkdirs()로 생성한다.
  			*/
  			File directory = new File(path);
  			if(!directory.isDirectory()) {
  				directory.mkdirs();
  			}
  			//업로드폼의 file필드 갯수만큼 반복
  			while(itr.hasNext()) {
  				//전송된 파일의 이름을 읽어온다.
  				fileName = (String)itr.next();
  				mfile = req.getFile(fileName);
  				System.out.println("mfile="+mfile);
  				
  				//한글깨짐방지 처리후 전송된 파일명을 가져옴
  				String originalName = 
  					new String(mfile.getOriginalFilename().getBytes(),"UTF-8");
  				//서버로 전송된 파일이 없다면 while문의 처음으로 돌아간다.
  				if("".equals(originalName)) {
  					continue;
  				}
  				
  				//파일명에서 확장자를 가져옴.
  				String ext = originalName.substring(originalName.lastIndexOf('.'));
  				String saveFileName = getUuid() + ext;
  				File serverFullName = 
  					new File(path + File.separator + saveFileName);
  				
  				mfile.transferTo(serverFullName);
  				
  				String image = sqlSession.getMapper(MemberImpl.class).getImage(user_id);
  				//이미 등록된 사진이 있는경우 원래있던 파일 삭제
  				if(image!=null) {
  					File f = new File(path+ File.separator+ image);
  					if(f.exists()) {
  						f.delete();
  					}
  				}
  				sqlSession.getMapper(MemberImpl.class).insertImage(user_id, saveFileName);
  			}
  		}
  		catch (IOException e) {
  			e.printStackTrace();
  		}
  		catch (Exception e) {
  			e.printStackTrace();
  		}
  		System.out.println("수정");
  		return "redirect:/member/mypage";
	}
	
	public static String getUuid() {
		String uuid = UUID.randomUUID().toString();
		System.out.println("생성된UUID-1:"+uuid);
		uuid = uuid.replaceAll("-", "");
		System.out.println("생성된UUID-2:"+uuid);
		return uuid;
	}
	
	//회원정보수정 
	@RequestMapping("/mypage/proEditAction")
	@ResponseBody
	public Map<String, Object> profileEditAction(Model model, HttpServletRequest req, HttpSession session) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		System.out.println(req.getParameter("pw"));
		System.out.println(req.getParameter("phone"));
		
		MemberDTO dto = new MemberDTO();
		dto.setPw(req.getParameter("pw"));
		dto.setPhone(req.getParameter("phone"));
		dto.setEmail(req.getParameter("email"));
		dto.setId(req.getParameter("id"));
		
		int result = sqlSession.getMapper(MypageImpl.class).proEdit(dto);
		System.out.println("수정처리:"+result);
		model.addAttribute("dto", dto);

		
		return map;
	}
	
	//인터뷰 목록 추가
	@RequestMapping("/mypage/addList")
	@ResponseBody
	public Map<String, Object> addInterviewList(HttpServletRequest req, HttpSession session){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			String user_id = (String)session.getAttribute("user_id");
			String request_time = req.getParameter("request_time");
			String flag = (String)session.getAttribute("flag");

			System.out.println("user_id:"+user_id);
			System.out.println("flag:"+flag);
			
			
			int ticketCount = sqlSession.getMapper(MypageImpl.class).ticketCount(user_id);
			System.out.println("티켓 몇개?"+ticketCount);
			
			if(0 < ticketCount) {
				if(flag.equals("sitter")) {
					int request_idx = Integer.parseInt(req.getParameter("idx"));
					String parentsBoard_id = req.getParameter("id");
					
					System.out.println("idx:"+request_idx);
					System.out.println("id:"+parentsBoard_id);
					
					int result = sqlSession.getMapper(MypageImpl.class).sitterApply(request_idx, parentsBoard_id, user_id, request_time);
					sqlSession.getMapper(MypageImpl.class).updateCount(user_id);
					MemberDTO sitdto = sqlSession.getMapper(MemberImpl.class).getMember(user_id);
					MemberDTO pardto = sqlSession.getMapper(MemberImpl.class).getMember(parentsBoard_id);
					//나중에 풀어주세요~
					//certificationService.certifiedPhoneNumber(pardto.getPhone(), sitdto.getName(), "interview");
					System.out.println("result:"+result);
					
					map.put("message", "success");
					map.put("count", ticketCount-1);
				}
				else {
					String sitterBoard_id = req.getParameter("sitterBoard_id");
					
					System.out.println("id:"+sitterBoard_id);
					
					int result = sqlSession.getMapper(MypageImpl.class).parentsApply(user_id, sitterBoard_id, request_time);
					sqlSession.getMapper(MypageImpl.class).updateCount(user_id);
					MemberDTO sitdto = sqlSession.getMapper(MemberImpl.class).getMember(sitterBoard_id);
					MemberDTO pardto = sqlSession.getMapper(MemberImpl.class).getMember(user_id);
					//나중에 풀어주세요~
					//certificationService.certifiedPhoneNumber(sitdto.getPhone(), pardto.getName(), "interview");
					
					System.out.println("result:"+result);
					map.put("message", "success");
					map.put("count", ticketCount-1);
				}	
			
			}
			else {
				System.out.println("티켓이 없어요");
			}
			
		}catch(NumberFormatException e) {
			e.printStackTrace();
		}
		
		catch(Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	//인터뷰 목록 리스트
	@RequestMapping("/mypage/interList")
	public String interviewList(HttpSession session, Model model){
		
		String flag = (String)session.getAttribute("flag");
		String id = (String)session.getAttribute("user_id");
		
		System.out.println("flag:"+flag+" id:"+id);
	
		if(flag.equals("sitter")) {
			ArrayList<InterviewDTO> lists = sqlSession.getMapper(MypageImpl.class).sitInterList(id);
			model.addAttribute("lists", lists);
			
			System.out.println("lists:"+lists);
		}
		else {
			ArrayList<InterviewDTO> lists = sqlSession.getMapper(MypageImpl.class).parInterList(id);
			model.addAttribute("lists", lists);
		}
		
		return "Mypage/interviewList";
	}
	
	//인터뷰 목록에서 상대방 개인정보 확인하기
	@RequestMapping("/mypage/popInfo")
	public String popInformation(HttpSession session, HttpServletRequest req, Model model) {
		
		String id = req.getParameter("id");
		
		MemberDTO dto = sqlSession.getMapper(MypageImpl.class).profile(id);
		model.addAttribute("dto", dto);
		
		System.out.println("dto"+dto);
		
		return "Mypage/information";
	}
	
	//인터뷰 목록에서 삭제하기
	@RequestMapping("mypage/deleteAction")
	@ResponseBody
	public Map<String, Object> deleteInterList(HttpServletRequest req, HttpSession session) {
		
		int idx = Integer.parseInt(req.getParameter("idx"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int result = sqlSession.getMapper(MypageImpl.class).delInterList(idx);
		System.out.println("result:"+result);
		map.put("message", "목록에서 삭제되었습니다.");
		
		return map;
	}
	
	//수락 상태 변경하기
	@RequestMapping("/mypage/agreeAction")
	@ResponseBody
	public Map<String, Object> agreeAction(HttpServletRequest req, HttpSession session) {
		
		System.out.println("수락 상태 변경 시도");
		
		int idx = Integer.parseInt(req.getParameter("idx"));
		String flag = (String)session.getAttribute("flag");
		
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
		
		
		return map;
	}
	
	//다이어리 팝업창 열기
	@RequestMapping("/mypage/openDiary")
	public String openDiary(HttpServletRequest req, Model model) {	
		
		int idx = Integer.parseInt(req.getParameter("idx"));
		
		System.out.println("idx:"+idx);
		
		InterviewDTO dto = sqlSession.getMapper(MypageImpl.class).interList(idx);
		model.addAttribute("dto", dto);
		
		return "Mypage/diary";
	}
	
	@RequestMapping("/mypage/openDiaryView")
	public String openDiaryView(HttpServletRequest req, Model model, Principal principal) {
		
		//알림장의 고유 일련번호를 받아온다.
		int its_idx = Integer.parseInt(req.getParameter("its_idx"));
		
		System.out.println("its_idx:"+its_idx);
		
		String user_id = principal.getName();
		//시터이면 수정이 가능하고 부모이면 수정이 불가능하게 하기 위해 flag을 받아온다.
		String user_flag = sqlSession.getMapper(MemberImpl.class).flagValidate(user_id);
		
		System.out.println("user_flag : " + user_flag);
		
		model.addAttribute("user_flag", user_flag);
		
		DiaryDTO dto = new DiaryDTO();
		
		if(user_flag.equals("sitter")) {
			dto = sqlSession.getMapper(MypageImpl.class).parDiaryView(its_idx);
		}
		else {
			dto = sqlSession.getMapper(MypageImpl.class).sitDiaryView(its_idx);
		}
		model.addAttribute("dto", dto);
		
		return "Mypage/diaryView";
	}
	

	@RequestMapping("/mypage/openCalendar")
	public String openCalendar(HttpServletRequest req, HttpSession session, Principal principal, Model model, CalendarDTO calendarDTO) {
		
		//flag가 뭔가용
		String flag = (String)session.getAttribute("flag");

		int idx = Integer.parseInt(req.getParameter("idx"));
		
		System.out.println("idx:"+idx);
		
		model.addAttribute("idx", idx);
		model.addAttribute("flag", flag);
		
		//사용자가 부모회원인지 시터회원인지 구별하고 모달에 알림장 데이터를 저장한다.
		
		String user_id = principal.getName();
		ArrayList<DiaryDTO> diaryList = new ArrayList<>();
		
		String user_flag = sqlSession.getMapper(MemberImpl.class).flagValidate(user_id);
		
		System.out.println("user_flag : " + user_flag);
		
		
		if("parents".equals(user_flag)) {
			diaryList = sqlSession.getMapper(MypageImpl.class).parDiary(user_id);
		}else if("sitter".equals(user_flag)) {
			diaryList = sqlSession.getMapper(MypageImpl.class).sitDiary(user_id);
		}
		
		
		System.out.println("user_flag : " + user_flag);
		
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
		
		model.addAttribute("diaryList", diaryList);
		
		///////////////////////////////////////////////////////////////////////
		
		
		
		//////////////////////////////////////////////////////////////////////
		Map<String, Object> today_data = new HashMap<String, Object>();
		Calendar cal = Calendar.getInstance();
		//CalendarDTO calendarData;
	
		//검색 날짜
		
		
//		 if(calendarDTO.getDate().equals("")&&calendarDTO.getMonth().equals("")){
//			 
//			 calendarDTO = new CalendarDTO(String.valueOf(cal.get(Calendar.YEAR)),
//					 String.valueOf(cal.get(Calendar.MONTH)),
//					 String.valueOf(cal.get(Calendar.DATE)),null); 
//		}
		
		String year = req.getParameter("year");
		String month = req.getParameter("month");
		String yearIdx = req.getParameter("yearIdx");
		String monthIdx = req.getParameter("monthIdx");
		
		System.out.println("넘어온 년 : " + year);
		System.out.println("넘어온 월  : " + month);
		
		if(yearIdx == null && monthIdx == null) {
			year = Integer.toString(cal.get(Calendar.YEAR));
			month = Integer.toString(cal.get(Calendar.MONTH));
		}else if("0".equals(yearIdx)) {
			year = Integer.toString(Integer.parseInt(year)-1); 
		}else if("0".equals(monthIdx)) {
			if(month.equals("0")) {
				month = "11";
				year = Integer.toString(Integer.parseInt(year)-1); 
			}else {
				month = Integer.toString(Integer.parseInt(month)-1); 
				System.out.println("변경된 월 : " + month);
			}
		}else if("1".equals(yearIdx)) {
			year = Integer.toString(Integer.parseInt(year)+1); 
		}else if("1".equals(monthIdx)) {
			if(month.equals("11")) {
				month = "0";
				year = Integer.toString(Integer.parseInt(year)+1); 
			}else {
				month = Integer.toString(Integer.parseInt(month)+1); 
				System.out.println("변경된 월 : " + month);
			}
		}
			
		
		
		
		//System.out.println(year+"년" + month + "월");
		//해당 년도와 날자를 set해줌 
		cal.set(Integer.parseInt(year), Integer.parseInt(month), 1);
		
		
		 //해당 월의 첫날 
		 int startDay = cal.getMinimum(java.util.Calendar.DATE); //해당 월의
		 //마지막 날 
		 int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
		 //1일의 요일 
		 int start = cal.get(java.util.Calendar.DAY_OF_WEEK);
		 
		
		
		//System.out.println(startDay+endDay+start);
		
		//오늘 날짜 정보
		Calendar todayCal = Calendar.getInstance();
		SimpleDateFormat yearFrm = new SimpleDateFormat("yyyy");
		SimpleDateFormat monthFrm = new SimpleDateFormat("M");

		
		
		//System.out.println("오늘: "+today_year+"년"+today_month+"월");
		
	
		//int year = Integer.parseInt(calendarDTO.getYear());
		//int month = Integer.parseInt(calendarDTO.getMonth())+1;
		
		System.out.println("년도: "+year);
		System.out.println("월: "+month );
		System.out.println("해당 월의 첫날 : "+startDay );
		System.out.println("마지막 날 : " + endDay);
		System.out.println("1일의 요일 : " + start);
		
		
		
		int today = cal.get(Calendar.DATE);
		
		System.out.println("오늘 날짜 : " + today);
		/*
		 * if (today_year==year && today_month == month) { SimpleDateFormat dayFrm = new
		 * SimpleDateFormat("dd"); today =
		 * Integer.parseInt(dayFrm.format(todayCal.getTime())); }
		 */
		
		
		
		// 캘린더 함수 end
		today_data.put("start", start);
		today_data.put("startDay", startDay);
		today_data.put("endDay", endDay);
		today_data.put("today", today);
		today_data.put("year", year);
		int monthInt = Integer.parseInt(month);
		today_data.put("month", monthInt);
		
		
		//배열에 담음
		//model.addAttribute("dateList", dateList);		//날짜 데이터 배열
		model.addAttribute("today", today_data);
		
		return "Mypage/diaryCalendar";
	
	}
	
	//알림장 보내기
	@RequestMapping("/mypage/sendDiary")
	@ResponseBody
	public Map<String, Object> sendDiary(HttpServletRequest req, HttpSession session, Model model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		System.out.println("sendDiary");
		
		String flag = (String)session.getAttribute("flag");
		String parents_id = req.getParameter("parents_id");
		String sitter_id = req.getParameter("sitter_id");
		String content = req.getParameter("content");
		int idx = Integer.parseInt(req.getParameter("idx"));
		
		System.out.println("parents_id:"+parents_id);
		System.out.println("sitter_id:"+sitter_id);
		System.out.println("content:"+content);
		

		int result = sqlSession.getMapper(MypageImpl.class).sendDiary(idx, sitter_id, parents_id, content);
		map.put("message", "발송 완료되었습니다.");
	
		System.out.println("result:"+result);

		
		return map;
		
		
	}
	
	//후기 작성 팝업창 열기
	@RequestMapping("/mypage/openComment")
	public String commentList(HttpServletRequest req, Model model) {
		
		int idx = Integer.parseInt(req.getParameter("idx"));
		
		System.out.println("idx:"+idx);
		
		InterviewDTO dto = sqlSession.getMapper(MypageImpl.class).interList(idx);
		sqlSession.getMapper(MypageImpl.class).setComplete(idx);
		
		model.addAttribute("dto", dto);
		
		return "Mypage/commentWrite";
	}
	
	//후기 작성하기
	@RequestMapping("/mypage/writeComment")
	@ResponseBody
	public Map<String, Object> writeComment(HttpServletRequest req, HttpSession session, Model model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		System.out.println("sendDiary");
		
		String flag = (String)session.getAttribute("flag");
		String parents_id = req.getParameter("parents_id");
		String sitter_id = req.getParameter("sitter_id");
		String content = req.getParameter("content");
		int newrate = Integer.parseInt(req.getParameter("newrate"));
		int idx = Integer.parseInt(req.getParameter("idx"));
		
		System.out.println("parents_id:"+parents_id);
		System.out.println("sitter_id:"+sitter_id);
		System.out.println("content:"+content);
		System.out.println("newrate:"+newrate);
		
		
		if(flag.equals("sitter")) {
			int starrate = sqlSession.getMapper(MypageImpl.class).
					getStarrate(parents_id);
			int result = sqlSession.getMapper(MypageImpl.class).
					writeComment(idx, sitter_id, parents_id, content, newrate);
			
			if(starrate==0) {
				starrate = newrate;
			}
			else {
				starrate = (newrate + starrate) / 2;
			}
			
			//포인트 50점 지급, 별점 업데이트
			int success = sqlSession.getMapper(MypageImpl.class).setStarrate(parents_id, starrate);
			int check = sqlSession.getMapper(MypageImpl.class).getPoint(sitter_id);
			
		}
		else {
			int starrate = sqlSession.getMapper(MypageImpl.class).getStarrate(sitter_id);
			int result = sqlSession.getMapper(MypageImpl.class).writeComment(idx, parents_id, sitter_id, content, newrate);
			
			if(starrate==0) {
				starrate = starrate;
			}
			else {
				starrate = (newrate + starrate) / 2;
			}

			int success = sqlSession.getMapper(MypageImpl.class).setStarrate(sitter_id, starrate);
			int check = sqlSession.getMapper(MypageImpl.class).getPoint(parents_id);

		}

		return map;	
	}
	
	//후기관리 페이지 이동
	@RequestMapping("/mypage/myComment")
	public String myComment(HttpSession session, HttpServletRequest req, Model model) {
		
		String id = (String)session.getAttribute("user_id");
		
		MemberDTO dto = sqlSession.getMapper(MypageImpl.class).profile(id);
		
		model.addAttribute("dto", dto);
		
		return "Mypage/comment";
	}
	//받은 후기
	@RequestMapping("/mypage/commentList")
	public String commentList(HttpSession session, HttpServletRequest req, Model model) {
		
		String id = (String)session.getAttribute("user_id");
		String mode = req.getParameter("mode");
		
		System.out.println("mode: "+mode);
		
		MemberDTO dto = sqlSession.getMapper(MypageImpl.class).profile(id);
		
		//내 후기 총 개수 구하기
		int totalCount = sqlSession.getMapper(MypageImpl.class).receCount(id);
		System.out.println("totalCount="+totalCount);
		
		if(mode.equals("send")) {
			int sendCount = sqlSession.getMapper(MypageImpl.class).sendCount(id);
			totalCount = sendCount;
		}

		//한 페이지에 나타낼 레코드 수
		int pageSize = 4;
		//한 페이지에 나타낼 이동 가능한 페이지 개수
		int blockPage = 2;
		//전체페이지수 계산
		int totalPage =
				(int)Math.ceil((double)totalCount/pageSize);
		//현재페이지 변호 가져오기
		int nowPage = req.getParameter("nowPage")==null ? 1 :
			Integer.parseInt(req.getParameter("nowPage"));
		//select할 게시물의 구간을 계산
		int start = (nowPage-1) * pageSize + 1;
		int end = nowPage * pageSize;
		
		//리스트 페이지에 출력할 게시물 가져오기

		ArrayList<DiaryDTO> lists = sqlSession.getMapper(MypageImpl.class).receivedComment(id, start, end);

		//페이지 번호 처리
		String pagingImg = 
				PagingUtil.pagingImg(totalCount, pageSize, blockPage,
						nowPage, req.getContextPath()+"/mypage/commentList?mode=receive&");
		
		if(mode.equals("send")) {
			ArrayList<DiaryDTO> sendLists = sqlSession.getMapper(MypageImpl.class).sendedComment(id, start, end);
			String paging = 
					PagingUtil.pagingImg(totalCount, pageSize, blockPage,
							nowPage, req.getContextPath()+"/mypage/commentList?mode=send&");
			lists = sendLists;
			pagingImg = paging;
		}
		
		//게시물의 줄바꿈 처리
		for(DiaryDTO diary : lists) {
			String temp = diary.getContent().replace("\r\n", "<br/>");
			diary.setContent(temp);
		}
		

		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("lists", lists);
		model.addAttribute("count", totalCount);
		model.addAttribute("dto", dto);
		model.addAttribute("mode", mode);
		
				
		return "Mypage/commentList";
	}
	
	@RequestMapping("/mypage/editComment")
	public String editComment(HttpServletRequest req, Model model) {
		
		DiaryDTO dto = sqlSession.getMapper(MypageImpl.class).edit(Integer.parseInt(req.getParameter("idx")));

		model.addAttribute("dto", dto);
		model.addAttribute("mode", req.getParameter("mode"));
		
		return "Mypage/commentEdit";
	}
	
	@RequestMapping("/mypage/editAction")
	public String editAction(HttpServletRequest req, Model model) {
		
		int result = sqlSession.getMapper(MypageImpl.class).editAction(Integer.parseInt(req.getParameter("idx")), 
				req.getParameter("content"));

		if(result==1) {	
			model.addAttribute("message", "수정이 완료되었습니다.");
		}
		else {
			model.addAttribute("message", "다시 시도해 주세요.");
		}
		
		return "forward:commentList";
	}
	
	@RequestMapping("mypage/delComment")
	public String deleteAction(HttpServletRequest req, Model model) {
		
		int result = sqlSession.getMapper(MypageImpl.class).delAction(Integer.parseInt(req.getParameter("idx")));
		if(result==1) {	
			model.addAttribute("message", "삭제가 완료되었습니다.");
		}
		else {
			model.addAttribute("message", "다시 시도해 주세요.");
		}
		return "forward:commentList";
	}
	
	@RequestMapping("mypage/membership")
	public String membership(HttpSession session, Model model, HttpServletRequest req) {
		
		String id = (String) session.getAttribute("user_id");
		
		MemberDTO dto = sqlSession.getMapper(MypageImpl.class).profile(id);
		ArrayList<OrderDTO> lists = sqlSession.getMapper(MypageImpl.class).purchaseList(id);
		
		System.out.println("lists:"+lists);
				
		model.addAttribute("dto", dto);
		model.addAttribute("lists", lists);
		
		return "Mypage/membership";
	}
	
	
	////////민우/////////////
	//시터정보 수정 페이지 진입
	@RequestMapping("/mypage/sitterEdit")
	public String sitterEdit (Model model, Principal principal) {
		String id = principal.getName();
		
		SitterMemberDTO dto = sqlSession.getMapper(SitterImpl.class).selectSitter(id);
		
		model.addAttribute("dto", dto);
		
		return "Mypage/sitterEdit";
	}
	//시터정보 수정처리
	@RequestMapping("/mypage/sitterEditAction")
	public String sitterEditAction (SitterMemberDTO sitterMemberDTO, Model model) {
		
		System.out.println(sitterMemberDTO.getSitter_id());
		System.out.println(sitterMemberDTO.getIntroduction());
		System.out.println(sitterMemberDTO.getActivity_time());
		
		int suc = sqlSession.getMapper(SitterImpl.class).updateSitter(sitterMemberDTO);
		
		model.addAttribute("suc", suc);
		return "redirect:../member/mypage";
	}
	
	@RequestMapping("/mypage/license")
	public String license(Model model, Principal principal) {
		String id = principal.getName();
		
		SitterMemberDTO dto = sqlSession.getMapper(SitterImpl.class).selectSitter(id);
		
		model.addAttribute("dto", dto);
		
		return "Mypage/license";
	}
	@RequestMapping("/mypage/updatelicense")
	public String updatelicense(MultipartHttpServletRequest req) {
		
		String id = req.getParameter("sitter_id");
		
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
				int sitter = sqlSession.getMapper(SitterImpl.class).updateLicense(originalName, id);
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:../member/mypage";
	}
	@RequestMapping("/mypage/advertise")
	@ResponseBody
	public Map<String, Object> advertise(HttpServletRequest req, Principal principal) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String id = principal.getName();
		String advertise = req.getParameter("check").equals("true")?"T":"F";
		int suc = sqlSession.getMapper(SitterImpl.class).updateAdvertise(advertise, id);
		System.out.println(suc);
		
		map.put("suc", suc);
		
		return map;
	}
	
	@RequestMapping("/mypage/premium")
	public String premium (Model model,Principal principal) {
		String id= principal.getName();
		
		ArrayList<ProductDTO> lists = sqlSession.getMapper(ProductImpl.class).premiumList();
		SitterMemberDTO dto = sqlSession.getMapper(SitterImpl.class).selectSitter(id);
		
		
		model.addAttribute("lists", lists);
		model.addAttribute("dto", dto);
		return "Mypage/premium";
	}
	
	@RequestMapping("/mypage/countInterview")
	@ResponseBody
	public Map<String, Object> countInterview(Principal principal, HttpSession session){
		//ajax에 결과를 보내줄 map
		Map<String, Object> result = new HashMap<>();
		int resultCount = 0;
		//부모회원인지 시터 회원인지 구별해야함
		if(session.getAttribute("user_id") != null) {
			String id= (String) session.getAttribute("user_id");
			System.out.println("id : " + id);
			String flag = sqlSession.getMapper(MemberImpl.class).flagValidate(id);
			System.out.println("출력되는 flag : " + flag);
			if(flag.equals("parents")) {
				resultCount = sqlSession.getMapper(MypageImpl.class).countParentsInterview(id);
				System.out.println("resultCount : " + resultCount);
			}else if(flag.equals("sitter")) {
				resultCount = sqlSession.getMapper(MypageImpl.class).countSitterInterview(id);
				System.out.println("resultCount : " + resultCount);
			}
		}
		
		result.put("interviewCount", resultCount);
		
		return result;
	}
	
}

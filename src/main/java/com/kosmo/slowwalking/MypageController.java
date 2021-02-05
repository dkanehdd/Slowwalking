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

import advertisement.InterviewDTO;
import member.MemberDTO;
import member.MemberImpl;
import member.MypageImpl;
import mutiBoard.CalendarDTO;
import mutiBoard.DiaryDTO;

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
		
		System.out.println("진입:"+req.getParameter("idx"));
		
		try {
			int idx = Integer.parseInt(req.getParameter("idx"));
			String id = req.getParameter("id");
			String flag = (String)session.getAttribute("flag");
			
			
			System.out.println("idx:"+idx);
			System.out.println("id:"+id);
			System.out.println("flag:"+flag);
			System.out.println("sitter id = "+ (String)session.getAttribute("user_id")); 
		
			
			if(flag.equals("sitter")) {
				int result = sqlSession.getMapper(MypageImpl.class).addInterList(idx, id, 
						(String)session.getAttribute("user_id"), req.getParameter("request_time"));
				System.out.println("result:"+result);
				
				map.put("message", "인터뷰 요청이 성공했습니다.");
			}
			else {
				int result = sqlSession.getMapper(MypageImpl.class).addInterList(idx,
						(String)session.getAttribute("user_id"), id, req.getParameter("request_time"));
				
				System.out.println("result:"+result);
				map.put("message", "인터뷰 요청이 성공했습니다.");
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
		
		MemberDTO dto = sqlSession.getMapper(MypageImpl.class).profile(id);
		model.addAttribute("dto", dto);
	
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
	@RequestMapping("/mypage/openDiary")
	public String openDiary(HttpServletRequest req, Model model) {
		
		int idx = Integer.parseInt(req.getParameter("idx"));
		
		System.out.println("idx:"+idx);
		
		InterviewDTO dto = sqlSession.getMapper(MypageImpl.class).interList(idx);
		model.addAttribute("dto", dto);
		
		return "Mypage/diary";
	}
	@RequestMapping("/mypage/openCalendar")
	public String openCalendar(HttpServletRequest req, HttpSession session, Model model, CalendarDTO calendarDTO) {
		
		String flag = (String)session.getAttribute("flag");

		int idx = Integer.parseInt(req.getParameter("idx"));
		
		System.out.println("idx:"+idx);
		
		model.addAttribute("idx", idx);
		model.addAttribute("flag", flag);
		
		//////////////////////////////////////////////////////////////////////
		Map<String, Integer> today_data = new HashMap<String, Integer>();
		Calendar cal = Calendar.getInstance();
		CalendarDTO calendarData;
	
		//검색 날짜
		if(calendarDTO.getDate().equals("")&&calendarDTO.getMonth().equals("")){
			calendarDTO = new CalendarDTO(String.valueOf(cal.get(Calendar.YEAR)),
					String.valueOf(cal.get(Calendar.MONTH)),String.valueOf(cal.get(Calendar.DATE)),null);
		}
		
		
		cal.set(Integer.parseInt(calendarDTO.getYear()), Integer.parseInt(calendarDTO.getMonth()), 1);
		
		//해당 월의 첫날
		int startDay = cal.getMinimum(java.util.Calendar.DATE);
		//해당 월의 마지막 날
		int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
		//1일의 요일
		int start = cal.get(java.util.Calendar.DAY_OF_WEEK);
		
		System.out.println(startDay+endDay+start);
		
		//오늘 날짜 정보
		Calendar todayCal = Calendar.getInstance();
		SimpleDateFormat yearFrm = new SimpleDateFormat("yyyy");
		SimpleDateFormat monthFrm = new SimpleDateFormat("M");

		int today_year = Integer.parseInt(yearFrm.format(todayCal.getTime()));
		int today_month = Integer.parseInt(monthFrm.format(todayCal.getTime()));
		
		System.out.println("오늘: "+today_year+"년"+today_month+"월");
		
	
		int year = Integer.parseInt(calendarDTO.getYear());
		int month = Integer.parseInt(calendarDTO.getMonth())+1;
		
		System.out.println("년도: "+year);
		System.out.println("월: "+month );
		
		
		int today = -1;
		if (today_year==year && today_month == month) {
			SimpleDateFormat dayFrm = new SimpleDateFormat("dd");
			today = Integer.parseInt(dayFrm.format(todayCal.getTime()));
		}
		
		// 캘린더 함수 end
		today_data.put("start", start);
		today_data.put("startDay", startDay);
		today_data.put("endDay", endDay);
		today_data.put("today", today);
		today_data.put("year", year);
		today_data.put("month", month);
		
		List<CalendarDTO> dateList = new ArrayList<CalendarDTO>();
		
		//실질적인 달력 데이터 리스트에 데이터 삽입 시작.
		//일단 시작 인덱스까지 아무것도 없는 데이터 삽입
		for(int i=1; i<start; i++){
			calendarData= new CalendarDTO(null, null, null, null);
			dateList.add(calendarData);
		}
		
		//날짜 삽입
		for (int i = startDay; i <= endDay; i++) {
			if(i==today){
				calendarData= new CalendarDTO(String.valueOf(calendarDTO.getYear()), 
						String.valueOf(calendarDTO.getMonth()), String.valueOf(i), "today");
			}else{
				calendarData= new CalendarDTO(String.valueOf(calendarDTO.getYear()), 
						String.valueOf(calendarDTO.getMonth()), String.valueOf(i), "normal_date");
			}
			dateList.add(calendarData);
		}

		//달력 빈곳 빈 데이터로 삽입
		int index = 7-dateList.size()%7;
		
		if(dateList.size()%7!=0){
			
			for (int i = 0; i < index; i++) {
				calendarData= new CalendarDTO(null, null, null, null);
				dateList.add(calendarData);
			}
		}
		
		//배열에 담음
		model.addAttribute("dateList", dateList);		//날짜 데이터 배열
		model.addAttribute("today", today_data);
		
		return "Mypage/diaryCalendar";
	
	}
	
	@RequestMapping("/mypage/changeCalendar")
	public String changeCalendar(HttpServletRequest req, Model model, HttpSession session, CalendarDTO calendarDTO) {
		
		String flag = (String)session.getAttribute("flag");

		
		///////////////////////////////////////////////////////////////

		String user_id = (String)session.getAttribute("user_id");
		
		if(flag.equals("sitter")) {
			System.out.println("리스트출력준비");
			ArrayList<DiaryDTO> lists = sqlSession.getMapper(MypageImpl.class).sitDiary(user_id);
			System.out.println("lists:"+lists);
			model.addAttribute("lists", lists);
		}
		else {
			ArrayList<DiaryDTO> lists = sqlSession.getMapper(MypageImpl.class).parDiary(user_id);
			
			model.addAttribute("lists", lists);
		}
		
		Map<String, Integer> todayData = new HashMap<String, Integer>();
		Calendar cal = Calendar.getInstance();
		CalendarDTO calendarData;
		
		String yearIdx = req.getParameter("yearIdx");
		String monthIdx = req.getParameter("monthIdx");
		
		System.out.println("yearIdx:"+yearIdx+" monthIdx:"+monthIdx);

	
		//검색 날짜
		if(calendarDTO.getDate().equals("")&&calendarDTO.getMonth().equals("")){
			calendarDTO = new CalendarDTO(String.valueOf(cal.get(Calendar.YEAR)),
					String.valueOf(cal.get(Calendar.MONTH)),String.valueOf(cal.get(Calendar.DATE)),null);
		}
		
		cal.set(Integer.parseInt(calendarDTO.getYear()), Integer.parseInt(calendarDTO.getMonth()), 1);
		
		//해당 월의 첫날
		int startDay = cal.getMinimum(java.util.Calendar.DATE);
		//해당 월의 마지막 날
		int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
		//1일의 요일
		int start = cal.get(java.util.Calendar.DAY_OF_WEEK);
		
		//오늘 날짜 정보
		Calendar todayCal = Calendar.getInstance();
		SimpleDateFormat yearFrm = new SimpleDateFormat("yyyy");
		SimpleDateFormat monthFrm = new SimpleDateFormat("M");

		int today_year = Integer.parseInt(yearFrm.format(todayCal.getTime()));
		int today_month = Integer.parseInt(monthFrm.format(todayCal.getTime()));
		
		System.out.println("오늘: "+today_year+"년"+today_month+"월");
		
		int year = Integer.parseInt(req.getParameter("year"));
		int month = Integer.parseInt(req.getParameter("month"))+1;
		
		int today = -1;
		if (today_year==year && today_month == month) {
			SimpleDateFormat dayFrm = new SimpleDateFormat("dd");
			today = Integer.parseInt(dayFrm.format(todayCal.getTime()));
		}
		
		month = month-1;
		
		System.out.println("파라미터 연도: "+year);
		System.out.println("파라미터 월: "+month );
		
		if(monthIdx==null){
			month = month;
		}
		else if(monthIdx.equals("0")){
		   if(month > 1){
			   System.out.println("진입");
			  month =  month - 1;
		   }
		   else{
			  year = year- 1;
			  month = 12;
		   }
		}
		else if(monthIdx.equals("1")){
		   if(month < 12){
			  month =  month + 1;
		   }
		   else{
			  year = year+ 1;
			  month = 1;
		   }
		}
		
		if(yearIdx==null) {
			year = year;
		}
		else if(yearIdx.equals("0")){
		   year = year- 1;
		}else if(yearIdx.equals("1")){
		   year = year+ 1;
		}
		System.out.println("year: "+year);
		System.out.println("month: "+month);
		
		
		// 캘린더 함수 end
		todayData.put("start", start);
		todayData.put("startDay", startDay);
		todayData.put("endDay", endDay);
		todayData.put("today", today);
		todayData.put("year", year);
		todayData.put("month", month);
		
		System.out.println("해당월의첫날:"+startDay+"해당월의마지막날"+endDay+"오늘:"+today+"그리고"+year+"년"+month+"월");
		
		List<CalendarDTO> dateList = new ArrayList<CalendarDTO>();
		
		//실질적인 달력 데이터 리스트에 데이터 삽입 시작.
		//일단 시작 인덱스까지 아무것도 없는 데이터 삽입
		for(int i=1; i<start; i++){
			calendarData= new CalendarDTO(null, null, null, null);
			dateList.add(calendarData);
		}
		
		//날짜 삽입
		for (int i = startDay; i <= endDay; i++) {
			if(i==today){
				calendarData= new CalendarDTO(String.valueOf(calendarDTO.getYear()), 
						String.valueOf(calendarDTO.getMonth()), String.valueOf(i), "today");
			}else{
				calendarData= new CalendarDTO(String.valueOf(calendarDTO.getYear()), 
						String.valueOf(calendarDTO.getMonth()), String.valueOf(i), "normal_date");
			}
			dateList.add(calendarData);
		}

		//달력 빈곳 빈 데이터로 삽입
		int index = 7-dateList.size()%7;
		
		if(dateList.size()%7!=0){
			
			for (int i = 0; i < index; i++) {
				calendarData= new CalendarDTO(null, null, null, null);
				dateList.add(calendarData);
			}
		}
		System.out.println(dateList);
		//배열에 담음
		model.addAttribute("dateList", dateList);		//날짜 데이터 배열
		model.addAttribute("today", todayData);

		
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
		

		int result = sqlSession.getMapper(MypageImpl.class).sendDiary(idx, parents_id, sitter_id, content);
		map.put("message", "발송 완료되었습니다.");
	
		System.out.println("result:"+result);

		
		return map;
		
		
	}
	
}

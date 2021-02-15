package com.kosmo.slowwalking;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import advertisement.ParameterDTO;
import advertisement.RequestBoardDTO;
import advertisement.RequestBoardImpl;
import member.AdminMemberImpl;
import member.MypageImpl;
import member.SitterImpl;
import member.SitterMemberDTO;
import mutiBoard.DiaryDTO;
import mutiBoard.MultiBoardDTO;

@Controller
public class AdvertisementController {

	@Autowired
	public SqlSession sqlSession;

	// 구인의뢰서 리스트 보기 페이지 이동 요청명(메소드)
	@RequestMapping("/advertisement/requestBoard_list")
	public String ReqeustBoardList(Model model, HttpServletRequest req, Principal principal, ParameterDTO parameterDTO) {
		ArrayList<RequestBoardDTO> lists = new ArrayList<RequestBoardDTO>();
		
		String search = parameterDTO.getSearch();
		System.out.println("search : " + search);
		System.out.println("parameterdto.request_time : " + parameterDTO.getRequest_time());
		
		if("search".equals(search)) {
			
			String age = parameterDTO.getAge();
			
			if(age.equals("상관없음")) {
				parameterDTO.setAge("");
			}
			
			if("".equals(parameterDTO.getRequest_time())) {
				System.out.println("request_time 파라미터 null인가요? : " + parameterDTO.getRequest_time());
				lists = sqlSession.getMapper(RequestBoardImpl.class).noTimeRequestSearch(parameterDTO);
			}else {
				System.out.println("request_time 파라미터 null이 아닌가요?: " + parameterDTO.getRequest_time());
				lists = sqlSession.getMapper(RequestBoardImpl.class).requestSearch(parameterDTO);
			}
			String list_flag=req.getParameter("list_flag");
			
			if(list_flag == null) {
				model.addAttribute("list_flag", list_flag);
				model.addAttribute("lists", lists);
			}
			
			for(RequestBoardDTO dto : lists) { 
				String children_name = dto.getChildren_name();
				String change_name = children_name.substring(0,1) + 0 + children_name.substring(2);
				System.out.println("변환된 아이의 이름 : " + change_name);
				dto.setChildren_name(change_name);
			}
			
			model.addAttribute("list_flag", list_flag);
			model.addAttribute("lists", lists);

			
		}
		else {
			String list_flag=req.getParameter("list_flag");
			String user_id = "";
			try {
				user_id = principal.getName();
				System.out.println("user_id=" + user_id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			if(list_flag == null) {
				lists = sqlSession.getMapper(RequestBoardImpl.class).requestBoard();
				model.addAttribute("list_flag", list_flag);
				model.addAttribute("lists", lists);
			}else {
				lists = sqlSession.getMapper(RequestBoardImpl.class).myRequestBoard(user_id);
				model.addAttribute("lists", lists);
			}
			
			for(RequestBoardDTO dto : lists) { 
				String children_name = dto.getChildren_name();
				String change_name = children_name.substring(0,1) + 0 + children_name.substring(2);
				System.out.println("변환된 아이의 이름 : " + change_name);
				dto.setChildren_name(change_name);
			}
			
			model.addAttribute("list_flag", list_flag);
			model.addAttribute("lists", lists);
		}

		return "advertisement/RequestBoard_list";
	}

	// 구인의뢰서 상세 보기 페이지 이동 요청명(메소드)
	@RequestMapping("/advertisement/requestBoard_view")
	public String ReqeustBoardView(HttpServletRequest req, Model model, Principal principal) {

		String user_id = "";
		try {
			user_id = principal.getName();
			System.out.println("user_id=" + user_id);
		} catch (Exception e) {
			e.printStackTrace();
		}

		String list_flag = req.getParameter("list_flag");
		int index = Integer.parseInt(req.getParameter("idx"));
		// System.out.println("넘어온 인덱스 : " + index);

		RequestBoardDTO requestBoarddto = sqlSession.getMapper(RequestBoardImpl.class).requestBoardView(index);
		
		//단기, 정기를 한글로 변환
		if (requestBoarddto.getRegular_short().equals("regular")) {
			requestBoarddto.setRegular_short("정기적");
		} else if (requestBoarddto.getRegular_short().equals("short")) {
			requestBoarddto.setRegular_short("단기");
		}
		
		//장애 등급을 한글로 변환
		if(requestBoarddto.getDisability_grade().equals("slight")) {
			requestBoarddto.setDisability_grade("경증");
		}else if(requestBoarddto.getDisability_grade().equals("slight")) {
			requestBoarddto.setDisability_grade("중증");
		}
		
		
		//이름의 가운데 글자를 비공개로 변환
		String children_name = requestBoarddto.getChildren_name();
		
		String change_name = children_name.substring(0,1) + 0 + children_name.substring(2);
		System.out.println("변환된 아이의 이름 : " + change_name);
		
		requestBoarddto.setChildren_name(change_name);
		
		//일할 요일과 시간을 나눈다
		String request_time = requestBoarddto.getRequest_time();
		
		//시간을 알기 위해 숫자만 추출
		String time = request_time.replaceAll("[^0-9]", "");
		String date = null;
		
		date = request_time.replaceAll("0", "");
		date = date.replaceAll("1", "");
		date = date.replaceAll("2", "");
		date = date.replaceAll("3", "");
		date = date.replaceAll("4", "");
		date = date.replaceAll("5", "");
		date = date.replaceAll("6", "");
		date = date.replaceAll("7", "");
		date = date.replaceAll("8", "");
		date = date.replaceAll("9", "");
		date = date.replaceAll(":", "");
		
		System.out.println("숫자가 없어진 date : " + date);
		
		//시간 형태로 재배치
		if(time.equals("")) {
			System.out.println("조합되기 전  time이 null일때 : " + time);
			time = "협의가능";
		}else {
			System.out.println("조합되기 전  time이 null아닐때 : " + time);		
			time = time.substring(0,2) + ":" + time.substring(2,4) + " ~ " + time.substring(4,6) + ":" + time.substring(6,8);
		}
		System.out.println("재조합된 시간 형태 :" + time);
	
		System.out.println("requestBoarddto.getRequest_date() : " + requestBoarddto.getRequest_date());
		
		//,로 요일을 배열에 저장함
		String[] requestTimeArray = requestBoarddto.getRequest_date().split(",");
		
		//model로 보낼 arrayList
		ArrayList<String> timeArray = new ArrayList<String>();
		
		//배열을 돌려서 리스트에 배열에 담겨져 있는 요일을 저장
		for(String temp : requestTimeArray) {
			System.out.println("나눠진 일하는 시간  : " + temp);
			if(temp.equals("월")) {
				timeArray.add(temp);
			}else if(temp.equals("화")) {
				timeArray.add(temp);
			}
			else if(temp.equals("화")) {
				timeArray.add(temp);
			}
			else if(temp.equals("수")) {
				timeArray.add(temp);
			}
			else if(temp.equals("목")) {
				timeArray.add(temp);
			}
			else if(temp.equals("금")) {
				timeArray.add(temp);
			}
			else if(temp.equals("토")) {
				timeArray.add(temp);
			}
			else if(temp.equals("일")) {
				timeArray.add(temp);
			}
			else if(temp.equals("협의 가능")) {
				timeArray.add(temp);
			}
		}
		
		//요일이 잘 저장되었는지 확인
		Iterator<String> mapIter = timeArray.iterator();
		
		while(mapIter.hasNext()) {
			System.out.println(mapIter.next());
		}
		
		//시작 시간 자르기
		String start_work = requestBoarddto.getStart_work();
		start_work = start_work.substring(0,10);
		requestBoarddto.setStart_work(start_work);
		
		
		//재조합한 시간을 보냄
		model.addAttribute("time", time);
		//요일을 보냄
		model.addAttribute("timeArray", timeArray);
		//dto보냄
		model.addAttribute("dto", requestBoarddto);
		//시터인지 부모회원인지 확인하는 쿼리문
		String flag = sqlSession.getMapper(RequestBoardImpl.class).flag(user_id);

		System.out.println("시터인지 부모인지 확인 : " + flag);
		//나의 의뢰서리스트에서 온건지 의뢰리스트에서 온건지 확인하는 flag
		model.addAttribute("list_flag", list_flag);
		model.addAttribute("flag", flag);

		return "advertisement/RequestBoard_view";
	}

	// 구인의뢰서 리스트 수정 페이지 이동 요청명(메소드)
	@RequestMapping("/advertisement/requestBoard_edit")
	public String ReqeustBoardEdit(Model model,HttpServletRequest req) {

		int index = Integer.parseInt(req.getParameter("idx"));
		String list_flag = req.getParameter("list_flag");
		
		RequestBoardDTO requestBoarddto = sqlSession.getMapper(RequestBoardImpl.class).requestBoardView(index);
		
		String start_work = requestBoarddto.getStart_work();
		
		
		start_work = start_work.substring(0,10);
		//System.out.println("변환된 시간 : " + start_work);
		
		requestBoarddto.setStart_work(start_work);
		
		model.addAttribute("dto", requestBoarddto);
		model.addAttribute("list_flag", list_flag);

		return "advertisement/RequestBoard_edit";
	}

	// 구인의뢰서 리스트 수정 요청명(메소드)
	@RequestMapping("/advertisement/requestBoardAction_edit")
	public ModelAndView ReqeustBoardEditAction(Model model, MultipartHttpServletRequest req) {
		
		String list_flag = "";
		
		RequestBoardDTO dto = new RequestBoardDTO();
		String path = req.getSession().getServletContext().getRealPath("/resources/images");
		Map returnObj = new HashMap();
		try {
			Iterator itr = req.getFileNames();
			// 파일을 받을수있는 객체
			MultipartFile mfile = null;
			String fileName = "";
			List resultList = new ArrayList();
			
			list_flag = req.getParameter("list_flag");
			System.out.println("파라미터로 넘어온 list_flag : " + list_flag);
			
			// 파일외에 폼값을 받음.
			dto.setIdx(Integer.parseInt(req.getParameter("idx")));
			dto.setId(req.getParameter("id"));
			String title = req.getParameter("title");
			title = " " + title;
			dto.setTitle(title);
			dto.setChildren_name(req.getParameter("children_name"));
			
			
			String advertise = req.getParameter("advertise");
			
			if(advertise == null) {
				advertise = "off";
			}
			
			dto.setAdvertise(advertise);
			dto.setPay(req.getParameter("pay"));
			dto.setRegion(req.getParameter("region"));
			System.out.println("지역 : " + dto.getRegion());
			dto.setRequest_time(req.getParameter("request_time"));
			
			//시간을 알기 위해 숫자만 추출
			String time = req.getParameter("request_time").replaceAll("[^0-9]", "");
			String date = null;
			
			date = req.getParameter("request_time").replaceAll("0", "");
			date = date.replaceAll("1", "");
			date = date.replaceAll("2", "");
			date = date.replaceAll("3", "");
			date = date.replaceAll("4", "");
			date = date.replaceAll("5", "");
			date = date.replaceAll("6", "");
			date = date.replaceAll("7", "");
			date = date.replaceAll("8", "");
			date = date.replaceAll("9", "");
			date = date.replaceAll(":", "");
			
			System.out.println("숫자가 없어진 date : " + date);
			
			//시간 형태로 재배치
			if(time.equals("")) {
				System.out.println("조합되기 전  time이 null일때 : " + time);
				time = "협의가능";
			}else {
				System.out.println("조합되기 전  time이 null아닐때 : " + time);		
				time = time.substring(0,2) + ":" + time.substring(2,4) + " ~ " + time.substring(4,6) + ":" + time.substring(6,8);
			}
			System.out.println("재조합된 시간 형태 :" + time);
		
			dto.setRequest_date(date);
			dto.setRequest_time(time);
			
			
			
			dto.setDisability_grade(req.getParameter("disability_grade"));
			dto.setWarning(req.getParameter("warning"));
			String age = req.getParameter("age");
			age = " " + age;
			dto.setAge(age);
			String regular_short = req.getParameter("regular_short");
			regular_short = " " + regular_short;
			dto.setRegular_short(regular_short);
			dto.setStart_work(req.getParameter("start_work"));
			dto.setContent(req.getParameter("content"));
			
			File directory = new File(path);
			if (!directory.isDirectory()) {
				System.out.println("절대경로의 파일이 없습니다.");
				directory.mkdirs();
			}
			
			while(itr.hasNext()) {
				// 전송된 파일의 이름을 읽어온다.
				fileName = (String) itr.next();
				mfile = req.getFile(fileName);
				System.out.println("mfile=" + mfile);

				//한글깨짐방지 처리후 전송된 파일명을 가져옴
  				String originalName = 
  					new String(mfile.getOriginalFilename().getBytes(),"UTF-8");
  				//서버로 전송된 파일이 없다면 while문의 처음으로 돌아간다.
  				if("".equals(originalName)) {
  					
  					int result = sqlSession.getMapper(RequestBoardImpl.class).noImageUpdateRequestBoard(dto);
  					
  					if(result == 1) {
  						System.out.println("1행이 업데이트되었습니다.");
  					}else {
  						System.out.println("업데이트에 실패했습니다.");
  					}
  					
  					continue;
  				}
  				
	  			//파일명에서 확장자를 가져옴.
				String ext = originalName.substring(originalName.lastIndexOf('.'));
				String saveFileName = getUuid() + ext;
				File serverFullName = 
					new File(path + File.separator + saveFileName);
				
				mfile.transferTo(serverFullName);
				
				String image = sqlSession.getMapper(RequestBoardImpl.class).getImage(dto.getIdx());
				
				System.out.println("찾은 이미지 이름 : " + image);
				if(image!=null) {
					File f = new File(path+ File.separator+ image);
					if(f.exists()) {
						f.delete();
					}
				}
				
				dto.setImage(saveFileName);
				
				int result = sqlSession.getMapper(RequestBoardImpl.class).updateRequestBoard(dto);
				
				if(result == 1) {
					System.out.println("1행이 업데이트되었습니다.");
				}else {
					System.out.println("업데이트에 실패했습니다.");
				}
			
  				
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		ModelAndView mv = new ModelAndView();
		
		if (list_flag.equals("mylist")) {
			mv.setViewName("redirect:requestBoard_Mylist");
		} else {
			mv.setViewName("redirect:requestBoard_list");
		}
		
		return mv;
	}

	// 구인의뢰서 쓰기 페이지 이동 요청명(메소드)
	@RequestMapping("/advertisement/requestBoard_write")
	public String ReqeustBoardWrite(Principal principal, Model model) {

		String user_id = ""; 
		try {
			user_id = principal.getName();
			System.out.println("user_id=" + user_id);
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("user_id", user_id);

		return "advertisement/RequestBoard_write";
	}

	// 구인의뢰서 쓰기 요청명(메소드)
	@RequestMapping(value = "/advertisement/requestBoardAction_write", method = RequestMethod.POST)
	public String ReqeustBoardWriteAction(Model model, MultipartHttpServletRequest req) {

		// System.out.println("들어옴?");

		// 서버의 물리적경로 얻어오기
		String path = req.getSession().getServletContext().getRealPath("/resources/images");
		System.out.println("서버의 물리적경로 : " + path);

		// 폼값과 파일명을 저장후 view로 전달하기 위한 맵컬렉션
		Map returnObj = new HashMap();
		try {
			Iterator itr = req.getFileNames();
			// 파일을 받을수있는 객체
			MultipartFile mfile = null;
			String fileName = "";
			List resultList = new ArrayList();

			// 파일외에 폼값을 받음.
			String id = req.getParameter("id");
			String title = req.getParameter("title");
			title = " " + title;
			String children_name = req.getParameter("children_name");
			String advertise = req.getParameter("advertise");
			String age = req.getParameter("age");
			age = " " + age;
			String pay = req.getParameter("pay");
			String region = req.getParameter("region");
			String request_time = req.getParameter("request_time");
			String disability_grade = req.getParameter("disability_grade");
			String warning = req.getParameter("warning");
			String regular_short = req.getParameter("regular_short");
			regular_short = " " + regular_short;
			String start_work = req.getParameter("start_work");
			String content = req.getParameter("content");
			
			
			//시간을 알기 위해 숫자만 추출
			String time = request_time.replaceAll("[^0-9]", "");
			String date = null;
			
			date = request_time.replaceAll("0", "");
			date = date.replaceAll("1", "");
			date = date.replaceAll("2", "");
			date = date.replaceAll("3", "");
			date = date.replaceAll("4", "");
			date = date.replaceAll("5", "");
			date = date.replaceAll("6", "");
			date = date.replaceAll("7", "");
			date = date.replaceAll("8", "");
			date = date.replaceAll("9", "");
			date = date.replaceAll(":", "");
			
			System.out.println("숫자가 없어진 date : " + date);
			
			//시간 형태로 재배치
			if(time.equals("")) {
				System.out.println("조합되기 전  time이 null일때 : " + time);
				time = "협의가능";
			}else {
				System.out.println("조합되기 전  time이 null아닐때 : " + time);		
				time = time.substring(0,2) + ":" + time.substring(2,4) + " ~ " + time.substring(4,6) + ":" + time.substring(6,8);
			}
			System.out.println("재조합된 시간 형태 :" + time);
		
		
			
			
			

			if (advertise == null) {
				advertise = "off";
			}
			System.out.println("의뢰신청서 보이기 : " + advertise);

			File directory = new File(path);
			if (!directory.isDirectory()) {
				System.out.println("절대경로의 파일이 없습니다.");
				directory.mkdirs();
			}

			while (itr.hasNext()) {
				// 전송된 파일의 이름을 읽어온다.
				fileName = (String) itr.next();
				mfile = req.getFile(fileName);
				System.out.println("mfile=" + mfile);

				// 한글깨짐방지 처리후 전송된 파일명을 가져옴
				String originalName = new String(mfile.getOriginalFilename().getBytes(), "UTF-8");

				System.out.println("원본 파일 이름 : " + originalName);
				// 서버로 전송된 파일이 없다면 while문의 처음으로 돌아간다.
				if ("".equals(originalName)) {
					int result = sqlSession.getMapper(RequestBoardImpl.class).insertRequestBoard(id, title, children_name,
							advertise, age, pay, region, time, disability_grade, warning, regular_short, start_work,
							content, "", date);
					
					if (result == 1) {
						System.out.println("레코드가 1행 입력되었습니다.");

					} else {
						System.out.println("레코드 입력에 실패하였습니다.");
						// 여기에 model 뭐 입력해주고 실패하면 쓰기로 돌아가서 입력이 실패했다는 알람창 뜨게 해주기
					}
					
					
					continue;
				}

				// 파일명에서 확장자를 가져옴.
				String ext = originalName.substring(originalName.lastIndexOf('.'));
				// UUID를 통해 생성된 문자열과 확장자를 합쳐서 파일명 완성
				String saveFileName = getUuid() + ext;
				// 물리적 경로에 새롭게 생성된 파일명으로 파일저장
				File serverFullName = new File(path + File.separator + saveFileName);
				
				mfile.transferTo(serverFullName);
				
				

//				System.out.println("파라미터로 넘어온 id : " + id);
//				System.out.println("파라미터로 넘어온 title : " + title);
//				System.out.println("파라미터로 넘어온 children_name : " + children_name);
//				System.out.println("파라미터로 넘어온 advertise : " + advertise);
//				System.out.println("파라미터로 넘어온 age : " + age);
//				System.out.println("파라미터로 넘어온 pay : " + pay);
//				System.out.println("파라미터로 넘어온 region : " + region);
//				System.out.println("파라미터로 넘어온 request_time : " + request_time);
//				System.out.println("파라미터로 넘어온 disability_grade : " + disability_grade);
//				System.out.println("파라미터로 넘어온 warning : " + warning);
//				System.out.println("파라미터로 넘어온 regular_short : " + regular_short);
//				System.out.println("파라미터로 넘어온 start_work : " + start_work);
//				System.out.println("파라미터로 넘어온 content : " + content);

				int result = sqlSession.getMapper(RequestBoardImpl.class).insertRequestBoard(id, title, children_name,
						advertise, age, pay, region, time, disability_grade, warning, regular_short, start_work,
						content, saveFileName, date);

				if (result == 1) {
					System.out.println("레코드가 1행 입력되었습니다.");

				} else {
					System.out.println("레코드 입력에 실패하였습니다.");
					// 여기에 model 뭐 입력해주고 실패하면 쓰기로 돌아가서 입력이 실패했다는 알람창 뜨게 해주기
				}

			}

		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:requestBoard_list";
	}

	// 구인의뢰서 삭제 요청명(메소드)
	@RequestMapping("/advertisement/requestBoardAction_delete")
	public ModelAndView ReqeustBoardDeleteAction(HttpServletRequest req) {
		
		String path = req.getSession().getServletContext().getRealPath("/resources/images");
		String idx = req.getParameter("idx");
		System.out.println("넘어온 idx" + idx);
		String list_flag = req.getParameter("list_flag");
		System.out.println("넘어온 list_flag" + list_flag);

		ModelAndView mv = new ModelAndView();

		int result = sqlSession.getMapper(RequestBoardImpl.class).deleteRequestBoard(idx);
		String image = sqlSession.getMapper(RequestBoardImpl.class).getImage(Integer.parseInt(idx));
		
		System.out.println("찾은 이미지 이름 : " + image);
		if(image!=null) {
			File f = new File(path+ File.separator+ image);
			if(f.exists()) {
				f.delete();
			}
		}

		if (list_flag.equals("mylist")) {
			mv.setViewName("redirect:requestBoard_Mylist");
		} else {
			mv.setViewName("redirect:requestBoard_list");
		}

		return mv;
	}

	// 시터 리스트 보기 페이지 이동 요청명 (메소드)
	@RequestMapping("/advertisement/SitterBoard_list")
	public String SitterBoardList(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
		//오라클에서 가져온 레코드를 저장하는 lists
		ArrayList<SitterMemberDTO> lists = new ArrayList<>();
		//paramterDTO에 map으로 검색자료를 저장할 map
		Map<String, String> searchmap = new HashMap<String, String>();
		
		if(parameterDTO.getSearch() != null) {
			if(parameterDTO.getRequest_time() != "" && parameterDTO.getRequest_time() != null)
				searchmap.put("activity_time", parameterDTO.getRequest_time());
			if(parameterDTO.getRegion() != "" && parameterDTO.getRegion() != null) {
				searchmap.put("residence1", parameterDTO.getRegion());
				searchmap.put("residence2", parameterDTO.getRegion());
				searchmap.put("residence3", parameterDTO.getRegion());
			}
			if(parameterDTO.getPay() != "" && parameterDTO.getPay() != null)
				searchmap.put("pay", parameterDTO.getPay());
		}
		
		Iterator<String> itr = searchmap.keySet().iterator();
		
		while(itr.hasNext()) {
			String key = itr.next();
			String value = (String)searchmap.get(key);
			
			System.out.println(key + " : " + value);
		}
		
		
		lists = sqlSession.getMapper(SitterImpl.class).list(parameterDTO);
		

		model.addAttribute("lists", lists);
		return "advertisement/SitterBorad_list";
	}

	// 시터 리스트 상세보기 페이지 이동 요청명 및 후기 보기(메소드)
	@RequestMapping("/advertisement/SitterBoard_view")
	public String SitterBoardView(HttpServletRequest req, Model model) {
		
		String id = req.getParameter("id");
		
		SitterMemberDTO dto = sqlSession.getMapper(SitterImpl.class).selectSitter(id);
		
		ArrayList<DiaryDTO> lists = sqlSession.getMapper(MypageImpl.class).CommentList(id);
		model.addAttribute("dto", dto);
		model.addAttribute("lists",lists);
		return "advertisement/SitterBorad_view";
	}

	/*
	 * UUID(Universally Unique Identifier) : 범용 고유 식별자. randomUUID()를통해 문자열을 생성하면
	 * 하이픈이 4개 포함된 32자의 랜덤하고 유니크한 문자열이 생성된다. JDK에서 기본클래스로 제공된다.
	 */
	public static String getUuid() {
		String uuid = UUID.randomUUID().toString();
		System.out.println("생성된UUID-1:" + uuid);
		uuid = uuid.replaceAll("-", "");
		System.out.println("생성된UUID-2:" + uuid);
		return uuid;
	}

}

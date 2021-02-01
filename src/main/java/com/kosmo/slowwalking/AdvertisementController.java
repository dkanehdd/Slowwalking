package com.kosmo.slowwalking;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
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

import advertisement.RequestBoardDTO;
import advertisement.RequestBoardImpl;
import member.SitterImpl;
import member.SitterMemberDTO;


@Controller
public class AdvertisementController {

	@Autowired
	public SqlSession sqlSession;
	
	//구인의뢰서 리스트 보기 페이지 이동 요청명(메소드)
	@RequestMapping("/advertisement/requestBoard_list")
	public String ReqeustBoardList(Model model) {
		ArrayList<RequestBoardDTO> lists = sqlSession.getMapper(RequestBoardImpl.class)
				.requestBoard();
		
		
		model.addAttribute("lists", lists);
		
		
		return "advertisement/RequestBoard_list";
	}
	
	
	//구인의뢰서 상세 보기 페이지 이동 요청명(메소드)
	@RequestMapping("/advertisement/requestBoard_view")
	public String ReqeustBoardView(HttpServletRequest req, Model model) {
		
		int index = Integer.parseInt(req.getParameter("idx"));
		//System.out.println("넘어온 인덱스 : " + index);
		
		RequestBoardDTO requestBoarddto = sqlSession.getMapper(RequestBoardImpl.class)
				.requestBoardView(index);
		
		System.out.println("dto의 regular_short : " + requestBoarddto.getRegular_short());
		if(requestBoarddto.getRegular_short().equals("regular")) {
			requestBoarddto.setRegular_short("정기적");
		}
		else if(requestBoarddto.getRegular_short().equals("short")) {
			requestBoarddto.setRegular_short("단기");
		}
		
		model.addAttribute("dto", requestBoarddto);
		
		return "advertisement/RequestBoard_view";
	}
	
	
	//구인의뢰서 리스트 수정 페이지 이동 요청명(메소드)
	@RequestMapping("/advertisement/requestBoard_edit")
	public String ReqeustBoardEdit() {
		return "advertisement/RequestBoard_edit";
	}
	
	//구인의뢰서 리스트 수정  요청명(메소드)
	@RequestMapping("/advertisement/requestBoardAction_edit")
	public String ReqeustBoardEditAction() {
		return "advertisement/RequestBoard_view";
	}
	
	//구인의뢰서 쓰기 페이지 이동 요청명(메소드)
	@RequestMapping("/advertisement/requestBoard_write")
	public String ReqeustBoardWrite(Principal principal, Model model) {
		
		String user_id="";
		try {
			user_id = principal.getName();
			System.out.println("user_id="+user_id);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("user_id", user_id);
		
		
		return "advertisement/RequestBoard_write";
	}
	
	//구인의뢰서 쓰기  요청명(메소드)
	@RequestMapping(value="/advertisement/requestBoardAction_write", method=RequestMethod.POST)
	public String ReqeustBoardWriteAction(Model model, MultipartHttpServletRequest req){
		
		//System.out.println("들어옴?");
		
		//서버의 물리적경로 얻어오기
		String path = req.getSession().getServletContext().getRealPath("/resources/images");
		
		//폼값과 파일명을 저장후 view로 전달하기 위한 맵컬렉션
		Map returnObj = new HashMap();
		try {
			Iterator itr = req.getFileNames();
			//파일을 받을수있는 객체
			MultipartFile mfile = null;
			String fileName = "";
			List resultList = new ArrayList();
			
			//파일외에 폼값을 받음.
			String id = req.getParameter("id");
			String title = req.getParameter("title");
			String children_name = req.getParameter("children_name");
			String advertise = req.getParameter("advertise");
			String age = req.getParameter("age");
			String pay = req.getParameter("pay");
			String region = req.getParameter("region");
			String request_time = req.getParameter("request_time");
			String disability_grade = req.getParameter("disability_grade");
			String warning = req.getParameter("warning");
			String regular_short = req.getParameter("regular_short");
			String start_work = req.getParameter("start_work");
			String content = req.getParameter("content");
			
			
			if(advertise == null) {
				advertise = "off";
			}
			System.out.println("의뢰신청서 보이기 : " + advertise);
			
			File directory = new File(path);
			if(!directory.isDirectory()) {
				System.out.println("절대경로의 파일이 없습니다.");
				directory.mkdirs();
			}
			
			
			while(itr.hasNext()) {
				//전송된 파일의 이름을 읽어온다.
				fileName = (String)itr.next();
				mfile = req.getFile(fileName);
				System.out.println("mfile="+mfile);
				
				//한글깨짐방지 처리후 전송된 파일명을 가져옴
				String originalName = 
					new String(mfile.getOriginalFilename().getBytes(),"UTF-8");
				
				System.out.println("원본 파일 이름 : " + originalName);
				//서버로 전송된 파일이 없다면 while문의 처음으로 돌아간다.
				if("".equals(originalName)) {
					continue;
				}
				
				//파일명에서 확장자를 가져옴.
				String ext = originalName.substring(originalName.lastIndexOf('.'));
				//UUID를 통해 생성된 문자열과 확장자를 합쳐서 파일명 완성
				String saveFileName = getUuid() + ext;
				//물리적 경로에 새롭게 생성된 파일명으로 파일저장
				File serverFullName = 
					new File(path + File.separator + saveFileName);
				
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
				
				
				int result = sqlSession.getMapper(RequestBoardImpl.class).insertRequestBoard(id,title,children_name, 
						advertise, age, pay, region, request_time, disability_grade, warning,
						regular_short, start_work, content, saveFileName);
				
				if(result == 1) {
					System.out.println("레코드가 1행 입력되었습니다.");
					
				}else {
					System.out.println("레코드 입력에 실패하였습니다.");
					//여기에 model 뭐 입력해주고 실패하면 쓰기로 돌아가서 입력이 실패했다는 알람창 뜨게 해주기
				}

				
			}
			
		}catch (IOException e) {
			e.printStackTrace();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		
		return "redirect:requestBoard_list";
	}
	
	//구인의뢰서 삭제  요청명(메소드)
	@RequestMapping("/advertisement/requestBoardAction_delete")
	public String ReqeustBoardDeleteAction() {
		return "advertisement/RequestBoard_list";
	}
	
	//시터 리스트 보기 페이지 이동 요청명(메소드)
	@RequestMapping("/advertisement/SitterBoard_list")
	public String SitterBoardList(Model model) {
		
		ArrayList<SitterMemberDTO> lists = sqlSession.getMapper(SitterImpl.class).list();
		
		model.addAttribute("lists", lists);
		return "advertisement/SitterBorad_list";
	}
	
	//시터 리스트 상세보기 페이지 이동 요청명(메소드)
	@RequestMapping("/advertisement/SitterBoard_view")
	public String SitterBoardView() {
		return "advertisement/SitterBorad_view";
	}
	
	/*
	UUID(Universally Unique Identifier)
		: 범용 고유 식별자. randomUUID()를통해 문자열을 생성하면
		하이픈이 4개 포함된 32자의 랜덤하고 유니크한 문자열이 생성된다.
		JDK에서 기본클래스로 제공된다.
	 */
	public static String getUuid() {
		String uuid = UUID.randomUUID().toString();
		System.out.println("생성된UUID-1:"+uuid);
		uuid = uuid.replaceAll("-", "");
		System.out.println("생성된UUID-2:"+uuid);
		return uuid;
	}
	
	
	
}

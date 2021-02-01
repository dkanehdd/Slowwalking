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

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import member.ImageTplDAO;
import member.MemberDTO;
import member.MypageImpl;

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
	public String getImage(Model model, Principal principal){
		
		String image_path = sqlSession.getMapper(MypageImpl.class).imgChange(principal.getName());
		System.out.println(image_path);
		
		model.addAttribute("image_path", image_path);
		return "Mypage/imgChange";
	}
	
	//프로필 사진 수정하기
	@RequestMapping(value="mypage/imgChange", method=RequestMethod.POST)
	public String imgChange(Model model, MultipartHttpServletRequest req, MultipartFile file) {
		
		//서버의 물리적경로 얻어오기
		String path = req.getSession().getServletContext().getRealPath("/resources/upload");

		if(file != null && !file.isEmpty()) {
			if(req.getParameter(image_path)!=null) {
				//삭제하는 거
			}
			
			//파일명에서 확장자를 가져온다.
			String ext =
					originalName.substring(originalName.lastIndexOf('.'));
			//UUID를 통해 생성된 문자열과 확장자를 합쳐서 파일명을 완성한다.
			String saveFileName = getUuid() + ext;
			//물리적 경로에 새롭게 생성된 파일명으로 파일 저장
			File serverFullName =
					new File(path + File.separator + saveFileName);
		}
		
		try {
			//업로드폼의 file속성의 필드를 가져온다.(여기서는 2개임)
			Iterator itr = req.getFileNames();
			
			MultipartFile mfile = null;
			String fileName="";
			List resultList = new ArrayList();
			//파일 외에 폼값 받음
			String title = req.getParameter("title");
			System.out.println("title="+title);
			
			/*
			물리적 경로를 기반으로 File객체를 생성한 후 지정된 디렉토리가
			있는지 확인한다. 만약 없다면 mkdirs()로 생성한다. -> make-directory라는 뜻
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
				
				//한글깨짐방지 처리 후 전송된 파일명을 가져온다.
				String originalName =
						new String(mfile.getOriginalFilename().getBytes(), "UTF-8");
				//서버로 전송된 파일이 없다면 while문의 처음으로 돌아간다.
				if("".equals(originalName)) {
					continue;
				}
				
				//파일명에서 확장자를 가져온다.
				String ext =
						originalName.substring(originalName.lastIndexOf('.'));
				//UUID를 통해 생성된 문자열과 확장자를 합쳐서 파일명을 완성한다.
				String saveFileName = getUuid() + ext;
				//물리적 경로에 새롭게 생성된 파일명으로 파일 저장
				File serverFullName =
						new File(path + File.separator + saveFileName);
				
				mfile.transferTo(serverFullName);
				
				Map file = new HashMap();
				//원본 파일명
				file.put("originalName", originalName);
				//저장된 파일명
				file.put("saveFileName", saveFileName);
				//서버의 전체경로
				file.put("serverFullName", serverFullName);
				//제목
				file.put("title", title);
				
				//위 4가지 정보를 저장한 Map을 ArrayList에 저장한다.
				resultList.add(file);
			}
			returnObj.put("files", resultList);
		}
		catch(IOException e) {
			e.printStackTrace();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		//모델객체에 리스트 컬렉션을 저장한 후 뷰로 전달
		model.addAttribute("returnObj", returnObj);
		return "Mypage/proEdit";
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
	public String profileEditAction(MemberDTO memberDTO) {
		
		int result = sqlSession.getMapper(MypageImpl.class).proEdit(memberDTO);
		System.out.println("수정처리:"+result);
		
		return "Mypage/proEdit";
	}
}

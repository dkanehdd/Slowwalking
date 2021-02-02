package admin;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import member.AdminMemberImpl;
import member.AdminSitterImpl;
import member.MemberDTO;
import member.MemberImpl;
import member.SitterImpl;
import member.SitterMemberDTO;
import mutiBoard.MultiBoardDTO;

@Controller
public class AdminSitter {

	@Autowired
	public SqlSession sqlSession;
	
	//admin sitter 회원 목록 처리
		@RequestMapping("/admin/member")
		public String List(Model model, HttpServletRequest req) {
			SitterMemberDTO sitterMemberDTO = new SitterMemberDTO();

			//Mapper 호출
			ArrayList<SitterMemberDTO> lists =
				sqlSession.getMapper(SitterImpl.class)
					.adminSitterlist();
			
			model.addAttribute("lists", lists);
			return "admin/member";
		}
	
		//sitter 가입승인처리
		@RequestMapping("/admin/permmisionAction")
		public String modifyAction(Model model, HttpServletRequest req) {

			
			String id = req.getParameter("id");
			System.out.println(id);
			// 수정폼에서 전송한 모든 폼값을 한꺼번에 저장한 커맨드객체를 사용한다.
			int applyRow = sqlSession.getMapper(AdminSitterImpl.class).permission(id);
			System.out.println("수정처리된 레코드수:" + applyRow);

			return "redirect:../admin/member";
		}
	
		
		//파일목록보기
	  	@RequestMapping("/fileUpload/uploadList.do")
	  	public String uploadList(HttpServletRequest req, Model model)
	  	{
	  		//서버의 물리적경로 얻어오기
	  		String path = req.getSession().getServletContext()
	  			.getRealPath("/resources/upload");
	  		//경로를 기반으로 파일객체 생성
	  		File file = new File(path);
	  		//파일의 목록을 배열형태로 얻어옴
	  		File[] fileArray = file.listFiles();
	  		//뷰로 전달할 파일목록을 저장하기 위해 Map생성
	  		Map<String, Integer> fileMap = new HashMap<String, Integer>();		
	  		for(File f : fileArray){
	  			//Map의 key로 파일명, value로 파일용량을 저장
	  			fileMap.put(f.getName(), (int)Math.ceil(f.length()/1024.0));
	  		}
	  		
	  		model.addAttribute("fileMap", fileMap);				
	  		return "admin/member";
	  	}
	    
	    
	    
	  //파일 다운로드
		@RequestMapping("/fileUpload/download.do")
		public ModelAndView download(HttpServletRequest req
			, HttpServletResponse resp) throws Exception
		{
			//저장된 파일명
			String fileName = req.getParameter("fileName");
			//원본 파일명
			String oriFileName = req.getParameter("oriFileName");
			//물리적경로
			String saveDirectory = req.getSession().getServletContext()
					.getRealPath("/resources/upload");
			//경로와 파일명을 통해 File객체 생성
			File downloadFile = new File(saveDirectory+"/"+fileName);
			//해당 경로에 파일이 있는지 확인
			if(!downloadFile.canRead()) {
				throw new Exception("파일을 찾을수 없습니다");
			}		
			
			ModelAndView mv = new ModelAndView();
			mv.setViewName("fileDownloadView");//다운로드 할 View명
			mv.addObject("downloadFile", downloadFile);//저장된파일명
			mv.addObject("oriFileName", oriFileName);//원본파일명
			return mv;		
		}
}

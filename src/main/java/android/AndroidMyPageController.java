package android;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.ws.Action;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import member.MemberDTO;
import member.MemberImpl;
import member.MypageImpl;
import member.SitterImpl;
import mutiBoard.DiaryDTO;
import util.PagingUtil;

@Controller
public class AndroidMyPageController {

	@Autowired
	SqlSession sqlSession;
	
	@RequestMapping("/android/advertise")
	@ResponseBody
	public Map<String, Object> advertise(HttpServletRequest req) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String id = req.getParameter("id");
		String advertise = req.getParameter("check").equals("true")?"T":"F";
		int suc = sqlSession.getMapper(SitterImpl.class).updateAdvertise(advertise, id);
		System.out.println(suc);
		map.put("message", "보이기상태가 변경되었습니다.");
		map.put("suc", suc);
		
		return map;
	}
	
	@RequestMapping("/android/myinfo")
	@ResponseBody
	public Map<String, Object> myinfo(HttpServletRequest req){
		
		Map<String, Object> map = new HashMap<String, Object>();
		String id = req.getParameter("id");
		
		MemberDTO dto = sqlSession.getMapper(MemberImpl.class).getMember(id);
		map.put("dto",dto );
		
		return map;
	}
	
	@RequestMapping("/android/commentList")
	@ResponseBody
	public ArrayList<DiaryDTO> commentList(HttpSession session, HttpServletRequest req, Model model) {
		
		String id = req.getParameter("id");
		
		
		
		ArrayList<DiaryDTO> lists = sqlSession.getMapper(MypageImpl.class).CommentList(id);


		
		
		
				
		return lists;
	}
}

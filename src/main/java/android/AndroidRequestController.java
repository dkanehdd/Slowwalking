package android;

import java.security.Principal;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import advertisement.RequestBoardDTO;
import advertisement.RequestBoardImpl;

@Controller
public class AndroidRequestController {

	@Autowired
	SqlSession sqlSession;
	
	@RequestMapping("/android/requestBoard_list")
	@ResponseBody
	public ArrayList<RequestBoardDTO> ReqeustBoardList(HttpServletRequest req) {
		
		ArrayList<RequestBoardDTO> lists = new ArrayList<RequestBoardDTO>();
		
			
		lists = sqlSession.getMapper(RequestBoardImpl.class).requestBoard();
			
		for(RequestBoardDTO dto : lists) { 
			String children_name = dto.getChildren_name();
			String change_name = children_name.substring(0,1) + 0 + children_name.substring(2);
			System.out.println("변환된 아이의 이름 : " + change_name);
			dto.setChildren_name(change_name);
		}
		

		return lists;
	}
}

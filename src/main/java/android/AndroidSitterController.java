package android;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import advertisement.ParameterDTO;
import member.SitterImpl;
import member.SitterMemberDTO;

@Controller
public class AndroidSitterController {
	
	@Autowired
	SqlSession sqlSession;
	
	// 시터 리스트 보기 페이지 이동 요청명 (메소드)
	@ResponseBody
	@RequestMapping("/android/SitterBoard_list")
	public Map<String, Object> SitterBoardList(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
		//오라클에서 가져온 레코드를 저장하는 lists
		ArrayList<SitterMemberDTO> lists = new ArrayList<>();
		//paramterDTO에 map으로 검색자료를 저장할 map
		Map<String, String> searchmap = new HashMap<String, String>();
		Map<String, Object> map = new HashMap<String, Object>();
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
		

		map.put("lists", lists);
		return map;
	}

}

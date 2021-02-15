package android;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import advertisement.ParameterDTO;
import member.SitterImpl;
import member.SitterMemberDTO;

@Controller
public class AndroidHomeController {
	
	@Autowired
	SqlSession sqlSession;
	
	@RequestMapping("/android/sitterList")
	@ResponseBody
	public ArrayList<SitterMemberDTO> sitterList(ParameterDTO parameterDTO){
		
		
		ArrayList<SitterMemberDTO> lists = 
				sqlSession.getMapper(SitterImpl.class).list(parameterDTO);
		
		
		return lists;
	}

}

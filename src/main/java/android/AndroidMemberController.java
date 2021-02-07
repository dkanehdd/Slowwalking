package android;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import member.MemberDTO;
import member.MemberImpl;

@Controller
public class AndroidMemberController {

	@Autowired
	SqlSession sqlSession;
	
	@RequestMapping("/android/memberLogin")
	@ResponseBody
	public Map<String, Object> memberLogin(MemberDTO memberDTO) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		MemberDTO memberInfo =
			sqlSession.getMapper(MemberImpl.class).getMemberAndoid(memberDTO);
		
		if(memberInfo==null) {
			//회원정보 불일치로 로그인에 실패한 경우..결과만 0으로 내려준다.
			returnMap.put("isLogin", 0);
		}
		else {
			//로그인에 성공하면 결과는 1, 해당 회원의 정보를 객체로 내려준다. 
			returnMap.put("memberInfo", memberInfo);
			returnMap.put("isLogin", 1);
		}
		
		return returnMap;
	}
}

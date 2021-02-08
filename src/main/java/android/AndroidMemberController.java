package android;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	
	
	//안드로이드 회원가입 조인액션
	@RequestMapping(value = "/android/joinAction", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> MemberJoinAction(Model model, MemberDTO memberDTO, HttpSession session) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		System.out.println(memberDTO.getName());
		System.out.println(memberDTO.getEmail());
		System.out.println(memberDTO.getPw());
		System.out.println(memberDTO.getId());
		System.out.println(memberDTO.getFlag());
		int sucOrFail = sqlSession.getMapper(MemberImpl.class).insertMember(memberDTO);
		//모델객체에 맵? 컬렉션을 저장한 후 뷰로 전달
		if(sucOrFail==1) {

			map.put("sucOrFail", sucOrFail);
			
		} else {
			map.put("sucOrFail", sucOrFail);
		}
		// 회원가입 완료후 이미지 등록
		return map ;
	}
}

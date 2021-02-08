package findMember;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import member.MemberImpl;

public class MemberFindService {

	@Autowired
	private SqlSession sqlSession;
	private MemberImpl mImpl;
	
	//아이디 찾기
	public String GetFindId(String name, String phone) {

		mImpl= sqlSession.getMapper(MemberImpl.class);
		
		String result="";
		try {
			result = mImpl.findId(name, phone);
		} 
		catch (Exception e) {
			e.printStackTrace();
		}

		return result;

	}
}

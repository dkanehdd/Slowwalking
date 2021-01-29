package member;

import java.util.ArrayList;

public interface MemberImpl {

	public ArrayList<MemberDTO> list();
	
	public int checkId(String id);
	
	public int insertMember(MemberDTO memberDTO);
	
	public String flagValidate(String id);
	   public SitterMemberDTO sitMem(String id);
}

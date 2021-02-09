package member;

import java.util.ArrayList;

public interface MemberImpl {

	public ArrayList<MemberDTO> list();

	public int checkId(String id);

	public MemberDTO getMember(String id);
	public MemberDTO getMemberAndoid(MemberDTO membetDTO);
	
	String findId(String name, String phone);//hjkosmo 추가
	String tempPw(String id, String email);//hjkosmo 추가
	String updatePw(String id, String email);//hjkosmo 추가
	public int checkEmail(String email); //hjkosmo 추가
	
	public int insertMember(MemberDTO memberDTO);

	public String flagValidate(String id);

	public String getImage(String id);

	public int insertImage(String id, String image);

	public ArrayList<String> getGu(String sido);
	
	public int updateTicket(int ticket, String id);
	public int updatePoint(int point, String id);
}

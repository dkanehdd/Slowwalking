package member;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import mutiBoard.MultiBoardDTO;

public interface MemberImpl {

	public ArrayList<MemberDTO> list();

	public int checkId(String id);

	public MemberDTO getMember(String id);
	public MemberDTO getMemberAndoid(MemberDTO membetDTO);
	
	public int checkEmail(String email); //hjkosmo 추가
	
	public int insertMember(MemberDTO memberDTO);

	public String flagValidate(String id);

	public String getImage(String id);

	public int insertImage(String id, String image);

	public ArrayList<String> getGu(String sido);
	
	public int updateTicket(int ticket, String id);
	public int updatePoint(int point, String id);
}

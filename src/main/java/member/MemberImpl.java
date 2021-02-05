package member;

import java.util.ArrayList;

import mutiBoard.MultiBoardDTO;

public interface MemberImpl {

	public ArrayList<MemberDTO> list();

	public int checkId(String id);

	public MemberDTO getMember(String id);
	
	public int insertMember(MemberDTO memberDTO);

	public String flagValidate(String id);

	public SitterMemberDTO sitMem(String id);

	public ParentsMemberDTO parMem(String id);
	

	public String getImage(String id);

	public int insertImage(String id, String image);

	public ArrayList<String> getGu(String sido);
}

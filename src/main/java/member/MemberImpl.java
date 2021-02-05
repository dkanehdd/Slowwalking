package member;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import mutiBoard.MultiBoardDTO;

public interface MemberImpl {

	public ArrayList<MemberDTO> list();

	public int checkId(String id);
	
	public int checkEmail(String email); //hjkosmo 추가
	
	public String findId(@Param("name")String name, @Param("phone")String phone); // 유저 ID 찾기 hjkosmo 추가
	public String findPw(@Param("id")String id, @Param("phone")String phone); // 유저 PW 찾기 hjkosmo 추가

	public int insertMember(MemberDTO memberDTO);

	public String flagValidate(String id);

	public SitterMemberDTO sitMem(String id);

	public ParentsMemberDTO parMem(String id);
	

	public String getImage(String id);

	public int insertImage(String id, String image);

	public ArrayList<String> getGu(String sido);
}

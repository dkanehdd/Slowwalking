package member;

import java.util.ArrayList;

import mutiBoard.MultiBoardDTO;

public interface MemberImpl {

	//회원리스트 보기
	public ArrayList<MemberDTO> list();
	
	//어드민 회원정보 수정
	public MemberDTO view(MemberDTO memberDTO);
	//어드민 회원정보 수정처리
	public int modify(MemberDTO memberDTO);	
	//어드민 회원정보 삭제처리
	public int delete(String id);
	
	//공지사항보기
	public ArrayList<MultiBoardDTO> listPage(MemberDTO memberDTO);
	public int getTotalCount(MemberDTO memberDTO);
	
	//공지사항 상세보기
	public MultiBoardDTO contentPage(int idx);
	
	//공지사항 조횟수
	public MultiBoardDTO contentCount(int idx);

	
	
	public int checkId(String id);
	
	public int insertMember(MemberDTO memberDTO);
	
	public String flagValidate(String id);
	   public SitterMemberDTO sitMem(String id);



	
}

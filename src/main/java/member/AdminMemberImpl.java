package member;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;

import mutiBoard.MultiBoardDTO;

public interface AdminMemberImpl {
	
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
	public int contentCount(int idx);
	
	//어드민 공지사항 글등록
	/*
	Mapper에서 파라미터를 전달한 이름 그대로 사용할수 있도록 @Param
	어노테이션을 사용한다. 
	 */
	public int write(MultiBoardDTO multiBoardDTO);
	
	//공지사항수정
	public MultiBoardDTO noticeview(MultiBoardDTO multiBoardDTO);
	
	//공지사항 수정처리
	public int noticemodify(MultiBoardDTO multiBoardDTO);	
	
	//공지사항 삭제처리
	public int noticedelete(int idx);



	
}

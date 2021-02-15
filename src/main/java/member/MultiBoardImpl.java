package member;

import java.util.ArrayList;

import mutiBoard.MultiBoardDTO;

public interface MultiBoardImpl {

	// 공지사항보기
	public ArrayList<MultiBoardDTO> listPage(MemberDTO memberDTO);

	public int getTotalCount(MemberDTO memberDTO);

	// 공지사항 상세보기
	public MultiBoardDTO contentPage(int idx);

	// 공지사항 조횟수
	public MultiBoardDTO contentCount(int idx);
	//채팅 인설트
	public int chatwrite(ChattingDTO chattingDTO);
	
	//채팅 리스트불러오기
	public int chatlist(ChattingDTO chattingDTO);    
}

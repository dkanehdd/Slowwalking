package member;

import java.util.ArrayList;
import java.util.Map;

import advertisement.InterviewDTO;
import mutiBoard.DiaryDTO;

public interface MypageImpl {
	
	//프로필 정보 가져오기
	public MemberDTO profile(String id);
	//프로필 수정
	public int proEdit(MemberDTO memberDTO);
	public MemberDTO getImage(String id);
	public ArrayList<InterviewDTO> sitInterList(String id);
	public ArrayList<InterviewDTO> parInterList(String id);
	//인터뷰 요청 목록(내 구인/구직현황)
	public int addInterList(int idx, String parents_id, String sitter_id, String request_time );
	public int delInterList(int idx);
	public InterviewDTO interList(int idx);
	//수락
	public int sitAgree(int idx);
	public int parAgree(int idx);
	//알림장
	public int sendDiary(int idx, String parents_id, String sitter_id, String content);
	public ArrayList<DiaryDTO> sitDiary(String id);
	public ArrayList<DiaryDTO> parDiary(String id);


}

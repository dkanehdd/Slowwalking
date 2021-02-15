package member;

import java.util.ArrayList;
import java.util.Map;

import advertisement.InterviewDTO;
import mutiBoard.DiaryDTO;
import mutiBoard.OrderDTO;

public interface MypageImpl {
	
	//프로필 정보 가져오기
	public MemberDTO profile(String id);
	//프로필 수정
	public int proEdit(MemberDTO memberDTO);
	public MemberDTO getImage(String id);
	public ArrayList<InterviewDTO> sitInterList(String id);
	public ArrayList<InterviewDTO> parInterList(String id);
	//인터뷰 요청 목록(내 구인/구직현황)
	public int sitterApply(int idx, String my_id, String your_id, String request_time );
	public int parentsApply(String my_id, String your_id, String request_time );
	public int delInterList(int idx);
	public int ticketCount(String id);
	public int updateCount(String id);
	public InterviewDTO interList(int idx);
	public InterviewDTO getAgree(int idx);
	public ArrayList<InterviewDTO> andsitInterList(String id);
	public ArrayList<InterviewDTO> andparInterList(String id);
	public ArrayList<InterviewDTO> andsitDiaryList(String id);
	
	public int countParentsInterview(String id);
	public int countSitterInterview(String id);
	//수락
	public int sitAgree(int idx);
	public int parAgree(int idx);
	//알림장
	public int sendDiary(int idx, String send_id, String rece_id, String content);
	public ArrayList<DiaryDTO> sitDiary(String id, int idx);
	public ArrayList<DiaryDTO> parDiary(String id, int idx);
	public DiaryDTO diaryView(int its_idx);

	//후기
	public int writeComment(int idx, String send_id, String rece_id, String content, int starrate);
	public ArrayList<DiaryDTO> receivedComment(String id, int start, int end);
	public ArrayList<DiaryDTO> sendedComment(String id, int start, int end);
	public DiaryDTO edit(int idx);
	public int editAction(int idx, String content);
	public int delAction(int idx);
	public int receCount(String id);
	public int sendCount(String id);
	public int setStarrate(String id, int rate);
	public int getStarrate(String id);
	public int getPoint(String id);
	
	public ArrayList<DiaryDTO> CommentList(String id); 
	//이용권
	public ArrayList<OrderDTO> purchaseList(String id);

}

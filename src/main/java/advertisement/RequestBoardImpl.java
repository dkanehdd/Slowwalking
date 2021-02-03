package advertisement;

import java.util.ArrayList;

public interface RequestBoardImpl {  
	
	//구직의뢰서 리스트를 가져오는 메소드
	public ArrayList<RequestBoardDTO> requestBoard();
	
	//나의 구직의뢰서 리스트를 가져오는 메소드
	public ArrayList<RequestBoardDTO> myRequestBoard(String user_id);
	
	//부모회원인지 시터회원인지 flag을 반환하는 메소드
	public String flag(String user_id);
	
	//구직의뢰서 상세보기를 가져오는 메소드
	public RequestBoardDTO requestBoardView(int idx);
	
	//admin에서 의뢰서 삭제
	public int requestBoardDelete(int idx);

	
	//구직의뢰서 쓰기
	public int insertRequestBoard(String id, String title, String children_name,
			String advertise, String age, String pay, String region, String request_time,
			String disability_grade, String warning, String regular_short, String start_work,
			String content, String saveFileName);
	
	//의뢰서 작세
	public int deleteRequestBoard(String idx);
	
	//의뢰서 이미지 가져오기
	public String getImage(int idx);
	
	//이미지 포함 의뢰서 업데이트
	public int updateRequestBoard(RequestBoardDTO dto);
	
	//이미지 제외 의뢰서 업데이트
	public int noImageUpdateRequestBoard(RequestBoardDTO dto);
	
}

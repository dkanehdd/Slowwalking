package advertisement;

import java.util.ArrayList;

public interface RequestBoardImpl {  
	
	//구직의뢰서 리스트를 가져오는 메소드
	public ArrayList<RequestBoardDTO> requestBoard();
	
	//구직의뢰서 상세보기를 가져오는 메소드
	public RequestBoardDTO requestBoardView(int idx);
	
	//admin에서 의뢰서 삭제
	public int requestBoardDelete(int idx);

	
	//구직의뢰서 쓰기
	public int insertRequestBoard(String id, String title, String children_name,
			String advertise, String age, String pay, String region, String request_time,
			String disability_grade, String warning, String regular_short, String start_work,
			String content, String saveFileName);
	
}

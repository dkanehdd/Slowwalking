package advertisement;

import java.util.ArrayList;

public interface RequestBoardImpl {  
	
	//구직의뢰서 리스트를 가져오는 메소드
	public ArrayList<RequestBoardDTO> requestBoard();
	
	//구직의뢰서 상세보기를 가져오는 메소드
	public RequestBoardDTO requestBoardView(int idx);
	
}

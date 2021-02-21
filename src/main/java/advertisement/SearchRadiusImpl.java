package advertisement;

import java.util.ArrayList;

public interface SearchRadiusImpl {
	
	/*
	검색하고자 하는 반경과 현재위치의 위/경도를 매개변수로 받아 
	검색된 항목의 갯수를 반환
	*/
	public int searchCount(int distance, double latTxt, double lngTxt);
	/*
	위와 동일한 조건에서 검색된 레코드를 start, end로 잘라서 200개씩 레코드 반환
	*/
	public ArrayList<MyHospitalDTO> searchRadius(int distance,
			double latTxt, double lngTxt, int start, int end);
}

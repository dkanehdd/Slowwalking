package mutiBoard;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

public class CalendarDTO {
	
	String year = "";
	String month = "";
	String date = "";
	String value = "";
	String schedule = "";
	String schedule_detail = "";
	
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getSchedule() {
		return schedule;
	}
	public void setSchedule(String schedule) {
		this.schedule = schedule;
	}
	public String getSchedule_detail() {
		return schedule_detail;
	}
	public void setSchedule_detail(String schedule_detail) {
		this.schedule_detail = schedule_detail;
	}
	
//	//달력 정보
//	public Map<String , Integer> today_info(CalendarDTO calendarDTO){
//		
//		Map<String, Integer> today_Data = new HashMap<String, Integer>();
//		Calendar cal = Calendar.getInstance();
//		cal.set(Integer.parseInt(calendarDTO.getYear()), Integer.parseInt(calendarDTO.getMonth()), 1);
//
//		int startDay = cal.getMinimum(java.util.Calendar.DATE);
//		int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
//		int start = cal.get(java.util.Calendar.DAY_OF_WEEK);
//		
//		Calendar todayCal = Calendar.getInstance();
//		SimpleDateFormat yearFrm = new SimpleDateFormat("yyyy");
//		SimpleDateFormat monthFrm = new SimpleDateFormat("M");
//
//		int today_year = Integer.parseInt(yearFrm.format(todayCal.getTime()));
//		int today_month = Integer.parseInt(monthFrm.format(todayCal.getTime()));
//
//		int search_year = Integer.parseInt(calendarDTO.getYear());
//		int search_month = Integer.parseInt(calendarDTO.getMonth()) + 1;
//
//		int today = -1;
//		if (today_year == search_year && today_month == search_month) {
//			SimpleDateFormat dayFrm = new SimpleDateFormat("dd");
//			today = Integer.parseInt(dayFrm.format(todayCal.getTime()));
//		}
//		
//		search_month = search_month-1; 
//		
//		Map<String, Integer> before_after_calendar = before_after_calendar(search_year,search_month);
//		
//		//날짜 관련
//		System.out.println("search_month : " + search_month);
//		// 캘린더 함수 end
//		today_Data.put("start", start);
//		today_Data.put("startDay", startDay);
//		today_Data.put("endDay", endDay);
//		today_Data.put("today", today);
//		today_Data.put("search_year", search_year);
//		today_Data.put("search_month", search_month+1);
//		today_Data.put("before_year", before_after_calendar.get("before_year"));
//		today_Data.put("before_month", before_after_calendar.get("before_month"));
//		today_Data.put("after_year", before_after_calendar.get("after_year"));
//		today_Data.put("after_month", before_after_calendar.get("after_month"));
//		return today_Data;
//	}
//	
//	//이전달 다음달 및 이전년도 다음년도
//	private Map<String, Integer> before_after_calendar(int search_year, int search_month){
//		Map<String, Integer> before_after_data = new HashMap<String, Integer>();
//		int before_year = search_year;
//		int before_month = search_month-1;
//		int after_year = search_year;
//		int after_month = search_month+1;
//
//		if(before_month<0){
//			before_month=11;
//			before_year=search_year-1;
//		}
//		
//		if(after_month>11){
//			after_month=0;
//			after_year=search_year+1;
//		}
//		
//		before_after_data.put("before_year", before_year);
//		before_after_data.put("before_month", before_month);
//		before_after_data.put("after_year", after_year);
//		before_after_data.put("after_month", after_month);
//		
//		return before_after_data;
//	}
	
	// 스케줄 사용시 사용될 생성자
		public CalendarDTO(String year, String month, String date, String value, String schedule, String schedule_detail) {

			this.year = year;
			this.month = month;
			this.date = date;
			this.value = value;
			this.schedule = schedule;
			this.schedule_detail = schedule_detail;

		}

		// 달력만 사용시 사용될 생성자
		public CalendarDTO(String year, String month, String date, String value) {
			if ((month != null && month != "") && (date != null && date != "")) {
				this.year = year;
				this.month = month;
				this.date = date;
				this.value = value;
			}
		}

		public CalendarDTO() {}

		@Override
		public String toString() {
			return "DateData [year=" + year + ", month=" + month + ", date=" + date + ", value=" + value + "]";
		}
}

package scheduler;

import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import member.SitterImpl;

@Component
public class Scheduler {
	
	@Autowired
	SqlSession sqlSession;
	/*
	참조URL : https://m.blog.naver.com/deeperain/221609802306
	초 | 분 | 시 | 일 | 월 | 요일 | 연도

	0~59 | 0~59 | 0~23 | 1~31 | 1~12 | 0~6 | 생략가능
	 */
	//@Scheduled(cron = "0 48 11 * * *") // 매일 11시 48분에 실행
	@Scheduled(cron = "0 30 11 * * *") //매일 11시 30분에 호출
	public void autoUpdate() {
		
		// 날짜시간에 대한 포맷 지정
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
		// 현재 시간을 위의 포맷으로 변경
		sqlSession.getMapper(SitterImpl.class).premiumUpdateAll();
		String nowTime = LocalTime.now().format(formatter);
		System.out.println("스케쥴러 호출됩니다."+ nowTime);
		
	}
}

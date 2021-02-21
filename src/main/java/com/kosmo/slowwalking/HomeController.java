package com.kosmo.slowwalking;

import java.security.Principal;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import advertisement.MyHospitalDTO;
import advertisement.SearchRadiusImpl;
import member.MypageImpl;
import mutiBoard.DiaryDTO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	SqlSession sqlSession;
	
	private static final String apiKey = "AIzaSyBydzPIfrdGj3DuawS1kU7Mhq97HxnJf_c";
	
	@RequestMapping("/main/main")
	public String home(HttpSession session, Model model) {
		model.addAttribute("apiKey", apiKey);
		
		ArrayList<DiaryDTO> lists = sqlSession.getMapper(MypageImpl.class).mainComment();
		
		//게시물의 줄바꿈 처리
		for(DiaryDTO diary : lists) {
			String temp = diary.getContent().replace("\r\n", "<br/>");
			diary.setContent(temp);
		}
				
		model.addAttribute("lists", lists);
		
		
		return "Main/slowwalking";
	}
	
	
	
	//내위치기반시설물반경검색
	@RequestMapping("/main/searchRadius")
	public String geoFunc3(Model model, HttpServletRequest req) {
		model.addAttribute("apiKey", apiKey);
		
		//폼값 받기
		int distance = (req.getParameter("distance")==null) ?
				0 : Integer.parseInt(req.getParameter("distance"));
		double latTxt = (req.getParameter("distance")==null) ?
				0 : Double.parseDouble(req.getParameter("latTxt"));
		double lngTxt = (req.getParameter("distance")==null) ?
				0 : Double.parseDouble(req.getParameter("lngTxt"));
		
		//검색결과 카운트
		int numberPerPage = 200;
		int resultCount = sqlSession.getMapper(SearchRadiusImpl.class)
				.searchCount(distance, latTxt, lngTxt);
		
		model.addAttribute("resultCount", "검색결과 : "+resultCount+" 건");
		model.addAttribute("selectNum", Math.ceil(resultCount/numberPerPage));
		
		int pageNum = (req.getParameter("pageNum")==null) ?
				1 : Integer.parseInt(req.getParameter("pageNum"));
		int start = ((pageNum - 1) * numberPerPage) + 1;
		int end = pageNum * numberPerPage;
		
		System.out.println(distance+" "+latTxt+" "+lngTxt+" "+
				start+" "+end);
		ArrayList<MyHospitalDTO> searchLists = null;
		if(distance!=0) {
			searchLists = sqlSession.getMapper(SearchRadiusImpl.class)
					.searchRadius(distance, latTxt, lngTxt, start, end);
		}
		model.addAttribute("searchLists", searchLists);
		System.out.println(searchLists);
		
		return "Main/searchRadius";
	}
	
}

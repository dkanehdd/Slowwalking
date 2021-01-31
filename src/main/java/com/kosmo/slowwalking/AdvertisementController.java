package com.kosmo.slowwalking;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import advertisement.RequestBoardDTO;
import advertisement.RequestBoardImpl;
import member.SitterImpl;
import member.SitterMemberDTO;

@Controller
public class AdvertisementController {

	@Autowired
	public SqlSession sqlSession;
	
	//구인의뢰서 리스트 보기 페이지 이동 요청명(메소드)
	@RequestMapping("/advertisement/requestBoard_list")
	public String ReqeustBoardList(Model model) {
		ArrayList<RequestBoardDTO> lists = sqlSession.getMapper(RequestBoardImpl.class)
				.requestBoard();
		
		
		model.addAttribute("lists", lists);
		
		
		return "advertisement/RequestBoard_list";
	}
	
	//구인의뢰서 상세 보기 페이지 이동 요청명(메소드)
	@RequestMapping("/advertisement/requestBoard_view")
	public String ReqeustBoardView(HttpServletRequest req, Model model) {
		
		int index = Integer.parseInt(req.getParameter("idx"));
		//System.out.println("넘어온 인덱스 : " + index);
		
		RequestBoardDTO requestBoarddto = sqlSession.getMapper(RequestBoardImpl.class)
				.requestBoardView(index);
		
		model.addAttribute("dto", requestBoarddto);
		
		return "advertisement/RequestBoard_view";
	}
	
	
	//구인의뢰서 리스트 수정 페이지 이동 요청명(메소드)
	@RequestMapping("/advertisement/requestBoard_edit")
	public String ReqeustBoardEdit() {
		return "advertisement/RequestBoard_edit";
	}
	
	//구인의뢰서 리스트 수정  요청명(메소드)
	@RequestMapping("/advertisement/requestBoardAction_edit")
	public String ReqeustBoardEditAction() {
		return "advertisement/RequestBoard_view";
	}
	
	//구인의뢰서 쓰기 페이지 이동 요청명(메소드)
	@RequestMapping("/advertisement/requestBoard_write")
	public String ReqeustBoardWrite() {
		return "advertisement/RequestBoard_write";
	}
	
	//구인의뢰서 쓰기  요청명(메소드)
	@RequestMapping("/advertisement/requestBoardAction_write")
	public String ReqeustBoardWriteAction() {
		return "advertisement/RequestBoard_list";
	}
	
	//구인의뢰서 삭제  요청명(메소드)
	@RequestMapping("/advertisement/requestBoardAction_delete")
	public String ReqeustBoardDeleteAction() {
		return "advertisement/RequestBoard_list";
	}
	
	//시터 리스트 보기 페이지 이동 요청명(메소드)
	@RequestMapping("/advertisement/SitterBoard_list")
	public String SitterBoardList(Model model) {
		
		ArrayList<SitterMemberDTO> lists = sqlSession.getMapper(SitterImpl.class).list();
		
		model.addAttribute("lists", lists);
		return "advertisement/SitterBorad_list";
	}
	
	//시터 리스트 상세보기 페이지 이동 요청명(메소드)
	@RequestMapping("/advertisement/SitterBoard_view")
	public String SitterBoardView() {
		return "advertisement/SitterBorad_view";
	}
	
	
	
}

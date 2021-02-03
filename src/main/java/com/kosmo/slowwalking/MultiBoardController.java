package com.kosmo.slowwalking;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import member.MemberDTO;
import member.MultiBoardImpl;
import mutiBoard.MultiBoardDTO;
import mutiBoard.ProductDTO;
import mutiBoard.ProductImpl;

@Controller
public class MultiBoardController {

	@Autowired
	public SqlSession sqlSession;

	// 공지사항으로 이동하는 요청명(메소드)
	@RequestMapping("/multiBoard/notice")
	public String list(Model model, HttpServletRequest req) {

		// 파라미터 저장을 위한 DTO객체 생성
		MemberDTO memberDTO = new MemberDTO();
		int totalRecordCount = sqlSession.getMapper(MultiBoardImpl.class).getTotalCount(memberDTO);
		// Mapper 호출
		ArrayList<MultiBoardDTO> lists = sqlSession.getMapper(MultiBoardImpl.class).listPage(memberDTO);

		model.addAttribute("lists", lists);

		return "MultiBoard/Notice";
	}

	// 공지사항 내용보기
	@RequestMapping("/multiBoard/notice_view") // 상세보기 눌렀을 때 , 요청명.
	public String contentview(Model model, HttpServletRequest req) {
		int idx = Integer.parseInt(req.getParameter("idx"));
		// 파라미터 저장을 위한 DTO객체 생성
		
		MultiBoardDTO multiBoardDTO = new MultiBoardDTO();
		// Mapper 호출
		multiBoardDTO = sqlSession.getMapper(MultiBoardImpl.class).contentPage(idx); // DTO객체에 쿼리문 실행 결과를 담는다.

		model.addAttribute("dto", multiBoardDTO); // model에 저장해서 view로 전달해주는 객체 dto.

		return "MultiBoard/Notice_view";
	}

	// 상품목록으로 이동하는 요청명(메소드)
	@RequestMapping("/multiBoard/product")
	public String productList(Model model, HttpServletRequest req) {

		// 파라미터 저장을 위한 DTO객체 생성
		ProductDTO productDTO = new ProductDTO();
		// Mapper 호출
		ArrayList<ProductDTO> lists = sqlSession.getMapper(ProductImpl.class).productList();

		model.addAttribute("lists", lists);

		return "MultiBoard/Product";
	}

	// 상품목록 내용보기
	@RequestMapping("/multiBoard/product_view") // 상세보기 눌렀을때 요청명
	public String productView(Model model, HttpServletRequest req) {
		String idx = req.getParameter("idx");
		// 파라미터 저장을 위한 DTO객체 생성
		// MemberDTO memberDTO = new MemberDTO();

		ProductDTO productDTO = new ProductDTO();
		// Mapper 호출
		productDTO = sqlSession.getMapper(ProductImpl.class).contentPage(idx); // DTO객체에 쿼리문 실행 결과를 담는다.

		model.addAttribute("dto", productDTO); // model에 저장해서 view로 전달해주는 객체 dto

		return "MultiBoard/Product_view";
	}
}
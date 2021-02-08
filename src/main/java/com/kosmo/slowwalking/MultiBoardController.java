package com.kosmo.slowwalking;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import member.MemberDTO;
import member.MemberImpl;
import member.MultiBoardImpl;
import mutiBoard.MultiBoardDTO;
import mutiBoard.OrderDTO;
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

	@RequestMapping("/multiBoard/FAQ")
	public String FAQ(Model model, HttpServletRequest req) {

		return "MultiBoard/FAQ";
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
	
	//결제페이지 이동
	@RequestMapping("/multiBoard/order")
	public String order(HttpServletRequest req, Model model,HttpSession session) {
		String idx = req.getParameter("idx");
		String flag = req.getParameter("flag");
		
		MemberDTO memberDTO = sqlSession.getMapper(MemberImpl.class).getMember(session.getAttribute("user_id").toString());
		
		ProductDTO dto = sqlSession.getMapper(ProductImpl.class).contentPage(idx);
		System.out.println(dto.getPrice());
		
		model.addAttribute("memberDTO", memberDTO);
		model.addAttribute("dto", dto);
		model.addAttribute("flag", flag);
		
		return "MultiBoard/order";
	}
	
	//결제완료후 DB저장
	@RequestMapping("/multiBoard/order_complete")
	@ResponseBody
	public Map<String, Object> Order_complete(HttpServletRequest req, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		OrderDTO dto = new OrderDTO();
		dto.setId(req.getParameter("id"));
		dto.setProduct_idx(Integer.parseInt(req.getParameter("idx")));
		System.out.println("상품 일련번호 : "+ req.getParameter("idx"));
		dto.setTotal_price(Integer.parseInt(req.getParameter("price")));
		dto.setPayment(req.getParameter("payment"));
		dto.setInfo("구매자 : "+ req.getParameter("id")
					+ ", 금액 : "+req.getParameter("price")
					+ ", 결제방식 : "+ req.getParameter("payment"));
		
		int suc = sqlSession.getMapper(ProductImpl.class).insertOrder(dto);
		ProductDTO productDTO = sqlSession.getMapper(ProductImpl.class).contentPage(req.getParameter("idx"));
		System.out.println("티켓 : "+productDTO.getTicket()+" 적립금 : "+ productDTO.getPrice()/20);
		System.out.println("구매자 : "+ req.getParameter("id"));
		int updateP = sqlSession.getMapper(MemberImpl.class).updatePoint(productDTO.getPrice()/20, req.getParameter("id"));
		int updateT = sqlSession.getMapper(MemberImpl.class).updateTicket(productDTO.getTicket(), req.getParameter("id"));
		System.out.println("포인트 결과 : "+ updateP + "티켓 결과 : "+ updateT);
		map.put("suc", suc);
		
		return map;
	}
}
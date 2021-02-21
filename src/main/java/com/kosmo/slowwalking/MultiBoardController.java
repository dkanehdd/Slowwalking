package com.kosmo.slowwalking;

import java.security.Principal;
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
import org.springframework.web.servlet.ModelAndView;

import member.MemberDTO;
import member.MemberImpl;
import member.MultiBoardImpl;
import member.SitterImpl;
import mutiBoard.ChattingDTO;
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
	public String productList(Model model, HttpServletRequest req, HttpSession session, Principal principal) {
		
		String user_id = principal.getName();
		System.out.println("id:"+user_id);
		System.out.println("flag:"+(String)session.getAttribute("flag"));
		
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
		int price = Integer.parseInt(req.getParameter("price"));
		String p = req.getParameter("usepoint")==null||req.getParameter("usepoint").equals("")?"0":req.getParameter("usepoint");
		int usepoint = Integer.parseInt(p);
		
		MemberDTO memberDTO = sqlSession.getMapper(MemberImpl.class).getMember(session.getAttribute("user_id").toString());
		
		ProductDTO Pdto = sqlSession.getMapper(ProductImpl.class).contentPage(idx);
		System.out.println(Pdto.getPrice());
		Pdto.setPrice(price);

		if(price==0) {
			int updateT = sqlSession.getMapper(MemberImpl.class).updateTicket(Pdto.getTicket(), memberDTO.getId());
			OrderDTO dto = new OrderDTO();
			dto.setId(session.getAttribute("user_id").toString());
			dto.setProduct_idx(Integer.parseInt(idx));
			System.out.println("상품 일련번호 : "+ req.getParameter("idx"));
			dto.setTotal_price(Integer.parseInt(req.getParameter("price")));
			dto.setPayment("point");
			dto.setInfo("구매자 : "+ req.getParameter("id")
						+ ", 금액 : "+req.getParameter("price")
						+ ", 결제방식 : "+ "point");
			int suc = sqlSession.getMapper(ProductImpl.class).insertOrder(dto);
			int point  = sqlSession.getMapper(MemberImpl.class).deletePoint(req.getParameter("usepoint"),memberDTO.getId());
			return "redirect:../multiBoard/product";
		}
	
		model.addAttribute("memberDTO", memberDTO);
		model.addAttribute("usepoint",usepoint);
		model.addAttribute("dto", Pdto);
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
		
		if(productDTO.getFlag().equals("ticket")) {
			System.out.println("티켓구매 업데이트");
			System.out.println("티켓 : "+productDTO.getTicket()+" 적립금 : "+ productDTO.getPrice()/20);
			System.out.println("구매자 : "+ req.getParameter("id"));
			int updateP = sqlSession.getMapper(MemberImpl.class).updatePoint(productDTO.getPrice()/20, req.getParameter("id"));
			int updateT = sqlSession.getMapper(MemberImpl.class).updateTicket(productDTO.getTicket(), req.getParameter("id"));
      int usepoint  = sqlSession.getMapper(MemberImpl.class).deletePoint(req.getParameter("point"),req.getParameter("id"));
			System.out.println("포인트 결과 : "+ updateP + "티켓 결과 : "+ updateT);
		}
		else {
			System.out.println("프리미엄권 구매");
			System.out.println("티켓 : "+productDTO.getTicket()+" 적립금 : "+ productDTO.getPrice()/20);
			System.out.println("구매자 : "+ req.getParameter("id"));
			int premiumdate = sqlSession.getMapper(SitterImpl.class).updatePremiumdate(productDTO.getTicket(), req.getParameter("id"));
			int premium = sqlSession.getMapper(SitterImpl.class).updatePremium(req.getParameter("id"));
			System.out.println("프리미엄권 구매결과"+premiumdate);
			System.out.println("프리미엄 날짜 업데이트 "+premium);
		}
		 
		map.put("suc", suc);
		
		return map;
	}
	@RequestMapping("/chat/insertChat")
	   @ResponseBody
	   public Map<String, Object> insertChat(HttpServletRequest req) {
	      Map<String, Object> map = new HashMap<String, Object>();
	      String message = req.getParameter("message");
	      String room = req.getParameter("room");
	      
	      System.out.println(message+"*****");
	      ChattingDTO dto = new ChattingDTO();
	      
	      dto.setRoom(room);
	      
	      String[] messageArr = message.split("/");
	      System.out.println(messageArr[0]);
	      System.out.println(messageArr[1]);
	      dto.setSend_id(messageArr[0].substring(0, messageArr[0].length()-1));
	      String[] arr = messageArr[1].split(" ");
	      String content = "";
	      for(int i =1 ; i<arr.length ; i++) {
	    	  content+= arr[i]+" ";
	      }
	      dto.setRece_id(arr[0]);
	      dto.setContent(content);
	      System.out.println(arr[0]);
	      System.out.println(arr[1]);
	      int write = sqlSession.getMapper(MultiBoardImpl.class).chatwrite(dto);
	      System.out.println("성공???"+write);
	      
	      map.put("save", write);
	      
	      return map;
	   }
}

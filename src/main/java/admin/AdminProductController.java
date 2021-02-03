package admin;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import advertisement.RequestBoardDTO;
import advertisement.RequestBoardImpl;
import member.AdminMemberImpl;
import member.MemberDTO;
import member.MemberImpl;
import member.SitterImpl;
import member.SitterMemberDTO;
import mutiBoard.MultiBoardDTO;
import mutiBoard.OrderDTO;
import mutiBoard.ProductDTO;
import mutiBoard.ProductImpl;

@Controller
public class AdminProductController {

	@Autowired
	public SqlSession sqlSession;

	@RequestMapping("/admin/product")
	public String productList(Model model) {

		ArrayList<ProductDTO> lists = sqlSession.getMapper(ProductImpl.class).productList();

		model.addAttribute("lists", lists);
		return "admin/productList";
	}

	@RequestMapping("/admin/productWrite")
	public String productWrite() {
		// 상품등록 페이지 진입
		return "admin/productwrite";
	}

	@RequestMapping(value = "/admin/productWriteAction", method = RequestMethod.POST)
	public String productWriteAction(Model model, MultipartHttpServletRequest req) {

		String view = "";
		ProductDTO productDTO = new ProductDTO();
		productDTO.setProduct_name(req.getParameter("product_name"));
		productDTO.setContent(req.getParameter("content"));
		productDTO.setPrice(Integer.parseInt(req.getParameter("price")));
		// 서버의 물리적경로 얻어오기
		String path = req.getSession().getServletContext().getRealPath("/resources/product");
		System.out.println(path);
		try {
			Iterator itr = req.getFileNames();
			MultipartFile mfile = null;
			String fileName = "";
			File directory = new File(path);
			if (!directory.isDirectory()) {
				directory.mkdirs();
			}
			while (itr.hasNext()) {
				// 전송된 파일의 이름을 읽어온다.
				fileName = (String) itr.next();
				mfile = req.getFile(fileName);
				System.out.println("mfile=" + mfile);

				// 한글깨짐방지 처리후 전송된 파일명을 가져옴
				String originalName = new String(mfile.getOriginalFilename().getBytes(), "UTF-8");

				// 서버로 전송된 파일이 없다면 while문의 처음으로 돌아간다.
				if ("".equals(originalName)) {
					continue;
				}
				File serverFullName = new File(path + File.separator + originalName);
				mfile.transferTo(serverFullName);
				productDTO.setImage(originalName);
			}
			int pro = sqlSession.getMapper(ProductImpl.class).insertProduct(productDTO);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:../admin/product";
	}

	// 결제관리 테이블 리스트
	@RequestMapping("/admin/orderList")
	public String orderList(Model model, HttpServletRequest req) {
		OrderDTO orderDTO = new OrderDTO();

		// Mapper 호출
		ArrayList<OrderDTO> lists = sqlSession.getMapper(ProductImpl.class).orderList();

		model.addAttribute("lists", lists);
		return "admin/orderList";

	}

	// 상품수정 페이지 진입
	@RequestMapping("/admin/productmodify")
	public String productmodify(HttpServletRequest req, Model model) {

		String idx = req.getParameter("idx");

		ProductDTO dto = sqlSession.getMapper(ProductImpl.class).contentPage(idx);

		model.addAttribute("dto", dto);
		return "admin/productmodify";
	}

	// 상품 수정하기
	@RequestMapping(value = "/admin/productmodifyAction", method = RequestMethod.POST)
	public String productmodifyAction(Model model, MultipartHttpServletRequest req) {

		String view = "";
		ProductDTO productDTO = new ProductDTO();
		productDTO.setIdx(Integer.parseInt(req.getParameter("idx")));
		productDTO.setProduct_name(req.getParameter("product_name"));
		productDTO.setContent(req.getParameter("content"));
		productDTO.setPrice(Integer.parseInt(req.getParameter("price")));
		// 서버의 물리적경로 얻어오기
		String path = req.getSession().getServletContext().getRealPath("/resources/product");
		System.out.println(path);
		String image = req.getParameter("originalfile");
		try {
			Iterator itr = req.getFileNames();
			MultipartFile mfile = null;
			String fileName = "";
			File directory = new File(path);
			if (!directory.isDirectory()) {
				directory.mkdirs();
			}
			if (itr.hasNext()) {
				// 전송된 파일의 이름을 읽어온다.
				fileName = (String) itr.next();
				mfile = req.getFile(fileName);
				System.out.println("mfile=" + mfile);

				// 한글깨짐방지 처리후 전송된 파일명을 가져옴
				String originalName = new String(mfile.getOriginalFilename().getBytes(), "UTF-8");
				
				File serverFullName = new File(path + File.separator + originalName);
				mfile.transferTo(serverFullName);
				productDTO.setImage(originalName);
				// 이미 등록된 사진이 있는경우 원래있던 파일 삭제
				
				if (image != null) {
					File f = new File(path + File.separator + image);
					if (f.exists()) {
						f.delete();
					}
				}
			}
			else {
				productDTO.setImage(image);
			}
			int pro = sqlSession.getMapper(ProductImpl.class).updateProduct(productDTO);
		} catch (IOException e) {
			e.printStackTrace(); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:../admin/product";
	}
	
	// 상품수정 페이지 진입
		@RequestMapping("/admin/productdelete")
		public String productDelete(HttpServletRequest req, Model model) {

			String idx = req.getParameter("idx");

			int dto = sqlSession.getMapper(ProductImpl.class).deleteProduct(idx);

			return "redirect:../admin/product";
		}


}

package admin;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import member.SitterImpl;
import member.SitterMemberDTO;
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

	@RequestMapping(value="/admin/productWriteAction", method = RequestMethod.POST)
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

		return "redirect:../admin/productList";
	}

}

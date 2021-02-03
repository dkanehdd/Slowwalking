package mutiBoard;

import java.util.ArrayList;

public interface ProductImpl {

	public ArrayList<ProductDTO> productList();
	public ProductDTO contentPage(String idx);
	
	public int insertProduct(ProductDTO productDTO);
	public int updateProduct(ProductDTO productDTO);
	public int deleteProduct(String idx);
	// 상품결제관리 리스트
	public ArrayList<OrderDTO> orderList();
	
}

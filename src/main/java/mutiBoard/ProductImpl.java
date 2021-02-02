package mutiBoard;

import java.util.ArrayList;

public interface ProductImpl {

	public ArrayList<ProductDTO> productList();
	public ProductDTO contentPage(String idx);
	
	public int insertProduct(ProductDTO productDTO);
}

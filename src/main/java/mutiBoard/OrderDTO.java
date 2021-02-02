package mutiBoard;

public class OrderDTO {

	private int idx;
	private String id;
	private int product_idx;
	private String payment;
	private String info;
	private int total_price;
	private java.sql.Date regidate;
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getProduct_idx() {
		return product_idx;
	}
	public void setProduct_idx(int product_idx) {
		this.product_idx = product_idx;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	public java.sql.Date getregidate() {
		return regidate;
	}
	public void setregidate(java.sql.Date regidate) {
		this.regidate = regidate;
	}
	
	
	
	
	
}

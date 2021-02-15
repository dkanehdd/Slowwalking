package mutiBoard;

public class ChattingDTO {

	private java.sql.Date regidate;
	private String send_id;
	private String rece_id;
	private String content;
	
	public java.sql.Date getRegidate() {
		return regidate;
	}
	public void setRegidate(java.sql.Date regidate) {
		this.regidate = regidate;
	}
	public String getSend_id() {
		return send_id;
	}
	public void setSend_id(String send_id) {
		this.send_id = send_id;
	}
	public String getRece_id() {
		return rece_id;
	}
	public void setRece_id(String rece_id) {
		this.rece_id = rece_id;
	} 
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
}

package mutiBoard;

public class ChattingDTO {

	private String regidate;
	private String send_id;
	private String rece_id;
	private String content;
	private String room;
	
	
	public String getRoom() {
		return room;
	}
	public void setRoom(String room) {
		this.room = room;
	}
	public String getRegidate() {
		return regidate;
	}
	public void setRegidate(String regidate) {
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

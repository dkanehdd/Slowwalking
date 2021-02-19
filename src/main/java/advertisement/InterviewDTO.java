package advertisement;

public class InterviewDTO {
	private int idx;
	private String parents_id;
	private String sitter_id;
	private String request_time;
	private String parents_agree;
	private String sitter_agree;
	private String parents_status;
	private String sitter_status;
	private int request_idx;

	
	///인터뷰을 신청한 부모회원과 시터회원의 이름을 알아오기 위한 맴버변수
	private String parents_name;
	private String sitter_name;
	
	
	
	public String getParents_status() {
		return parents_status;
	}
	public void setParents_status(String parents_status) {
		this.parents_status = parents_status;
	}
	public String getSitter_status() {
		return sitter_status;
	}
	public void setSitter_status(String sitter_status) {
		this.sitter_status = sitter_status;
	}
	public String getParents_name() {
		return parents_name;
	}
	public void setParents_name(String parents_name) {
		this.parents_name = parents_name;
	}
	public String getSitter_name() {
		return sitter_name;
	}
	public void setSitter_name(String sitter_name) {
		this.sitter_name = sitter_name;
	}
	public int getRequest_idx() {
		return request_idx;
	}
	public void setRequest_idx(int request_idx) {
		this.request_idx = request_idx;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getParents_id() {
		return parents_id;
	}
	public void setParents_id(String parents_id) {
		this.parents_id = parents_id;
	}
	public String getSitter_id() {
		return sitter_id;
	}
	public void setSitter_id(String sitter_id) {
		this.sitter_id = sitter_id;
	}
	public String getRequest_time() {
		return request_time;
	}
	public void setRequest_time(String request_time) {
		this.request_time = request_time;
	}
	public String getParents_agree() {
		return parents_agree;
	}
	public void setParents_agree(String parents_agree) {
		this.parents_agree = parents_agree;
	}
	public String getSitter_agree() {
		return sitter_agree;
	}
	public void setSitter_agree(String sitter_agree) {
		this.sitter_agree = sitter_agree;
	}
	
	
	
	
}

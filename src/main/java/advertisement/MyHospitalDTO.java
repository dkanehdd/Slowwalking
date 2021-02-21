package advertisement;

public class MyHospitalDTO {
	
	private String hp_name;
	private String hp_sido;
	private String hp_gugun;
	private String hp_addr;
	private String hp_explain;
    private String hp_tel;
	private String hp_latitude;
	private String hp_longitude;
	private String disKM;
	private String rNum;
	
	
	public MyHospitalDTO() {}

	public MyHospitalDTO(String hp_name, String hp_sido, String hp_gugun, String hp_addr, String hp_explain,
			String hp_tel, String hp_latitude, String hp_longitude, String disKM, String rNum) {
		super();
		this.hp_name = hp_name;
		this.hp_sido = hp_sido;
		this.hp_gugun = hp_gugun;
		this.hp_addr = hp_addr;
		this.hp_explain = hp_explain;
		this.hp_tel = hp_tel;
		this.hp_latitude = hp_latitude;
		this.hp_longitude = hp_longitude;
		this.disKM = disKM;
		this.rNum = rNum;
	}

	public String getHp_name() {
		return hp_name;
	}

	public void setHp_name(String hp_name) {
		this.hp_name = hp_name;
	}

	public String getHp_sido() {
		return hp_sido;
	}

	public void setHp_sido(String hp_sido) {
		this.hp_sido = hp_sido;
	}

	public String getHp_gugun() {
		return hp_gugun;
	}

	public void setHp_gugun(String hp_gugun) {
		this.hp_gugun = hp_gugun;
	}

	public String getHp_addr() {
		return hp_addr;
	}

	public void setHp_addr(String hp_addr) {
		this.hp_addr = hp_addr;
	}

	public String getHp_explain() {
		return hp_explain;
	}

	public void setHp_explain(String hp_explain) {
		this.hp_explain = hp_explain;
	}

	public String getHp_tel() {
		return hp_tel;
	}

	public void setHp_tel(String hp_tel) {
		this.hp_tel = hp_tel;
	}

	public String getHp_latitude() {
		return hp_latitude;
	}

	public void setHp_latitude(String hp_latitude) {
		this.hp_latitude = hp_latitude;
	}

	public String getHp_longitude() {
		return hp_longitude;
	}

	public void setHp_longitude(String hp_longitude) {
		this.hp_longitude = hp_longitude;
	}

	public String getDisKM() {
		return disKM;
	}

	public void setDisKM(String disKM) {
		this.disKM = disKM;
	}

	public String getrNum() {
		return rNum;
	}

	public void setrNum(String rNum) {
		this.rNum = rNum;
	}
	
}

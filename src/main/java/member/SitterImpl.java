package member;

import java.util.ArrayList;

import advertisement.ParameterDTO;

public interface SitterImpl {

	public ArrayList<SitterMemberDTO> list(ParameterDTO parameterDTO);
	public ArrayList<SitterMemberDTO> adminSitterlist();
	public int insertSitter(SitterMemberDTO sitterMemberDTO);
	
	public SitterMemberDTO selectSitter(String id);
	
	public int updateSitter(SitterMemberDTO sitterMemberDTO);
	public int updateLicense(String filename, String id);
	public int updateAdvertise(String advertise, String id);
	
	public int updatePremiumdate(int ticket, String id);
	public int updatePremium(String id);
	public int resetPremium(String id);
}

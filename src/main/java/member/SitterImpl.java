package member;

import java.util.ArrayList;
import java.util.Map;

import advertisement.ParameterDTO;

public interface SitterImpl {

	public ArrayList<SitterMemberDTO> list(ParameterDTO parameterDTO);
	public ArrayList<SitterMemberDTO> adminSitterlist();
	public int insertSitter(SitterMemberDTO sitterMemberDTO);
	
	public SitterMemberDTO selectSitter(String id);
}

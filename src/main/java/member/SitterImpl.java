package member;

import java.util.ArrayList;

public interface SitterImpl {

	public ArrayList<SitterMemberDTO> list();
	public ArrayList<SitterMemberDTO> adminSitterlist();
	public int insertSitter(SitterMemberDTO sitterMemberDTO);
}

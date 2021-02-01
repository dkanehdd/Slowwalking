package member;

public interface MypageImpl {
	
	public MemberDTO profile(String id);
	public int proEdit(MemberDTO memberDTO);
	public String imgChange(String id);
}

package user;
//자바빈즈 구현
public class User {
	//게시판에 작성된 글정보를 저장하는 필드
	private String userID;
	private String userPassword;
	private String userName;
	private String userPhone;
	private String userEmail;
	
	//private로 저장된 유저의 정보를 가져오고, 수정하는 getter, setter생성
	public String getUserID() { return userID; }
	public void setUserID(String userID) { this.userID = userID; }
	public String getUserPassword() { return userPassword; }
	public void setUserPassword(String userPassword) { this.userPassword = userPassword; }
	public String getUserName() { return userName; }
	public void setUserName(String userName) { this.userName = userName; }
	public String getUserPhone() { return userPhone; }
	public void setUserPhone(String userPhone) { this.userPhone = userPhone; }
	public String getUserEmail() { return userEmail; }
	public void setUserEmail(String userEmail) { this.userEmail = userEmail; }
}
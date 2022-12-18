package bbs;

public class Bbs {
	//유저의 정보를 저장하는 필드
	private int bbsID;
	private String bbsTitle;
	private String userID;
	private String bbsDate;
	private String bbsContent;
	private int bbsAvailable;

	//private로 저장된 유저의 정보를 가져오고, 수정하는 getter, setter생성
	public int getBbsID() { return bbsID; }
	public void setBbsID(int bbsID) { this.bbsID = bbsID; }
	public String getBbsTitle() { return bbsTitle; }
	public void setBbsTitle(String bbsTitle) { this.bbsTitle = bbsTitle; }
	public String getUserID() { return userID; }
	public void setUserID(String userID) { this.userID = userID; }
	public String getBbsDate() { return bbsDate;	}
	public void setBbsDate(String bbsDate) { this.bbsDate = bbsDate;	}
	public String getBbsContent() { return bbsContent; }
	public void setBbsContent(String bbsContent) { this.bbsContent = bbsContent; }
	public int getBbsAvailable() { return bbsAvailable; }
	public void setBbsAvailable(int bbsAvailable) { this.bbsAvailable = bbsAvailable; }	
}

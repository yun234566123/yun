package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class BbsDAO {
	Connection con;
	Statement stmt;
	ResultSet rs;
	PreparedStatement pstmt;
	
	//드라이버 로드
		static{
		try { 
			Class.forName("oracle.jdbc.driver.OracleDriver"); 
		} catch (ClassNotFoundException e) {}
		}

	//드라이버 연결
	public void connect() { 
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String userid = "javalink";
		String pwd = "javalink";
		
		try {
			con = DriverManager.getConnection(url,userid,pwd); 
		} catch (SQLException e) {
			System.out.println("데이터베이스 연결 실패");
		}
	}	
	
	//글 작성 시간을 표시하기 위한 메소드
	public String getDate() {
		connect();
		String SQL = "SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD hh24:mi:ss') FROM dual"; 
		//현재 시간을 검색하는 쿼리문
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			// PreparedStatement : statement를 상속받는 인터페이스, SQL구문을 실행시키는 기능을 갖는 객체
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //데이베이스 오류
	}
	
	//순번을 출력할때, 하나씩 더해지도록하는 메소드
	public int getNext() {
		connect();
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
		//bbs테이블의 순번을 내림차순으로 정렬하여 검색
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1; //가장 높은 순번에 1을 더한 값을 리턴
			}
			return 1; //현재가 첫 번째 개시물일경우 1을 리턴
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return -1; //오류
	}
	
	//게시글을 작성하는 메소드
	public int write(String bbsTitle, String userID, String bbsContent) {
		connect();
		String SQL = "INSERT INTO BBS VALUES (?, ?, ?, ?, ?, ?)"; //동적쿼리
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1,getNext()); //하나씩 값을 넣어줌, 첫번째는 다음번에 쓰여야 할 게시글번호
			pstmt.setString(2,bbsTitle);
			pstmt.setString(3,userID);
			pstmt.setString(4,getDate()); //글을 작성했을때의 시간을 받아옴
			pstmt.setString(5,bbsContent);
			pstmt.setInt(6,1); //Available이니까 처음에 글을 작성했을때, 글이 보여지도록함 (삭제가 안됨)
			return pstmt.executeUpdate(); //INSERT의 경우 성공하면 0이상의 값을, 실패하면 -1을 반환
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return -1; //오류
	}
	
	//게시판 목록에 표시되는 글을 검색하는 메소드
	public ArrayList<Bbs> getList(){
		connect();
		ArrayList<Bbs> list = new ArrayList<Bbs>(); //Bbs클래스 타입의 리스트 생성
		try {
			stmt = con.createStatement(); 
			String sql = "SELECT * FROM bbs WHERE bbsAvailable = 1 ORDER BY bbsID DESC";
			//bbsAvailable이 1인 글을 검색
			rs = stmt.executeQuery(sql); //쿼리실행
			while(rs.next()) { //있는 글의 수만큼 반복
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6)); //속성들을 저장
				list.add(bbs); //리스트에 저장
			}
		} catch (SQLException e) {
			System.out.println("게시글이 없습니다.");
		} 
		return list;
	}
	
	//특정한 id값을 받아 그에 해당하는 게시글을 가져오는 메소드
	public Bbs getBbs(int bbsID) { 
		connect();
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?"; //bbsID가 특정한 숫자일경우 어떠한 행위를 수행할 수 있게 해줌
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) { //값이 존재하면
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs; //결과로 나온 각각의 6개의 변수를 다 받아서 bbs인스턴스에 넣어서 메소드를 불러온 대상에게 반환함
			}
		} catch (Exception e) {
			System.out.println("bbsID가 존재하지 않습니다.");
		}
		return null; //해당 글이 존재하지 않을때는 null을 반환
	}
	
	//게시글을 수정하는 메소드
	public int update(int bbsID, String bbsTitle, String bbsContent) { 
		connect();
		try {
			String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?"; //특정한 ID에 해당하는 제목과 내용을 바꿈 
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setString(1,bbsTitle); 
			pstmt.setString(2,bbsContent);
			pstmt.setInt(3,bbsID); 
			return pstmt.executeUpdate(); //성공적으로 실행이 되면 0이상의 값을 반환 
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return -1; //오류
	}
	
	//게시글을 삭제하는 메소드
	public int delete(int bbsID) {
		connect();
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?"; //bbsAvailable을 0으로 바꾸어 글목록에 표시되지 않도록함
//		String SQL = "DELETE FROM BBS WHERE bbsID =?";
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1,bbsID); 
			return pstmt.executeUpdate(); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //오류
	}
}
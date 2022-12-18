package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class UserDAO {
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
	
	//로그인 메소드 : 성공(1), 비밀번호오류(0), 아이디오류(-1), 데이터베이스오류(-2) 리턴
	public int login(String userID, String userPassword) {
		connect();
		String SQL = "SELECT userPassword FROM users WHERE userID = ?";
		try {
			pstmt = con.prepareStatement(SQL); //SQL문장을 데이터베이스에 삽입, 동적쿼리
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery(); //SQL문을 실행
			if (rs.next()) { // 결과가 존재하는지 여부 확인
				if (rs.getString(1).equals(userPassword)) // 결과에서 얻은 비밀번호가 유저의 비밀번호와 동일한지 여부 확인
					return 1; // 로그인 성공
				else
					return 0; // 비밀번호 불일치
			}
			return -1; // 아이디가 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	}

	//회원가입을 수행하는 메소드
	public int join(User user) {
		connect();
		String SQL = "INSERT INTO users VALUES (?, ?, ?, ?, ?)"; //동적쿼리
		try {
			pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserPhone());
			pstmt.setString(5, user.getUserEmail()); //각각의 인덱스에 해당하는 곳에 주어진 값을 넣음
			return pstmt.executeUpdate(); //실행하고 종료 (DB에 INSERT가 됨)
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
}

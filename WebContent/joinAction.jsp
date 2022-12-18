<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%> <!-- UserDAO클래스의 데이터를 사용-->
<%@ page import="java.io.PrintWriter"%> <!-- 자바스크립트를 사용 -->
<%
	request.setCharacterEncoding("UTF-8"); //받아온 데이터의 인코딩방식을 UTF-8로 변환
%>
<jsp:useBean id="user" class="user.User" scope="page" />
<!-- User클래스를 자바빈즈로 사용, page내에서만 자바빈즈가 사용됨 -->
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userPhone" />
<jsp:setProperty name="user" property="userEmail" />
<!-- ID, Password, Name, Phone, Email의 정보를  user클래스에 저장 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JoinAction</title>
</head>
<body>
	<% //자바코드 사용
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
			//세션에 userID가 저장되어 있으면 userID를 받아서 저장함
		}
		
		//세션에 저장된 ID가 존재할때
		if(userID != null){ //userID가 존재 -> 이미 로그인 되어있음
			PrintWriter script = response.getWriter(); //자바스크립트 코드 사용
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
		}
		
		//회원가입 페이지에 입력되지 않은 사항이 하나라도 있을때
		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null 
				 || user.getUserPhone() == null || user.getUserEmail() == null){
			PrintWriter script = response.getWriter(); //자바스크립트 코드 사용
			script.println("<script>");
			script.println("alert('입력되지 않은 정보가 있습니다.')");
			script.println("history.back()"); //다시 회원가입 페이지로 이동
			script.println("</script>");
		} else{ //모든 사항이 입력되었으면
			UserDAO userDAO = new UserDAO(); //객체생성
			int result = userDAO.join(user); //성공하면 INSERT를 하고 실패하면 -1리턴
			if(result == -1){ //회원가입에 실패 -> userID가 PRIMARY KEY이므로 중복이 발생하면 실패함
				PrintWriter script = response.getWriter(); //자바스크립트 코드 사용
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()"); //이전 페이지로 이동
				script.println("</script>");
			} else{ //정상적으로 회원가입 완료
				session.setAttribute("userID", user.getUserID());
				PrintWriter script = response.getWriter(); //자바스크립트 코드 사용
				script.println("<script>");
				script.println("location.href = 'board.jsp'"); //게시판 페이지로 이동
				script.println("</script>");
			}
 		}
	%>
</body>
</html>
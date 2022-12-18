<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<!-- UserDAO클래스의 메소드를 사용하기 위해 import -->
<%@ page import="java.io.PrintWriter"%>
<!-- 자바스크립트 문장을 작성하기 위해 사용 -->
<%
	request.setCharacterEncoding("UTF-8"); //전달받은 정보들을 UTF-8로 인코딩
%>
<jsp:useBean id="user" class="user.User" scope="page" />
<!-- User클래스를 자바빈즈로 사용, id생성, id의User에 접근, page내에서만 자바빈즈가 사용됨 -->
<jsp:setProperty name="user" property="userID" />
<!-- 로그인 페이지의 userID를 받아서 하나의 페이지에 넣어줌 -->
<jsp:setProperty name="user" property="userPassword" />
<!-- 페이지 안의 userID와 userPassword가 담김 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LoginAction</title>
</head>
<body>
	<% //자바 코드를 사용하기 위한 태그
		String userID = null;
	//세션에 저장된 데이터가 있을경우 처리
	//세션 : 클라이언트별로 서버에 저장되는 정보
	if(session.getAttribute("userID") != null){ 
		userID = (String) session.getAttribute("userID"); //userID를 받아와 String타입으로 형변환 
		//getAttribute는 getParameter와 달리 Object타입으로 데이터를 받아오기 떄문에 형변환이 필요
		//주로 빈 객체나 다른 클래스를 받아올 때 사용
	}
	
	//이미 로그인되어있을때의 처리
	if(userID != null){
		PrintWriter script = response.getWriter(); //자바스크립트 코드 사용
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다.')");
		script.println("location.href = 'board.jsp'"); //게시판 페이지로 돌아감
		script.println("</script>");
	}
	
	//UserDAO에 저장된 정보를 받아올 때
	UserDAO userDAO = new UserDAO(); //객체생성
	int result = userDAO.login(user.getUserID(), user.getUserPassword());
	//user에 저장된 ID와 Password를 매개변수로 로그인성공(1), 비밀번호 불인치(0), 아이디없음(-1), 데이터베이스오류(-2)를 저장

	if(result == 1){ //로그인 성공
		session.setAttribute("userID", user.getUserID()); //user클래스의 userID에 로그인에서 받아온 userID를 저장
		PrintWriter script = response.getWriter(); //자바스크립트 코드 사용
		script.println("<script>");
		script.println("location.href = 'board.jsp'"); //로그인이 성공하면 board.jsp페이지로 이동
		script.println("</script>");
	} else if(result == 0){ //비밀번호 오류
		PrintWriter script = response.getWriter(); //자바스크립트 코드 사용
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.')");
		script.println("history.back()"); //로그인이 실패했기 때문에 이전 페이지인 로그인페이지로 돌아감
		script.println("</script>");		
	} else if(result == -1){ //아이디가 존재하지 않을때
		PrintWriter script = response.getWriter(); //자바스크립트 코드 사용
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다.')");
		script.println("history.back()"); //이전페이지로 이동		
		script.println("</script>");
	} else if(result == -2){ //데이터베이스 오류가 발생했을때
		PrintWriter script = response.getWriter(); //자바스크립트 코드 사용
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생하였습니다.')");
		script.println("histort.back()"); //이전페이지로 이동
		script.println("</script>");
	}
	%>
</body>
</html>
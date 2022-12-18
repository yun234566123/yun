<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %> <!-- BbsDAO클래스의 메소드를 사용해야함 -->
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 사용 -->
<% //받아온 데이터를 UTF-8로 인코딩
  request.setCharacterEncoding("UTF-8"); 
%>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" /> <!-- 페이지의 데이터를 Bbs클래스에 보냄  -->
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WriteAction</title>
</head>
<body>
  <%
		String userID = null;
		if (session.getAttribute("userID") != null){ //세션에 userID가 있으면 받아옴
			userID = (String) session.getAttribute("userID");
		}
		
		if (userID == null){ //세션에 userID가 없으면 로그인페이지로 돌아감
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else{
			if(bbs.getBbsTitle() == null||bbs.getBbsContent() == null){
				//제목과 내용중 빈칸이 존재하면 정보를 전달하지 않고, 글쓰기 페이지로 되돌아감
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else{ //모든 사항이 입력되었으면
				BbsDAO bbsDAO = new BbsDAO(); //메소드를 사용하기 위한 객체생성
				int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent()); 
				if (result == -1) { //오류가 발생하면 DB에 정보를 저장하지 않고, 글쓰기 페이지로 돌아감
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else { //글쓰기에 성공하면 DB에 정보를 저장하고, 게시글 목록 페이지로 이동함
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'board.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %> <!-- Bbs, BbsDAO의 메소드와 필드 사용 -->
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 사용 -->
<%
  request.setCharacterEncoding("UTF-8");  //전달받은 정보를 UTF-8로 변환
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateAction</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		
		if (userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID")); 
		}
				
		if( bbsID == 0){
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')"); 
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID); 
		if(!userID.equals(bbs.getUserID())){ 
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");  
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
			//여기까지는 writeAction과 동일
			
		} else{
			if(request.getParameter("bbsTitle") == null||request.getParameter("bbsContent") == null ||
					request.getParameter("bbsTitle").equals("")||request.getParameter("bbsContent").equals("")){
				//입력받은 사항에 null이나 ""이 있는 경우 다시 입력하도록 수정페이지로 돌아감
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else{
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
				
				//받아온 bbsTitle과 bbsContent를 매개변수로 전달하여 글을 수정하는 메소드를 실행함
				if (result == -1) { //수정 오류
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글수정에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else { //수정 성공시 게시글목록으로 돌아감
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
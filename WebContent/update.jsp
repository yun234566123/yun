<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 사용 -->
<%@ page import="bbs.Bbs" %> 
<%@ page import="bbs.BbsDAO" %> <!-- BbsDAO, Bbs클래스의 메소드와 필드 사용 -->
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="css/view.css" />
    <title>update</title>
  </head>
  <body>
  <%
		String userID = null;
		if(session.getAttribute("userID") != null){ //세션에 userID가 있으면 전달받아 저장
			userID = (String) session.getAttribute("userID");
		}
		
		if(userID == null){ //세션에 userID가 없으면 로그인페이지로 돌아감
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('로그인을 하세요.')"); 
			script.println("location.href = 'login.jsp'");
			script.println("</script>");	
		}
		
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){ //받아온 bbsID값이 있으면 저장함
			bbsID = Integer.parseInt(request.getParameter("bbsID")); 
		}
		
		if( bbsID == 0){ //받아온 bbsID값이 없으면 글이 존재하지 않으므로 게시글 목록으로 이동 
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
		}
		
		Bbs bbs = new BbsDAO().getBbs(bbsID); //현재 작성한 글이 작성한 사람 본인인지 확인해야함
											  //세션관리 필요 -> 넘어온 bbsID값을 가지고 해당 글을 가져온 다음 실제로 글을 작성한 사람이 맞는지 확인
		if(!userID.equals(bbs.getUserID())){ //유저의 ID와 작성자의 ID가 다를경우
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('권한이 없습니다.')"); //작성자 본인이 아닌데 글을 수정하려고 할때 
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
		}
	%>
    <h1>글 수정</h1>
    <form method="POST" action="updateAction.jsp?bbsID=<%=bbsID%>" class="writeAction" >
    <!-- post방식으로 제목과 내용, bbsID를 updateAction.jsp페이지에 전달 -->
      <table class="write"> 
        <tr>
       	  <td> 제목 </td>
       	  <td><input type="text" name="bbsTitle" /></td>
        </tr>
        <tr>
 	      <td> 내용 </td>
          <td>
            <textarea name="bbsContent" cols="30" rows="10" ></textarea>
          </td>
        </tr>
        <tr>
          <td>
            <input type="submit" value="수정" class="btnWrite" />
          </td>
          <td>
            <input type="button" value="취소" class="btnCancle" onclick="location.href='view.jsp?bbsID=<%=bbsID%>'" />
            <!-- 취소버튼 클릭시 수정하려던 글을 보는 페이지로 이동함 (그 페이지의 url에 bbsID가 들어가므로 위와같이 작성) -->
          </td>
        </tr>
      </table>
    </form>
  </body>
</html>

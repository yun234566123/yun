<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 사용 -->
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %> <!-- Bbs, BbsDAO클래스 사용 -->
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="css/view.css" />
    <title>게시글 보기</title>
  </head>
  <body>
  	<%
		String userID = null;
		if(session.getAttribute("userID") != null){ //세션에 userID가 존재하면 받아와 저장
			userID = (String) session.getAttribute("userID");
		}
		
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){ //넘어온 bbsID정보가 있으면 받아와 저장
			bbsID = Integer.parseInt(request.getParameter("bbsID")); 
		}
		
		if( bbsID == 0){ //넘어온 bbsID정보가 없으면
			PrintWriter script = response.getWriter(); //자바스크립트코드 사용
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')"); //알림창 출력
			script.println("location.href = 'board.jsp'"); //게시판페이지로 돌아감
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID); //얻은 bbsID에 해당하는 게시글의 정보를 얻어옴
	%>
    <h1>게시글 보기</h1>
    <table class="view">
      <tr>
     	<td>제목 </td>
     	<td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
     	<!-- 공백, 태그표시, 줄바꿈이 표시될 수 있도록 html언어로 변경함 -->
      </tr>
      <tr>
     	<td>작성자 </td>
		<td colspan="2"><%=bbs.getUserID() %></td>
      </tr>
      <tr>
     	<td>작성일자 </td>
     	<td colspan="2"><%=bbs.getBbsDate().substring(0,11) + bbs.getBbsDate().substring(11,13) + "시"+bbs.getBbsDate().substring(14,16) + "분"  %></td>
      </tr>
      <tr>
     	<td>내용 </td>
     	<td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
      </tr>
    </table>
    <table class="viewBtn">
        <tr>
	      <td>
	        <input type="button" value="목록" class="btn" onclick="location.href='board.jsp' " />
	        <!-- 목록버튼을 클릭하면 게시글 목록 페이지로 돌아감 -->
          </td>
          <%
				if(userID != null && userID.equals(bbs.getUserID())){ //접속중인 아이디와 작성자가 같으면 수정/삭제 버튼을 표시함
		  %>
          <td>
            <input type="button" value="수정" class="btn" onclick="location.href='update.jsp?bbsID=<%= bbsID %>'"/>
          </td>
          <td>
            <input type="button" value="삭제" class="btn" onclick="confirm('글을 삭제하시겠습니까?');location.href='deleteAction.jsp?bbsID=<%=bbsID %>'" />
          </td>
          <!-- 수정과 삭제버튼 클릭시 이동하는 페이지에 bbsID정보를 전달함 -->
          <%
				}
		  %>
        </tr>
    </table>
  </body>
</html>

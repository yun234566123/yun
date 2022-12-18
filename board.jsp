<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> <!-- 스크립트 문장을 실행할 수 있도록 import해줌 -->
<%@ page import="bbs.BbsDAO" %> <!-- BbsDAO클래스의 메소드 사용 -->
<%@ page import="bbs.Bbs" %><!-- Bbs클래스의 데이터 사용 -->
<%@ page import="java.util.ArrayList" %> <!-- ArrayList사용 -->
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="css/board.css" />
    <title>게시판</title>
  </head>
  <body>
    <%
		String userID = null;
		if(session.getAttribute("userID") != null){ //세션에 userID가 존재하면
			userID = (String) session.getAttribute("userID"); //userID에 저장
		}
		
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
			
		}
	%>
    <h1>게시판</h1>
    <table class="table">
      <thead>
        <tr>
          <th>번호</th>
          <th>제목</th>
          <th>작성자</th>
          <th>작성시간</th>
        </tr>
      </thead>
      <tbody>
        <% //게시글을 뽑아올 수 있도록함
			BbsDAO bbsDAO = new BbsDAO(); //메소드를 사용하기 위한 객체생성
			ArrayList<Bbs> list = bbsDAO.getList(); //리스트 생성
			for(int i=0; i<list.size();i++){
		%>
		<tr>
			<td><%= list.get(i).getBbsID() %></td>	
			<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
			<td><%= list.get(i).getUserID() %></td>
			<td><%= list.get(i).getBbsDate() %></td>
			<!-- 글목록에 작성할 내용을 데이터베이스에서 얻어옴, 제목은 링크를 걸어 view.jsp로 이동하고, id정보를 건네줌 -->
		</tr>
		<%
			}
		%>
      </tbody>
    </table>
    <table>
<!-- 	      <li><input type="button" value="이전" class="beforeBtn" /></li>
          <li><input type="button" value="다음" class="nextBtn" /></li> -->	
      <tr>
 		<td>
 		  <input type="button" value="글쓰기" id="writeBtn" onclick="location.href='write.jsp'" />
 		  <!-- 글쓰기 버튼 클릭시 write.jsp페이지로 이동 -->
        </td>
        <td>
          <input type="button" value="로그아웃" id="logoutBtn" onclick="location.href='logoutAction.jsp'" />
          <!-- 로그아웃 버튼 클릭시 logoutAction.jsp페이지로 이동 -->
        </td>
      </tr>
    </table>
  </body>
</html>

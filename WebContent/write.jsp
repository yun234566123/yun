<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 사용 -->
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>write</title>
    <link rel="stylesheet" href="css/view.css" />
  </head>
  <body>
    <%
		String userID = null;
		if(session.getAttribute("userID") != null){ //세션에 userID가 있으면 받아옴
			userID = (String) session.getAttribute("userID");
		}
	%>
    <h1>글쓰기</h1>
    <form method="POST" action="writeAction.jsp" class="writeAction">
    <!-- post방식으로 정보를 writeAction.jsp페이지에 전달함 -->
      <table class="write">
        <tr>
          <td>제목</td> <td><input type="text" name="bbsTitle" /></td>
        </tr>
        <tr>
          <td>내용</td>
          <td>
            <textarea name="bbsContent" id="content" cols="30" rows="10"></textarea>
          </td>
        </tr>
        <tr>
 		  <td>
             <input type="submit" value="글쓰기" class="btnWrite" />
             <!-- submit버튼을 클릭하면 위에서 지정한 곳으로 정보가 전달됨 -->
          </td>
          <td>
            <input type="button" value="취소" class="btnCancle" onclick="location.href='board.jsp' " />
            <!-- 취소를 누르면 게시글 목록 페이지로 돌아감 -->
          </td>
        </tr>
      </table>
    </form>
  </body>
</html>

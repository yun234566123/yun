<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="css/join.css" />
    <title>회원가입</title>
  </head>
  <body>
    <h1>회원가입</h1>
    <form method="POST" action="joinAction.jsp" class="joinAction">
    <!-- 아래의 정보들을 joinAction.jsp페이지에 post방식으로 저장 -->
      <ul>
        <li>아이디 <input type="text" name="userID" /></li>
        <li>비밀번호 <input type="password" name="userPassword" /></li>
        <li>이름 <input type="text" name="userName" /></li>
        <li>연락처 <input type="text" name="userPhone" /></li>
        <li>이메일 <input type="email" name="userEmail" /></li>
        <span>
          <li><input type="submit" value="회원가입" /></li>
  		  <li><input type="button" value="취소" onclick="location.href='login.jsp'" /></li>      
        </span>
      </ul>
    </form>
  </body>
</html>
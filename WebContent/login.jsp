<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="css/login.css" />
    <title>Login</title>
  </head>
  <body>
    <h1>Login</h1>
    <form method="POST" action="loginAction.jsp" class="loginAction">
    <!-- submit을 클릭하면 id/pw가 post방식으로 loginAction.jsp로 전달됨 -->
      <table>
        <tr>
          <td>아이디 </td>
          <td><input type="text" name="userID" /></td>
        </tr>
        <tr>
          <td>비밀번호 </td>
          <td><input type="password" name="userPassword" /></td>
        </tr>
        <tr>
          <td><input type="submit" value="로그인" class="login" /></td>
          <td>
            <input type="button" value="회원가입" onclick="location.href='join.jsp' ">
            <!-- 회원가입을 누르면 join.jsp로 이동 -->
          </td>
        </tr>
      </table>
    </form>
  </body>
</html>

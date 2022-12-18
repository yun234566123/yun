<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logout</title>
</head>
<body>
	<%
		session.invalidate(); 
	    //세션을 중단시킴 : 세션을 이용해 접속중인 아이디이의 정보를 받으므로 중단시키면 로그아웃됨
	%>
	<script>
		location.href = 'login.jsp'; //로그인페이지로 돌아감
	</script>
</body>
</html>
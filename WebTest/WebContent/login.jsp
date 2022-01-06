<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="otpTest.jsp">
		<h3>로그인 화면</h3>
		<div class="form-group"><input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20"/></div>
		<div class="form-group"><input type="password" class="form-control" placeholder="비밀번호" name="userPW" maxlength="20"/></div>
		<input type="submit" class="btn btn-primary form-control" value="로그인"/>
	</form>
</body>
</html>
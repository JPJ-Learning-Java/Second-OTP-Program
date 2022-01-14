<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE>
<html>
    <head>
    <meta charset="UTF-8">
    </head>
<body>
<%
String user_id = "";
String user_pw = "";
String userLevel = "";
if(request.getParameter("user_id") == ""){  %>
     <script>
	 alert("아이디를 입력하세요");
	 document.location.href='./login.jsp'
	 </script>
    <% }
else if(request.getParameter("user_pw") == ""){ %>
     <script>
	 alert("비밀번호를 입력하세요");
	 document.location.href='./login.jsp'
	 </script>
    <% }
else{
	user_id = request.getParameter("user_id"); //ID값 가져옴
	user_pw = request.getParameter("user_pw"); //PW값 가져옴
    //여기서 부터 DB 연결 코드
	Connection conn = null;
	String driverName="com.mysql.jdbc.Driver";
	Class.forName(driverName);
	String serverName = "localhost";
	String serverPort = "3306";
	String sid = "mysql";
	String url = "jdbc:mysql://localhost:3306/id?allowPublicKeyRetrieval=true";
	String userName = "root";
	String userPassword = "emforhs77";
	conn = DriverManager.getConnection(url, userName, userPassword);
	Statement st = conn.createStatement();
	ResultSet rs = st.executeQuery("select * from login where id = '" + user_id + "' AND PassWord ='" + user_pw + "'");
	Boolean check = false;
	while(rs.next()) // 결과값을 하나씩 가져와서 저장하기 위한 while문
    {
		String id = rs.getString("id"); //DB에 있는 ID가져옴
    	session.setAttribute("user_id", id); //DB값을 세션에 넣음
		check = true;	
    }
	if(check){ //ID,PW가 DB에 존재하는 경우 게시판으로 이동하는 코드 
		
    %> 
 			 <script>
  			 document.location.href='./addition'
 			 </script> <%
    	      rs.close();
    	      conn.close();
		}   else  { //ID,PW가 일치하지 않는 경우
        %>
     <script>
	 alert("ID 또는 PW를 잘못 입력했습니다.");
	 document.location.href='./login.jsp'
	 </script>
    <%    }
   } %>
</html>
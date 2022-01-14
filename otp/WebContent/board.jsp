<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
   <%
   String user_id = (String)session.getAttribute("user_id");
   if(user_id == null){
	   response.sendRedirect("login.jsp");
   }  	%>   
    <script  type="text/javascript">
     function logout(){
            window.location.href = 'logout.jsp';
            }
     </script>
</head>
<body>

 <div style="background:white;margin:-12px -0.5% 0px -20px; text-align:center;height:80px; border: 1px solid"><h2>취약한 페이지</h2></div>
 <div style="text-align:center;">
 <br>세션 ID : <%=session.getId() %><br>
<%=user_id %>님 로그인 되었습니다.
     <a href="./logout.jsp" style="margin-left:3%">로그아웃</a>
    <a href="/webTest/main.html"style="margin-left:3%">메인 페이지</a></div><br>
	<div style="margin-left:42%">
    <form action="./list_search.jsp" method="post">
        <input type="text" name="search_word" size="30" align="center"/>
        <input type="hidden" name="sort" value="BOARD_N">
        <button>검색</button>
    </form>
</div>
<table border="1" width="80%" style="margin-top:3%;margin-left:9%">
    <tr>
        <td align="center"><a href="./board_list.jsp?sort=BOARD_N">번호</a></td>
        <td align="center"><a href="./board_list.jsp?sort=TITLE">제목</a></td>
        <td align="center"><a href="./board_list.jsp?sort=WRITER">작성자</a></td>
        <td align="center"><a href="./board_list.jsp?sort=WRITE_DATE">날짜</a></td>
        <td align="center">조회수</td>
    </tr>
    <%
	Class.forName("com.mysql.jdbc.Driver");
     Connection conn = null;
     Statement stmt = null;
     ResultSet rs = null;
     ResultSet gg = null;
     String sort = "";
     if(request.getParameter("sort") != null){
     	sort = request.getParameter("sort");
     	}  
     else if(request.getParameter("sort") == null){
  	   	sort = "BOARD_N";
  	   	} 
     try {
    	 String jdbcDriver = "jdbc:mysql://localhost:3306/id?allowPublicKeyRetrieval=true";
    	 String dbUser = "root";
    	 String dbPw = "emforhs77";
    	 String query = "SELECT * FROM id.BOARD ORDER BY " + sort + " desc";
         conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPw);
         stmt = conn.createStatement();
         rs = stmt.executeQuery(query);
   	 while(rs.next()){  %>
    <tr align=center>
        <td width="70"><%=rs.getInt("BOARD_N")%></td>
        <td width="500"><a href="./view.jsp?N=<%=rs.getInt("BOARD_N")%>"><%=rs.getString("TITLE")%></a></td>
     	<td width="120"><%=rs.getString("WRITER")%></td>
     	<td width="100"><%=rs.getString("WRITE_DATE")%></td>
        <td width="100"><%=rs.getString("HIT")%></td>
	<tr>
	<% 	}
     }catch(SQLException ex){
            out.println(ex.getMessage());
            ex.printStackTrace();
      }finally{
            // 6. 사용한 Statement 종료
            if(rs != null) try { rs.close(); } catch(SQLException ex) {}
            if(stmt != null) try { stmt.close(); } catch(SQLException ex) {}
            // 7. 커넥션 종료
            if(conn != null) try { conn.close(); } catch(SQLException ex) {}
      } %>
</table>
<br>
<button type="button" onclick="location.href='new_write.html?id=<%=user_id%>' " style="margin-left:83%">글쓰기</button>
</body>
</html>
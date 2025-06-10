<%@page import="java.sql.* "%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%  request.setCharacterEncoding("UTF-8"); %>
    
<%
String url = "jdbc:mysql://localhost:3306/project";
String dbId = "cye";
String dbPass = "pwpw12211234*";

	Connection conn = null; 
	PreparedStatement pstmt = null;
	//pstmt sql에서 값이 정해지지 않았을 때
	//stmt 값이 이미 정해졌을 때
	
try{
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String nickname = request.getParameter("nickname");
	String message = request.getParameter("message");
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn =  DriverManager.getConnection(url, dbId, dbPass); //conn이랑 클래스랑 연결
	
	String sql = "INSERT INTO signup(id, password, nickname, message) values(?, ?, ?, ?)";
	pstmt = conn.prepareStatement(sql); //sql문 실행
	
	pstmt.setString(1, id); //파라미터에 값 넣어 줌 sql문 순서대로
	pstmt.setString(2, password);
	pstmt.setString(3, nickname);
	pstmt.setString(4, message);
	pstmt.executeUpdate(); //update = insert, delete, update 리턴하지 않기 때문임
	
	response.sendRedirect("mainpage.jsp");
	
}
	catch(Exception e){
	    out.print(e);
} finally {
	if (pstmt != null) pstmt.close();
	if(conn!= null) conn.close();
}

%>
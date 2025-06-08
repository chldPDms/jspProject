<%@page import="java.sql.* "%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String url = "jdbc:mysql://localhost:3306/project";
String dbId = "cye"; // 설정된 id
String dbPass = "pwpw12211234*"; // 설정된 password
	Connection conn = null; 
	PreparedStatement pstmt = null;
	//pstmt sql에서 값이 정해지지 않았을 때
	//stmt 값이 이미 정해졌을 때
	
try{
	String userid = request.getParameter("userid");
	String pw = request.getParameter("pw");
	String nickname = request.getParameter("nickname");
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn =  DriverManager.getConnection(url, dbId, dbPass); //conn이랑 클래스랑 연결
	
	String sql = "INSERT INTO signup(userid, pw, nickname) values(?, ?, ?)";
	pstmt = conn.prepareStatement(sql); //sql문 실행
	
	pstmt.setString(1, userid); //파라미터에 값 넣어 줌 sql문 순서대로
	pstmt.setString(2, pw);
	pstmt.setString(3, nickname);
	pstmt.executeUpdate(); //update = insert, delete, update 리턴하지 않기 때문임
	
	out.print(userid + " 님, 안녕하세요!");
	
}
	catch(Exception e){
	    out.print(e);
} finally {
	if (pstmt != null) pstmt.close();
	if(conn!= null) conn.close();
}

%>
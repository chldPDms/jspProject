<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="sign" class="project.Signup" />
<jsp:setProperty property="*" name="sign" />
<%
String url = "jdbc:mysql://localhost:3306/project";
String dbId = "cye";
String dbPass = "pwpw12211234*";

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;


try {
	conn = DriverManager.getConnection(url, dbId, dbPass);
	String sql = "Select * from signup where userid = ?"; //password는 일부로 보안 문제 때문에 안 함
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, sign.getUserid());
	
	rs = pstmt.executeQuery();
	
	if (!rs.next()){
		out.print("id 없음");
		return;
	} if (!rs.getString("pw").equals(sign.getPw())){
		out.print("pw 없음");
		return;
	}
	
	session.setAttribute("userid", rs.getString("userid"));
	session.setAttribute("nickname", rs.getString("nickname"));
	
	out.print("로그인 성공");
	
	
} catch (Exception e){
	e.printStackTrace();
	out.print("로그인 실패");
	
} finally {
	if (conn!=null) conn.close();
	if (pstmt!=null) pstmt.close();
	if (rs !=null) rs.close();
}

%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.koreait.web.*"%>

<%!
	Connection getCon() throws Exception {
	
		String url = "jdbc:oracle:thin:@localhost:1521:orcl2";
		String username = "hr";
		String password = "koreait2020";
	
		Class.forName("oracle.jdbc.driver.OracleDriver");
	
		//getConnection : static메소드, 클래스명.메소드, db연결된 connection객체를 받아옴 
		//변수는 주소값 혹은 value값 만 저장 가능 객체는 여러개 가능
		Connection con = DriverManager.getConnection(url, username, password);
		System.out.println("접속성공");
		return con;
	
	}

%>

<%
	String strI_board = request.getParameter("i_board");
	String title = request.getParameter("title");	
	String ctnt = request.getParameter("ctnt");
	String strI_student = request.getParameter("i_student");
	
	int i_board = Integer.parseInt(strI_board);
	int i_student = Integer.parseInt(strI_student);
	
	Connection con = null;
	PreparedStatement ps = null;
		
	String sql = " UPDATE t_board "
				+ " SET title = ? "
				+ " , ctnt=? "
				+ " , i_student=? "
				+ " WHERE i_board = ? ";
	
	try {
		
		con = getCon();
		ps = con.prepareStatement(sql);
		
		ps.setNString(1, title);
		ps.setNString(2, ctnt);
		ps.setInt(3, i_student);
		ps.setInt(4, i_board);
		
		ps.executeUpdate();
		
	} catch(Exception e) {
		
	} finally {
		if(ps != null) {try {ps.close();} catch(Exception e) {} }
		if(con != null) {try {con.close();} catch(Exception e) {} }
	}

	response.sendRedirect("/jsp/boardDetail.jsp?i_board=" + strI_board);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정</title>
</head>
<body></body>
</html>
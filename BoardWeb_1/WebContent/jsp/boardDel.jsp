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
	int i_board = Integer.parseInt(strI_board);
	
	String sql = " DELETE FROM t_board WHERE i_board = ? ";
	
	Connection con = null;
	PreparedStatement ps = null;
	
	int result = -1;
	
	try {
		
		con = getCon();
		ps = con.prepareStatement(sql);
		
		ps.setInt(1,i_board);
		
		result = ps.executeUpdate();
		

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if(ps != null) {try {ps.close();} catch (Exception e) {} }
		if(con != null) {try {con.close();} catch (Exception e) {} }
	}
	
	System.out.println("result : " + result);
	
	switch(result) {
	case -1:
		response.sendRedirect("/jsp/boardList.jsp?err=-1&i_board=" + i_board);
		break;
	case 0:
		response.sendRedirect("/jsp/boardList.jsp?err=0&i_board=" + i_board);
		break;
	case 1:
		response.sendRedirect("/jsp/boardList.jsp");
		break;
	}

%>

<%=result %>
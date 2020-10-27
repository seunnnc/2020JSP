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
	//request.setCharacterEncoding("UTF-8");	//post방식으로 사용할때 utf-8적용하는 방법
	//request HttpServletRequest의 주소값
	String title = request.getParameter("title");	//getParameter 외부로 부터 값을 받기 위해, 맵형식, titel값 없었으면 null값 넘어옴
	String ctnt = request.getParameter("ctnt");
	String strI_student = request.getParameter("i_student");
	
	if("".equals(title) || "".equals(ctnt) || "".equals(strI_student)) {
		response.sendRedirect("/jsp/boardWrite.jsp?err=10");
		return;
	}
	
	int i_student = Integer.parseInt(strI_student);	//strI_student가 만약 a가 넘어오면 에러터짐, 예외처리 해줘야함
	
	Connection con = null;
	PreparedStatement ps = null;
	
	String sql = " insert into t_board "
			+ "(i_board, title, ctnt, i_student) "
			+ " select nvl(max(i_board),0) + 1, ?, ?, ? "
			+ " from t_board ";
	
	int result = -1;
	
	try {
		
		con = getCon();
		ps = con.prepareStatement(sql);
		
		ps.setNString(1, title);
		ps.setNString(2, ctnt);
		ps.setInt(3, i_student);
		
		result = ps.executeUpdate();
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if(ps != null) {try {ps.close();} catch(Exception e) {} }
		if(con != null) {try {con.close();} catch(Exception e) {} }
	}

	System.out.println("result : " + result);
	int err = 0;
	switch(result) {
		case 1 : 
			response.sendRedirect("/jsp/boardList.jsp");
			return;	//메소드가 종료
		case 0 :
			err = 10;
			break;	//switch문이 종료
		case -1:
			err = 20;
			break;
	}
	
	response.sendRedirect("/jsp/boardWrite.jsp?err=" + err);
%>
<!-- i_board는 1. 서브 쿼리 사용하여 max(i_board)하여 넣어줌
			2. 시퀀스를 사용 auto increment주면 자동으로 값 넘겨줌 
<div>title : <%=title %></div>
<div>ctnt : <%=ctnt %></div>
<div>strI_student : <%=strI_student %></div>
-->
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

	String sql = " SELECT title, ctnt, i_student FROM t_board WHERE i_board = ? ";
	
	BoardVO vo = new BoardVO();
	
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	try {
		
		con = getCon();
		ps = con.prepareStatement(sql);
		
		ps.setInt(1, i_board);
		
		rs = ps.executeQuery();
		
		if(rs.next()) {
			
			
			String title = rs.getNString("title");
			String ctnt = rs.getNString("ctnt");
			int i_student = rs.getInt("i_student");
			
			vo.setTitle(title);
			vo.setCtnt(ctnt);
			vo.setI_student(i_student);
		}
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if(rs != null) {try {rs.close();} catch (Exception e) {} }
		if(ps != null) {try {ps.close();} catch (Exception e) {} }
		if(con != null) {try {con.close();} catch (Exception e) {} }
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정</title>
</head>
<body>
	<div>
		<form action="/jsp/boardModProc.jsp" method="post" onsubmit="return chk()">
			<input type="hidden" name="i_board" value=<%=i_board%>>
			<div><label>제목: <input type="text" name="title" value=<%=vo.getTitle() %>></label></div>
			<div><label>내용 : <textarea name="ctnt"><%=vo.getCtnt() %></textarea></label></div>
			<div><label>작성자 : <input type="text" name="i_student" value=<%=vo.getI_student() %>></label></div>
			<div><input type="submit" value="글수정"></div>
			<div><input type="reset" value="초기화"></div>
		</form>
	</div>
	
	<script>
		function eleValid(ele, nm) {
			if(ele.value.length == 0) {
				alert(nm+'을(를) 입력해 주세요.')
				ele.focus()
				return true
			}
		}
		
		function chk() {
			console.log(`title : \${frm.title.value}`)
			
			if(eleValid(frm.title, '제목')) {
				return false
			} else if (eleValid(frm.ctnt, '내용')) {
				return false
			} else if (eleValid(frm.i_student, '작성자')) {
				return flase
			}
		}
	</script>

</body>
</html>
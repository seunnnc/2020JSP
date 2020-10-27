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
	String strI_board = request.getParameter("i_board");	//프로토콜
	if(strI_board == null) {
%>

	<script>
		alert('잘 못 된 접근입니다.')
		location.href='/jsp/boardList.jsp'
	</script>
	
<%	
		return;
	}
	
	int i_board = Integer.parseInt(strI_board);
	
	//value값이 넘어옴, title, ctnt등 보내고 받을 수 있지만 트래픽 생성이 많아지고 비효율적임 pk값 보내는게 best
	String sql = " SELECT title, ctnt, i_student FROM t_board WHERE i_board = ? ";	// strI_board;
	

	BoardVO vo = new BoardVO();
	
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	
	try {

		con = getCon();
		ps = con.prepareStatement(sql);
		
		ps.setInt(1,i_board);		//첫번째 물음표에 3을 압력하겠다 	(물음표의 위치값, 입력하고 싶은 데이터)
		//ps.setString(1,strI_board);
		
		rs = ps.executeQuery();
		
		//0줄 일수 있기 때문에 rs.next()처리를 해줘야 값이 넘어옴
		//while사용해도 상관 없음 한줄만 넘어졸것이기때문 but boardList에서는 if 사용하면 한줄만 나오기 떄문에 while만 사용해야함
		if(rs.next()) {
			
			String title = rs.getNString("title");
			String ctnt = rs.getNString("ctnt");
			int i_student = rs.getInt("i_student");
			
			
			//값주입
			vo.setTitle(title);
			vo.setCtnt(ctnt);
			vo.setI_student(i_student);
		}

		
	} catch (Exception e ) {
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
	<title>상세 페이지</title>
	<style type="text/css">
		div {
			width : 800px;
			margin : 30px auto;
		}
		p {
			margin-left : 20px;
			width : 300px;
			height : 200px;
			border : 1px solid black;
			padding : 10px;
		}
	</style>
	</head>
	<body>
		<div>
			<!-- <h3>
				글번호 :
				<%=strI_board %>
			</h3>
			<h3>제목 : <%=vo.getTitle() %></h3>
			<h3>학생번호 : <%=vo.getI_student() %></h3>
			
			<h3>내용</h3>
			<p><%=vo.getCtnt() %></p> -->
			
			<div>
				<a href="/jsp/boardList.jsp">리스트보기</a>
				<a href="#" onclick="procDel(<%=i_board%>)">삭제</a>
				<a href="/jsp/boardMod.jsp?i_board=<%=i_board%>">수정</a>
			</div>
			
			<div>제목 : <%=vo.getTitle() %></div>
			<div>내용 : <%=vo.getCtnt() %></div>
			<div>작성자 : <%=vo.getI_student() %></div>
			
			<script>
				function procDel(i_board) {
					//alert('i_board : ' + i_board)
					if(confirm('삭제 하시겠습니까?')) {
						location.href = '/jsp/boardDel.jsp?i_board=' + i_board;
					}
				}
			</script>
		</div>
	</body>
</html>
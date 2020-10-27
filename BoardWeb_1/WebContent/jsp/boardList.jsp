<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
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
	//스크립트릿이라고 말함
	//메소드 안임
	//메소드안에 메소드 만들 수 없음
	//<%에 !붙여주면 메소드 밖에 만들어줌 메소드나 private사용할 수 있음
	//<%@는 메소드
	//private 사용할 수 없음
	//int a = 10;		//지역변수임
	
	//pageContext jsp에서 클라이언트 응답순간 죽음
	//request
	//session 브라우저 켜면 생성 한개로 유지 끄면 죽음 로그인 여부
	//application 전체
	
	
	List<BoardVO> boardList = new ArrayList();	//레코드 한줄 아닌 여러줄을 가져오기 위해서 사용해줌 BoardVO 객체의 주소값을 가져오기 위해서
	
	Connection con = null;	//db와 연결 담당
	PreparedStatement ps = null;	//쿼리문 문장완성, 실행 담당
	ResultSet rs = null;	//select때만 사용함! (read때) 
	//선언을 try문 안에서 사용하면 그 안에서만 사용할 수 있기 때문에 finally에서 사용할 수 없음 finally에서 사용해주기 위해서 큰 범위에서 선언을 해줌
	
	//sql문 안에 ;들어가면 sql인젝션 공격이 가능해짐 ;은 허용되면 안됨
	//sql문은 앞뒤로 띄어줌
	String sql = " SELECT i_board, title FROM t_board ORDER BY i_board DESC";
	
	try {
		
		con = getCon();
		ps = con.prepareStatement(sql);
		rs = ps.executeQuery();	//executeQuery : 리턴타입이 rs임, select문에서는 무조건 executeQuery
		
		//한줄만 0줄 혹은 1줄이 확실할 경우 if문 사용하기도 함
		while(rs.next()) {		//rs.next() 리턴타입 : boolean while안쪽이 false가 될때 까지 반복함
			
			int i_board = rs.getInt("i_board");		//getInt()안의 값은 컬럼명임 리턴타입은 int이다
			String title = rs.getNString("title");
			
			//파싱작업
			BoardVO vo = new BoardVO();	//BoardVO 서랍이라고 생각하면 됨 반복문 안에서 만들어 줘야함 꼭!!! 반복문 밖에서 선언하면 똑같은 값으로 대체됨
			
			vo.setI_board(i_board);
			vo.setTitle(title);
			
			boardList.add(vo);	//리스트에 값을 넣어줌
			
		}
		
	} catch (Exception e) {
		e.printStackTrace();	//에러 찍어줌, 에러발생 관련 공부 추가로 하기
	} finally {
		//열었던 순서와 반대로 닫아줘야함
		//rs, ps, con 세개를 한번에 닫아주면 rs에서 에러가 나면 ps와 con이 닫히지 않을 수 있기 때문이다  
		//닫아주지 않으면 서버 다운됨 
		if(rs != null) { try { rs.close(); } catch (Exception e) {} }
		if(ps != null) { try { ps.close(); } catch (Exception e) {} }
		if(con != null) { try { con.close(); } catch (Exception e) {} }

	}
	
%>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>게시판</title>
	<style>
		h1 {
			margin: 50px;
		}
		a {
			text-decoration : none;
			color : black;
		}
		a button {
			margin-left : 50px
		}
		table {
			border: 1px solid black;
			border-collapse : collapse;
			margin: 35px;
		}
		th, td {
			border: 1px solid black;
			padding: 5px;
			text-align: center;
		}
		thead {
			background-color: lightpink;
		}
	</style>
	</head>
	<body>
		<div>게시판 리스트</div>
		<table>
			<thead>
			<tr>
				<th>No</th>
				<th>제목</th>	
			</tr>
			</thead>
			<% for(BoardVO vo : boardList) { %>
			<tr>
				<td><%=vo.getI_board() %></td>
				<td>
					<!-- 속도를 중시한다 get방식 보안이 중시된다 post방식  --> 
					<a href="/jsp/boardDetail.jsp?i_board=<%=vo.getI_board() %>"> <!-- ?key값=value값,  & : key와 value를 더 보내고 싶을때 사용함 %> --> 
						<%=vo.getTitle() %>
					</a>
				</td>
			</tr>
			<% } %>
		</table>
		<a href="/jsp/boardWrite.jsp"><button>글쓰기</button></a>
	</body>
</html>
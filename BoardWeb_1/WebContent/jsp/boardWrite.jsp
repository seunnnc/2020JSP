<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%
	String msg = "";
	String err = request.getParameter("err");
	if(err != null) {
		switch(err) {
		case "10" :
			msg = "등록할 수 없습니다.";
			break;
		case "20":
			msg = "DB에러발생";
			break;
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<style>
 	/*소스를 나눠 줘야 관리 하기 용이함
		name, id, class 혹은 내가 만들어 줄수도 있음, 
		name : 키값, 
		id : 유일해야함 유일성,
		class : 여러개에 똑같은 속성을 주고 싶을경우 사용, 여러개의 class 걸어줄 수 있음 ex) class="bb kk ddd" 가능  
	*/
	div {
		margin-bottom : 10px;
	}
	div > input {
		margin-left : 100px;
		margin-top : 20px;
	}
	#msg {
		color : red;
	}
</style>
</head>
<body>
	<div id="msg"><%=msg %></div>
	<div>
		<form id="frm" action="/jsp/boardWriteProc.jsp" method="post" onsubmit="return chk()"> <!-- get으로 보내면 주소창에 아래의 정보가 다 나옴 -->
			<div><label>제목: <input type="text" name="title"></label></div>
			<div><label>내용: <textarea name="ctnt"></textarea></label></div>
			<div><label>작성자: <input type="text" name="i_student"></label></div>
			<div><input type="submit" value="글등록"></div>
		</form>
	</div>
	<script>
		/* 
			바디에 선언하는 이유는 엘리멘트를 가지고 놀기 위해서 밑에 적어줌 
			CSS는 반드시 위에  적어줌 번쩍임 현상이 일어나기 때문에 무조건 head부분에 적어움
			on으로 시작하는 것들 event라고 함 onclick, onsubmit등 동작했을 "때"
			onsubmit="return false" 절대로 서버에 날아갈 수 없음
		*/
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
			
			/*
			if(frm.title.value == '') {
				alert('제목을 입력해 주세요.')
				frm.title.focus()
				return false
			} else if (frm.ctnt.value.length == 0) {
				alert('내용을 입력하세요.')
				frm.ctnt.focus()
				return false
			} else if (frm.i_student.value.length == 0) {
				alert('작성자를 입력하세요.')
				frm.i_student.focus()
				return false
			*/
		}
		
	</script>
</body>
</html>
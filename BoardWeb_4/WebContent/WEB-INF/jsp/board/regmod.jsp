<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>등록/수정</title>
		<style>
		* {
			font-family: "Noto Sans KR", sans-serif;
			background-color: #fcfefe;
		}
		
		*:focus {
			outline: none;
		}
		
		body {
			width: 100%
		}
		
		.container {
			width: 500px;
			margin: 80px auto;
			padding: 20px;
		}
		
		#frm input {
			width: 500px;
			padding: 7px;
			border: 0;
			color: #331606;
			border-bottom: 1px solid #331606;
			font-size: 1em;
		}
		
		#frm input:-webkit-autofill, 
		#frm input:-webkit-autofill:hover, 
		#frm input:-webkit-autofill:focus,
		#frm input:-webkit-autofill:active {
			-webkit-transition: "color 9999s ease-out, background-color 9999s ease-out";
			-webkit-transition-delay: 9999s;
		}
		
		#frm textarea {
			margin-top: 20px;
			width: 500px;
			height: 100px;
			padding: 7px;
			border: 1px solid #331606;
			color: #331606;
			font-size: 1em;
		}
		
		#frm button {
			width: 78px;
			background-color: #babc99;
			text-align: center;
			border: none;
			padding: 8px;
			color: #331606;
			border-radius: 10px;
			margin: 20px 0px 0px 211px;
			font-weight: bold;
		}
		</style>
	</head>
	<body>
		<div class="container">
			<form id="frm" action="regmod" method="post">
				<div>
					<input type="hidden" name="i_board" value="${data.i_board }">
				</div>
				<div>
					<input id="title" type="text" name="title" placeholder="제목을 입력하세요"
						value="${data.title }">
				</div>
				<div>
					<textarea name="ctnt" placeholder="내용을 입력하세요">${data.ctnt }</textarea>
				</div>
				<div>
					<button type="submit">${data.i_board == null ? '글등록' : '글수정'}</button>
				</div>
			</form>
		</div>
	</body>
</html>